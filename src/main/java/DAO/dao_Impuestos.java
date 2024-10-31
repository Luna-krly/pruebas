/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Impuestos;
import Objetos.obj_Mensaje;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Impuestos extends DataAccessObject{
    private static final long serialVersionUID = 1L;
   public dao_Impuestos() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("-------------Ingresa a Impuestos DAO------------");
    }
    
   //---------------------------------------------------------MENU IMPUESTOS
    public obj_Mensaje ctg_impuestos(String opcion, obj_Impuestos objImpuestos, String idRegistro) {
        System.out.println("--Menu-- Impuestos");
        try {
            String sql = "call menu_impuestos (?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objImpuestos.getClaveImpuesto());
            stmt.setString(3, objImpuestos.getDescripcionImpuesto());
            stmt.setString(4, objImpuestos.getUsuario());
            stmt.setString(5, idRegistro);
            stmt.setString(6, objImpuestos.getRetencion());
            stmt.setString(7, objImpuestos.getTraslado());


            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(9, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(8));
            msj.setDescripcion(stmt.getString(9));
            msj.setTipo(stmt.getBoolean(10));
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
    public List<obj_Impuestos> Listar() throws SQLException, DAOException{
      System.out.println("--------------ImpuestosDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_Impuestos imp= null;
        List<obj_Impuestos> implista = new ArrayList<obj_Impuestos>();
        
        String sql="SELECT * FROM vw_impuestos";
        System.out.println("ImpuestosDAO.Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("ImpuestosDAO.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            imp= new obj_Impuestos();
            imp.setIdImpuesto(rs.getInt("id"));
            imp.setClaveImpuesto(rs.getString("clave"));
            imp.setDescripcionImpuesto(rs.getString("descripcion"));
            imp.setRetencion(rs.getString("retencion"));
            imp.setTraslado(rs.getString("traslado"));
            implista.add(imp);
            }
            
            return implista;
            
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
