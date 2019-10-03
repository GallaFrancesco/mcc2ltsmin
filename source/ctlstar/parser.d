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
	assert(parseOK("(AFG(#p2 > 0) or AGEF(#p2 < 2) )"));

	immutable fm1 = "AG(XF(#p1 > 0) and !((#p2 <= 3) U G (#p1 == 1)))";
	assert(parseOK("AG(XF(#p1 > 0) and !((#p2 <= 3) U G (#p1 == 1)))"));

	immutable fm2 = "AXG!(#p4 < 400) and EFG((#p1 > 0) || A(true U (#p4 < 400)))";
	assert(parseOK("AXG!(#p4 < 400) and EFG((#p1 > 0) || A(true U (#p4 < 400)))"));

	immutable fm3 = "(AFG(#p2 > 234) or (AGEF(#p5 == 0)))";
	assert(parseOK("(AFG(#p2 > 234) or (AGEF(#p5 == 0)))"));

	immutable fm4 = "((EFG(#p1 == (8*4)) && AF(true U (#p32 < 1))))";
	assert(parseOK("((EFG(#p1 == (8*4)) && AF(true U (#p32 < 1))))"));
}
