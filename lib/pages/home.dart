import "package:flutter/material.dart";

import "package:ledger/widgets/budget_widget.dart";
import "package:ledger/widgets/records_widget.dart";

import "package:ledger/pages/transaction_page.dart";
import "package:ledger/pages/totals_page.dart";

import "package:ledger/types/transaction.dart";
import "package:ledger/types/budget.dart";
import "package:ledger/types/app_state.dart";
import "package:ledger/types/totals.dart";

import "package:ledger/utils.dart";

class Home extends StatefulWidget {
	const Home({super.key});

	@override
	State<Home> createState() => _Home();
}

class _Home extends State<Home> {
	AppState state = AppState();
	Totals totals = Totals();

	@override
	Widget build(BuildContext context) {

		setState(() {
			totals.calculate_totals(state.transactions);
		});

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

			floatingActionButton: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget> [
					FloatingActionButton(
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

					SizedBox(width: 50),

					FloatingActionButton(
						onPressed: () {
							Navigator.of(context).push(
								MaterialPageRoute(
									builder: (context) => TotalsPage(totals: totals)
								)
							).then((_) => setState(() {}));
						},
						tooltip: 'Totals',
						child: const Icon(Icons.event_note_outlined)
					), // FloadingActionButton
				] // children
			), // Row
			floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
		); // Scaffold
	}
}
