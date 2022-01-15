module Main

import configuration::constants::Project;
import reporting::ReportGenerator;

import visualization::Menu;

private loc HSQLDB = DEFAULT_HSQL_DB_LOC;
private loc SMALLSQL = DEFAULT_SMALL_SQL_LOC;
private list[loc] projects() {
 	return [SMALLSQL, HSQLDB];
}

public void main() {
 	//printReportToConsole(SMALLSQL);
 	//printReportToConsole(HSQLDB);
 	printReportToFile(SMALLSQL);
 	//printReportToFile(HSQLDB);
	//visualize(projects());
 }
