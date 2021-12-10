module analysis::UnitSize

import configuration::data_types::Rank;
import configuration::constants::sig::SigUnitSizeConstants;
import analysis::m3::AST;

import utils::MathUtils;
import Map;
import List;

@doc {
    Compute total lines of code for a list of unit sizes

    Parameters: 
    - lrel[Declaration, int] List relation with unit, loc (lines of code)

    Returns: 
    - int aggregated loc

    it syntax:
    https://github.com/usethesource/rascal/blob/82074afd6ab3bb0fa2dae2c83538c0cfd1f29699/src/org/rascalmpl/courses/Rascal/Expressions/Reducer/Reducer.concept
    https://tutor.rascal-mpl.org/Rascal/Rascal.html#/Rascal/Expressions/Reducer/Reducer.html
}
private int computeTotalLinesOfCode(lrel[Declaration, int] unitSizes) {
    return (0 | it + y | <_, y> <- unitSizes);
}

@doc {
	Compute unit size rating based on SIG model
    
	Parameters:
	- real moderateRiskPercentage
	- real highRiskPercentage
	- real veryHighRiskPercentage

	Returns:
	- Rank rank
}
public Rank computeUnitSizeRank(real moderateRiskPercentage, real highRiskPercentage, real veryHighRiskPercentage) {
	if(moderateRiskPercentage 			<= 	SIG_UNIT_SIZE_PLUS_PLUS[0] 
			&& highRiskPercentage 		== SIG_UNIT_SIZE_PLUS_PLUS[1] 
			&& veryHighRiskPercentage 	== SIG_UNIT_SIZE_PLUS_PLUS[2]) {
		return \plusplus();
	} else if(moderateRiskPercentage 	<= SIG_UNIT_SIZE_PLUS[0] 
			&& highRiskPercentage 		<= SIG_UNIT_SIZE_PLUS[1] 
			&& veryHighRiskPercentage 	== SIG_UNIT_SIZE_PLUS[2]) {
		return \plus();
	} else if(moderateRiskPercentage 	<= SIG_UNIT_SIZE_NEUTRAL[0] 
			&& highRiskPercentage 		<= SIG_UNIT_SIZE_NEUTRAL[1] 
			&& veryHighRiskPercentage	== SIG_UNIT_SIZE_NEUTRAL[2]) {
		return \neutral();
	} else if(moderateRiskPercentage 	<= SIG_UNIT_SIZE_MINUS[0] 
			&& highRiskPercentage 		<= SIG_UNIT_SIZE_MINUS[1] 
			&& veryHighRiskPercentage 	<= SIG_UNIT_SIZE_MINUS[2]) {
		return \minus();
	}
	return \minusminus();
}

@doc {
    Compute unit size

    Parameters: 
    - map[Declarataion, int] unitSizeUnits units mapped to loc
    - int projectLinesOfCode lines of code in project

    Returns: 
    - Rank rank
}
public Rank computeUnitSize(map[Declaration, int] unitSizeUnits, int projectLinesOfCode) {
	return computeUnitSizeRank(
			computeModerateUnitSizePercentage(unitSizeUnits, projectLinesOfCode),
			computeHighRiskUnitSizePercentage(unitSizeUnits, projectLinesOfCode),
			computeVeryHighRiskUnitSizePercentage(unitSizeUnits, projectLinesOfCode)
		);
}

@doc{
	Calculate percentage of simple unit sizes
	
	Parameters 
	- map[Declaration, int] unitSizeUnits unit mapped to loc (lines of code)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeSimpleUnitSizePercentage(map[Declaration, int] unitSizeUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toList(unitSizeUnits), y > 0, y <= SIG_UNIT_SIZE_LOW_RISK]), 
			projectLinesOfCode
		);
}


@doc{
	Calculate percentage of moderate risk for unit sizes
	
	Parameters 
	- map[Declaration, int] unitSizeUnits unit mapped to loc (lines of code)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeModerateUnitSizePercentage(map[Declaration, int] unitSizeUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toList(unitSizeUnits), y > SIG_UNIT_SIZE_LOW_RISK, y <= SIG_UNIT_SIZE_MODERATE_RISK]), 
			projectLinesOfCode
		);
}

@doc{
	Calculate percentage of high risk for unit sizes
	
	Parameters 
	- map[Declaration, int] unitSizeUnits unit mapped to loc (lines of code)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeHighRiskUnitSizePercentage(map[Declaration, int] unitSizeUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toList(unitSizeUnits), y > SIG_UNIT_SIZE_MODERATE_RISK, y <= SIG_UNIT_SIZE_HIGH_RISK]), 
			projectLinesOfCode
		);
}

@doc{
	Calculate percentage of very high risk for unit sizes
	
	Parameters 
	- map[Declaration, int] unitSizeUnits unit mapped to loc (lines of code)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeVeryHighRiskUnitSizePercentage(map[Declaration, int] unitSizeUnits, int projectLinesOfCode) {
	return calculatePercentage(computeTotalLinesOfCode(
			[<x, y> | <x, y> <- toList(unitSizeUnits), y > SIG_UNIT_SIZE_HIGH_RISK]), 
			projectLinesOfCode
		);
}


