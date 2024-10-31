/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_ClientesSAT;
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
public class dao_CltSat extends DataAccessObject{
    private static final long serialVersionUID = 1L;
   
    public dao_CltSat() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("Ingresa a ClienteSat-DAO");
    }
    
    //Para imprimir se utiliza Mostrar en estatus A

    //***********Modificar menu con parámetros 

       //---------------------------------------------------------MENU CLIENTES SAT
    public obj_Mensaje ctg_clientesSAT(String opcion, obj_ClientesSAT objCliente, String idRegistro) {
        System.out.println("--Menu-- Clientes SAT");
        System.out.println("Esta es una prueba para debuger" + objCliente.getCuentaBanco());
        try {
            String sql = "call menu_clientes_Sat(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setInt(2, objCliente.getNumeroCliente());
            stmt.setString(3, objCliente.getTipo());
            stmt.setInt(4, objCliente.getIdRegimen());
            stmt.setString(5, objCliente.getRfc());
            stmt.setString(6, objCliente.getNombreCliente());
            stmt.setString(7, objCliente.getCalle());
            stmt.setString(8, objCliente.getNumeroExterior());
            stmt.setString(9, objCliente.getNumeroInterior());
            stmt.setInt(10, objCliente.getIdCodigo());
            stmt.setString(11, objCliente.getEmail());
            stmt.setInt(12, objCliente.getIdPais());
            stmt.setString(13, objCliente.getReferencia());
            stmt.setString(14, objCliente.getCuentaBanco());
            stmt.setString(15, objCliente.getCodigoQr());
            stmt.setString(16, objCliente.getUsuario());
            stmt.setString(17, idRegistro);
            stmt.registerOutParameter(18, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(19, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(20, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(18));
            msj.setDescripcion(stmt.getString(19));
            msj.setTipo(stmt.getBoolean(20));
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
    //--------------------------------------------MOSTRAR ULTIMO--------------------------------------------------------
    public int ultimo() throws SQLException, DAOException{
        System.out.println("--------------CSatDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        String resultado=null;
        int numero=0;
        String sql="Select No_Cliente from cat_clientessat order by No_Cliente desc limit 1;";
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            while(rs.next()){   
            resultado=rs.getString("No_Cliente");
            numero=Integer.parseInt(resultado);
            }
            return numero;
            
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        }
    } 
    
    
    //--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_ClientesSAT> Listar() throws SQLException, DAOException {
        System.out.println("--------------UsoCFDIDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_ClientesSAT cs= null;
        List<obj_ClientesSAT> cslista = new ArrayList<obj_ClientesSAT>();

        String sql = "SELECT * FROM vw_clientessat";
        System.out.println("UsoCFDIDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("UsoCFDIDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                cs = new obj_ClientesSAT();
                cs.setIdCliente(rs.getInt("id"));
                cs.setNumeroCliente(rs.getInt("No_Cliente"));
                cs.setTipo(rs.getString("tipo"));
                
                cs.setIdRegimen(rs.getInt("id_regimen"));
                cs.setRegimenFiscal(rs.getString("regimen_fiscal"));
                
                cs.setRfc(rs.getString("rfc"));
                cs.setNombreCliente(rs.getString("nombre"));
                cs.setCalle(rs.getString("calle"));
                cs.setNumeroExterior(rs.getString("no_exterior"));
                cs.setNumeroInterior(rs.getString("no_interior"));
                
                cs.setIdCodigo(rs.getInt("id_codigo"));
                cs.setCodigo(rs.getString("codigo_postal"));
                
                cs.setDelegacion(rs.getString("delegacion"));
                cs.setEstado(rs.getString("estado"));
                
                
                
                cs.setIdPais(rs.getInt("id_pais"));
                cs.setPais(rs.getString("pais"));
                
                cs.setEmail(rs.getString("email"));
                cs.setReferencia(rs.getString("condicion_pago"));
                cs.setCuentaBanco(rs.getString("cuenta"));
                cs.setCodigoQr(rs.getString("codigoqr"));
                cslista.add(cs);
            }

            return cslista;

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