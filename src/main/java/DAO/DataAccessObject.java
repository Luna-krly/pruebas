/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class DataAccessObject {
     private Connection connection = null;

    private static final long serialVersionUID = 1L;
    CallableStatement stmt=null;
    
    //CONEXION BD DIRVER, URL, USUARIO, CONTRASEÑA Y PUERTO
    private static final String DRIVER ="com.mysql.cj.jdbc.Driver"; //com.microsoft.jdbc.sqlserver.SQLServerDriver///com.mysql.cj.jbc.Driver
//    private static final String URL="jdbc:mysql://50.192.40.245:3306/facturacion?allowPublicKeyRetrieval=true&useSSL=false";
//    private static final String USER="usuario1"; //sa";
//    private static final String PASSWORD="112233"; //"SS2022";
    
    private static final String URL="jdbc:mysql://10.15.15.76:3306/facturacion?allowPublicKeyRetrieval=true&useSSL=false";
    private static final String USER="facturacion"; //sa";
    private static final String PASSWORD="f4ctur4s";
    //private Connection connection=null;
    
    //INGESAR A LA BASE DE DATOS
    public DataAccessObject() throws ClassNotFoundException,SQLException{
        Class.forName(DRIVER);
        System.out.println("Comentario prueba");
        System.out.println("Comentario para karely");
        connection= DriverManager.getConnection(URL,USER,PASSWORD);
       System.out.println("Conectado");
    }
    
    //PREPARAR PROCEDIMIENTOS 
     public CallableStatement prepareCall(String sql) throws SQLException,DAOException {
        if(connection==null || connection.isClosed()){
            throw new DAOException("La base de datos esta cerrada");
        }else{
            return connection.prepareCall(sql);
        }        
    }
     
    //CREAR STATEMENT PARA DAR INSTRUCCIONES A LA BD
    public Statement createStatement() throws SQLException, DAOException {
        if(connection==null || connection.isClosed())
        {
            throw new DAOException("DAO HA SIDO CERRADA");
        }else{
            return connection.createStatement();
        }
    }
 
    //PREPARA EL STATEMENT
    public PreparedStatement prepareStatement(String sql) throws SQLException, DAOException{
        if(connection == null || connection.isClosed())
        {
            throw new DAOException("DAO HA SIDO CERRADA");
	}else{
            return connection.prepareStatement(sql);
	}
    }
    
    
    
    //CERRAR LA CONEXION
    public void closeConnection(){
	try{
            if(connection == null || connection.isClosed()){
		throw new DAOException("DAO HA SIDO CERRADA");
            }else{
		connection.close();
            }
			// System.out.println("DataAccessObject.closeConnection() - BASE DE DATOS CERRADA);
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }

        //TENET CONEXION CON LA BASE DE DATOS
    public Connection getConnection() throws SQLException, ClassNotFoundException, DAOException{
	System.out.println("DataAccessObject.getConnection()");
	if(connection == null || connection.isClosed()){
            throw new DAOException("DAO HA SIDO CERRADA");
	}
            return connection;
    }

    //CERRAR STATEMENT
    public void closeStatement(Statement stmt) throws SQLException, DAOException{
	if(connection == null || connection.isClosed()){
            throw new DAOException("DAO HA SIDO CERRADA");
	}
        if(stmt != null && !stmt.isClosed()){
            stmt.close();
	}
		// System.out.println("DataAccessObject.closeStatement() - STATEMENT DE BASE DE DATOS CERRADA");
    }
    
    //CERRAR QUERY
    public void closeResultSet(ResultSet rs) throws SQLException, DAOException{
	if(connection == null || connection.isClosed()){
            throw new DAOException("DAO HA SIDO CERRADA");
	}
	if(rs != null && !rs.isClosed()){
            rs.close();
	}
		// System.out.println("DataAccessObject.closeResultSet() - QUERY DE BASE DE DATOS CERRADA");
    }
}
