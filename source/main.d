module main;

import ctlstar.parser;

import std.stdio;
import std.string;

void main(string[] args)
{
	if(args.length < 2) {
		writeln("Usage: ./ctlstar \"[formula]\"");
		return;
	}

    string fuzzed = fuzz(args[1]).matches.join();
    writeln(fuzzed);

	auto pt = parse(fuzzed);
}
