import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:ledger/types/transaction.dart";
import "package:ledger/utils.dart";

class Total {
	String date;
	double amount;

	Total(this.date, this.amount);
}

class Totals {
	List<Total> _totals = [];

	void calculate_totals(Transactions trans) {
		SharedPreferences
			.getInstance()
			.then((pref) {
				String? tot_str = pref.getString("totals");
				_totals.clear();

				if (!(tot_str == null || tot_str.isEmpty)) {
					Map<String, dynamic> totals = jsonDecode(tot_str!);
					totals
						.keys
						.toList()
						.asMap()
						.forEach((i, k) {
							Total t = Total(k, totals[k]!);
							_totals.insert(i, t);
						});
				}

				DateTime now = DateTime.now();
				int total_days = DateTime(now.year, now.month + 1, 0).day;
				if (now.day >= total_days) {
					_submit_totals(trans);
				}
			});
	}

	Map<String, double> to_json() {
		Map<String, double> json = Map();
		for (var i = 0; i < _totals.length; i++) {
			Total t = _totals[i];
			json[t.date] = t.amount;
		}
		return json;
	}

	Future<void> save() async {
		SharedPreferences pref = await SharedPreferences.getInstance();
		String tot_str = jsonEncode(to_json());
		pref.setString('totals', tot_str);
	}

	bool _contains_date(String date) {
		for (var i = 0; i < _totals.length; i++) {
			Total t = _totals[i];
			if (t.date == date)
				return true;
		}
		return false;
	}

	void _submit_totals(Transactions trans) {
		String curr_date = DateFormat('yyyy-MM-dd').format(DateTime.now());

		if (_contains_date(curr_date))
			return;

		double total = 0;

		for (var i = 0; i < trans.length(); i++) {
			Transaction t = trans.get(i);

			String curr_date = DateFormat('yyyy-MM').format(DateTime.now());
			if (t.date == curr_date && t.ttype == TransactionType.SPENT) {
				total += t.amount;
			}
		}

		Total t = Total(curr_date, total);
		_totals.insert(0, t);

		save();
	}

	int length() {
		return _totals.length;
	}

	Total get(int index) {
		return _totals[index];
	}
}
