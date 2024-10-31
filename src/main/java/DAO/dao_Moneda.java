/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Mensaje;
import Objetos.obj_Monedas;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Moneda extends DataAccessObject{
    private static final long serialVersionUID = 1L;
   
    public dao_Moneda() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("------------Ingresa a Moneda DAO------------");
    }
    
   //---------------------------------------------------------MENU MONEDA
    public obj_Mensaje ctg_moneda(String opcion, obj_Monedas objMoneda, String idRegistro) {
        System.out.println("--Menu-- Moneda");
        try {
            String sql = "call menu_moneda (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objMoneda.getClaveMoneda());
            stmt.setString(3, objMoneda.getDescripcionMoneda());
            stmt.setString(4, objMoneda.getUsuario());
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
    public List<obj_Monedas> Listar() throws SQLException, DAOException{
      System.out.println("--------------MonedaDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_Monedas moneda= null;
        List<obj_Monedas> monedalista = new ArrayList<obj_Monedas>();
        
        String sql="SELECT * FROM vw_moneda";
        System.out.println("MonedaDAO.Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("MonedaDAO.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            moneda= new obj_Monedas();
            moneda.setIdMoneda(rs.getInt("id"));
            moneda.setClaveMoneda(rs.getString("clave"));
            moneda.setDescripcionMoneda(rs.getString("descripcion"));
            monedalista.add(moneda);
            }
            
            return monedalista;
            
        } catch(Exception ex){
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("MonedaDAO.Mostar -Cierra consulta");
        }
    }           
//-----------------------------------------Llave final----------------------------------   
}
