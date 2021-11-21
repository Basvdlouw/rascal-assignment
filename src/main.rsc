module main

import util;

public loc DEFAULT_SMALL_SQL_LOC = |project://smallsql|;
public loc DEFAULT_HSQL_DB_LOC = |project://hsqldb|;

public void main() {
	createM3Model(DEFAULT_HSQL_DB_LOC);
}
