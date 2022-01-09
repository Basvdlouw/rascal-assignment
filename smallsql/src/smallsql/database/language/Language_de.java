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
 * Language_it.java
 * ---------------
 * Author: Volker Berlin
 * 
 */
package smallsql.database.language;

/**
 * Extended localization class for German language.
 */
public class Language_de extends Language {
	protected Language_de() {
		addMessages(ENTRIES);
	}
	
	public String[][] getEntries() {
System.out.println(new Throwable().getStackTrace()[0]);
return ENTRIES;
}
	
	//////////////////////////////////////////////////////////////////////
	// MESSAGES
	//////////////////////////////////////////////////////////////////////
	
    private final String[][] ENTRIES = {
            { UNSUPPORTED_OPERATION           , "Nicht unterstÃ¼tzte Funktion: {0}" },
            { CANT_LOCK_FILE                  , "Die Datei ''{0}'' kann nicht gelockt werden. Eine einzelne SmallSQL Datenbank kann nur fÃ¼r einen einzigen Prozess geÃ¶ffnet werden." },

            { DB_EXISTENT                     , "Die Datenbank ''{0}'' existiert bereits." },
            { DB_NONEXISTENT                  , "Die Datenbank ''{0}'' existiert nicht." },
            { DB_NOT_DIRECTORY                , "Das Verzeichnis ''{0}'' ist keine SmallSQL Datenbank." },
            { DB_NOTCONNECTED                 , "Sie sind nicht mit einer Datenbank verbunden." },

            { CONNECTION_CLOSED               , "Die Verbindung ist bereits geschlossen." },

            { VIEW_INSERT                     , "INSERT wird nicht unterstÃ¼tzt fÃ¼r eine View." },
            { VIEWDROP_NOT_VIEW               , "DROP VIEW kann nicht mit ''{0}'' verwendet werden, weil es keine View ist." },
            { VIEW_CANTDROP                   , "View ''{0}'' kann nicht gelÃ¶scht werden." },

            { RSET_NOT_PRODUCED               , "Es wurde kein ResultSet erzeugt." },
            { RSET_READONLY                   , "Das ResultSet ist schreibgeschÃ¼tzt." },
            { RSET_FWDONLY                    , "Das ResultSet ist forward only." },
            { RSET_CLOSED                     , "Das ResultSet ist geschlossen." },
            { RSET_NOT_INSERT_ROW             , "Der Cursor zeigt aktuell nicht auf die EinfÃ¼geposition (insert row)." },
            { RSET_ON_INSERT_ROW              , "Der Cursor zeigt aktuell auf die EinfÃ¼geposition (insert row)." },
            { ROWSOURCE_READONLY              , "Die Rowsource ist schreibgeschÃ¼tzt." },
            { STMT_IS_CLOSED                  , "Das Statement ist bereits geschlossen." },

            { SUBQUERY_COL_COUNT              , "Die Anzahl der Spalten in der Subquery muss 1 sein und nicht {0}." },
            { JOIN_DELETE                     , "Die Methode deleteRow wird nicht unterstÃ¼tzt fÃ¼r Joins." },
            { JOIN_INSERT                     , "Die Methode insertRow wird nicht unterstÃ¼tzt fÃ¼r Joins." },
            { DELETE_WO_FROM                  , "Die Methode deleteRow benÃ¶tigt einen FROM Ausdruck." },
            { INSERT_WO_FROM                  , "Die Methode insertRow benÃ¶tigt einen FROM Ausdruck." },

            { TABLE_CANT_RENAME               , "Die Tabelle ''{0}'' kann nicht umbenannt werden." },
            { TABLE_CANT_DROP                 , "Die Tabelle ''{0}'' kann nicht gelÃ¶scht werden." },
            { TABLE_CANT_DROP_LOCKED          , "Die Tabelle ''{0}'' kann nicht gelÃ¶scht werden, weil sie gelockt ist." },
            { TABLE_CORRUPT_PAGE              , "BeschÃ¤digte Tabellenseite bei Position: {0}." },
            { TABLE_MODIFIED                  , "Die Tabelle ''{0}'' wurde modifiziert." },
            { TABLE_DEADLOCK                  , "Deadlock, es kann kein Lock erzeugt werden fÃ¼r Tabelle ''{0}''." },
            { TABLE_OR_VIEW_MISSING           , "Tabelle oder View ''{0}'' existiert nicht." },
            { TABLE_FILE_INVALID              , "Die Datei ''{0}'' enthÃ¤lt keine gÃ¼ltige SmallSQL Tabelle." },
            { TABLE_OR_VIEW_FILE_INVALID      , "Die Datei ''{0}'' ist keine gÃ¼ltiger Tabellen oder View Speicher." },
            { TABLE_EXISTENT                  , "Die Tabelle oder View ''{0}'' existiert bereits." },

            { FK_NOT_TABLE                    , "''{0}'' ist keine Tabelle." },
            { PK_ONLYONE                      , "Eine Tabelle kann nur einen PrimÃ¤rschlÃ¼ssel haben." },
            { KEY_DUPLICATE                   , "Doppelter SchlÃ¼ssel." },

            { MONTH_TOOLARGE                  , "Der Monat ist zu groÃŸ im DATE oder TIMESTAMP Wert ''{0}''." },
            { DAYS_TOOLARGE                   , "Die Tage sind zu groÃŸ im DATE oder TIMESTAMP Wert ''{0}''." },
            { HOURS_TOOLARGE                  , "Die Stunden sind zu groÃŸ im TIME oder TIMESTAMP Wert ''{0}''." },
            { MINUTES_TOOLARGE                , "Die Minuten sind zu groÃŸ im TIME oder TIMESTAMP Wert ''{0}''." },
            { SECS_TOOLARGE                   , "Die Sekunden sind zu groÃŸ im TIME oder TIMESTAMP Wert ''{0}''." },
            { MILLIS_TOOLARGE                 , "Die Millisekunden sind zu groÃŸ im TIMESTAMP Wert ''{0}''." },
            { DATETIME_INVALID                , "''{0}'' ist ein ungÃ¼ltiges DATE, TIME or TIMESTAMP." },

            { UNSUPPORTED_CONVERSION_OPER     , "Nicht unterstÃ¼tzte Konvertierung zu Datentyp ''{0}'' von Datentyp ''{1}'' fÃ¼r die Operation ''{2}''." },
            { UNSUPPORTED_DATATYPE_OPER       , "Nicht unterstÃ¼tzter Datentyp ''{0}'' fÃ¼r Operation ''{1}''." },
            { UNSUPPORTED_DATATYPE_FUNC       , "Nicht unterstÃ¼tzter Datentyp ''{0}'' fÃ¼r Funktion ''{1}''." },
            { UNSUPPORTED_CONVERSION_FUNC     , "Nicht unterstÃ¼tzte Konvertierung zu Datentyp ''{0}'' fÃ¼r Funktion ''{1}''." },
            { UNSUPPORTED_TYPE_CONV           , "Nicht unterstÃ¼tzter Typ fÃ¼r CONVERT Funktion: {0}." },
            { UNSUPPORTED_TYPE_SUM            , "Nicht unterstÃ¼tzter Datentyp ''{0}'' fÃ¼r SUM Funktion." },
            { UNSUPPORTED_TYPE_MAX            , "Nicht unterstÃ¼tzter Datentyp ''{0}'' fÃ¼r MAX Funktion." },
            { UNSUPPORTED_CONVERSION          , "Kann nicht konvertieren ''{0}'' [{1}] zu ''{2}''." },
            { INSERT_INVALID_LEN              , "UngÃ¼ltige LÃ¤nge ''{0}'' in Funktion INSERT." },
            { SUBSTR_INVALID_LEN              , "UngÃ¼ltige LÃ¤nge ''{0}'' in Funktion SUBSTRING." },

            { VALUE_STR_TOOLARGE              , "Der String Wert ist zu groÃŸ fÃ¼r die Spalte." },
            { VALUE_BIN_TOOLARGE              , "Ein BinÃ¤re Wert mit LÃ¤nge {0} ist zu groÃŸ fÃ¼r eine Spalte mit der GrÃ¶ÃŸe {1}." },
            { VALUE_NULL_INVALID              , "Null Werte sind ungÃ¼ltig fÃ¼r die Spalte ''{0}''." },
            { VALUE_CANT_CONVERT              , "Kann nicht konvertieren ein {0} Wert zu einem {1} Wert." },

            { BYTEARR_INVALID_SIZE            , "UngÃ¼ltige Bytearray GroÃŸe {0} fÃ¼r UNIQUEIDENFIER." },
            { LOB_DELETED                     , "Lob Objekt wurde gelÃ¶scht." },

            { PARAM_CLASS_UNKNOWN             , "Unbekante Parameter Klasse: ''{0}''." },
            { PARAM_EMPTY                     , "Parameter {0} ist leer." },
            { PARAM_IDX_OUT_RANGE             , "Parameter Index {0} liegt auÃŸerhalb des GÃ¼ltigkeitsbereiches. Der Wert muss zwischen 1 und {1} liegen." },

            { COL_DUPLICATE                   , "Es gibt einen doppelten Spaltennamen: ''{0}''." },
            { COL_MISSING                     , "Spalte ''{0}'' wurde nicht gefunden." },
            { COL_VAL_UNMATCH                 , "Die Spaltenanzahl und Werteanzahl ist nicht identisch." },
            { COL_INVALID_SIZE                , "UngÃ¼ltige SpaltengrÃ¶ÃŸe {0} fÃ¼r Spalte ''{1}''." },
            { COL_WRONG_PREFIX                , "Der Spaltenprefix ''{0}'' passt zu keinem Tabellennamen oder Aliasnamen in dieser Abfrage." },
            { COL_READONLY                    , "Die Spalte {0} ist schreibgeschÃ¼tzt." },
            { COL_INVALID_NAME                , "UngÃ¼ltiger Spaltenname ''{0}''." },
            { COL_IDX_OUT_RANGE               , "Spaltenindex auÃŸerhalb des GÃ¼ltigkeitsbereiches: {0}." },
            { COL_AMBIGUOUS                   , "Die Spalte ''{0}'' ist mehrdeutig." },

            { GROUP_AGGR_INVALID              , "Aggregatfunktion sind nicht erlaubt im GROUP BY Klausel: ({0})." },
            { GROUP_AGGR_NOTPART              , "Der Ausdruck ''{0}'' ist nicht Teil einer Aggregatfunktion oder GROUP BY Klausel." },
            { ORDERBY_INTERNAL                , "Interner Error mit ORDER BY." },
            { UNION_DIFFERENT_COLS            , "Die SELECT Teile des UNION haben eine unterschiedliche Spaltenanzahl: {0} und {1}." },

            { INDEX_EXISTS                    , "Index ''{0}'' existiert bereits." },
            { INDEX_MISSING                   , "Index ''{0}'' existiert nicht." },
            { INDEX_FILE_INVALID              , "Die Datei ''{0}'' ist kein gÃ¼ltiger Indexspeicher." },
            { INDEX_CORRUPT                   , "Error beim Laden des Index. Die Index Datei ist beschÃ¤digt. ({0})." },
            { INDEX_TOOMANY_EQUALS            , "Zu viele identische EintrÃ¤ge im Index." },

            { FILE_TOONEW                     , "Dateiversion ({0}) der Datei ''{1}'' ist zu neu fÃ¼r diese Laufzeitbibliothek." },
            { FILE_TOOOLD                     , "Dateiversion ({0}) der Datei ''{1}'' ist zu alt fÃ¼r diese Laufzeitbibliothek." },
            { FILE_CANT_DELETE                , "Datei ''{0}'' kann nicht gelÃ¶scht werden." },

            { ROW_0_ABSOLUTE                  , "Datensatz 0 ist ungÃ¼ltig fÃ¼r die Methode absolute()." },
            { ROW_NOCURRENT                   , "Kein aktueller Datensatz." },
            { ROWS_WRONG_MAX                  , "Fehlerhafter Wert fÃ¼r Maximale Datensatzanzahl: {0}." },
            { ROW_LOCKED                      , "Der Datensatz ist gelocked von einer anderen Verbindung." },
            { ROW_DELETED                     , "Der Datensatz ist bereits gelÃ¶scht." },

            { SAVEPT_INVALID_TRANS            , "Der Savepoint ist nicht gÃ¼ltig fÃ¼r die aktuelle Transaction." },
            { SAVEPT_INVALID_DRIVER           , "Der Savepoint ist nicht gÃ¼ltig fÃ¼r diesen Treiber {0}." },

            { ALIAS_UNSUPPORTED               , "Ein Alias ist nicht erlaubt fÃ¼r diesen Typ von Rowsource." },
            { ISOLATION_UNKNOWN               , "Unbekantes Transaktion Isolation Level: {0}." },
            { FLAGVALUE_INVALID               , "UngÃ¼ltiger Wert des Flags in Methode getMoreResults: {0}." },
            { ARGUMENT_INVALID                , "UngÃ¼ltiges Argument in Methode setNeedGenratedKeys: {0}." },
            { GENER_KEYS_UNREQUIRED           , "GeneratedKeys wurden nicht angefordert." },
            { SEQUENCE_HEX_INVALID            , "UngÃ¼ltige Hexadecimal Sequenze bei Position {0}." },
            { SEQUENCE_HEX_INVALID_STR        , "UngÃ¼ltige Hexadecimal Sequenze bei Position {0} in ''{1}''." },

            { SYNTAX_BASE_OFS                 , "Syntax Error bei Position {0} in ''{1}''. " },
            { SYNTAX_BASE_END                 , "Syntax Error, unerwartetes Ende des SQL Strings. " },
            { STXADD_ADDITIONAL_TOK           , "ZusÃ¤tzliche Zeichen nach dem Ende des SQL statement." },
            { STXADD_IDENT_EXPECT             , "Bezeichner erwartet." },
            { STXADD_IDENT_EMPTY              , "Leerer Bezeichner." },
            { STXADD_IDENT_WRONG              , "UngÃ¼ltiger Bezeichner ''{0}''." },
            { STXADD_OPER_MINUS               , "UngÃ¼ltiger Operator Minus fÃ¼r Datentyp VARBINARY." },
            { STXADD_FUNC_UNKNOWN             , "Unbekannte Funktion." },
            { STXADD_PARAM_INVALID_COUNT      , "UngÃ¼ltige Paramter Anzahl." },
            { STXADD_JOIN_INVALID             , "UngÃ¼ltige Join Syntax." },
            { STXADD_FROM_PAR_CLOSE           , "Unerwartet schlieÃŸende Klammer in FROM Klausel." },
            { STXADD_KEYS_REQUIRED            , "BenÃ¶tige SchlÃ¼sselwÃ¶rter sind: " },
            { STXADD_NOT_NUMBER               , "Eine Zahl ist erforderlich: ''{0}''." },
            { STXADD_COMMENT_OPEN             , "Fehlendes Kommentarende ''*/''." },
    };
}