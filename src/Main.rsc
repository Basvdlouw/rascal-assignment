module Main

import configuration::constants::Project;
import configuration::constants::sig::SigUnitSizeConstants;
import reporting::ReportGenerator;
import visualization::UnitSize;

public loc HSQLDB = DEFAULT_HSQL_DB_LOC;
public loc SMALLSQL = DEFAULT_SMALL_SQL_LOC;
public int UNIT_SIZE_HIGH_RISK = SIG_UNIT_SIZE_HIGH_RISK;

public void main() {
 	//generateReport(SMALLSQL);
 	//generateReport(HSQLDB);
	visualizeUnitSize(SMALLSQL, UNIT_SIZE_HIGH_RISK);
 }


@doc{
	Generate report for project
}
public void generateReport(loc project) {
	printReportToConsole(project);
}

@doc{
	visualizeUnitSize for project, excludes units from the provided risk level
	Units in visualization are clickable in order to easily find problematic code smells
}
public void visualizeUnitSize(loc project, int riskLevel) {
	 visualizeUnitSizes(project, riskLevel);
}