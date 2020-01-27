module main;

import ctlstar.parser;

import std.stdio;
import std.string;

int main(string[] args)
{
	if(args.length < 2 && args.length > 3) {
		writeln("Usage: ./ctlstar [--fuzz] \"[formula]\"");
		return 0;
	}

    string formula;
    if(args[1] == "--fuzz") {
        formula = fuzz(args[2]).matches.join();
        writeln(formula);
    } else {
        formula = args[1];
    }

	auto pt = parse(formula);
    return !pt.successful;
}
