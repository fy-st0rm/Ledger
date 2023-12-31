import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum CardType {
	WALLET("Wallet"),
	BANK("Bank"),
	KU_CARD("KU Card"),
	ESEWA("Esewa");

	const CardType(this.label);
	final String label;
}

class Budget {
	Map<CardType, double> _budget = Map();

	Budget() {
	}

	void init(bool updated, void Function(void Function()) callback) {
		SharedPreferences
			.getInstance()
			.then((pref) {
				String? budget_str = pref.getString('budget');
				if (budget_str == null || budget_str.isEmpty) {
					_budget[CardType.WALLET] = 0;
					_budget[CardType.BANK] = 0;
					_budget[CardType.KU_CARD] = 0;
					_budget[CardType.ESEWA] = 0;
				} else {
					Map<String, dynamic> budget = jsonDecode(budget_str!);
					_budget[CardType.WALLET]  = budget["WALLET"]!;
					_budget[CardType.BANK]    = budget["BANK"]!;
					_budget[CardType.KU_CARD] = budget["KU_CARD"]!;
					_budget[CardType.ESEWA]   = budget["ESEWA"]!;
				}
				if (!updated) {
					callback(() {});
				}
			});
	}

	double get(CardType ctype) {
		return _budget[ctype]!;
	}

	void gained(CardType ctype, double amount) {
		_budget.update(ctype, (value) => _budget[ctype]! + amount);
	}

	void spent(CardType ctype, double amount) {
		_budget.update(ctype, (value) => _budget[ctype]! - amount);
	}

	Map<String, double> to_json() {
		return {
			"WALLET": get(CardType.WALLET),
			"BANK": get(CardType.BANK),
			"KU_CARD": get(CardType.KU_CARD),
			"ESEWA": get(CardType.ESEWA),
		};
	}
	
	Future<void> save() async {
		SharedPreferences pref = await SharedPreferences.getInstance();
		String budget_str = jsonEncode(to_json());
		pref.setString('budget', budget_str);
	}
}
