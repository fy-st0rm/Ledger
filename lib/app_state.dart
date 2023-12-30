import "package:ledger/transaction.dart";
import "package:ledger/budget.dart";

class AppState {
	late Budget budget;
	late Transactions transactions;

	AppState() {
		this.budget = Budget(0, 0, 0, 0);
		this.transactions = Transactions();
	}
}
