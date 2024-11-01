/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Perfil;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP
 */
public class dao_Perfil extends DataAccessObject {

    private static final long serialVersionUID =1L;
    
public dao_Perfil() throws ClassNotFoundException, SQLException{
    super();
    System.out.println("---------Ingresa a Perfil DAO-----------");
        }

//---------------mostrar lista--------------

 public List<obj_Perfil> listarperfil() throws SQLException, DAOException  {
            
        System.out.println("-----perfil.Mostrar lista()-----");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Perfil perfil = null;
        List<obj_Perfil> listaPerfil = new ArrayList<>();
        
         String sql="SELECT * FROM tabla_perfiles";
        
        try {
        stmt = prepareStatement(sql);
        rs = stmt.executeQuery();
            
        while(rs.next()){
            perfil = new obj_Perfil();
            perfil.setIdPerfil(rs.getInt("id_perfil"));
            perfil.setNombre_perfil(rs.getString("nombre_perfil"));
            perfil.setEstatus(rs.getString("estatus"));
            listaPerfil.add(perfil);
            }
         
        return listaPerfil;
        
        } catch (Exception ex) {
            System.out.println("Ocurrio un error al mandar la lista de areas") ;
            System.out.println("Excepcion: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
           
            //return null;
        }finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
        return null;

    }
 
}
