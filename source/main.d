module main;

import ctlstar.parser;

import std.stdio;
import std.getopt;
import std.string;
import core.stdc.stdio;

int main(string[] args)
{
    bool doFuzz = false;
    string formula;

    auto helpInformation = getopt(
            args,
            "query|q", "The LTL/CTL formula to be processed", &formula,
            "fuzz|f","Generate a CTL* formula from a CTL one", &doFuzz);

    if(helpInformation.helpWanted | formula.empty) {
        defaultGetoptPrinter(
            "Usage: ./mcc2ltsmin [--fuzz] --query|q \"[formula]\"",
            helpInformation.options);
        return 1;
    }

    if(doFuzz) {
        formula = fuzz(formula).matches.join();
        writeln(formula);
    }

	auto pt = parse(formula);

    if(!pt.successful) writeln(pt);
    else printf("\n");

    return !pt.successful;
}
