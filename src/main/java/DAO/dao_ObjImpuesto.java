/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_OImpuesto;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_ObjImpuesto extends DataAccessObject{
     private static final long serialVersionUID = 1L;
   
    public dao_ObjImpuesto() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("-------------Ingresa a ObjImpuesto DAO------------");
    }
  
   //---------------------------------------------------------MENU OBJETO DE IMPUESTO
    public obj_Mensaje ctg_obj_imp(String opcion, obj_OImpuesto objObjetoImpuesto, String idRegistro) {
        System.out.println("--Menu-- Objeto de Impuesto");
        try {
            String sql = "call menu_obj_imp (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objObjetoImpuesto.getClave());
            stmt.setString(3, objObjetoImpuesto.getDescripcion());
            stmt.setString(4, objObjetoImpuesto.getUsuario());
            stmt.setString(5, idRegistro);


            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(6));
            msj.setDescripcion(stmt.getString(7));
            msj.setTipo(stmt.getBoolean(8));
            return msj;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje("Ocurrió un error al llamar procedimiento");
            msj.setDescripcion(ex.getMessage());
            msj.setTipo(false);
            return msj;
        }
    }
    
//Para imprimir se utiliza Mostrar en estatus A
//--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_OImpuesto> Listar() throws SQLException, DAOException{
      System.out.println("--------------ObjImpuestoDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_OImpuesto obj_imp= null;
        List<obj_OImpuesto> obj_implista = new ArrayList<obj_OImpuesto>();
        

        String sql="SELECT * FROM vw_obj_imp";

        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){   
            obj_imp= new obj_OImpuesto();
            obj_imp.setIdObjetoImpuesto(rs.getInt("id"));
            obj_imp.setClave(rs.getString("clave"));
            obj_imp.setDescripcion(rs.getString("descripcion"));
            obj_implista.add(obj_imp);
            }
            return obj_implista;
            
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
//-------------------------------------------------------
}
