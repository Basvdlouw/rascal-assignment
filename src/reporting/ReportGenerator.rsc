module reporting::ReportGenerator

import IO;
import Calculate;

private loc project;
private int projectName;
private int volume;
private int numberOfUnits;

@doc{
    Uses Calculate module to calculate metrics and populates fields.

    Parameters 
    - loc project
}
private void calculateMetrics(loc proj) {
    project = proj;
    volume = calculateProjectVolume(proj);
    // Call methods to fill variables
    // volume = calculateVolume()
}

@doc{
    Prints report to console

    Parameters 
    - loc project. Metrics in report are calculated based on project location.
}
public void printReportToConsole(loc proj) {
    calculateMetrics(proj);
    println(generateReport());
}

@doc{
    Generates report based on global variables on top of module

    Returns 
    - str report in string format

    TODO: remove hardcoded values
}
private str generateReport() {
    return 
    "
    <project.authority>
    -----------------------
    lines of code: <volume>
    number of units: <"NOT IMPLEMENTED">
    -----------------------
    unit size:
    * simple: <"NOT IMPLEMENTED">
    * moderate: <"NOT IMPLEMENTED">
    * high: <"NOT IMPLEMENTED">
    * very high: <"NOT IMPLEMENTED">
    -----------------------
    unit complexity:
    * simple: <"NOT IMPLEMENTED">
    * moderate: <"NOT IMPLEMENTED">
    * high: <"NOT IMPLEMENTED">
    * very high: <"NOT IMPLEMENTED">
    -----------------------
    duplication: <"NOT IMPLEMENTED">
    -----------------------
    volume score: <"NOT IMPLEMENTED">
    unit size score: <"NOT IMPLEMENTED">
    unit complexity score: <"NOT IMPLEMENTED">
    duplication score: <"NOT IMPLEMENTED">
    -----------------------
    analysability score: <"NOT IMPLEMENTED">
    changability score: <"NOT IMPLEMENTED">
    testability score: <"NOT IMPLEMENTED">
    -----------------------
    overall maintainability score: <"NOT IMPLEMENTED">
    ";
}



