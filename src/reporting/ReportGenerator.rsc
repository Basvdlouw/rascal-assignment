module reporting::ReportGenerator

import IO;

// use Calculate module to calculate SIG metrics
import Calculate;
// Use Analyze module to compute SIG scores
import Analyze;

private loc project;
private int volume;
private int numberOfUnits;
private lrel[loc, int, int] cyclomaticComplexityUnits;

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
    * simple: <"NOT IMPLEMENTED">
    * moderate: <"NOT IMPLEMENTED">
    * high: <"NOT IMPLEMENTED">
    * very high: <"NOT IMPLEMENTED">
    -----------------------
    unit complexity:
    * simple: <computeProjectSimpleCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume)>%
    * moderate: <computeProjectModerateCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume)>%
    * high: <computeProjectHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume)>%
    * very high: <computeProjectVeryHighRiskCyclomaticComplexityPercentage(cyclomaticComplexityUnits, volume)>%
    -----------------------
    duplication: <"NOT IMPLEMENTED">
    -----------------------
    volume score: <computeProjectVolumeRating(volume)>
    unit size score: <"NOT IMPLEMENTED">
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



