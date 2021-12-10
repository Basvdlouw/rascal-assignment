module configuration::constants::sig::SigUnitSizeConstants

@doc{
	SIG Unit size rating constants
	
		Ratings from leitner 2017
}
public list[real] SIG_UNIT_SIZE_PLUS_PLUS 	= [25.0, 0.0, 0.0];
public list[real] SIG_UNIT_SIZE_PLUS		= [30.0, 5.0, 0.0];
public list[real] SIG_UNIT_SIZE_NEUTRAL 	= [40.0, 10.0, 0.0];
public list[real] SIG_UNIT_SIZE_MINUS 		= [50.0, 15.0, 5.0];

@doc{
	SIG Unit size rating constants per unit, unit size measured by lines of code (loc)
	
	Ratings from leitner 2017
}
public int SIG_UNIT_SIZE_LOW_RISK		= 10;
public int SIG_UNIT_SIZE_MODERATE_RISK 	= 20;
public int SIG_UNIT_SIZE_HIGH_RISK 		= 40;
