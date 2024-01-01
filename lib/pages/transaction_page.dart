import "package:flutter/material.dart";

import "package:ledger/types/budget.dart";
import "package:ledger/types/transaction.dart";
import "package:ledger/types/app_state.dart";
import "package:ledger/utils.dart";

class TransactionPage extends StatefulWidget {
	final AppState state;
	const TransactionPage({super.key, required this.state});

	State<TransactionPage> createState() => _TransactionPage(state);
}

class _TransactionPage extends State<TransactionPage> {
	final TextEditingController card_controller = TextEditingController();
	final TextEditingController transaction_controller = TextEditingController();
	final form_key = GlobalKey<FormState>();
	final AppState state;
	final Transaction final_transaction = Transaction(0, TransactionType.GAINED, CardType.WALLET, "");

	_TransactionPage(this.state);

	@override
	Widget build(BuildContext context) {
		Pair<double, double> screen_size = get_screen_size(context);
		return Scaffold(
			body: Container(
				child: Padding(
					padding: EdgeInsets.all(28.0),
					child: Form(
						key: form_key,
						child: Column(
							children: <Widget> [
								SizedBox(height: 10),

								Expanded(
									child: Column(
										children: <Widget> [
											Text("Transaction",
												style: TextStyle(
													fontSize: 44
												) // TextStyle
											), // Text

											SizedBox(height: 45),

											Expanded(
												child: TextFormField(
													keyboardType: TextInputType.number,
													onSaved: (String? value) {
														final_transaction.amount = double.parse(value!);
													},
													decoration: InputDecoration(
														labelText: "Amount",
														border: OutlineInputBorder(),
													), // InputDecoration
													validator: (value) {
														if (value == null || value.isEmpty) {
															return "Amount is required.";
														}
														return null;
													} // Validator
												), // TextFormField
											), // Expanded

											Expanded(
												child: TextFormField(
													onSaved: (String? value) {
														final_transaction.remark = value!;
													},
													decoration: InputDecoration(
														labelText: "Remark",
														border: OutlineInputBorder(),
													), // InputDecoration
													validator: (value) {
														if (value == null || value.isEmpty) {
															return "Remark is required.";
														}
														return null;
													} // Validator
												), // TextFormField
											), // Expanded

											Expanded(
												child: DropdownMenu<TransactionType>(
													initialSelection: TransactionType.GAINED,
													controller: transaction_controller,
													requestFocusOnTap: false,
													label: Text("Transaction Type"),
													onSelected: (TransactionType? transaction_type) {
														setState(() {
															final_transaction.ttype = transaction_type!;
														});
													},
													dropdownMenuEntries: TransactionType.values.map<DropdownMenuEntry<TransactionType>>(
														(TransactionType transaction_type) {
															return DropdownMenuEntry<TransactionType>(
																value: transaction_type,
																label: transaction_type.label
															);
														}
													).toList()
												), // DropdownMenu<TransactionType>
											), // Expanded

											Expanded(
												child: DropdownMenu<CardType>(
													initialSelection: CardType.WALLET,
													controller: card_controller,
													requestFocusOnTap: false,
													label: Text("Card Type"),
													onSelected: (CardType? card_type) {
														setState(() {
															final_transaction.ctype = card_type!;
														});
													},
													dropdownMenuEntries: CardType.values.map<DropdownMenuEntry<CardType>>(
														(CardType card_type) {
															return DropdownMenuEntry<CardType>(
																value: card_type,
																label: card_type.label
															);
														}
													).toList()
												), // DropdownMenu<CardType>
											) // Expanded
										] // children
									) // Column
								), // Expanded

								Align(
									alignment: Alignment.bottomCenter,
									child: Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: <Widget>[
											ElevatedButton(
												child: Text("Submit"),
												onPressed: () {
													if (form_key.currentState!.validate()) {
														form_key.currentState!.save();
															double budget = state.budget.get(final_transaction.ctype);
															bool res = state.transactions.create(
																final_transaction, state.budget
															);
															if (!res) {
																ScaffoldMessenger.of(context).showSnackBar(
																	const SnackBar(
																		content: Text('Not enought money.',
																			style: TextStyle(
																				fontSize: 14,
																				color: Color.fromARGB(255, 255, 255, 255)
																			) // TextStyle
																		) // Text
																	), // SnackBar
																);
															}
														Navigator.of(context, rootNavigator: true).pop();
													}
												}
											), // ElevatedButton
											SizedBox(width: 50),
											ElevatedButton(
												child: Text("Cancel"),
												onPressed: () {
													Navigator.of(context, rootNavigator: true).pop();
												}
											) // ElevatedButton
										] // children
									) // Row
								) // Algin
							] // children
						) // Column
					) // Form
				) // Container
			), // Padding
		); // Scaffold
	}
}
