/* =============================================================
 * SmallSQL : a free Java DBMS library for the Java(tm) platform
 * =============================================================
 *
 * (C) Copyright 2004-2007, by Volker Berlin.
 *
 * Project Info:  http://www.smallsql.de/
 *
 * This library is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU Lesser General Public License as published by 
 * the Free Software Foundation; either version 2.1 of the License, or 
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, 
 * USA.  
 *
 * [Java is a trademark or registered trademark of Sun Microsystems, Inc. 
 * in the United States and other countries.]
 *
 * ---------------
 * SSStatement.java
 * ---------------
 * Author: Volker Berlin
 * 
 */
package smallsql.database;

import java.sql.*;
import java.util.ArrayList;
import smallsql.database.language.Language;

class SSStatement implements Statement{

    final SSConnection con;

    Command cmd;

    private boolean isClosed;

    int rsType;

    int rsConcurrency;

    private int fetchDirection;

    private int fetchSize;

    private int queryTimeout;

    private int maxRows;

    private int maxFieldSize;

    private ArrayList batches;

    private boolean needGeneratedKeys;

    private ResultSet generatedKeys;

    private int[] generatedKeyIndexes;

    private String[] generatedKeyNames;


    SSStatement(SSConnection con) throws SQLException{
        this(con, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
    }


    SSStatement(SSConnection con, int rsType, int rsConcurrency) throws SQLException{
        this.con = con;
        this.rsType = rsType;
        this.rsConcurrency = rsConcurrency;
        con.testClosedConnection();
    }


    final public ResultSet executeQuery(String sql) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
executeImpl(sql);
        return cmd.getQueryResult();
}


    final public int executeUpdate(String sql) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
executeImpl(sql);
        return cmd.getUpdateCount();
}


    final public boolean execute(String sql) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
executeImpl(sql);
        return cmd.getResultSet() != null;
}


    final private void executeImpl(String sql) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        generatedKeys = null;
        try{
            con.log.println(sql);
            SQLParser parser = new SQLParser();
            cmd = parser.parse(con, sql);
            if(maxRows != 0 && (cmd.getMaxRows() == -1 || cmd.getMaxRows() > maxRows))
                cmd.setMaxRows(maxRows);
            cmd.execute(con, this);
        }catch(Exception e){
            throw SmallSQLException.createFromException(e);
        }
        needGeneratedKeys = false;
        generatedKeyIndexes = null;
        generatedKeyNames = null;
}


    final public void close(){
System.out.println(new Throwable().getStackTrace()[0]);
con.log.println("Statement.close");
        isClosed = true;
        cmd = null;
}


    final public int getMaxFieldSize(){
System.out.println(new Throwable().getStackTrace()[0]);
return maxFieldSize;
}


    final public void setMaxFieldSize(int max){
System.out.println(new Throwable().getStackTrace()[0]);
maxFieldSize = max;
}


    final public int getMaxRows(){
System.out.println(new Throwable().getStackTrace()[0]);
return maxRows;
}


    final public void setMaxRows(int max) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
if(max < 0)
            throw SmallSQLException.create(Language.ROWS_WRONG_MAX, String.valueOf(max));
        maxRows = max;
}


    final public void setEscapeProcessing(boolean enable) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
}


    final public int getQueryTimeout() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return queryTimeout;
}


    final public void setQueryTimeout(int seconds) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        queryTimeout = seconds;
}


    final public void cancel() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
}


    final public SQLWarning getWarnings(){
System.out.println(new Throwable().getStackTrace()[0]);
return null;
}


    final public void clearWarnings(){
System.out.println(new Throwable().getStackTrace()[0]);
}


    final public void setCursorName(String name) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
throw SmallSQLException.create(Language.UNSUPPORTED_OPERATION, "setCursorName");
}


    final public ResultSet getResultSet() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return cmd.getResultSet();
}


    final public int getUpdateCount() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return cmd.getUpdateCount();
}


    final public boolean getMoreResults() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return getMoreResults(CLOSE_CURRENT_RESULT);
}


    final public void setFetchDirection(int direction) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        fetchDirection = direction;
}


    final public int getFetchDirection() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return fetchDirection;
}


    final public void setFetchSize(int rows) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        fetchSize = rows;
}


    final public int getFetchSize() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return fetchSize;
}


    final public int getResultSetConcurrency() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return rsConcurrency;
}


    final public int getResultSetType() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        return rsType;
}


    final public void addBatch(String sql){
System.out.println(new Throwable().getStackTrace()[0]);
if(batches == null)
            batches = new ArrayList();
        batches.add(sql);
}


    public void clearBatch() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
