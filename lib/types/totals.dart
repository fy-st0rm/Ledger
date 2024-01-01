import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:ledger/types/transaction.dart";
import "package:ledger/utils.dart";

class Totals {
	Map<String, double> _totals = Map();

	void calculate_totals(Transactions trans) {
		SharedPreferences
			.getInstance()
			.then((pref) {
				String? tot_str = pref.getString("totals");
				_totals.clear();

				if (!(tot_str == null || tot_str .isEmpty)) {
					Map<String, dynamic> totals = jsonDecode(tot_str!);
					totals.forEach((k, v) {
						_totals[k] = v;
					});
				}

				DateTime now = DateTime.now();
				int total_days = DateTime(now.year, now.month + 1, 0).day;
				if (now.day < total_days) {
					_submit_totals(trans);
				}
			});
	}

	Future<void> save() async {
		SharedPreferences pref = await SharedPreferences.getInstance();
		String tot_str = jsonEncode(_totals);
		pref.setString('totals', tot_str);
	}

	void _submit_totals(Transactions trans) {
		String curr_date = DateFormat('yyyy-MM-dd').format(DateTime.now());

		if (_totals.containsKey(curr_date))
			return;

		double total = 0;

		for (var i = 0; i < trans.length(); i++) {
			Transaction t = trans.get(i);
			total += t.amount;
		}

		_totals[curr_date] = total;

		save();
	}

	int length() {
		return _totals.length;
	}

	Pair<String, double> get(int index) {
		String key = _totals.keys.elementAt(index);
		double value =  _totals.values.elementAt(index);

		var p = Pair<String, double> (key, value);
		return p;
	}
}
