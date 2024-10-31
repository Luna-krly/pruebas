/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_TServicio;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_TServicio extends DataAccessObject{
     private static final long serialVersionUID = 1L;
   
    public dao_TServicio() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("-------------Ingresa a TServicio DAO------------");
    }
    
    
  //---------------------------------------------------------MENU Tipo de Servicio
    public obj_Mensaje ctg_tipo_serv(String opcion, obj_TServicio objTipoServicio, String idRegistro) {
        System.out.println("--Menu-- Tipo de Servicio");
        try {
            String sql = "call menu_tipo_serv (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objTipoServicio.getClave());
            stmt.setString(3, objTipoServicio.getDescripcion());
            stmt.setString(4, objTipoServicio.getUsuario());
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
    public List<obj_TServicio> Listar() throws SQLException, DAOException{
      System.out.println("--------------TServicioDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_TServicio servicio= null;
        List<obj_TServicio> serviciolista = new ArrayList<obj_TServicio>();
        
        String sql="SELECT * FROM vw_tipo_serv";
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){   
            servicio= new obj_TServicio();
            servicio.setIdTServicio(rs.getInt("id"));
            servicio.setClave(rs.getString("clave"));
            servicio.setDescripcion(rs.getString("descripcion"));
            serviciolista.add(servicio);
            }
            return serviciolista;
            
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