checkStatement();
        if(batches == null)
            return;
        batches.clear();
}


    public int[] executeBatch() throws BatchUpdateException{
System.out.println(new Throwable().getStackTrace()[0]);
if(batches == null)
            return new int[0];
        final int[] result = new int[batches.size()];
        BatchUpdateException failed = null;
        for(int i = 0; i < result.length; i++){
            try{
                result[i] = executeUpdate((String)batches.get(i));
            }catch(SQLException ex){
                result[i] = EXECUTE_FAILED;
                if(failed == null){
                    failed = new BatchUpdateException(ex.getMessage(), ex.getSQLState(), ex.getErrorCode(), result);
                    failed.initCause(ex);
                }
                failed.setNextException(ex);
            }
        }
        batches.clear();
        if(failed != null)
            throw failed;
        return result;
}


    final public Connection getConnection(){
System.out.println(new Throwable().getStackTrace()[0]);
return con;
}


    final public boolean getMoreResults(int current) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
switch(current){
        case CLOSE_ALL_RESULTS:
        // currently there exists only one ResultSet
        case CLOSE_CURRENT_RESULT:
            ResultSet rs = cmd.getResultSet();
            cmd.rs = null;
            if(rs != null)
                rs.close();
            break;
        case KEEP_CURRENT_RESULT:
            break;
        default:
            throw SmallSQLException.create(Language.FLAGVALUE_INVALID, String.valueOf(current));
        }
        return cmd.getMoreResults();
}


    final void setNeedGeneratedKeys(int autoGeneratedKeys) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
switch(autoGeneratedKeys){
        case NO_GENERATED_KEYS:
            break;
        case RETURN_GENERATED_KEYS:
            needGeneratedKeys = true;
            break;
        default:
            throw SmallSQLException.create(Language.ARGUMENT_INVALID, String.valueOf(autoGeneratedKeys));
        }
}


    final void setNeedGeneratedKeys(int[] columnIndexes) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
needGeneratedKeys = columnIndexes != null;
        generatedKeyIndexes = columnIndexes;
}


    final void setNeedGeneratedKeys(String[] columnNames) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
needGeneratedKeys = columnNames != null;
        generatedKeyNames = columnNames;
}


    final boolean needGeneratedKeys(){
System.out.println(new Throwable().getStackTrace()[0]);
return needGeneratedKeys;
}


    final int[] getGeneratedKeyIndexes(){
System.out.println(new Throwable().getStackTrace()[0]);
return generatedKeyIndexes;
}


    final String[] getGeneratedKeyNames(){
System.out.println(new Throwable().getStackTrace()[0]);
return generatedKeyNames;
}


    /**
     * Set on execution the result with the generated keys.
     * 
     * @param rs
     */
    final void setGeneratedKeys(ResultSet rs){
System.out.println(new Throwable().getStackTrace()[0]);
generatedKeys = rs;
}


    final public ResultSet getGeneratedKeys() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
if(generatedKeys == null)
            throw SmallSQLException.create(Language.GENER_KEYS_UNREQUIRED);
        return generatedKeys;
}


    final public int executeUpdate(String sql, int autoGeneratedKeys) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
setNeedGeneratedKeys(autoGeneratedKeys);
        return executeUpdate(sql);
}


    final public int executeUpdate(String sql, int[] columnIndexes) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
setNeedGeneratedKeys(columnIndexes);
        return executeUpdate(sql);
}


    final public int executeUpdate(String sql, String[] columnNames) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
setNeedGeneratedKeys(columnNames);
        return executeUpdate(sql);
}


    final public boolean execute(String sql, int autoGeneratedKeys) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
setNeedGeneratedKeys(autoGeneratedKeys);
        return execute(sql);
}


    final public boolean execute(String sql, int[] columnIndexes) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
setNeedGeneratedKeys(columnIndexes);
        return execute(sql);
}


    final public boolean execute(String sql, String[] columnNames) throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
setNeedGeneratedKeys(columnNames);
        return execute(sql);
}


    final public int getResultSetHoldability() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
throw new java.lang.UnsupportedOperationException("Method getResultSetHoldability() not yet implemented.");
}


    void checkStatement() throws SQLException{
System.out.println(new Throwable().getStackTrace()[0]);
if(isClosed){
            throw SmallSQLException.create(Language.STMT_IS_CLOSED);
        }
}


	@Override
	public <T> T unwrap(Class<T> iface) throws SQLException {
System.out.println(new Throwable().getStackTrace()[0]);
return null;
}


	@Override
	public boolean isWrapperFor(Class<?> iface) throws SQLException {
System.out.println(new Throwable().getStackTrace()[0]);
return false;
}


	@Override
	public boolean isClosed() throws SQLException {
System.out.println(new Throwable().getStackTrace()[0]);
return false;
}


	@Override
	public void setPoolable(boolean poolable) throws SQLException {
System.out.println(new Throwable().getStackTrace()[0]);
}


	@Override
	public boolean isPoolable() throws SQLException {
System.out.println(new Throwable().getStackTrace()[0]);
return false;
}
}