enum CardType {
	WALLET("Wallet"),
	BANK("Bank"),
	KU_CARD("KU Card"),
	ESEWA("Esewa");

	const CardType(this.label);
	final String label;
}

class Budget {
	Map<CardType, double> _budget = Map();

	Budget(double wallet, double bank, double ku_card, double esewa) {
		this._budget[CardType.WALLET] = wallet;
		this._budget[CardType.BANK] = bank;
		this._budget[CardType.KU_CARD] = ku_card;
		this._budget[CardType.ESEWA] = esewa;
	}

	double get(CardType ctype) {
		return this._budget[ctype]!;
	}
}
