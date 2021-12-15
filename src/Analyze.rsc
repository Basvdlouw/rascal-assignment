@doc{
	Facade module which uses submodules to compute Ranks
}
module Analyze

import configuration::data_types::Rank;
import configuration::data_types::UnitSizes;
import analysis::m3::AST;
 
import analysis::Volume;
import analysis::Duplication;
import analysis::UnitSize;
import analysis::UnitComplexity;

import metrics::UnitSize;
import configuration::constants::sig::SigUnitSizeConstants;
import Map;
import Relation;
import util::Math;

import IO;

@doc{
    Uses submodule analysis::Volume
    
    Compute project volume rating.

    Parameters:
    - int volume in LinesOfCode (loc)

    Returns:
    - str volume rating
}
public str computeProjectVolumeRating(int volume) {
    return convertRankToLiteral(computeVolumeRating(volume));
}

@doc {
    Uses submodule analysis::UnitComplexity
    
    Compute Cyclomatic Complexity rating of project

    Parameters: 
	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
    - int lines of code in project

    Returns: 
    - Rank rank
}
public str computeProjectCyclomaticComplexityRating(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return convertRankToLiteral(computeCyclomaticComplexity(complexityUnits, projectLinesOfCode));
}

@doc {
	Uses submodule analysis::UnitComplexity
	
	Calculate percentage of simple cyclomatic complexity
	
	Parameters 
	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectSimpleCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return computeSimpleCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of moderate cyclomatic complexity
	
	Parameters 
	- map[Declaration, int] map with unit, coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectModerateCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return computeModerateCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of high risk cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectHighRiskCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return computeHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of very high risk cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectVeryHighRiskCyclomaticComplexityPercentage(map[Declaration, int] complexityUnits, int projectLinesOfCode) {
	return computeVeryHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

//---------------------------

@doc {
    Uses submodule analysis::UnitSize
    
    Compute Unit Size rating of project

    Parameters: 
    - map[Declaration, int] unitSizes units mapped to linesOfCode
    - int lines of code in project

    Returns: 
    - Rank rank
}
public str computeProjectUnitSizeRating(CountedList unitSizes) {
	return convertRankToLiteral(computeUnitSize(unitSizes));
}

@doc {
	Uses submodule analysis::UnitSize
	
	Calculate percentage of simple unit sizes
	
	Parameters 
    - map[Declarataion, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectSimpleUnitSizePercentage(CountedList unitSizes) {
	return computeSimpleUnitSizePercentage(unitSizes);
}

@doc {
	Uses submodule analysis::UnitSize

	Calculate percentage of moderate unit sizes
	
	Parameters 
    - map[Declaration, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectModerateUnitSizePercentage(CountedList unitSizes) {
	return computeModerateUnitSizePercentage(unitSizes);
}

@doc {
	Uses submodule analysis::UnitSize

	Calculate percentage of high risk unit sizes
	
	Parameters 
    - map[Declaration, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectHighRiskUnitSizePercentage(CountedList unitSizes) {
	return computeHighRiskUnitSizePercentage(unitSizes);
}

@doc {
	Uses submodule analysis::UnitSize

	Calculate percentage of very high risk unit sizes
	
	Parameters 
    - map[Declaration, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectVeryHighRiskUnitSizePercentage(CountedList unitSizes) {
	return computeVeryHighRiskUnitSizePercentage(unitSizes);
}

public list[real] computeProjectUnitSizePercentages(CountedList unitSizes) {
	list[real] result = [];
	
	result += 100.0 * (0 | it + y | <_,y> <- unitSizes.datalist, y <= SIG_UNIT_SIZE_LOW_RISK) / unitSizes.total;
	result += 100.0 * (0 | it + y | <_,y> <- unitSizes.datalist, y > SIG_UNIT_SIZE_LOW_RISK, y <= SIG_UNIT_SIZE_MODERATE_RISK) / unitSizes.total;
	result += 100.0 * (0 | it + y | <_,y> <- unitSizes.datalist, y > SIG_UNIT_SIZE_MODERATE_RISK, y <= SIG_UNIT_SIZE_HIGH_RISK) / unitSizes.total;
	result += 100.0 * (0 | it + y | <_,y> <- unitSizes.datalist, y > SIG_UNIT_SIZE_HIGH_RISK) / unitSizes.total;
			
	return result;
}

public CountedList computeUnitSizes(list[Declaration] ast) {
	return calculateUnitSizes(ast);
}