/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_CodigoPostal;
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
public class dao_CodPostal extends DataAccessObject{
  private static final long serialVersionUID = 1L;
   
    public dao_CodPostal() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("Ingresa a CodigosPostales DAO");
    }
    
    //---------------------------------------------------------MENU CODIGO POSTAL
    public obj_Mensaje ctg_codigopostal(String opcion, obj_CodigoPostal objCodigoPostal, String idRegistro) {
        System.out.println("--Menu-- Codigo Postal");
        try {
            String sql = "call menu_codpos (?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            
            stmt.setString(2, objCodigoPostal.getCodigo());
            stmt.setString(3, objCodigoPostal.getColonia());
            stmt.setString(4, objCodigoPostal.getCiudad());
            stmt.setString(5, objCodigoPostal.getDelegacion());
            stmt.setString(6, objCodigoPostal.getEstado());
            stmt.setString(7, objCodigoPostal.getEstadoSAT());
            stmt.setString(8, objCodigoPostal.getUsuario());
            stmt.setString(9, idRegistro);


            stmt.registerOutParameter(10, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(11, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(12, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(10));
            msj.setDescripcion(stmt.getString(11));
            msj.setTipo(stmt.getBoolean(12));
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
    
//--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_CodigoPostal> Listar() throws SQLException, DAOException{
        System.out.println("--------------Codigos Postales DAO.  Show()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_CodigoPostal cpost= null;

        List<obj_CodigoPostal> cpostlista = new ArrayList<obj_CodigoPostal>();
        
        String sql="SELECT * FROM vw_codpos";
        System.out.println("Codigos Postales DAO. Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();

            while(rs.next()){
            cpost = new obj_CodigoPostal();    
            cpost.setIdCodigo(rs.getString("id"));
            cpost.setCodigo(rs.getString("codigo"));
            cpost.setColonia(rs.getString("colonia"));
            cpost.setCiudad(rs.getString("ciudad"));
            cpost.setDelegacion(rs.getString("delegacion"));
            cpost.setEstado(rs.getString("estado"));
            cpost.setEstadoSAT(rs.getString("estado_sat"));      
            cpostlista.add(cpost);
            }
            return cpostlista;
            
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
