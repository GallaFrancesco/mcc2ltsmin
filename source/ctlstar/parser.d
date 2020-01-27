module ctlstar.parser;

import ctlstar.grammar;

auto parse(immutable string formula)
{
	version (tracer)
	{
		import pegged.peg;
		import std.algorithm;
		import std.experimental.logger;

		// dump extremely verbose parser trace for debugging
		sharedLog = new TraceLogger("trace.pegged");
		setTraceConditionFunction(
				(string ruleName, const ref ParseTree p) =>
					ruleName.startsWith("CTLStar")
				);
	}

	// actual parsing
	auto pt = CTLStar(formula);

	return pt;
}

auto fuzz(immutable string formula)
{
    auto pt = CTLStarFuzz(formula);
    return pt;
}

unittest {
	bool parseOK(immutable string formula) {
		import std.stdio;
		writeln("\nParsing: " ~ formula ~ "\n");
		auto pt = parse(formula);
		writeln(pt);
		writeln("---");
		return pt.successful;
	}

	// example formulas taken from Principles of MC - Katoen - CTL* section
	assert(parseOK("(A F G(\"p2\" > 0) or A G E F(\"p2\" < 2) )"));

	assert(parseOK("A G(X F(\"p1\" > 0) and !((\"p2\" <= 3) U G (\"p1\" == 1)))"));

	assert(parseOK("A X G!(\"p4\" < 400) and E F G((\"p1\" > 0) || A (true U (\"p4\" < 400)))"));

	assert(parseOK("(A F G(\"p2\" > 234) or (A G E F(\"p5\" == 0)))"));

	assert(parseOK("((E F G(\"p1\" == (8*4)) && A F(\"p32\" < 1)))"));
}
