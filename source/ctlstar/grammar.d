module ctlstar.grammar;

import pegged.grammar;

mixin(grammar(CTLStarGrammar));

/**
 * POC of a CTL* parser
 * --------------------
 * Syntax: SYMBOL <- EXPANSION { ACTION }
*/
immutable string CTLStarGrammar = `
	CTLStar:

		StateFormula <- StateFormula AND StateFormula /
						StateFormula OR StateFormula /
						NOT StateFormula /
						EXISTS PathFormula /
						ALWAYS PathFormula /
						LPARENT StateFormula RPARENT /
						AtomicProp

		PathFormula <- 	PathFormula AND PathFormula /
						PathFormula OR PathFormula /
						NOT PathFormula /
						NEXT PathFormula  /
						GLOBALLY PathFormula /
						FUTURE PathFormula /
						PathFormula UNTIL PathFormula /
						LPARENT PathFormula RPARENT /
						StateFormula

		AtomicProp  <-	BasicExpr INEQ BasicExpr /
						LPARENT AtomicProp RPARENT

		BasicExpr 	<-  BasicExpr ALG_OP BasicExpr /
						PlaceID /
						LPARENT BasicExpr RPARENT /
						NUMBER

		EXISTS 		<-  space* 'E' space*

		ALWAYS 		<-  space* 'A' space*

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

		PlaceID 	<-  doublequote identifier doublequote

`;
