/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_MetodoPago;
import java.io.Reader;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_MPago extends DataAccessObject{
      private static final long serialVersionUID = 1L;
    
    public dao_MPago() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("-------------Ingresa a Método de Pago DAO------------");
    }
    
   //---------------------------------------------------------MENU METODO PAGO
    public obj_Mensaje ctg_metodopago(String opcion, obj_MetodoPago objMetodoPago, String idRegistro) {
        System.out.println("--Menu-- Método de Pago");
        try {
            String sql = "call menu_metodo_pago (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objMetodoPago.getClaveMetodoPago());
            stmt.setString(3, objMetodoPago.getDescripcionMetodoPago());
            stmt.setString(4, objMetodoPago.getUsuario());
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
    public List<obj_MetodoPago> Listar() throws SQLException, DAOException{
      System.out.println("--------------MetPagoDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_MetodoPago mpago= null;
        List<obj_MetodoPago> mplista = new ArrayList<obj_MetodoPago>();
        
        String sql="SELECT * FROM vw_metodo_pago";
        System.out.println("ProdServDAO.Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("MetPagoDAO.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            mpago= new obj_MetodoPago();
            mpago.setIdMetodoPago(rs.getInt("id"));
            mpago.setClaveMetodoPago(rs.getString("clave"));
            mpago.setDescripcionMetodoPago(rs.getString("descripcion"));
            mplista.add(mpago);
            }
            
            return mplista;
            
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
