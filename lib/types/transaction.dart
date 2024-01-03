import "package:ledger/types/budget.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum TransactionType {
	GAINED("Gained"),
	SPENT("Spent");

	const TransactionType(this.label);
	final String label;
}

class Transaction {
	double amount;
	TransactionType ttype;
	CardType ctype;
	String remark;
	String date; // year-month
	int day;

	Transaction(this.amount, this.ttype, this.ctype, this.remark, this.date, this.day);
}

class Transactions {
	List<Transaction> _transactions = [];

	Map<String, TransactionType> tmap = {
		"Gained": TransactionType.GAINED,
		"Spent": TransactionType.SPENT
	};

	Map<String, CardType> cmap = {
		"Wallet": CardType.WALLET,
		"Bank": CardType.BANK,
		"KU Card": CardType.KU_CARD,
		"Esewa": CardType.ESEWA,
	};

	void init(bool updated, void Function(void Function()) callback) {
		SharedPreferences
			.getInstance()
			.then((pref) {
				String? tran_str = pref.getString("transactions");
				_transactions.clear();
				if (!(tran_str == null || tran_str.isEmpty)) {
					Map<String, dynamic> transactions = jsonDecode(tran_str!);
					transactions.forEach((k, v) {
						Transaction t = Transaction(
							double.parse(v["amount"]!),
							tmap[v["ttype"]!]!,
							cmap[v["ctype"]!]!,
							v["remark"]!,
							v["date"]!,
							int.parse(v["day"]!)
						);
						_transactions.insert(int.parse(k), t);
					});
				}
				if (!updated)
					callback(() {});
			});
	}

	void clear() {
		_transactions.clear();
	}

	bool create(Transaction t, Budget budget) {
		double max = budget.get(t.ctype);

		if (t.ttype == TransactionType.GAINED) {
			budget.gained(t.ctype, t.amount);
		} else {
			if (max < t.amount)
				return false;

			budget.spent(t.ctype, t.amount);
		}

		_transactions.insert(0, t);
		budget.save();
		save();

		return true;
	}

	void remove(int index, Transaction t, Budget budget) {
		if (t.ttype == TransactionType.GAINED) {
			budget.spent(t.ctype, t.amount);
		} else if (t.ttype == TransactionType.SPENT) {
			budget.gained(t.ctype, t.amount);
		}

		_transactions.removeAt(index);
		save();
	}

	int length() {
		return this._transactions.length;
	}

	Transaction get(int index) {
		return this._transactions[index];
	}

	Map<String, Map<String, String>> to_json() {
		Map<String, Map<String, String>> json = Map();
		_transactions.asMap().forEach((i, t) {
			json[i.toString()] = {
				"amount": t.amount.toString(),
				"ttype": t.ttype.label,
				"ctype": t.ctype.label,
				"remark": t.remark,
				"date": t.date,
				"day": t.day.toString()
			};
		});
		return json;
	}

	Future<void> save() async {
		SharedPreferences pref = await SharedPreferences.getInstance();
		String tran_str = jsonEncode(to_json());
		pref.setString('transactions', tran_str);
	}
}
