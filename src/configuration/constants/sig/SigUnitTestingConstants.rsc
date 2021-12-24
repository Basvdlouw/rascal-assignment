module configuration::constants::sig::SigUnitTestingConstants

@doc{
	SIG unit testing rating constants
	
	Note: numbers in percentage of unit test coverage
	
	++ 	rating = 95-100
	+ 	rating = 80-95
	o 	rating = 60-80
	- 	rating = 20-60
	-- 	rating = 0-20
}
public real SIG_UNIT_TESTING_PLUS_PLUS 	= 95.0;
public real SIG_UNIT_TESTING_PLUS 		= 80.0;
public real SIG_UNIT_TESTING_NEUTRAL 	= 60.0;
public real SIG_UNIT_TESTING_MINUS 		= 20.0;
