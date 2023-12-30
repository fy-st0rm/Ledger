import "package:flutter/material.dart";
import "package:ledger/transaction.dart";

class Record extends StatelessWidget {
	final Transaction transaction;

	const Record(this.transaction);

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
				child: Center(
					child: Text(
						"${this.transaction.remark}",
						style: TextStyle(fontSize: 40)
					) // Text
				) // Center
			) // Container
		); // Padding
	}
}

class RecordsWidget extends StatelessWidget {
	final Transactions transactions;

	const RecordsWidget(this.transactions);

	@override
	Widget build(BuildContext context) {
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
