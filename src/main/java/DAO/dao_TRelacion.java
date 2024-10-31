/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_TRelacion;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_TRelacion extends DataAccessObject{
    private static final long serialVersionUID = 1L;
   
    public dao_TRelacion() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("-------------Ingresa a Tipo de Relacion DAO------------");
    }
    
//---------------------------------------------------------MENU TIPO RELACION
    public obj_Mensaje ctg_tipo_relacion(String opcion, obj_TRelacion objTipoRelacion, String idRegistro) {
        System.out.println("--Menu-- Tipo de Relación");
        try {
            String sql = "call menu_tipo_relacion (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objTipoRelacion.getClaveTipoRelacion());
            stmt.setString(3, objTipoRelacion.getDescripcionTipoRelacion());
            stmt.setString(4, objTipoRelacion.getUsuario());
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
    public List<obj_TRelacion> Listar() throws SQLException, DAOException{
      System.out.println("--------------TRelacionDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_TRelacion tr= null;
        List<obj_TRelacion> trlista = new ArrayList<obj_TRelacion>();
        
        String sql="SELECT * FROM vw_tipo_relacion";
        System.out.println("TRelacionDAO.Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("TRelacionDAO.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            tr= new obj_TRelacion();
            tr.setIdTipoRelacion(rs.getInt("id"));
            tr.setClaveTipoRelacion(rs.getString("clave"));
            tr.setDescripcionTipoRelacion(rs.getString("descripcion"));
            trlista.add(tr);
            }
            return trlista;
            
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
