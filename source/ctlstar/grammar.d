module ctlstar.grammar;

import pegged.grammar;

mixin(grammar(CTLStarGrammar));

immutable string CTLStarGrammar = "
	CTLStar:

		StateFormula <- AtomicProp /
						StateFormula AND StateFormula /
						StateFormula OR StateFormula /
						NOT StateFormula /
						EXISTS PathFormula /
						ALWAYS PathFormula /
						LPARENT StateFormula RPARENT

		PathFormula <-  PathFormula AND PathFormula /
						PathFormula OR PathFormula /
						NOT PathFormula /
						NEXT PathFormula  /
						GLOBALLY PathFormula /
						FUTURE PathFormula /
						PathFormula UNTIL PathFormula /
						StateFormula

		AtomicProp  <-  False /
						True /
						Expression INEQ Expression

		Expression  <-  LPARENT Expression RPARENT /
						SHARP PlaceID /
						NUMBER /
						Expression ALG_OP Expression

		EXISTS 		<-  'E'

		ALWAYS 		<-  'A'

		GLOBALLY 	<-  'G'

		FUTURE 		<-  'F'

		NEXT 		<-  'N'

		UNTIL 		<-  'U'

		AND 		<-  space* ('and' / '&&') space*

		OR 			<-  space* ('or' / '||') space*

		NOT 		<-  ('not' / '!') space*

		INEQ 		<-  space* INEQ_OP space*

		INEQ_OP 	<-  '==' / '<=' / '<' / '>=' / '>' / '!='

		ALG_OP 		<-  space* ('*' / '/' / '+' / '-') space*

		LPARENT 	<-  space* '(' space*

		RPARENT 	<-  space* ')' space*

		NUMBER 		<-  ~([0-9]+)

		SHARP 		<-  '#'

		PlaceID 	<-  identifier

		True 		<-  'true'

		False 		<-  'false'
";
