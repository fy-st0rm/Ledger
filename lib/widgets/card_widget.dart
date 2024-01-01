import "package:flutter/material.dart";
import "package:ledger/types/budget.dart";

Map<CardType, Color> card_color = {
	CardType.WALLET: Colors.brown,
	CardType.BANK: Colors.lightGreen,
	CardType.KU_CARD: Colors.red,
	CardType.ESEWA: Colors.green
};


class CardWidget extends StatelessWidget {
	final CardType ctype;
	final double budget;

	CardWidget(this.ctype, this.budget);

	@override
	Widget build(BuildContext context) {
		return Expanded(
			child: Row(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget> [
					SizedBox(width: 40),
					Container(
						width: 30,
						height: 30,
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(10),
							color: card_color[ctype],
						) // BoxDecoration
					), // Container

					SizedBox(width: 20),
					Expanded(
						child: Text(
							"Rs. ${budget}",
							style: TextStyle(
								fontSize: 30,
								color: Colors.white
							)
						), // Text
					) // Expanded
				] // children
			), // Row
		); // Expanded
	}
}

