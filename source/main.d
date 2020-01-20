module main;

import ctlstar.parser;

import std.stdio;

void main(string[] args)
{
	if(args.length < 2) {
		writeln("Usage: ./ctlstar \"[formula]\"");
		return;
	}

	// parse and dump parse tree
	parse(args[1]);
}
