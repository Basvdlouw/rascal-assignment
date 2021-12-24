@doc{
	Facade module which uses submodules to compute Ranks
}
module Analyze

import configuration::constants::sig::SigUnitSizeConstants;
import configuration::data_types::Rank;
import configuration::data_types::CountedList;

import analysis::m3::AST;

import analysis::Volume;
import analysis::Duplication;
import analysis::UnitSize;
import analysis::UnitComplexity;
import analysis::UnitTesting;

import List;
import util::Math;

import metrics::UnitSize;

@doc{
    Uses submodule analysis::Volume
    
    Compute project volume rating.

    Parameters:
    - int volume in LinesOfCode (loc)

    Returns:
    - str volume rating
}
public Rank computeProjectVolumeRating(int volume) {
    return computeVolumeRating(volume);
}

//---------------------------

@doc{
    Uses submodule analysis::Duplication
    
    Compute project duplication rating.

    Parameters:
    - real duplication percentage

    Returns:
    - str volume rating
}
public Rank computeProjectDuplicationRating(real duplicationpercentage) {
	return computeDuplicationRating(duplicationpercentage);
}

//---------------------------

public Rank computeProjectUnitTestCoverageRating(real coveragepercentage) {
	return computeUnitTestingRating(coveragepercentage);
}

//---------------------------

@doc {
    Uses submodule analysis::UnitComplexity
    
    Compute Cyclomatic Complexity rating of project

    Parameters: 
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values

    Returns: 
    - Rank rank
}
public Rank computeProjectCyclomaticComplexityRating(CountedList complexityUnits) {
	return computeCyclomaticComplexity(complexityUnits);
}

@doc {
	Uses submodule analysis::UnitComplexity
	
	Calculate percentage of simple cyclomatic complexity
	
	Parameters 
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
	Returns:
	- real percentage
}
public real computeProjectSimpleCyclomaticComplexityPercentage(CountedList complexityUnits) {
	return computeSimpleCyclomaticComplexityPercentage(complexityUnits);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of moderate cyclomatic complexity
	
	Parameters 
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
	Returns:
	- real percentage
}
public real computeProjectModerateCyclomaticComplexityPercentage(CountedList complexityUnits) {
	return computeModerateCyclomaticComplexityPercentage(complexityUnits);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of high risk cyclomatic complexity
	
	Parameters 
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
	Returns:
	- real percentage
}
public real computeProjectHighRiskCyclomaticComplexityPercentage(CountedList complexityUnits) {
	return computeHighRiskCyclomaticComplexityPercentage(complexityUnits);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of very high risk cyclomatic complexity
	
	Parameters 
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
	Returns:
	- real percentage
}
public real computeProjectVeryHighRiskCyclomaticComplexityPercentage(CountedList complexityUnits) {
	return computeVeryHighRiskCyclomaticComplexityPercentage(complexityUnits);
}

//---------------------------

@doc {
    Uses submodule analysis::UnitSize
    
    Compute Unit Size rating of project

    Parameters: 
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values

    Returns: 
    - Rank rank
}
public Rank computeProjectUnitSizeRating(CountedList unitSizes) {
	return computeUnitSize(unitSizes);
}

@doc {

	Uses submodule analysis::UnitSize
	
	Calculate percentage of simple unit sizes
	
	Parameters 
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
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
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
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
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
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
	- CountedList with CountedList.total indicating the total sum of all CountedList.datalist entry values
	
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

//---------------------------

@doc{
	Computes aggregate rating based on list of ratings
	
	Example:
	[plus(), minus(), plusplus(), neutral()]  == [4, 2, 5, 3]
	Sum = 14 / amount of ranks (4)
	14/4 = 3.5
	round(3.5) = 4 (plus) will be returned
	
	Parameters
	- list[Rank] list of ratings
	
	Returns
	- Rank aggregated rank, weighted evenly across ranks as described by the SIG model
}
public Rank computeAggregateRating(list[Rank] ratings) {
	return toRank(round(toReal((0 | it + toInt(x) | x <- ratings))/size(ratings)));
}

//---------------------------

public real computeProjectUnitTestCoverage(list[Declaration] ast) {
	return computeUnitTestCoverage(ast);
}

public list[loc] computeProjectUnitTestAssertCount(list[Declaration] ast) {
	return computeUnitTestAssertCount(ast);
}