import "package:flutter/material.dart";
import "package:ledger/types/transaction.dart";
import "package:ledger/types/budget.dart";
import "package:ledger/widgets/card_widget.dart";

class Record extends StatelessWidget {
	final Transaction transaction;

	const Record(this.transaction);

	Widget get_card_icon(CardType ctype) {
		return Container(
			width: 30,
			height: 30,
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(10),
				color: card_color[ctype],
			) // BoxDecoration
		); // Container
	}

	Widget get_arrow(TransactionType ttype) {
		if (ttype == TransactionType.GAINED) {
			return Icon(
				Icons.keyboard_double_arrow_up_rounded,
				color: Colors.green,
			);
		}
		return Icon(
			Icons.keyboard_double_arrow_down_rounded,
			color: Colors.red,
		);
	}

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: EdgeInsets.all(16.0),
			child: Container(
				height: 100,
				decoration: BoxDecoration(
					color: Color(0xFFD9D9D9),
					borderRadius: BorderRadius.circular(10)
				), // BoxDecorator
				child: Padding(
					padding: EdgeInsets.all(20),
					child: Row(
						children: <Widget> [
							get_card_icon(transaction.ctype), // CardIcon
							SizedBox(width: 10),
							Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget> [
									Text(
										"${transaction.amount}"
									),
									get_arrow(transaction.ttype),
								] // children
							), // Column
							SizedBox(width: 35),
							Expanded(
								child: Text(
									"${this.transaction.remark}",
									overflow: TextOverflow.ellipsis,
									style: TextStyle(fontSize: 40)
								) // Text
							) // Expanded
						] // children
					) // Row
				) // Padding
			) // Container
		); // Padding
	}
}

class RecordsWidget extends StatefulWidget {
	final Transactions transactions;
	const RecordsWidget(this.transactions);

	State<RecordsWidget> createState() => _RecordsWidget(transactions);
}

class _RecordsWidget extends State<RecordsWidget> {
	final Transactions transactions;
	bool updated = false;

	_RecordsWidget(this.transactions);

	@override
	Widget build(BuildContext context) {

		transactions.init(updated, setState);
		setState(() {
			updated = true;
		});

		return Scaffold(
			body: ClipRRect(
				borderRadius: BorderRadius.circular(10),
				child: Container(
					color: const Color(0xFF7E998F),
					child: Column(
						children: <Widget> [
							Expanded(
								child: ListView.builder(
									itemCount: this.transactions.length(),
									itemBuilder: (context, index) {
										return Record(this.transactions.get(index));
									}
								) // ListView.builder
							) // Expanded
						] // children
					) // Column
				) // Container
			) // ClipRect
		);
	}
}
