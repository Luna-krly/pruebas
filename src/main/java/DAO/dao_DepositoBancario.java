/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_DepositoBancario;
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
public class dao_DepositoBancario extends DataAccessObject{
    private static final long serialVersionUID = 1L;
   
    public dao_DepositoBancario() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("------------Ingresa a Deposito Bancario DAO------------");
    }
    
    //---------------------------------------------------------MENU FORMA DE PAGO
    public obj_Mensaje ctg_depositoBancario(String opcion, obj_DepositoBancario objDepositoBancario, String idRegistro) {
        System.out.println("--Menu-- Deposito Bancario");
        try {
            String sql = "call menu_deposito_bancario (?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objDepositoBancario.getIdBanco());
            stmt.setString(3, objDepositoBancario.getNombreBanco());
            stmt.setString(4, objDepositoBancario.getCuentaBancaria());
            stmt.setString(5, objDepositoBancario.getUsuario());
            stmt.setString(6, idRegistro);
            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(9, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(7));
            msj.setDescripcion(stmt.getString(8));
            msj.setTipo(stmt.getBoolean(9));
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
    public List<obj_DepositoBancario> Listar() throws SQLException, DAOException{
      System.out.println("DepositoBancarioDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_DepositoBancario depositoBancario= null;
        List<obj_DepositoBancario> depositolista = new ArrayList<obj_DepositoBancario>();
        
        String sql="SELECT * FROM vw_deposito_bancario";
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("DepositoBancarioDAO.Mostar - EJECUTA SENTENCIA");
            while(rs.next()){   
            depositoBancario= new obj_DepositoBancario();
            depositoBancario.setIdDeposito(rs.getString("id"));
            depositoBancario.setIdBanco(rs.getString("id_banco"));
            depositoBancario.setNombreBanco(rs.getString("nombre_banco"));
            depositoBancario.setCuentaBancaria(rs.getString("no_cuenta"));
            depositoBancario.setDepositoBancario(rs.getString("deposito_bancario"));
            depositolista.add(depositoBancario);
            }
            return depositolista;
            
        }catch(Exception ex){
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("DepositoBancarioDAO.Mostar -Cierra consulta");
        }
    }        
//---------------------------------------------------------     
    
    
}
