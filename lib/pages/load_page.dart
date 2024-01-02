import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import "package:ledger/types/budget.dart";
import "package:ledger/types/transaction.dart";
import "package:ledger/types/app_state.dart";
import "package:ledger/utils.dart";

class LoadPage extends StatefulWidget {
	final AppState state;
	const LoadPage({super.key, required this.state});

	State<LoadPage> createState() => _LoadPage(state);
}

class _LoadPage extends State<LoadPage> {
	final Transaction load_t = Transaction(0, TransactionType.GAINED, CardType.WALLET, "", "", 0);
	final Transaction unload_t = Transaction(0, TransactionType.SPENT, CardType.WALLET, "", "", 0);

	final TextEditingController card_controller_load = TextEditingController();
	final TextEditingController card_controller_unload = TextEditingController();
	final form_key = GlobalKey<FormState>();
	final AppState state;

	_LoadPage(this.state);

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
											Text("Load Money",
												style: TextStyle(
													fontSize: 44
												) // TextStyle
											), // Text

											SizedBox(height: 45),

											Expanded(
												child: TextFormField(
													keyboardType: TextInputType.number,
													onSaved: (String? value) {
														load_t.amount = double.parse(value!);
														unload_t.amount = double.parse(value!);
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
														load_t.remark = value!;
														unload_t.remark = value!;
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
												child: DropdownMenu<CardType>(
													initialSelection: CardType.WALLET,
													controller: card_controller_unload,
													requestFocusOnTap: false,
													label: Text("Load from"),
													onSelected: (CardType? card_type) {
														setState(() {
															unload_t.ctype = card_type!;
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
											), // Expanded

											Expanded(
												child: DropdownMenu<CardType>(
													initialSelection: CardType.WALLET,
													controller: card_controller_load,
													requestFocusOnTap: false,
													label: Text("Load to"),
													onSelected: (CardType? card_type) {
														setState(() {
															load_t.ctype = card_type!;
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
											FloatingActionButton(
												tooltip: 'Submit',
												child: const Icon(Icons.check),
												onPressed: () {
													if (form_key.currentState!.validate()) {
														form_key.currentState!.save();

														String curr_date = DateFormat('yyyy-MM').format(DateTime.now());
														unload_t.date = curr_date;
														load_t.date = curr_date;

														unload_t.day = DateTime.now().day;
														load_t.day = DateTime.now().day;

														double max = state.budget.get(unload_t.ctype);
														if (max < unload_t.amount) {
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
														} else {
															state.budget.spent(unload_t.ctype, unload_t.amount);
															bool res = state.transactions.create(
																load_t, state.budget
															);
														}
														Navigator.of(context, rootNavigator: true).pop();
													}
												}
											), // ElevatedButton
											SizedBox(width: 50),
											FloatingActionButton(
												tooltip: 'Cancel',
												child: const Icon(Icons.close_outlined),
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
