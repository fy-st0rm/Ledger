import "package:flutter/material.dart";
import "package:ledger/utils.dart";
import "package:ledger/types/budget.dart";
import "package:ledger/widgets/card_widget.dart";

class BudgetWidget extends StatefulWidget{
	final Budget budget;
	const BudgetWidget(this.budget);

	State<BudgetWidget> createState() => _BudgetWidget(budget);
}

class _BudgetWidget extends State<BudgetWidget> {
	final Budget budget;
	bool updated = false;
	_BudgetWidget(this.budget);

	@override
	Widget build(BuildContext context) {
		Pair<double, double> screen_size = get_screen_size(context);

		// Initializing budget and updating the state afterward
		budget.init(updated, setState);
		setState(() {
			updated = true; // Used this to not keep updating the state in a loop
		});

		return Scaffold(
			body: ClipRRect(
				borderRadius: BorderRadius.circular(10),

				// Container of the widgets
				child: Container(
					width: screen_size.x,
					height: 0.3 * screen_size.y,
					color: const Color(0xFF7E998F),

					// Budget widget's childs
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							SizedBox(width: 50),
							CardWidget(CardType.WALLET, budget.get(CardType.WALLET)),
							SizedBox(width: 50),
							CardWidget(CardType.BANK, budget.get(CardType.BANK)),
							SizedBox(width: 50),
							CardWidget(CardType.KU_CARD, budget.get(CardType.KU_CARD)),
							SizedBox(width: 50),
							CardWidget(CardType.ESEWA, budget.get(CardType.ESEWA))
						]
					) // Column
				) // Container
			) // ClipRRect
		);
	}
}
