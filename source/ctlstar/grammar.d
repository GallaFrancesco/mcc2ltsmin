module ctlstar.grammar;

import pegged.grammar;
import core.stdc.stdio;
import std.string;
import std.stdio;
import std.random;

mixin(grammar(CTLStarGrammar));
mixin(grammar(CTLStarFuzzer));


/**
 * POC of a CTL* parser
 * --------------------
 * Syntax: SYMBOL <- EXPANSION { ACTION }
*/
immutable string CTLStarGrammar = `
	CTLStar:

		StateFormula <- AtomicProp /
                        StateFormula AND StateFormula /
                        StateFormula OR StateFormula /
                        NOT StateFormula /
						EXISTS StateFormula /
						ALWAYS StateFormula /
						NEXT StateFormula  /
						GLOBALLY StateFormula /
						FUTURE StateFormula /
						StateFormula UNTIL StateFormula /
						LPARENT StateFormula RPARENT 

		AtomicProp  <-  BasicExpr INEQ BasicExpr

		BasicExpr 	<-  BasicExpr ALG_OP BasicExpr /
						LPARENT BasicExpr RPARENT /
						PlaceID /
						NUMBER

		EXISTS 		<-  space* 'E' space* { (p) { printf(" E "); return p; }}

		ALWAYS 		<-  space* 'A' space* { (p) { printf(" A "); return p; }}

		GLOBALLY 	<-  space* 'G' space* { (p) { printf(" [] "); return p; }}

		FUTURE 		<-  space* 'F' space* { (p) { printf(" <> "); return p; }}

		NEXT 		<-  space* 'X' space* { (p) { printf(" X "); return p; }}

		UNTIL 		<-  space* 'U' space* { (p) { printf(" U "); return p; }}

		AND 		<-  space* ('and' / '&&') space* { (p) {printf(" && "); return p; }}

		OR 			<-  space* ('or' / '||') space* { (p) {printf(" || "); return p; }}

		NOT 		<-  ('not' / '!') space* { (p) {printf(" ! "); return p; }}

		INEQ 		<-  space* INEQ_OP space* 

		INEQ_OP 	<-  space* ('==' / '<=' / '<' / '>=' / '>' / '!=') space* { (p) { printf(" %s ", p.input[p.begin-2..p.end].toStringz()); return p; }}

		ALG_OP 		<-  space* ('*' / '/' / '+' / '-') space* { (p) { printf(" %s ", p.input[p.begin-1..p.end].toStringz()); return p; }}

		LPARENT 	<-  space* '(' space* { (p) { printf(" %s ", p.input[p.begin-1..p.end].toStringz()); return p; }}

		RPARENT 	<-  space* ')' space* { (p) { printf(" %s ", p.input[p.begin-1..p.end].toStringz()); return p; }}

		NUMBER 		<-  ~([0-9]+) { (p) { printf(" %s ", p.input[p.begin..p.end].toStringz()); return p; }}

		SHARP 		<-  '#'

		PlaceID 	<-  doublequote ID doublequote 

        ID          <-  identifier { (p) { printf(" %s ", p.input[p.begin..p.end].toStringz()); return p; }}
`;

bool isFirstQuantifier = true;

auto fuzz_quantifier(PT)(PT pt)
{
    if(pt.begin < pt.end) {
        // it should NEVER remove the first quantifier.
        if(isFirstQuantifier) {
            isFirstQuantifier = false;
            return pt;
        }
        Mt19937 rng;
        rng.seed(unpredictableSeed);
        bool pdel = cast(bool)dice(rng, 40, 60); // 40% false, 60% true
        if(pdel) pt.matches = [];
    }

    return pt;
}

immutable string CTLStarFuzzer = `
	CTLStarFuzz:

		StateFormula <- AtomicProp /
                        StateFormula AND StateFormula /
                        StateFormula OR StateFormula /
                        NOT StateFormula /
						EXISTS StateFormula /
						ALWAYS StateFormula /
						NEXT StateFormula  /
						GLOBALLY StateFormula /
						FUTURE StateFormula /
						StateFormula UNTIL StateFormula /
						LPARENT StateFormula RPARENT 

		AtomicProp  <-  BasicExpr INEQ BasicExpr

		BasicExpr 	<-  BasicExpr ALG_OP BasicExpr /
						LPARENT BasicExpr RPARENT /
						PlaceID /
						NUMBER

		EXISTS 		<-  space* E space* 

        E           <-  'E' { (p) { return fuzz_quantifier(p);}}

		ALWAYS 		<-  space* A space* 

        A           <-  'A' { (p) { return fuzz_quantifier(p);}}

		GLOBALLY 	<-  space* 'G' space* 

		FUTURE 		<-  space* 'F' space* 

		NEXT 		<-  space* 'X' space* 

		UNTIL 		<-  space* 'U' space* 

		AND 		<-  space* ('and' / '&&') space*

		OR 			<-  space* ('or' / '||') space* 

		NOT 		<-  ('not' / '!') space* 

		INEQ 		<-  space* INEQ_OP space* 

		INEQ_OP 	<-  space* ('==' / '<=' / '<' / '>=' / '>' / '!=') space* 

		ALG_OP 		<-  space* ('*' / '/' / '+' / '-') space* 

		LPARENT 	<-  space* '(' space* 

		RPARENT 	<-  space* ')' space* 

		NUMBER 		<-  ~([0-9]+) 

		SHARP 		<-  '#'

		PlaceID 	<-  doublequote ID doublequote 

        ID          <-  identifier 
`;
