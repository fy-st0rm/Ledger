import "package:ledger/types/transaction.dart";
import "package:ledger/types/budget.dart";

class AppState {
	late Budget budget;
	late Transactions transactions;

	AppState() {
		budget = Budget();
		transactions = Transactions();
	}
}
