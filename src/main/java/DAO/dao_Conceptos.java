/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Conceptos;
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
public class dao_Conceptos extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_Conceptos() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("Ingresa a Conceptos DAO");
    }
    //---------------------------------------------------------MENU CONCEPTOS
    public obj_Mensaje ctg_conceptos(String opcion, obj_Conceptos objConcepto, String idRegistro) {
        System.out.println("--Menu-- Conceptos");
        try {
            String sql = "call menu_conceptos (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objConcepto.getNombre());
            stmt.setString(3, objConcepto.getTipoIngreso());
            stmt.setString(4, objConcepto.getRemitente());
            stmt.setString(5, objConcepto.getDestinatario());
            stmt.setString(6, objConcepto.getConcepto());
            stmt.setString(7, objConcepto.getNombreVo());
            stmt.setString(8, objConcepto.getPuestoVo());
            stmt.setString(9, objConcepto.getNombreAtt());
            stmt.setString(10, objConcepto.getPuestoAtt());
            stmt.setString(11, objConcepto.getUsuario());
            stmt.setString(12, idRegistro);

            stmt.registerOutParameter(13, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(14, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(15, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(13));
            msj.setDescripcion(stmt.getString(14));
            msj.setTipo(stmt.getBoolean(15));
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
    public List<obj_Conceptos> Listar() throws SQLException, DAOException {
        System.out.println("--------------Conceptos DAO.  Show()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Conceptos concepto = null;

        List<obj_Conceptos> conceptolista = new ArrayList<obj_Conceptos>();

        String sql = "SELECT * FROM vw_conceptos";// WHERE estatus='A' 
        System.out.println("Conceptos DAO. Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("Conceptos DAO. Mostar - EJECUTA SENTENCIA");

            while (rs.next()) {
                concepto = new obj_Conceptos();
                concepto.setIdConcepto(rs.getString("id"));
                concepto.setNombre(rs.getString("nombre"));
                concepto.setTipoIngreso(rs.getString("tipo_ingreso"));
                concepto.setRemitente(rs.getString("remitente"));
                concepto.setDestinatario(rs.getString("destinatario"));
                concepto.setConcepto(rs.getString("concepto"));
                concepto.setNombreVo(rs.getString("nombre_vobo"));
                concepto.setNombreAtt(rs.getString("nombre_att"));
                concepto.setPuestoVo(rs.getString("puesto_vobo"));
                concepto.setPuestoAtt(rs.getString("puesto_att"));
                conceptolista.add(concepto);
            }
            
            return conceptolista;

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
