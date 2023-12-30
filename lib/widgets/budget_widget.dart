import "package:flutter/material.dart";
import "package:ledger/utils.dart";
import "package:ledger/budget.dart";
import "package:ledger/widgets/card_widget.dart";

class BudgetWidget extends StatelessWidget {
	final Budget budget;
	const BudgetWidget(this.budget);

	@override
	Widget build(BuildContext context) {
		Pair<double, double> screen_size = get_screen_size(context);

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
