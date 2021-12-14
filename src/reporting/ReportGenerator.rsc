module reporting::ReportGenerator

import utils::StringUtils;
import utils::ProjectUtils;

import analysis::m3::AST; 
import lang::java::jdt::m3::Core;
import IO;

// use Benchmark to time reporting performance
import util::Benchmark;

// use Calculate module to calculate SIG metrics
import Calculate;
// Use Analyze module to compute SIG scores
import Analyze;

private int DECIMAL_POINTS = 2;
private loc project;
private int volume;
private int numberOfUnits;
private map[Declaration, int] cyclomaticComplexityUnits;
private list[real] unitSizes;

@doc{
    Uses Calculate module to calculate metrics and populates fields.

    Parameters:
    - loc project
}
private void calculateMetrics(loc proj) {
    project = proj;
    
    M3 projectM3 = createM3ModelFromProject(proj);
    list[Declaration] AST = getASTsFromProject(projectM3);
    
    volume = calculateProjectVolume(projectM3);
    numberOfUnits = calculateProjectNumberOfUnits(AST);
    cyclomaticComplexityUnits = calculateProjectCyclomaticComplexityPerUnit(AST);
    
    unitSizes = computeProjectUnitSizePercentages(AST);
}

@doc{
    Prints report to console

    Parameters:
    - loc proj metrics in report are calculated based on project location.
}
public void printReportToConsole(loc proj) {    
    str report = "";
    int gentime = cpuTime(() {
    	calculateMetrics(proj);
    	report = generateReport();
    });
        
    report += "-----------------------
    project analyzed in <toFixed(gentime * 0.000001, DECIMAL_POINTS)> ms";
    
    println(report);
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
    * simple: <toFixed(unitSizes[0], DECIMAL_POINTS)>%
    * moderate: <toFixed(unitSizes[1], DECIMAL_POINTS)>%
    * high: <toFixed(unitSizes[2], DECIMAL_POINTS)>%
    * very high: <toFixed(unitSizes[3], DECIMAL_POINTS)>%
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
    unit complexity score: <computeProjectCyclomaticComplexityRating(cyclomaticComplexityUnits, volume)>
    duplication score: <"NOT IMPLEMENTED">
    -----------------------
    analysability score: <"NOT IMPLEMENTED">
    changability score: <"NOT IMPLEMENTED">
    testability score: <"NOT IMPLEMENTED">
    -----------------------
    overall maintainability score: <"NOT IMPLEMENTED">
    ";
    
    //unit size score: <computeProjectUnitSizeRating(unitSizes, volume)>
}



