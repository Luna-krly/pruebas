/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_MGeneral;
import Objetos.obj_Mensaje;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_MGeneral extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_MGeneral() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("------------Ingresa a Memorandum General DAO------------");
    }

    //---------------------------------------------------------MENU FORMA DE PAGO
    public obj_Mensaje guardar_memo(String opcion, obj_MGeneral objMemoGeneral) {
        System.out.println("--Menu-- Memo general");
        try {
            String sql = "call menu_memo_gen (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objMemoGeneral.getIdConcepto());
            stmt.setString(3, objMemoGeneral.getNombreConcepto());
            stmt.setString(4, objMemoGeneral.getIdMemorandum());
            stmt.setString(5, objMemoGeneral.getNoMemorandum());
            stmt.setString(6, objMemoGeneral.getFecha());
            stmt.setString(7, objMemoGeneral.getRemitente());
            stmt.setString(8, objMemoGeneral.getDestinatario());
            stmt.setString(9, objMemoGeneral.getIdTIngreso());
            stmt.setString(10, objMemoGeneral.getConceptoGeneral());
            stmt.setDouble(11, objMemoGeneral.getTotal());
            stmt.setDouble(12, objMemoGeneral.getRetenido());
            stmt.setDouble(13, objMemoGeneral.getIva());
            stmt.setDouble(14, objMemoGeneral.getSubtotal());
            stmt.setString(15, objMemoGeneral.getTotalLetras());
            stmt.setString(16, objMemoGeneral.getNombreVo());
            stmt.setString(17, objMemoGeneral.getPuestoVo());
            stmt.setString(18, objMemoGeneral.getNombreAtt());
            stmt.setString(19, objMemoGeneral.getPuestoAtt());
            stmt.setString(20, objMemoGeneral.getUsuario());
            stmt.setString(21, objMemoGeneral.getCancelacion());

            stmt.registerOutParameter(22, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(23, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(24, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(22));
                        System.out.println("22 "+stmt.getString(22));
            msj.setDescripcion(stmt.getString(23));
            System.out.println("23 "+stmt.getString(23));
            msj.setTipo(stmt.getBoolean(24));
            System.out.println("24 "+stmt.getBoolean(24));
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
    public List<obj_MGeneral> Listar() throws SQLException, DAOException {
        System.out.println("MemorandumGeneralDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_MGeneral memo = null;
        List<obj_MGeneral> memolista = new ArrayList<obj_MGeneral>();

        String sql = "SELECT * FROM vw_memorandum_general WHERE tipomemo='G'";

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("obj_MGeneralDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                memo = new obj_MGeneral();
                memo.setIdMemorandum(rs.getString("id_encmemo"));
                memo.setNoMemorandum(rs.getString("nomemo"));
                memo.setIdConcepto(rs.getString("id_concepto"));
                memo.setNombreConcepto(rs.getString("nomconcepto"));
                memo.setFecha(rs.getString("fechmemo"));
                memo.setRemitente(rs.getString("remi"));
                memo.setDestinatario(rs.getString("dest"));
                memo.setIdTIngreso(rs.getString("id_tiping"));
                memo.setTipoIngreso(rs.getString("tipo_ing"));
                memo.setConceptoGeneral(rs.getString("concepto_gen"));
                memo.setTotal(rs.getDouble("total"));
                System.out.println("TOTAL DAO "+rs.getDouble("total") );
                memo.setRetenido(rs.getDouble("retenido"));
                memo.setIva(rs.getDouble("iva"));
                memo.setSubtotal(rs.getDouble("subtotal"));

                memo.setTotalLetras(rs.getString("totalletras"));
                memo.setNombreVo(rs.getString("nombrevobo"));
                memo.setPuestoVo(rs.getString("puestovobo"));
                memo.setNombreAtt(rs.getString("nombreatte"));
                memo.setPuestoAtt(rs.getString("puestoatte"));
                memo.setEstatus(rs.getString("estatus"));
                memo.setFechaCapturado(rs.getString("fch_alta"));
                memolista.add(memo);
            }
            return memolista;

        } catch (Exception ex) {
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
    }

//--------------------------------------------BUSCAR MEMORANDUM--------------------------------------------------------
    public obj_MGeneral buscarMemorandum(String noMemorandum) throws SQLException, DAOException {
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_MGeneral memorandum = null;

        String sql = "SELECT * FROM vw_memorandum_general WHERE nomemo=? AND tipomemo=? AND( estatus=?  OR estatus=? )";

        System.out.println("MArrendamientoDAO.buscar() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            stmt.setString(1, noMemorandum);
            stmt.setString(2, "G");
            stmt.setString(3, "A");
            stmt.setString(4, "I");
            rs = stmt.executeQuery();
            if (rs.next()) {
                memorandum = new obj_MGeneral();
                memorandum.setIdMemorandum(rs.getString("id_encmemo"));
                memorandum.setNoMemorandum(rs.getString("nomemo"));
                System.out.println("No Memo: "+rs.getString("nomemo"));
                memorandum.setIdConcepto(rs.getString("id_concepto"));
                memorandum.setNombreConcepto(rs.getString("nomconcepto"));
                memorandum.setFecha(rs.getString("fechmemo"));
                memorandum.setRemitente(rs.getString("remi"));
                memorandum.setDestinatario(rs.getString("dest"));
                memorandum.setConceptoGeneral(rs.getString("concepto_gen"));
                memorandum.setTotal(rs.getDouble("total"));
                memorandum.setRetenido(rs.getDouble("retenido"));
                memorandum.setIva(rs.getDouble("iva"));
                memorandum.setSubtotal(rs.getDouble("subtotal"));
                memorandum.setTotalLetras(rs.getString("totalletras"));
                memorandum.setNombreVo(rs.getString("nombrevobo"));
                memorandum.setPuestoVo(rs.getString("puestovobo"));
                memorandum.setNombreAtt(rs.getString("nombreatte"));
                memorandum.setPuestoAtt(rs.getString("puestoatte"));
                return memorandum;
            } else {
                return null;
            }
        } catch (Exception ex) {
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
    }

    //--------------------------------------------MOSTRAR LISTA PARA REPORTE--------------------------------------------------------
    public List<obj_MGeneral> ImpresionLista(String fechaInicio, String fechaFin, String estatus) throws SQLException, DAOException {
        System.out.println("MemorandumGeneralDAO.lista reportes()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_MGeneral memo = null;
        List<obj_MGeneral> memolista = new ArrayList<obj_MGeneral>();

        String sql = "SELECT * "
                + "FROM vw_memorandum_general "
                + "WHERE ( fechmemo BETWEEN ? AND ? )"
                + "AND tipomemo = 'G' ";

        if (estatus.equals("A")) {
                sql += "AND estatus = 'A'";
            } else if (estatus.equals("I")) {
                sql += "AND estatus = 'I'";
            } else if (estatus.equals("T")) {
                sql += "AND 'cualquiera' = 'cualquiera'";
            }
        
        try {
            stmt = prepareStatement(sql);
            stmt.setString(1, fechaInicio);
            System.out.println("Fecha inicio: "+fechaInicio);
            stmt.setString(2, fechaFin);
            System.out.println("Fecha fin: "+fechaFin);
            rs = stmt.executeQuery();

            System.out.println("MArrendamientoDAO.ImpresionLista() - SQL - " + stmt);
            
            while (rs.next()) {
                memo = new obj_MGeneral();
                memo.setIdMemorandum(rs.getString("id_encmemo"));
                memo.setNoMemorandum(rs.getString("nomemo"));
                System.out.println("No memo: "+rs.getString("nomemo"));
                memo.setIdConcepto(rs.getString("id_concepto"));
                memo.setNombreConcepto(rs.getString("nomconcepto"));
                memo.setFecha(rs.getString("fechmemo"));
                memo.setRemitente(rs.getString("remi"));
                memo.setDestinatario(rs.getString("dest"));
                memo.setIdTIngreso(rs.getString("id_tiping"));
                memo.setTipoIngreso(rs.getString("tipo_ing"));
                memo.setConceptoGeneral(rs.getString("concepto_gen"));

                memo.setTotal(rs.getDouble("total"));
                memo.setRetenido(rs.getDouble("retenido"));
                memo.setIva(rs.getDouble("iva"));
                memo.setSubtotal(rs.getDouble("subtotal"));

                memo.setTotalLetras(rs.getString("totalletras"));
                memo.setNombreVo(rs.getString("nombrevobo"));
                memo.setPuestoVo(rs.getString("puestovobo"));
                memo.setNombreAtt(rs.getString("nombreatte"));
                memo.setPuestoAtt(rs.getString("puestoatte"));
                memo.setEstatus(rs.getString("estatus"));
                memolista.add(memo);
            }
            return memolista;

        } catch (Exception ex) {
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
            System.out.println("Cierra consulta");
        }
    }
//---------------------------------------------------------     
    
     public int CambiarEstatus(String noMemorandum) throws SQLException, DAOException{
        System.out.println("--------------GUARDAR ENCABEZADO FACTURA DAO--------------");
        PreparedStatement stmt = null;
       
        String sql = "UPDATE memo_encabezado SET estatus='I' WHERE nomemo=? AND tipomemo='G'";

        
        try{
        
	stmt = prepareStatement(sql);
        
	stmt.setString(1,noMemorandum);
        stmt.executeUpdate();
	return 1;
	
        } catch (Exception ex) {
            System.out.println("Ocurrió un error al cambiar estatus I");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return 0;
        } finally {
            closeStatement(stmt);
            System.out.println("Cierra consulta");
        }
    }
}
