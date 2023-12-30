import "package:flutter/material.dart";

import "package:ledger/home.dart";

void main() {
	runApp(const App());
}

class App extends StatelessWidget {
	const App({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: "Ledger",
			theme: ThemeData(
				scaffoldBackgroundColor: const Color(0xFFD9D9D9),
				useMaterial3: true,
			),
			home: const Home()
		);
	}
}
