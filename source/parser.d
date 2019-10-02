module parser;

import ctlstar.grammar;

import std.stdio;

void main(string[] args)
{
	if(args.length < 2) {
		writeln("Usage: ./ctlstar \"[formula]\"");
		return;
	}

	immutable formula = args[1];
	writeln("Parsing: " ~ formula);
	auto pt = CTLStar(formula);

	writeln(pt);
}
