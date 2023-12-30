import "package:flutter/material.dart";

class Pair<T1, T2> {
	final T1 x;
	final T2 y;

	Pair(this.x, this.y);
}

Pair<double, double> get_screen_size(BuildContext context) {
	double screen_width = MediaQuery.of(context).size.width;
	double screen_height = MediaQuery.of(context).size.height;
	EdgeInsets padding = MediaQuery.of(context).padding;
	screen_height = screen_height - padding.top - padding.bottom;
	return Pair(screen_width, screen_height);
}
