/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_UMedida;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_UMedida extends DataAccessObject{
     private static final long serialVersionUID = 1L;
   public dao_UMedida() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("-------------Ingresa a Unidad de Medida DAO------------");
    }
    
   //---------------------------------------------------------MENU UNIDAD DE MEDIDA
    public obj_Mensaje ctg_ud_medida(String opcion, obj_UMedida objUnidadMedida, String idRegistro) {
        System.out.println("--Menu-- Unidad de Medida");
        try {
            String sql = "call menu_ud_medida (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objUnidadMedida.getClaveUnidadMedida());
            stmt.setString(3, objUnidadMedida.getDescripcionUnidadMedida());
            stmt.setString(4, objUnidadMedida.getUsuario());
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
    public List<obj_UMedida> Listar() throws SQLException, DAOException{
      System.out.println("--------------UMedidaDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_UMedida um= null;
        List<obj_UMedida> umlista = new ArrayList<obj_UMedida>();
        
        String sql="SELECT * FROM vw_ud_medida";
        System.out.println("UMedidaDAO.Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("UMedidaDAO.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            um= new obj_UMedida();
            um.setIdUnidadMedida(rs.getInt("id"));
            um.setClaveUnidadMedida(rs.getString("clave"));
            um.setDescripcionUnidadMedida(rs.getString("descripcion"));
            umlista.add(um);
            }

            return umlista;
            
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
}
