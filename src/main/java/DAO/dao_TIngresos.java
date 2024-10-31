/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_TIngreso;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_TIngresos extends DataAccessObject{
     private static final long serialVersionUID = 1L;
   
    public dao_TIngresos() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("------------Ingresa a Tipo Ingreso C DAO------------");
    }
  

//--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_TIngreso> Listar() throws SQLException, DAOException{
      System.out.println("--------------TIngresosCDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_TIngreso tingresoc= null;
        List<obj_TIngreso> tingresoclista = new ArrayList<obj_TIngreso>();
        
        String sql="SELECT * FROM vw_tipo_ingreso";
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){   
            tingresoc= new obj_TIngreso();
            tingresoc.setIdTipoIngresoC(rs.getInt("id"));
            tingresoc.setClaveTipoInrgesoC(rs.getString("clave"));
            tingresoc.setDescripcionTipoIngresoC(rs.getString("descripcion"));
            tingresoclista.add(tingresoc);
            }
            return tingresoclista;
            
        }catch(Exception ex){
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
    }           
//-----------------------------------------Llave final----------------------------------   
}
