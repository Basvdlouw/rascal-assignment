module analysis::UnitComplexity

import configuration::data_types::Rank;
import configuration::constants::sig::SigCyclomaticComplexityConstants;
import utils::MathUtils;
import lang::java::m3::AST;
import Map;

@doc {
    Compute total lines of code for a list of complexity units

    Parameters: 
    - lrel[Declaration, int] List relation with unit, cyclomatic complexity

    Returns: 
    - int aggregated loc

    it syntax:
    https://github.com/usethesource/rascal/blob/82074afd6ab3bb0fa2dae2c83538c0cfd1f29699/src/org/rascalmpl/courses/Rascal/Expressions/Reducer/Reducer.concept
    https://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Expressions/Reducer/Reducer.html
}
private int computeTotalLinesOfCode(lrel[Declaration, int] complexityUnits) {
    return (0 | it + y | <_, y> <- complexityUnits);
}

@doc {
	Compute cyclomatic complexity rating based on SIG model
    
	Parameters:
	- real moderateRiskPercentage
	- real highRiskPercentage
	- real veryHighRiskPercentage

	Returns:
	- Rank rank
}
public Rank computeCyclomaticComplexityRank(real moderateRiskPercentage, real highRiskPercentage, real veryHighRiskPercentage) {
	if(moderateRiskPercentage 			<= SIG_CYCLOMATIC_COMPLEXITY_PLUS_PLUS[0] 
			&& highRiskPercentage 		== SIG_CYCLOMATIC_COMPLEXITY_PLUS_PLUS[1] 
			&& veryHighRiskPercentage 	== SIG_CYCLOMATIC_COMPLEXITY_PLUS_PLUS[2]) {
		return \plusplus();
	} else if(moderateRiskPercentage 	<= SIG_CYCLOMATIC_COMPLEXITY_PLUS[0] 
			&& highRiskPercentage 		<= SIG_CYCLOMATIC_COMPLEXITY_PLUS[1] 
			&& veryHighRiskPercentage	 == SIG_CYCLOMATIC_COMPLEXITY_PLUS[2]) {
		return \plus();
	} else if(moderateRiskPercentage 	<= SIG_CYCLOMATIC_COMPLEXITY_NEUTRAL[0] 
			&& highRiskPercentage 		<= SIG_CYCLOMATIC_COMPLEXITY_NEUTRAL[1] 
			&& veryHighRiskPercentage 	== SIG_CYCLOMATIC_COMPLEXITY_NEUTRAL[2]) {
		return \neutral();
	} else if(moderateRiskPercentage 	<= SIG_CYCLOMATIC_COMPLEXITY_MINUS[0] 
			&& highRiskPercentage 		<= SIG_CYCLOMATIC_COMPLEXITY_MINUS[1] 
			&& veryHighRiskPercentage 	<= SIG_CYCLOMATIC_COMPLEXITY_MINUS[2]) {
		return \minus();
	}
	return \minusminus();
}

@doc {
    Compute cyclomatic complexity

    Parameters: 
  	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
    - int lines of code in project

    Returns: 
    - Rank rank
}
public Rank computeCyclomaticComplexity(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return computeCyclomaticComplexityRank(
			computeModerateCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode),
			computeHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode),
			computeVeryHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode)
		);
}

@doc {
	Calculate percentage of simple cyclomatic complexity
	
	Parameters 
  	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeSimpleCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toRel(complexityUnits), y > 0, y <= SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK]), 
			projectLinesOfCode
		);
}

@doc {
	Calculate percentage of moderate cyclomatic complexity
	
	Parameters 
  	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeModerateCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toRel(complexityUnits), y > SIG_CYCLOMATIC_COMPLEXITY_LOW_RISK, y <= SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK]), 
			projectLinesOfCode
		);
}

@doc {
	Calculate percentage of high risk cyclomatic complexity
	
	Parameters 
  	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeHighRiskCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toRel(complexityUnits), y > SIG_CYCLOMATIC_COMPLEXITY_MODERATE_RISK, y <= SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK]), 
			projectLinesOfCode
		);
}

@doc {
	Calculate percentage of very high risk cyclomatic complexity
	
	Parameters 
  	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeVeryHighRiskCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toRel(complexityUnits), y > SIG_CYCLOMATIC_COMPLEXITY_HIGH_RISK]), 
			projectLinesOfCode
		);
}
