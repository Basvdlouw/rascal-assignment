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
 * ExpressionName.java
 * ---------------
 * Author: Volker Berlin
 * 
 */
package smallsql.database;


public class ExpressionName extends Expression {

    private String tableAlias;
    private DataSource fromEntry;
    private int colIdx;
    private TableView table;
    private Column column;

    // field name Expression i.e. abc, mytable.abc, "ab c"
    ExpressionName(String name){
		super(NAME);
        setName( name );
    }
    
    /**
     * Constructor used for aggregate functions from parser.
     * @param type the type of the aggregate function
     */
	ExpressionName(int type){
		super(type);
		//setName( "" ); if null it will be generate a automatic name
	}

    void setNameAfterTableAlias(String name){
System.out.println(new Throwable().getStackTrace()[0]);
tableAlias = getName();
		setName( name );
}
    
    /**
     * Is used in GroupResult.
     */
    public boolean equals(Object expr){
System.out.println(new Throwable().getStackTrace()[0]);
if(!super.equals(expr)) return false;
    	if(!(expr instanceof ExpressionName)) return false;
    	if( ((ExpressionName)expr).fromEntry != fromEntry) return false;
    	return true;
}

    boolean isNull() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.isNull(colIdx);
}

    boolean getBoolean() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getBoolean(colIdx);
}

    int getInt() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getInt(colIdx);
}

    long getLong() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getLong(colIdx);
}

    float getFloat() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getFloat(colIdx);
}

    double getDouble() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getDouble(colIdx);
}

    long getMoney() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getMoney(colIdx);
}

    MutableNumeric getNumeric() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getNumeric(colIdx);
}

    Object getObject() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getObject(colIdx);
}

    String getString() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getString(colIdx);
}

    byte[] getBytes() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry.getBytes(colIdx);
}

    int getDataType(){
System.out.println(new Throwable().getStackTrace()[0]);
switch(getType()){
			case NAME:
			case GROUP_BY:
				return fromEntry.getDataType(colIdx);
			case FIRST:
			case LAST:
			case MAX:
			case MIN:
			case SUM:
				return getParams()[0].getDataType();
			case COUNT:
				return SQLTokenizer.INT;
			default: throw new Error();
		}
}

    /**
     * Set the DataSource and the index in the DataSource. The first column has the index 0.
     * The Table object is using to request the Column description.
     */
    void setFrom( DataSource fromEntry, int colIdx, TableView table ){
System.out.println(new Throwable().getStackTrace()[0]);
this.fromEntry  = fromEntry;
        this.colIdx     = colIdx;
        this.table      = table;
        // Because the DataSource is a TableResult the colIdx of both is identical
        this.column		= table.columns.get(colIdx);
}

	/**
	 * Set the DataSource and the index in the DataSource. The first column has the index 0.
	 * The Table object is using to request the Column description.
	 */
	void setFrom( DataSource fromEntry, int colIdx, Column column ){
System.out.println(new Throwable().getStackTrace()[0]);
this.fromEntry  = fromEntry;
		this.colIdx     = colIdx;
		this.column		= column;
}
    
    
    DataSource getDataSource(){
System.out.println(new Throwable().getStackTrace()[0]);
return fromEntry;
}
    

    String getTableAlias(){
System.out.println(new Throwable().getStackTrace()[0]);
return tableAlias;
}

	/**
	 * Get the table of this column
	 * @return
	 */
	final TableView getTable(){
System.out.println(new Throwable().getStackTrace()[0]);
return table;
}

	/**
	 * Get index of the column in the table
	 * @return
	 */
	final int getColumnIndex(){
System.out.println(new Throwable().getStackTrace()[0]);
return colIdx;
}
	

	final Column getColumn(){
System.out.println(new Throwable().getStackTrace()[0]);
return column;
}
	

	final public String toString(){
System.out.println(new Throwable().getStackTrace()[0]);
if(tableAlias == null) return String.valueOf(getAlias());
        return tableAlias + "." + getAlias();
}


	/*=======================================================================
	 
		Methods for ResultSetMetaData
	 
	=======================================================================*/

	String getTableName(){
System.out.println(new Throwable().getStackTrace()[0]);
if(table != null){
			return table.getName();
		}
		return null;
}

	int getPrecision(){
System.out.println(new Throwable().getStackTrace()[0]);
return column.getPrecision();
}

	int getScale(){
System.out.println(new Throwable().getStackTrace()[0]);
return column.getScale();
}

	int getDisplaySize(){
System.out.println(new Throwable().getStackTrace()[0]);
return column.getDisplaySize();
}

	boolean isAutoIncrement(){
System.out.println(new Throwable().getStackTrace()[0]);
return column.isAutoIncrement();
}
	
	boolean isCaseSensitive(){
System.out.println(new Throwable().getStackTrace()[0]);
return column.isCaseSensitive();
}

	boolean isNullable(){
System.out.println(new Throwable().getStackTrace()[0]);
return column.isNullable();
}

	boolean isDefinitelyWritable(){
System.out.println(new Throwable().getStackTrace()[0]);
return true;
}

}