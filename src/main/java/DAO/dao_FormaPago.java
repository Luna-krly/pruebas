/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_FormaPago;
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
public class dao_FormaPago extends DataAccessObject{
    private static final long serialVersionUID = 1L;
   
    public dao_FormaPago() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("------------Ingresa a Forma Pago DAO------------");
    }
    
//---------------------------------------------------------MENU FORMA DE PAGO
    public obj_Mensaje ctg_formapago(String opcion, obj_FormaPago objFormaPago, String idRegistro) {
        System.out.println("--Menu-- Forma de Pago");
        try {
            String sql = "call menu_forma_pago (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objFormaPago.getClaveFormaPago());
            stmt.setString(3, objFormaPago.getDescripcionFormaPago());
            stmt.setString(4, objFormaPago.getUsuario());
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
    public List<obj_FormaPago> Listar() throws SQLException, DAOException{
      System.out.println("FormaPagoDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_FormaPago formaPago= null;
        List<obj_FormaPago> formaPagolista = new ArrayList<obj_FormaPago>();
        
        String sql="SELECT * FROM vw_forma_pago";
        System.out.println("FormaPagoDAO.Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("FormaPagoDAO.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            formaPago= new obj_FormaPago();
            formaPago.setIdFormaPago(rs.getInt("id"));
            formaPago.setClaveFormaPago(rs.getString("clave"));
            formaPago.setDescripcionFormaPago(rs.getString("descripcion"));
            formaPagolista.add(formaPago);
            }
            return formaPagolista;
            
        }catch(Exception ex){
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("FormaPagoDAO.Mostar -Cierra consulta");
        }
    }        
//---------------------------------------------------------     
}
