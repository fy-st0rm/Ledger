import "package:flutter/material.dart";
import "package:ledger/types/budget.dart";

Map<CardType, AssetImage> card_icon = {
	CardType.WALLET : AssetImage("assets/wallet.png"),
	CardType.BANK   : AssetImage("assets/bank.png"),
	CardType.KU_CARD: AssetImage("assets/ku_icon.png"),
	CardType.ESEWA  : AssetImage("assets/esewa_icon.png")
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
					Image(
						image: card_icon[ctype]!,
						width: 25,
						height: 25
					), // Image
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

