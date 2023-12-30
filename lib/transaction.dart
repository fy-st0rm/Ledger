import "package:ledger/budget.dart";

enum TransactionType {
	GAINED("Gained"),
	SPENT("Spent");

	const TransactionType(this.label);
	final String label;
}

class Transaction {
	double amount;
	TransactionType ttype;
	CardType ctype;
	String remark;

	Transaction(this.amount, this.ttype, this.ctype, this.remark);
}

class Transactions {
	// TODO: change list to hashmap
	List<Transaction> _transactions = [];

	void create_transaction(double amount, TransactionType ttype, CardType ctype, String remark) {
		this._transactions.add(
			Transaction(amount, ttype, ctype, remark)
		);
	}

	int length() {
		return this._transactions.length;
	}

	Transaction get(int index) {
		return this._transactions[index];
	}
}
