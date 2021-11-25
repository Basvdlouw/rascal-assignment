module configuration::constants::sig::SigCyclomaticComplexityConstants

@doc{
	SIG Cyclomatic complexity rating constants
	
	++ rating 	= <moderate, 25%>, <high, 0%>, 	<very high, 0%> 
	+ rating 	= <moderate, 30%>, <high, 5%>, 	<very high, 0%> 
	o rating	= <moderate, 40%>, <high, 10%>, <very high, 0%> 
	- rating 	= <moderate, 50%>, <high, 15%>, <very high, 5%> 
	-- rating 	= Higher % in any of the above categories results in -- rating
}
public list[real] SIG_CYCLOMATIC_COMPLEXITY_PLUS_PLUS 	= [25.0, 0.0, 0.0];
public list[real] SIG_CYCLOMATIC_COMPLEXITY_PLUS		= [30.0, 5.0, 0.0];
public list[real] SIG_CYCLOMATIC_COMPLEXITY_NEUTRAL 	= [40.0, 10.0, 0.0];
public list[real] SIG_CYCLOMATIC_COMPLEXITY_MINUS 		= [50.0, 15.0, 0.0];

@doc{
	SIG Cyclomatic complexity rating constants per unit
	
	simple, without much risk rating 	= CC 1-10
	more complex, moderate risk 		= CC 11-20
	complex, high risk					= CC 21-50
	untestable, very high risk 			= CC > 50
}
public int SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK		= 10;
public int SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK 	= 20;
public int SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK 		= 50;
