import "package:flutter/material.dart";

import "package:ledger/widgets/budget_widget.dart";
import "package:ledger/widgets/records_widget.dart";

import "package:ledger/pages/transaction_page.dart";

import "package:ledger/types/transaction.dart";
import "package:ledger/types/budget.dart";
import "package:ledger/types/app_state.dart";

import "package:ledger/utils.dart";

class Home extends StatefulWidget {
	const Home({super.key});

	@override
	State<Home> createState() => _Home();
}

class _Home extends State<Home> {
	AppState state = AppState();

	@override
	Widget build(BuildContext context) {
		Pair<double, double> screen_size = get_screen_size(context);

		return Scaffold(
			body: Padding(
				padding: EdgeInsets.only(
					top: 55.0, bottom: 45.0, left: 16.0, right: 16.0
				), // EdgeInsets
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget> [
						Container(height: 0.3 * screen_size.y, child: BudgetWidget(state.budget)),
						SizedBox(height: 20),
						Expanded(child: RecordsWidget(state.transactions)),
					]
				), // Column
			), // Padding

			floatingActionButton: FloatingActionButton(
				onPressed: () {
					Navigator.of(context).push(
						MaterialPageRoute(
							builder: (context) => TransactionPage(state: state)
						)
					).then((_) => setState(() {}));
				},
				tooltip: 'Add transaction',
				child: const Icon(Icons.add)
			), // FloadingActionButton
			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
		); // Scaffold
	}
}
