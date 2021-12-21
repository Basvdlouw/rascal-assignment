module configuration::constants::sig::SigDuplicationConstants

@doc{
	SIG Duplicaation rating constants
	
	Note: numbers in percentage of duplicate code
	++ 	rating = 0..3
	+ 	rating = 3..5
	o 	rating = 5..10
	- 	rating = 10..20
	-- 	rating = 20..100
}
public int SIG_DUPLICATION_PLUS_PLUS = 3;
public int SIG_DUPLICATION_PLUS = 5;
public int SIG_DUPLICATION_NEUTRAL = 10;
public int SIG_DUPLICATION_MINUS = 20;
