/* =============================================================
 * SmallSQL : a free Java DBMS library for the Java(tm) platform
 * =============================================================
 *
 * (C) Copyright 2004-2006, by Volker Berlin.
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
 * ExpressionFunctionFloor.java
 * ---------------
 * Author: Volker Berlin
 * 
 */
package smallsql.database;


class ExpressionFunctionFloor extends ExpressionFunctionReturnP1Number {

    int getFunction(){
System.out.println(new Throwable().getStackTrace()[0]);
return SQLTokenizer.FLOOR;
}


    double getDouble() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
return Math.floor( param1.getDouble() );
}
	

    String getString() throws Exception{
System.out.println(new Throwable().getStackTrace()[0]);
Object obj = getObject();
        if(obj == null) return null;
        return obj.toString();
}
    

}