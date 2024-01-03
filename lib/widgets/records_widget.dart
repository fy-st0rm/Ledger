import "package:flutter/material.dart";
import "package:ledger/types/transaction.dart";
import "package:ledger/types/budget.dart";
import "package:ledger/types/app_state.dart";
import "package:ledger/widgets/card_widget.dart";

class Record extends StatelessWidget {
	final int index;
	final Transaction transaction;
	final AppState state;
	final Function() refresh;

	const Record(this.index, this.transaction, this.state, this.refresh);

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
					padding: EdgeInsets.only(
						left: 16, right: 16, top: 10, bottom: 10
					),
					child: Row(
						children: <Widget> [
							Image(
								image: card_icon[transaction.ctype]!,
								width: 25,
								height: 25
							), // Image
							SizedBox(width: 10),
							Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget> [
									Text(
										"${transaction.amount}"
									),
									get_arrow(transaction.ttype),
									Text(
										"${transaction.date}-${transaction.day}",
										overflow: TextOverflow.ellipsis,
										style: TextStyle(fontSize: 12)
									), // Text
								] // children
							), // Column
							SizedBox(width: 35),
							Expanded(
								child: Text(
									"${transaction.remark}",
									overflow: TextOverflow.ellipsis,
									style: TextStyle(fontSize: 35)
								) // Text
							), // Expanded
							Column(
								children: <Widget> [
									Container(
										width: 35,
										height: 35,
										child: FittedBox(
											child: FloatingActionButton.small(
												onPressed: () {
													state.transactions.remove(index, transaction, state.budget);
													refresh();
												},
												tooltip: 'Remove',
												child: const Icon(Icons.remove)
											), // FloadingActionButton
										) // FittedBox
									), // Container
								] // children
							) // Column
						] // children
					) // Row
				) // Padding
			) // Container
		); // Padding
	}
}

class RecordsWidget extends StatefulWidget {
	final AppState state;
	final Function() refresh;
	const RecordsWidget(this.state, this.refresh);

	State<RecordsWidget> createState() => _RecordsWidget(state, refresh);
}

class _RecordsWidget extends State<RecordsWidget> {
	bool updated = false;
	final AppState state;
	final Function() refresh;
	_RecordsWidget(this.state, this.refresh);

	@override
	Widget build(BuildContext context) {
		state.transactions.init(updated, setState);
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
									itemCount: state.transactions.length(),
									itemBuilder: (context, index) {
										return Record(index, state.transactions.get(index), state, refresh);
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
