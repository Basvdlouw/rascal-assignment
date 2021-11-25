module analysis::UnitComplexity

import configuration::data_types::Rank;
import utils::MathUtils;
import configuration::constants::sig::SigCyclomaticComplexityConstants;

@doc {
    Compute total lines of code for a list of complexity units

    Parameters: 
    - lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)

    Returns: 
    - int aggregated loc

    it syntax:
    https://github.com/usethesource/rascal/blob/82074afd6ab3bb0fa2dae2c83538c0cfd1f29699/src/org/rascalmpl/courses/Rascal/Expressions/Reducer/Reducer.concept
    https://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Expressions/Reducer/Reducer.html
}
private int computeTotalLinesOfCode(lrel[loc, int, int] complexityUnits) {
    return (0 | it + y | <x, y, z> <- complexityUnits);
}

@doc {
	Compute cyclomatic complexity rating based on SIG model
    
	Parameters:
	- num volume in loc

	Returns:
	- Rank rank
}
public Rank computeCyclomaticComplexityRank(real moderateRiskPercentage, real highRiskPercentage, real veryHighRiskPercentage) {
	if(moderateRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_PLUS_PLUS[0] 
			&& highRiskPercentage == SIG_CYCLOMATIC_COMPLEXITY_PLUS_PLUS[1] 
			&& veryHighRiskPercentage == SIG_CYCLOMATIC_COMPLEXITY_PLUS_PLUS[2]) {
		return \plusplus();
	} else if(moderateRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_PLUS[0] 
			&& highRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_PLUS[1] 
			&& veryHighRiskPercentage == SIG_CYCLOMATIC_COMPLEXITY_PLUS[2]) {
		return \plus();
	} else if(moderateRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_NEUTRAL[0] 
			&& highRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_NEUTRAL[1] 
			&& veryHighRiskPercentage == SIG_CYCLOMATIC_COMPLEXITY_NEUTRAL[2]) {
		return \neutral();
	} else if(moderateRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_MINUS[0] 
			&& highRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_MINUS[1] 
			&& veryHighRiskPercentage <= SIG_CYCLOMATIC_COMPLEXITY_MINUS[2]) {
		return \minus();
	}
	return \minusminus();
}

@doc {
    Compute cyclomatic complexity

    Parameters: 
    - lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
    - int lines of code in project

    Returns: 
    - Rank rank
}
public Rank computeCyclomaticComplexity(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return computeCyclomaticComplexityRank(
			computeModerateCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode),
			computeHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode),
			computeVeryHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode)
		);
}

@doc {
	Calculate percentage of simple cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeSimpleCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y, z> | <x, y, z> <- complexityUnits, z > 0, z <= SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK]), 
			projectLinesOfCode
		);
}

@doc {
	Calculate percentage of moderate cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeModerateCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y, z> | <x, y, z> <- complexityUnits, z > SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK, z <= SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK]), 
			projectLinesOfCode
		);
}

@doc {
	Calculate percentage of high risk cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeHighRiskCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y, z> | <x, y, z> <- complexityUnits, z > SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK, z <= SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK]), 
			projectLinesOfCode
		);
}

@doc {
	Calculate percentage of very high risk cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeVeryHighRiskCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y, z> | <x, y, z> <- complexityUnits, z > SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK]), 
			projectLinesOfCode
		);
}
