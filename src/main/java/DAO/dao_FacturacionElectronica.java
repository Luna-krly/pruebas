/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Objetos.obj_Factura;
import Objetos.obj_Mensaje;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_FacturacionElectronica extends DataAccessObject {

    private static final long serialVersionUID = 1L;

    public dao_FacturacionElectronica() throws ClassNotFoundException, SQLException {
        super();
        System.out.println("Ingresa a FACTURACIÓN ELECTRÓNICA DAO");
    }

    //--------------------------------------------MOSTRAR LISTA--------------------------------------------------------
    public List<obj_Factura> Listar() throws SQLException, DAOException {
        System.out.println("--------------FactuaElectronicaDAO.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Factura factura = null;
        List<obj_Factura> listafacturas = new ArrayList<obj_Factura>();

        String sql = "SELECT * FROM vw_facturas";
        System.out.println("FactuaElectronicaDAO.Mostar todo() - SQL - " + sql);

        try {
            stmt = prepareStatement(sql);
            rs = stmt.executeQuery();
            System.out.println("FactuaElectronicaDAO.Mostar - EJECUTA SENTENCIA");
            while (rs.next()) {
                factura = new obj_Factura();
                factura.setIdFactura(rs.getString("idFactura"));
                factura.setSerie(rs.getString("serie"));
                factura.setFolio(rs.getString("folio"));
                factura.setFechaFactura(rs.getString("fch_factura"));
                factura.setTotal(rs.getString("total"));
                factura.setUsuarioAutorizo(rs.getString("usuario_autoriza"));
                factura.setFechaAutorizo(rs.getString("fecha_autorizacion"));
                factura.setEstatus(rs.getString("estatus"));
                listafacturas.add(factura);
            }
            return listafacturas;

        } catch (Exception ex) {
            System.out.println("Ocurrió un error al mandar listas");
            System.out.println("Exception: " + ex);
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
        }
    }
//------------------

    //---------------------------------------------------------MENU GUARDA ENCABEZADO
    public Map<String, String> menu_factura_encabezado(String opcion, obj_Factura objFactura) {
        System.out.println("--Menu-- factura encabezado");
        Map<String, String> resultado = new HashMap<>();
        try {
            String sql = "call menu_factura_encabezado (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);
            stmt.setString(1, opcion);
            stmt.setString(2, objFactura.getIdFactura());
            stmt.setString(3, objFactura.getFolio());//--modificar
            stmt.setString(4, objFactura.getSerie());
            stmt.setString(5, objFactura.getFechaFactura());//--modificar
            stmt.setString(6, objFactura.getIdTipoComprobante());
            stmt.setString(7, objFactura.getIdCliente());
            stmt.setString(8, objFactura.getCpEmisorFactura());
            stmt.setString(9, objFactura.getIdUsoCFDI());
            stmt.setString(10, objFactura.getIdMoneda());
            stmt.setString(11, objFactura.getTipoCambio());
            stmt.setString(12, objFactura.getIdFormaPago());
            stmt.setString(13, objFactura.getCuentaBancaria());
            stmt.setString(14, objFactura.getIdMetodoPago());
            stmt.setString(15, objFactura.getIdTipoRelacion());
            stmt.setString(16, objFactura.getCondicionesPago());
            stmt.setString(17, objFactura.getIdPermiso());
            stmt.setString(18, objFactura.getSubtotal());
            stmt.setString(19, objFactura.getIVA());
            stmt.setString(20, objFactura.getTotal());
            stmt.setString(21, objFactura.getTotalLetras());
            stmt.setString(22, objFactura.getConceptoFactura());
            stmt.setString(23, objFactura.getFechaPago());
            stmt.setString(24, objFactura.getObservaciones());
            stmt.setString(25, objFactura.getIdPeriodicidad());
            stmt.setString(26, objFactura.getMes());
            stmt.setString(27, objFactura.getIdTipoServicio());
            stmt.setString(28, objFactura.getUsuario());
            stmt.registerOutParameter(29, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(30, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(31, java.sql.Types.VARCHAR);
            stmt.execute();
            
            // Obtener los valores de salida
        resultado.put("folio", stmt.getString(29));
        resultado.put("serie", stmt.getString(30));
        resultado.put("fechaFactura", stmt.getString(31));
            return resultado;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }
    }


    //---------------------------------------------------------MENU UNIDAD DE MEDIDA
    public obj_Mensaje guardar_listas(String listaProductos, String listaImportes,String folio, String serie, String fecha_factura) {
        System.out.println("--Menu-- guardar listas factutracion JSON");
        try {
            String sql = "call menu_facturas_listas (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);
            
            stmt.setString(1, listaProductos);
            stmt.setString(2, listaImportes);
            stmt.setString(3, folio);
            stmt.setString(4, serie);
            stmt.setString(5, fecha_factura);

            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(6));
            msj.setDescripcion(stmt.getString(7));
            msj.setTipo(stmt.getBoolean(8));
            System.out.println("SALIDA 6"+stmt.getString(6));
            System.out.println("SALIDA 7"+stmt.getString(7));
            System.out.println("SALIDA 8"+stmt.getString(8));
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
    //---------------------------------------------------------MENU UNIDAD DE MEDIDA
    public obj_Mensaje modificar_listas(String listaProductos, String listaImportes,String folio, String serie, String fecha_factura) {
        System.out.println("--Menu-- MODIFICAR listas factutracion JSON");
        try {
            String sql = "call menu_facturas_modificacion_listas (?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);
            
            stmt.setString(1, listaProductos);
            stmt.setString(2, listaImportes);
            stmt.setString(3, folio);
            stmt.setString(4, serie);
            stmt.setString(5, fecha_factura);

            stmt.registerOutParameter(6, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
            stmt.registerOutParameter(8, java.sql.Types.VARCHAR);
            stmt.execute();

            obj_Mensaje msj = new obj_Mensaje();
            msj.setMensaje(stmt.getString(6));
            msj.setDescripcion(stmt.getString(7));
            msj.setTipo(stmt.getBoolean(8));
            System.out.println("SALIDA 6"+stmt.getString(6));
            System.out.println("SALIDA 7"+stmt.getString(7));
            System.out.println("SALIDA 8"+stmt.getString(8));
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

    public obj_Factura buscarEncabezado(int folio) throws SQLException, DAOException {
        System.out.println("Busqueda de factura encabezado --------->");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Factura encabezado = new obj_Factura();

        String qs = "select id_enc_factura, folio, serie, id_comprobante, id_cliente, mes, concepto, fecha_pago,observ, id_uso_cfdi, id_monedas,id_forma_pago, noctabanco, id_metodo_pago, id_tipo_rel, id_tiposervicio, condiciones, id_permiso, id_periodicidad,totalletras  from factura_encabezado where folio = ?;";

        try {
            stmt = prepareStatement(qs);
            stmt.setInt(1, folio);
            rs = stmt.executeQuery();

            if (rs.next()) {
                encabezado.setIdFactura(rs.getString("id_enc_factura"));
                encabezado.setFolio(rs.getString("folio"));
                encabezado.setSerie(rs.getString("serie"));
                encabezado.setIdTipoComprobante(rs.getString("id_comprobante"));
                encabezado.setIdCliente(rs.getString("id_cliente"));
                encabezado.setMes(rs.getString("mes"));
                encabezado.setConceptoFactura(rs.getString("concepto"));
                encabezado.setFechaPago(rs.getString("fecha_pago"));
                encabezado.setObservaciones(rs.getString("observ"));
                encabezado.setIdUsoCFDI(rs.getString("id_uso_cfdi"));
                encabezado.setIdMoneda(rs.getString("id_monedas"));
                encabezado.setIdFormaPago(rs.getString("id_forma_pago"));
                encabezado.setCuentaBancaria(rs.getString("noctabanco"));
                encabezado.setIdMetodoPago(rs.getString("id_metodo_pago"));
                encabezado.setIdTipoRelacion(rs.getString("id_tipo_rel"));
                encabezado.setIdTipoServicio(rs.getString("id_tiposervicio"));
                encabezado.setCondicionesPago(rs.getString("condiciones"));
                encabezado.setIdPermiso(rs.getString("id_permiso"));
                encabezado.setIdPeriodicidad(rs.getString("id_periodicidad"));
                encabezado.setTotalLetras(rs.getString("totalletras"));
            }

            return encabezado;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
        }
    }

    public List<obj_Factura> buscarDetalle(int folio) throws SQLException, DAOException {
        System.out.println("Busqueda de factura detalle --------->");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Factura detalle = null;
        List<obj_Factura> detallesFactura = new ArrayList<obj_Factura>();

        String qs = "select folio, id_det_fact, renglon, id_prod_serv, cantidad, id_ud_medida, concepto, importe, predial, serie, fch_factura, precio_unitario, nofact_nc, serie_nc, fch_fact_nc, folio_fiscal_nc from factura_detalle where folio = ? order by renglon;";

        try {
            stmt = prepareStatement(qs);
            stmt.setInt(1, folio);
            rs = stmt.executeQuery();

            while (rs.next()) {
                detalle = new obj_Factura();

                detalle.setFolio(rs.getString("folio"));
                detalle.setRenglonProducto(rs.getString("renglon"));
                System.out.println("RENGLONNNNNNNNNNNNN ------" + rs.getString("renglon"));
                detalle.setIdProductoServicio(rs.getString("id_prod_serv"));
                detalle.setCantidad(rs.getString("cantidad"));
                detalle.setIdUnidadMedida(rs.getString("id_ud_medida"));
                detalle.setConceptoFactura(rs.getString("concepto"));
                detalle.setImporteConcepto(rs.getString("importe"));
                detalle.setPredial(rs.getString("predial"));
                detalle.setSerie(rs.getString("serie"));
                detalle.setFechaFactura(rs.getString("fch_factura"));
                detalle.setPrecioUnitario(rs.getString("precio_unitario"));
                detalle.setFacturaNC(rs.getString("nofact_nc"));
                detalle.setSerieNC(rs.getString("serie_nc"));
                detalle.setFechaFacturaNC(rs.getString("fch_fact_nc"));
                detalle.setFolioFiscalNC(rs.getString("folio_fiscal_nc"));
                detallesFactura.add(detalle);
            }

            return detallesFactura;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
        }
    }

    public List<obj_Factura> buscarimportes(int folio) throws SQLException, DAOException {
        System.out.println("Busqueda de factura importes --------->");
        ResultSet rs = null;
        PreparedStatement stmt = null;
        obj_Factura importe = null;
        List<obj_Factura> importesFactura = new ArrayList<obj_Factura>();

        String qs = "select ret_tras,id_imp_fact,folio,renglon, id_tipo_imp, id_tipo_factor, importebase, tasa_imp, imp_impuesto, renglon_concep from factura_importe  where folio = ? order by renglon, renglon_concep;";

        try {
            stmt = prepareStatement(qs);
            stmt.setInt(1, folio);
            rs = stmt.executeQuery();

            while (rs.next()) {
                importe = new obj_Factura();
                importe.setFolio(rs.getString("folio"));
                importe.setRenglonImpuesto(rs.getString("renglon"));
                importe.setRenglonProductoReferencia(rs.getString("renglon_concep"));
                importe.setIdFactura(rs.getString("id_imp_fact"));
                importe.setImporteBase(rs.getString("importebase"));
                importe.setTasa(rs.getFloat("tasa_imp"));
                importe.setImporteImpuesto(rs.getString("imp_impuesto"));
                importe.setIdTipoFactor(rs.getString("id_tipo_factor"));
                importe.setIdTipoimpuesto(rs.getString("id_tipo_imp"));
                importe.setImpuesto(rs.getString("ret_tras"));
                importesFactura.add(importe);
            }

            return importesFactura;
        } catch (Exception e) {
            System.out.println("Error: " + e);
            return null;
        } finally {
            closeStatement(stmt);
            closeResultSet(rs);
        }
    }

//---------------------------------------------------------MENU GUARDA ENCABEZADO
    public String validaFolio(int folio) {
        System.out.println("--Menu-- valida folio");
        try {
            String sql = "call validar_folio (?,?)";
            stmt = prepareCall(sql);
            stmt.setInt(1, folio);

            stmt.registerOutParameter(2, java.sql.Types.VARCHAR);
            stmt.execute();
            String salida = stmt.getString(2);
            return salida;

        } catch (Exception ex) {
            System.out.println("Ocurrio un error: " + ex);
            System.out.println("Causa: " + ex.getCause());
            System.out.println("Mensaje: " + ex.getMessage());
            return null;
        }
    }

}
