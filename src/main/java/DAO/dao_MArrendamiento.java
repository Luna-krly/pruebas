/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_MArrendamiento;
import Objetos.obj_Mensaje;
import Objetos.obj_detalleArrendamiento;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_MArrendamiento extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_MArrendamiento() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("------------Ingresa a MArrendamiento  DAO------------");
    }

    //---------------------------------------------------------MENU GUARDA ENCABEZADO
    public int guardar_memo_arrendamiento(String opcion, obj_MArrendamiento objMemoArrendamiento) {
        System.out.println("--Menu-- Memo arrendamiento");
        try {
            String sql = "call menu_memo_arrendamiento (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setString(2, objMemoArrendamiento.getIdConcepto());
            stmt.setString(3, objMemoArrendamiento.getNombreConcepto());
            stmt.setString(4, objMemoArrendamiento.getIdMemorandum());
            stmt.setString(5, objMemoArrendamiento.getNoMemorandum());
            stmt.setString(6, objMemoArrendamiento.getFecha());
            stmt.setString(7, objMemoArrendamiento.getRemitente());
            stmt.setString(8, objMemoArrendamiento.getDestinatario());
            stmt.setString(9, objMemoArrendamiento.getCuentaBancaria());
            stmt.setString(10, objMemoArrendamiento.getConceptoGeneral());
            stmt.setDouble(11, objMemoArrendamiento.getSubtotal());
            stmt.setDouble(12, objMemoArrendamiento.getIva());
            stmt.setDouble(13, objMemoArrendamiento.getRetenido());
            stmt.setDouble(14, objMemoArrendamiento.getTotal());
            stmt.setString(15, objMemoArrendamiento.getTotalLetras());
            stmt.setString(16, objMemoArrendamiento.getNombreVo());
            stmt.setString(17, objMemoArrendamiento.getPuestoVo());
            stmt.setString(18, objMemoArrendamiento.getNombreAtt());
            stmt.setString(19, objMemoArrendamiento.getPuestoAtt());
            stmt.setString(20, objMemoArrendamiento.getUsuario());
            stmt.setString(21, objMemoArrendamiento.getMotivos());
            stmt.registerOutParameter(22, java.sql.Types.INTEGER);

            stmt.execute();

            int salida = stmt.getInt(22);
            System.out.println("Salida encabeazado " + salida);
            return salida;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            return 0;
        }
    }

    //---------------------------------------------------------MENU GUARDA DETALLE
    public String guardar_memo_arr_detalle(String opcion, obj_detalleArrendamiento objDetalle) {
        System.out.println("--Menu-- Memo detalle arrendamiento");
        try {
            String sql = "call menu_detalle_memo (?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setString(1, opcion);
            stmt.setInt(2, objDetalle.getIdEncabezado());
            stmt.setString(3, objDetalle.getConsecutivo());
            stmt.setString(4, objDetalle.getConcepto_desglose());
            stmt.setDouble(5, objDetalle.getImporte());
            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.execute();

            String salida = stmt.getString(6);
            System.out.println("Salida: " + salida);
            return salida;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }
    }

    //--------------------------------------------MOSTRAR LISTA Memorandums--------------------------------------------------------
    public List<obj_MArrendamiento> Listar() throws SQLException, DAOException {
        System.out.println("MemorandumGeneralDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_MArrendamiento memo = null;
        List<obj_MArrendamiento> memolista = new ArrayList<obj_MArrendamiento>();

        String sql = "SELECT * FROM vw_memorandum_general WHERE tipomemo='A'";

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("obj_MGeneralDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                memo = new obj_MArrendamiento();
                memo.setIdMemorandum(rs.getString("id_encmemo"));
                memo.setNoMemorandum(rs.getString("nomemo"));
                memo.setIdConcepto(rs.getString("id_concepto"));
                memo.setNombreConcepto(rs.getString("nomconcepto"));
                memo.setFecha(rs.getString("fechmemo"));
                memo.setRemitente(rs.getString("remi"));
                memo.setDestinatario(rs.getString("dest"));
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
    public obj_MArrendamiento buscarMemorandum(String noMemorandum) throws SQLException, DAOException {
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_MArrendamiento memorandum = null;

        String sql = "SELECT * FROM vw_memorandum_general WHERE nomemo=? AND tipomemo=? AND estatus=?";

        System.out.println("MArrendamientoDAO.buscar() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            stmt.setString(1, noMemorandum);
            stmt.setString(2, "A");
            stmt.setString(3, "A");
            rs = stmt.executeQuery();
            if (rs.next()) {
                memorandum = new obj_MArrendamiento();
                memorandum.setIdMemorandum(rs.getString("id_encmemo"));
                memorandum.setNoMemorandum(rs.getString("nomemo"));
                memorandum.setIdConcepto(rs.getString("id_concepto"));
                memorandum.setNombreConcepto(rs.getString("nomconcepto"));
                memorandum.setFecha(rs.getString("fechmemo"));
                memorandum.setRemitente(rs.getString("remi"));
                memorandum.setDestinatario(rs.getString("dest"));
                memorandum.setDepositoBancario(rs.getString("nombanco"));
                memorandum.setCuentaBancaria(rs.getString("nocta"));
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
                System.out.println("Retorna nullo");
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
    
    //--------------------------------------------BUSCAR MEMORANDUM--------------------------------------------------------
    public obj_MArrendamiento buscarparaImpresion(String noMemorandum) throws SQLException, DAOException {
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_MArrendamiento memorandum = null;

        String sql = "SELECT * FROM vw_memorandum_general WHERE nomemo=? AND tipomemo='A' AND (estatus='A' OR estatus='I') ";

        System.out.println("MArrendamientoDAO.buscarparaimpresion() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            stmt.setString(1, noMemorandum);
            System.out.println("*****QUERY: " +stmt );
            rs = stmt.executeQuery();
            if (rs.next()) {
                memorandum = new obj_MArrendamiento();
                memorandum.setIdMemorandum(rs.getString("id_encmemo"));
                memorandum.setNoMemorandum(rs.getString("nomemo"));
                System.out.println("******NOMEMO " + rs.getString("nomemo"));
                memorandum.setIdConcepto(rs.getString("id_concepto"));
                memorandum.setNombreConcepto(rs.getString("nomconcepto"));
                memorandum.setFecha(rs.getString("fechmemo"));
                System.out.println("Fecha: "+ rs.getString("fechmemo"));
                memorandum.setRemitente(rs.getString("remi"));
                memorandum.setDestinatario(rs.getString("dest"));
                memorandum.setDepositoBancario(rs.getString("nombanco"));
                memorandum.setCuentaBancaria(rs.getString("nocta"));
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
                System.out.println("Retorna nullo");
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

    //---------------------------------------BUSCAR DETALLE POR NO MEmorandum Lista ------------------------------------
    public List<obj_detalleArrendamiento> buscarDetalle(String noMemorandum) throws SQLException, DAOException {
        ResultSet rs = null;
        PreparedStatement stmt = null;
        System.out.println("MArrendamiento.Buscar por Clave()-----------");
        obj_detalleArrendamiento memorandum = null;
        List<obj_detalleArrendamiento> detallelista = new ArrayList<obj_detalleArrendamiento>();
        String sql = "SELECT * FROM memo_arrenda_detalle WHERE nomemo=? ";

        try {
            stmt = prepareStatement(sql);
            stmt.setString(1, noMemorandum);
            rs = stmt.executeQuery();
            while (rs.next()) {
                memorandum = new obj_detalleArrendamiento();
                memorandum.setIdDetalle(rs.getInt("id_memoimp"));
                memorandum.setIdMemorandum(rs.getString("id_encmemo"));
                memorandum.setNoMemorandum(rs.getString("nomemo"));
                memorandum.setConsecutivo(rs.getString("consecutivo"));
                memorandum.setConcepto_desglose(rs.getString("concepto_desglose"));
                memorandum.setImporte(rs.getDouble("importe"));
                detallelista.add(memorandum);
            }
            return detallelista;
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

        //---------------------------------------BUSCAR DETALLE POR NO MEmorandum Lista ------------------------------------
    public List<obj_detalleArrendamiento> buscarDetalleImpresion(String noMemorandum) throws SQLException, DAOException {
        ResultSet rs = null;
        PreparedStatement stmt = null;
        System.out.println("MArrendamiento.Buscar por Clave()-----------");
        obj_detalleArrendamiento memorandum = null;
        List<obj_detalleArrendamiento> detallelista = new ArrayList<obj_detalleArrendamiento>();
        String sql = "SELECT * FROM memo_arrenda_detalle WHERE nomemo=? ";

        try {
            stmt = prepareStatement(sql);
            stmt.setString(1, noMemorandum);
            rs = stmt.executeQuery();
            while (rs.next()) {
                memorandum = new obj_detalleArrendamiento();
                memorandum.setConcepto_desglose(rs.getString("concepto_desglose"));
                memorandum.setImporte(rs.getDouble("importe"));
                detallelista.add(memorandum);
            }
            return detallelista;
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
    public int CambiarEstatus(String noMemorandum) throws SQLException, DAOException {
        System.out.println("--------------GUARDAR ENCABEZADO FACTURA DAO--------------");
        PreparedStatement stmt = null;
        String sql = "UPDATE memo_encabezado SET estatus='I' WHERE nomemo=? AND tipomemo='A'";

        try {
            stmt = prepareStatement(sql);
            stmt.setString(1, noMemorandum);
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
    
        //--------------------------------------------MOSTRAR LISTA PARA REPORTE--------------------------------------------------------
    public List<obj_MArrendamiento> ImpresionLista(String fechaInicio, String fechaFin, String estatus) throws SQLException, DAOException {
        System.out.println("MemorandumGeneralDAO.lista reportes()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_MArrendamiento memo = null;
        List<obj_MArrendamiento> memolista = new ArrayList<obj_MArrendamiento>();

        String sql = "SELECT * "
                + "FROM vw_memorandum_general "
                + "WHERE ( fechmemo BETWEEN ? AND ? )"
                + "AND tipomemo = 'A' ";

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
                memo = new obj_MArrendamiento();
                memo.setIdMemorandum(rs.getString("id_encmemo"));
                memo.setNoMemorandum(rs.getString("nomemo"));
                memo.setConceptoGeneral(rs.getString("concepto_gen"));
                memo.setNombreVo(rs.getString("nombrevobo"));
                memo.setNombreAtt(rs.getString("nombreatte"));
                memo.setFecha(rs.getString("fechmemo"));
                memo.setTotal(rs.getDouble("total"));
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
}
