module Main

import configuration::constants::Constants;
import reporting::ReportGenerator;

 public void main() {
 	//generateReportSmallSQL();
	 generateReportHsqlDb();
 }

@doc{
	Generate report for SmallSQL project
}
public void generateReportSmallSQL() {
	printReportToConsole(DEFAULT_SMALL_SQL_LOC);
}

@doc{
	Generate report for HsqlDb project
}
public void generateReportHsqlDb() {
	printReportToConsole(DEFAULT_HSQL_DB_LOC);
}