import "package:flutter/material.dart";
import "package:ledger/types/totals.dart";
import "package:ledger/utils.dart";

class Total extends StatelessWidget {
	final Pair<String, double> total;

	Total(this.total);

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
					padding: EdgeInsets.all(10),
					child: Column(
						children: <Widget> [
							Text(
								"${total.x}",
								overflow: TextOverflow.ellipsis,
								style: TextStyle(fontSize: 12)
							), // Text
							Expanded(
								child: Text(
									"Rs. ${total.y}",
									overflow: TextOverflow.ellipsis,
									style: TextStyle(fontSize: 40)
								), // Text
							), // Expanded
						] // children
					) // Column
				) // Padding
			) // Container
		); // Padding
	}
}

class TotalsPage extends StatefulWidget {
	final Totals totals;
	const TotalsPage({super.key, required this.totals});

	State<TotalsPage> createState() => _TotalsPage(totals);
}

class _TotalsPage extends State<TotalsPage> {
	final Totals totals;
	_TotalsPage(this.totals);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Padding(
				padding: EdgeInsets.only(
					top: 55.0, bottom: 55.0, left: 16.0, right: 16.0
				), // EdgeInsets
				child: Column(
					children: <Widget> [
						Text(
							"Totals:",
							style: TextStyle(
								fontSize: 30
							)
						), // Text

						SizedBox(height: 10),

						Expanded(
							child: ClipRRect(
								borderRadius: BorderRadius.circular(10),
								child: Container(
									color: const Color(0xFF7E998F),
									child: Column(
										children: <Widget> [
											Expanded(
												child: ListView.builder(
													itemCount: totals.length(),
													itemBuilder: (context, index) {
														return Total(totals.get(index));
													}
												) // ListView.builder
											), // Expanded
										] // children
									) // Column
								), // Container
							), // ClipRect
						), // Expanded

						SizedBox(height: 10),

						Align(
							alignment: Alignment.centerRight,
							child: FloatingActionButton(
								onPressed: () {
									Navigator.of(context).pop();
								},
								tooltip: 'Back',
								child: const Icon(Icons.arrow_back_ios_new)
							), // FloadingActionButton
						), // Align
					] // children
				) // Column
			) // Padding
		); // Scaffold
	}
}

