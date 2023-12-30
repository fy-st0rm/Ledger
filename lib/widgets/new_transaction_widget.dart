import "package:flutter/material.dart";
import "package:ledger/budget.dart";
import "package:ledger/transaction.dart";
import "package:ledger/utils.dart";
import "package:ledger/app_state.dart";

class NewTransactionWidget extends StatefulWidget {
	final AppState state;
	const NewTransactionWidget({super.key, required this.state});

	State<NewTransactionWidget> createState() => _NewTransactionWidget(state);
}

class _NewTransactionWidget extends State<NewTransactionWidget> {
	final TextEditingController card_controller = TextEditingController();
	final TextEditingController transaction_controller = TextEditingController();
	final form_key = GlobalKey<FormState>();
	final AppState state;

	_NewTransactionWidget(this.state);

	Transaction final_transaction = Transaction(0, TransactionType.GAINED, CardType.WALLET, "");

	@override
	Widget build(BuildContext context) {
		Pair<double, double> screen_size = get_screen_size(context);

		return Scaffold(
			body: Container(
				child: Padding(
					padding: EdgeInsets.all(18.0),
					child: Form(
						key: form_key,
						child: Column(
							children: <Widget> [
								Expanded(
									child: TextFormField(
										keyboardType: TextInputType.number,
										onSaved: (String? value) {
											final_transaction.amount = double.parse(value!);
										},
										decoration: InputDecoration(
											labelText: "Amount",
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
										), // InputDecoration
										validator: (value) {
											if (value == null || value.isEmpty) {
												return "Remark is required.";
											}
											return null;
										} // Validator
									), // TextFormField
								), // Expanded

								SizedBox(height: 10),

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
									) // DropdownMenu<CardType>
								), // Expanded

								Expanded(
									child: Row(
										children: <Widget>[
											ElevatedButton(
												child: Text("Submit"),
												onPressed: () {
													if (form_key.currentState!.validate()) {
														form_key.currentState!.save();
														setState(() {
															double budget = state.budget.get(final_transaction.ctype);
															if (budget < final_transaction.amount) {
																return;
															}
															state.transactions.create_transaction(
																final_transaction.amount,
																final_transaction.ttype,
																final_transaction.ctype,
																final_transaction.remark
															);
														});
														Navigator.of(context, rootNavigator: true).pop();
													}
												}
											), // ElevatedButton
											ElevatedButton(
												child: Text("Cancel"),
												onPressed: () {
													Navigator.of(context, rootNavigator: true).pop();
												}
											) // ElevatedButton
											
										] // children
									) // Row
								) // Expanded
							] // children
						) // Column
					) // Form
				) // Container
			), // Padding
		); // Scaffold
	}
}
