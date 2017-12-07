import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

public final class PGConnector {
	private Connection dbConnection;
	private String url;
	
	public PGConnector(String hostAddress, String dbPort, String dbName) {
		url = "jdbc:postgresql://" + hostAddress + ":" + dbPort + "/" + dbName;
		dbConnection = null;
	}
	
	public boolean connect(String userName, String userPassword) {
		try {
			Class.forName("org.postgresql.Driver");
			dbConnection = DriverManager.getConnection(url, userName, userPassword);
			
			return true;
		} catch (Exception e) {
			showError(e);
			
			return false;
		}
	}
	
	public boolean disconnect() {
		try {
			dbConnection.close();
			return true;
		} catch (Exception e) {
			showError(e);
			return false;
		}
	}
	
	public boolean isConnected() {
		if (dbConnection != null) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean execute(String queryString) {
		Statement Query = null;
		
		try {
			Query = dbConnection.createStatement();
			Query.execute(queryString);
			
			return true;
		} catch(SQLException e) {
			showError(e);
			
			return false;
		} finally {
			try { Query.close(); } catch (Exception e){ showError(e); }
		}
	}
	
	public List<Map<String, Object>> executeQuery(String queryString) {
		Statement Query = null;
		ResultSet result = null;
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		Map<String, Object> row = null;
		
		try {
			Query = dbConnection.createStatement();
			result = Query.executeQuery(queryString);
			
			ResultSetMetaData metaData = result.getMetaData();
			
			int columnCount = metaData.getColumnCount();
			
			while(result.next()) {
				row = new HashMap<String, Object>();
				
				for(int i = 1; i < columnCount; i++) {
					row.put(metaData.getColumnName(i), result.getObject(i));
				}
				
				resultList.add(row);
			}
		} catch (SQLException e) {
			showError(e);
		} finally {
			try { result.close(); } catch (Exception e) { showError(e); }
			try { Query.close(); } catch (Exception e) { showError(e); }
		}
		
		return resultList;
	}
	
	public void showError(Exception e) {
		System.err.println("ERROR: " + e);
	}
}

