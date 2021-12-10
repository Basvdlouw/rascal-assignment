module reporting::ReportGenerator

import utils::StringUtils;
import analysis::m3::AST; 

import IO;

// use Calculate module to calculate SIG metrics
import Calculate;
// Use Analyze module to compute SIG scores
import Analyze;

private int DECIMAL_POINTS = 2;
private loc project;
private int volume;
private int numberOfUnits;
private lrel[loc, int, int] cyclomaticComplexityUnits;
private map[Declaration, int] unitSizes;

@doc{
    Uses Calculate module to calculate metrics and populates fields.

    Parameters:
    - loc project
}
private void calculateMetrics(loc proj) {
    project = proj;
    volume = calculateProjectVolume(proj);
    numberOfUnits = calculateProjectNumberOfUnits(proj);
    cyclomaticComplexityUnits = calculateProjectCyclomaticComplexityPerUnit(proj);
    unitSizes = calculateProjectUnitSizePerUnit(proj);
}

@doc{
    Prints report to console

    Parameters:
    - loc proj metrics in report are calculated based on project location.
}
public void printReportToConsole(loc proj) {
    calculateMetrics(proj);
    println(generateReport());
}

@doc{
    Generates report based on global variables on top of module

    Returns 
    - str report in string format

    TODO: remove hardcoded values/format percentages amount of decimals
}
private str generateReport() {
    return 
    "
    <project.authority>
    -----------------------
    lines of code: <volume>
    number of units: <numberOfUnits>
    -----------------------
    unit size:
    * simple: <toFixed(computeProjectSimpleUnitSizePercentage(unitSizes, volume), DECIMAL_POINTS)>%
    * moderate: <toFixed(computeProjectModerateUnitSizePercentage(unitSizes, volume), DECIMAL_POINTS)>%
    * high: <toFixed(computeProjectHighRiskUnitSizePercentage(unitSizes, volume), DECIMAL_POINTS)>%
    * very high: <toFixed(computeProjectVeryHighRiskUnitSizePercentage(unitSizes, volume), DECIMAL_POINTS)>%
    -----------------------
    unit complexity:
    * simple: <toFixed(computeProjectSimpleCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume), DECIMAL_POINTS)>%
    * moderate: <toFixed(computeProjectModerateCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume), DECIMAL_POINTS)>%
    * high: <toFixed(computeProjectHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume), DECIMAL_POINTS)>%
    * very high: <toFixed(computeProjectVeryHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume), DECIMAL_POINTS)>%
    -----------------------
    duplication: <"NOT IMPLEMENTED">
    -----------------------
    volume score: <computeProjectVolumeRating(volume)>
    unit size score: <computeProjectUnitSizeRating(unitSizes, volume)>
    unit complexity score: <computeProjectCyclomaticComplexityRating(cyclomaticComplexityUnits, volume)>
    duplication score: <"NOT IMPLEMENTED">
    -----------------------
    analysability score: <"NOT IMPLEMENTED">
    changability score: <"NOT IMPLEMENTED">
    testability score: <"NOT IMPLEMENTED">
    -----------------------
    overall maintainability score: <"NOT IMPLEMENTED">
    ";
}



