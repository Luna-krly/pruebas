/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Excepciones.DAOException;
import Funciones.Convertir;
import Objetos.Obj_Banco;
import Objetos.obj_Factura;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import Objetos.Obj_FacturacionAutomatica;
import Objetos.Obj_ConceptoFactura;
import Objetos.Obj_ImpuestoConcepto;
import Objetos.obj_Mensaje;
import java.time.Month;
import java.time.format.TextStyle;
import java.util.Date;
import java.util.Locale;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
public class dao_Facturas extends DataAccessObject{
     private static final long serialVersionUID = 1L;
   
    public dao_Facturas() throws ClassNotFoundException, SQLException{
        super();
         System.out.println("Ingresa a FACTURACION AUTOMATICA DAO");
    }
    
//--------------------------------------------FACTURACION AUTOMATICA--------------------------------------------------------

    //--- Facturas automaticas
    public List<Obj_FacturacionAutomatica> getEncabezadoFacturasAutomaticas(String nombreUsuario) throws SQLException, DAOException{
           System.out.println("--------------FACTURA.obetner lista de facturacion automatica()--------------");
           SimpleDateFormat formatoEntrada = new SimpleDateFormat("MMMM, yyyy", Locale.ENGLISH);
           SimpleDateFormat formatoSalida = new SimpleDateFormat("MMMM ',' yyyy", new Locale("es", "ES"));
           ResultSet rs = null;
           PreparedStatement stmt = null;
           Obj_FacturacionAutomatica furacionAutomatica= null;
           List<Obj_FacturacionAutomatica> facturasAutomaticas = new ArrayList<Obj_FacturacionAutomatica>();
           String sql="call obtener_encabezado_facturas_automaticas (?)";
        try {
                stmt = prepareStatement(sql);
                stmt.setString(1, nombreUsuario);
                rs=stmt.executeQuery();
                while(rs.next()){   
                    furacionAutomatica= new Obj_FacturacionAutomatica();

                    furacionAutomatica.setFolio(rs.getInt("folio"));
                    furacionAutomatica.setSerie(rs.getString("serie"));
                    furacionAutomatica.setCliente(rs.getString("cliente"));
                    furacionAutomatica.setRFC(rs.getString("rfc"));
                    furacionAutomatica.setTipoComprobante(rs.getString("TipoComprobante"));
                    furacionAutomatica.setLugarEmision(rs.getString("LugarEmision"));
                    furacionAutomatica.setUsoFactura(rs.getString("usoFactura"));
                    furacionAutomatica.setFechaFactura(rs.getString("fechaFactura"));
                    furacionAutomatica.setHoraFactura(rs.getString("horaFactura"));
                    furacionAutomatica.setMoneda(rs.getString("moneda"));
                    furacionAutomatica.setTipoCambio(rs.getString("tipoCambio"));
                    furacionAutomatica.setFormaPago(rs.getString("formaPago"));
                    furacionAutomatica.setMetodoPago(rs.getString("metodoPago"));
                    furacionAutomatica.setCuentaBanco(rs.getString("cuenta"));
                    furacionAutomatica.setCondicionesPago(rs.getString("condicionesPago"));
                    furacionAutomatica.setNoPermiso(rs.getString("permiso"));
                    furacionAutomatica.setSubTotal(rs.getDouble("subTotal"));
                    furacionAutomatica.setIVA(rs.getDouble("IVA"));
                    furacionAutomatica.setTotalFactura(rs.getDouble("totalFactura"));
                    furacionAutomatica.setTotalLetra(rs.getDouble("totalFactura"));
                    furacionAutomatica.setUsuarioResponsable(rs.getString("usuarioResponsable"));
                    furacionAutomatica.setFechaGeneracion(rs.getString("fechaGeneracion"));
                    furacionAutomatica.setEstatus(rs.getString("estatus"));
                    Date fecha = formatoEntrada.parse(rs.getString("conceptoFactura"));
                    String fechaFormateada = formatoSalida.format(fecha).toUpperCase();
                    furacionAutomatica.setConceptoFactura(fechaFormateada);
                    furacionAutomatica.setFechaPago(rs.getString("fechaPago"));
                    furacionAutomatica.setSaldoFactura(rs.getDouble("saldoFactura"));
                    String fechaRecibida = rs.getString("mesFactura");
                    String[] partes = fechaRecibida.split(" - ");
                    String mesNumero = partes[0];
                    String mesIngles = partes[1];

                    // Convertir el número de mes (MM) a un objeto Month
                    int mesInt = Integer.parseInt(mesNumero);
                    Month mes = Month.of(mesInt);

                    // Obtener el nombre del mes en español
                    String mesEspanol = mes.getDisplayName(TextStyle.FULL, new Locale("es", "ES")).toUpperCase();

                    // Formatear la salida final "MM - MES_EN_ESPAÑOL"
                    String fechaFormateadaMes = mesNumero + " - " + mesEspanol;
                    furacionAutomatica.setMesFactura(fechaFormateadaMes);
                    furacionAutomatica.setTipoServicio(rs.getString("tipoServicio"));
                    furacionAutomatica.setIdCliente(rs.getInt("id_cliente"));
                    facturasAutomaticas.add(furacionAutomatica);
                    
                }
                
                return facturasAutomaticas;
            
        } catch (Exception e) {
            System.out.println("Error" + e);
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        } 
    }
    
    public List<Obj_ConceptoFactura> getDetalleFacturasAutomaticas(String clienteRFC, String NoPermiso) throws SQLException, DAOException{ 
        System.out.println("--------------FACTURA.obetner lista de encabezado facturacion automatica()--------------");
           ResultSet rs = null;
           PreparedStatement stmt = null;
           Obj_ConceptoFactura detalleFactura= null;
           List<Obj_ConceptoFactura> conceptosFacturas = new ArrayList<Obj_ConceptoFactura>();
           String sql="call obtener_detalle_facturacion_automatica (?,?)";
        try {
                stmt = prepareStatement(sql);
                stmt.setString(1, clienteRFC);
                stmt.setString(2, NoPermiso);
                rs=stmt.executeQuery();
                while(rs.next()){   
                    detalleFactura= new Obj_ConceptoFactura();

                    detalleFactura.setFolio(rs.getInt("folio"));
                    detalleFactura.setSerie(rs.getString("serie"));
                    detalleFactura.setFechaFactura(rs.getString("fechaFactura")); 
                    detalleFactura.setRenglon(rs.getString("renglon"));
                    detalleFactura.setProductoServicio(rs.getString("productoServicio")); 
                    detalleFactura.setCantidad(rs.getString("cantidad")); 
                    detalleFactura.setUnidadMedida(rs.getString("unidadMedida")); 
                    detalleFactura.setDescripcionUnidadMedida(rs.getString("descripcionUnidadMedida")); 
                    detalleFactura.setPrecioUnitario(rs.getString("preciounitario"));
                    detalleFactura.setImporteConcepto(rs.getString("importeConcepto"));
                    detalleFactura.setCuentaPredial(rs.getString("cuentaPredial"));
                    detalleFactura.setConcepto(rs.getString("concepto"));
                    detalleFactura.setRFC(rs.getString("rfc"));
                    detalleFactura.setPermiso(rs.getString("permiso"));
                    conceptosFacturas.add(detalleFactura);
                    
                }
                return conceptosFacturas;
            
        } catch (Exception e) {
            System.out.println("Error" + e);
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        } 
    }
    
public List<Obj_ImpuestoConcepto> getImpuestosFacturasAutomaticas(String clienteRFC, String NoPermiso) throws SQLException, DAOException{ 
        System.out.println("--------------FACTURA.obetner lista de encabezado facturacion automatica()--------------");
           ResultSet rs = null;
           PreparedStatement stmt = null;
           Obj_ImpuestoConcepto impuestoFactura= null;
           List<Obj_ImpuestoConcepto> impuestosFacturas = new ArrayList<Obj_ImpuestoConcepto>();
           String sql="call obtener_impuesto_facturacion_automatica (?,?)";
        try {
                stmt = prepareStatement(sql);
                stmt.setString(1, clienteRFC);
                stmt.setString(2, NoPermiso);
                rs=stmt.executeQuery();
                while(rs.next()){   
                    impuestoFactura= new Obj_ImpuestoConcepto();

                    impuestoFactura.setFolio(rs.getInt("folio"));
                    impuestoFactura.setSerie(rs.getString("serie"));
                    impuestoFactura.setFechaFactura(rs.getString("fechaFactura")); 
                    impuestoFactura.setRenglon(rs.getString("renglon"));
                    impuestoFactura.setTipoImpuesto(rs.getString("tipoImpuesto")); 
                    impuestoFactura.setTipoFactor(rs.getString("tipoFactor")); 
                    impuestoFactura.setTasaImpuesto(rs.getString("tasaImpuesto")); 
                    impuestoFactura.setImporteImpuesto(rs.getString("importeImpuesto")); 
                    impuestoFactura.setImpTrasRet(rs.getString("importeTrasRet"));
                    impuestoFactura.setRenglonConcepto(rs.getString("renglonConcepto"));
                    impuestoFactura.setImpuestoBase(rs.getString("impuestoBase"));
                    impuestoFactura.setRFC(rs.getString("rfc"));
                    impuestoFactura.setPermiso(rs.getString("permiso"));                    
                    impuestosFacturas.add(impuestoFactura);
                    
                }
                return impuestosFacturas;
            
        } catch (Exception e) {
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        } 
    }

     public int saveEncabezadoFacturaAutomatica(Obj_FacturacionAutomatica encabezadoFactura) {
        System.out.println("--Guarda encabezado de facturacion automatica");
        int idEncabezado = -1;
        try {
           
            String sql = "call guardar_encabezado_automatico (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setInt(1, encabezadoFactura.getFolio());
            stmt.setString(2, encabezadoFactura.getSerie());
            stmt.setString(3, encabezadoFactura.getFechaFactura());
            stmt.setString(4, encabezadoFactura.getHoraFactura());
            stmt.setString(5, encabezadoFactura.getTipoCambio());
            stmt.setString(6, encabezadoFactura.getCuentaBanco());
            stmt.setString(7, encabezadoFactura.getCondicionesPago());
            stmt.setDouble(8, encabezadoFactura.getSubTotal());
            stmt.setDouble(9, encabezadoFactura.getIVA());
            stmt.setDouble(10, encabezadoFactura.getTotalFactura());
            stmt.setString(11, encabezadoFactura.getTotalLetra());
            stmt.setString(12, encabezadoFactura.getConceptoFactura());
            stmt.setString(13, encabezadoFactura.getFechaPago());
            stmt.setString(14, encabezadoFactura.getEstatus());
            stmt.setString(15, encabezadoFactura.getMesFactura());
            stmt.setString(16, encabezadoFactura.getNoPermiso());
            stmt.setInt(17, encabezadoFactura.getIdCliente());
            stmt.setString(18, encabezadoFactura.getUsuarioResponsable());
            stmt.setDouble(19, encabezadoFactura.getSaldoFactura());
            stmt.setString(20, encabezadoFactura.getRFC());
            
            stmt.registerOutParameter(21, java.sql.Types.INTEGER);
            stmt.execute();

            idEncabezado = stmt.getInt(21);
            
            return idEncabezado;

        } catch (Exception ex) {
            System.out.println("Error" + ex);
            idEncabezado = -1;
            return idEncabezado;
        }

    }
     
     public int saveDetalleFacturaAutomatica(Obj_ConceptoFactura detalleFactura, int idEncabezado, int folio) {
        int idDetalle = -1;
        try {
            System.out.println("Id Encabezado : " + idEncabezado);
            String sql = "call guardar_detalle_automatico (?,?,?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setInt(1, folio);
            stmt.setString(2, detalleFactura.getSerie());
            // Convertir la fecha al formato correcto
             SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
             java.util.Date date = sdf.parse(detalleFactura.getFechaFactura());
             java.sql.Date sqlDate = new java.sql.Date(date.getTime());
             stmt.setDate(3, sqlDate);
            stmt.setInt(4, idEncabezado);
            stmt.setString(5, detalleFactura.getRenglon());
            stmt.setString(6, detalleFactura.getCantidad());
            stmt.setString(7, detalleFactura.getConcepto());
            
            String precioSinComas = detalleFactura.getPrecioUnitario().replace(",", "");
            stmt.setString(8, precioSinComas);
            String importeSinComas = detalleFactura.getImporteConcepto().replace(",", "");
            stmt.setString(9,importeSinComas);
            
            stmt.setString(10, detalleFactura.getCuentaPredial());
            stmt.registerOutParameter(11, java.sql.Types.INTEGER);
            stmt.execute();

            idDetalle = stmt.getInt(11);
                
            System.out.println("Id detalle factura:  " + idDetalle);
            
            return idDetalle;

        } catch (Exception ex) {
            System.out.println("Error " + ex);
            idDetalle = -1;
            return idDetalle;
        }

    }
     
    public int saveImporteFacturaAutomatica(Obj_ImpuestoConcepto impuestoConcepto, int idEncabezado, int folio) {
        System.out.println("--Guarda encabezado de facturacion automatica");
        int idImpuesto = -1;
        try {
            String sql = "call guardar_importe_automatico (?,?,?,?,?,?,?,?,?)";
            stmt = prepareCall(sql);

            stmt.setInt(1, folio);
            stmt.setString(2, impuestoConcepto.getSerie());
            // Convertir la fecha al formato correcto
             SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
             java.util.Date date = sdf.parse(impuestoConcepto.getFechaFactura());
             java.sql.Date sqlDate = new java.sql.Date(date.getTime());
            stmt.setDate(3, sqlDate);
            stmt.setString(4, impuestoConcepto.getRenglon());
            stmt.setString(5, impuestoConcepto.getTasaImpuesto());
            
            String importeImpuesto = impuestoConcepto.getImporteImpuesto().replace(",", "");
            stmt.setString(6, importeImpuesto);
            stmt.setString(7, impuestoConcepto.getRenglonConcepto());
            String importeBase = impuestoConcepto.getImpuestoBase().replace(",", "");
            stmt.setString(8, importeBase);
            stmt.registerOutParameter(9, java.sql.Types.INTEGER);
            stmt.execute();

            idImpuesto = stmt.getInt(9);
            
            System.out.println("Id importe factura:  " + idImpuesto);
            
            return idImpuesto;

        } catch (Exception ex) {
            System.out.println("ERR " + ex);
            idImpuesto = -1;
            return idImpuesto;
        }

    }
    
public void updateMonthCreateFactura(Obj_FacturacionAutomatica encabezadoFactura, String mes) {
        System.out.println("--Guarda encabezado de facturacion automatica");
        try {
            String sql = "UPDATE clientes_refer SET mesgenerado = ? WHERE rfc = ? AND permiso = ? AND mesgenerado <> ? AND usr_responsable = ?";
            stmt = prepareCall(sql);
            stmt.setString(1, mes);
            stmt.setString(2, encabezadoFactura.getRFC());
            stmt.setString(3, encabezadoFactura.getNoPermiso());
            stmt.setString(4, mes);
            stmt.setString(5, encabezadoFactura.getUsuarioResponsable());
            stmt.execute();

        } catch (Exception ex) {
           
        }

    }

    public List<Obj_FacturacionAutomatica> getEncabezadoFacturasAutomaticasMesesAnteriores(String nombreUsuario, String rfc, String permiso, String[] meses, String year) throws SQLException, DAOException{
           System.out.println("Meses" + meses.length);
           System.out.println("--------------FACTURA.obetner lista de facturacion automatica()--------------");
           SimpleDateFormat formatoEntrada = new SimpleDateFormat("MMMM, yyyy", Locale.ENGLISH);
           SimpleDateFormat formatoSalida = new SimpleDateFormat("MMMM ',' yyyy", new Locale("es", "ES"));
           ResultSet rs = null;
           PreparedStatement stmt = null;
           Obj_FacturacionAutomatica furacionAutomatica= null;
           List<Obj_FacturacionAutomatica> facturasAutomaticas = new ArrayList<Obj_FacturacionAutomatica>();
           String sql="call obtener_encabezado_facturas_automaticas_meses_anteriores (?,?,?)";
        try {
                stmt = prepareStatement(sql);
                stmt.setString(1, nombreUsuario);
                stmt.setString(2, rfc);
                stmt.setString(3, permiso);
                System.out.println("quert" + stmt.toString());
                rs=stmt.executeQuery();
                while(rs.next()){
                    int i = 0;
                    for(String mes :  meses ){
                        
                        furacionAutomatica= new Obj_FacturacionAutomatica();
                        
                        if(i == 0){
                            System.out.println("indice" + i);
                            furacionAutomatica.setFolio(rs.getInt("folio"));
                        }else{
                            System.out.println("Foliooooooo================>" + rs.getInt("folio")+i );
                             furacionAutomatica.setFolio(rs.getInt("folio")+i);
                        }
                      
                        furacionAutomatica.setSerie(rs.getString("serie"));
                        furacionAutomatica.setCliente(rs.getString("cliente"));
                        furacionAutomatica.setRFC(rs.getString("rfc"));
                        furacionAutomatica.setTipoComprobante(rs.getString("TipoComprobante"));
                        furacionAutomatica.setLugarEmision(rs.getString("LugarEmision"));
                        furacionAutomatica.setUsoFactura(rs.getString("usoFactura"));
                        furacionAutomatica.setFechaFactura(rs.getString("fechaFactura"));
                        furacionAutomatica.setHoraFactura(rs.getString("horaFactura"));
                        furacionAutomatica.setMoneda(rs.getString("moneda"));
                        furacionAutomatica.setTipoCambio(rs.getString("tipoCambio"));
                        furacionAutomatica.setFormaPago(rs.getString("formaPago"));
                        furacionAutomatica.setMetodoPago(rs.getString("metodoPago"));
                        furacionAutomatica.setCuentaBanco(rs.getString("cuenta"));
                        furacionAutomatica.setCondicionesPago(rs.getString("condicionesPago"));
                        furacionAutomatica.setNoPermiso(rs.getString("permiso"));
                        furacionAutomatica.setSubTotal(rs.getDouble("subTotal"));
                        furacionAutomatica.setIVA(rs.getDouble("IVA"));
                        furacionAutomatica.setTotalFactura(rs.getDouble("totalFactura"));
                        furacionAutomatica.setTotalLetra(rs.getDouble("totalFactura"));
                        furacionAutomatica.setUsuarioResponsable(rs.getString("usuarioResponsable"));
                        furacionAutomatica.setFechaGeneracion(rs.getString("fechaGeneracion"));
                        furacionAutomatica.setEstatus(rs.getString("estatus"));
                        
                        String mesLetras = Convertir.obtenerNombreMes(mes);
                        String fechaFormateada = mesLetras + ", " + year;
                        

//                        Date fecha = formatoEntrada.parse(rs.getString("conceptoFactura"));
//                        String fechaFormateada = formatoSalida.format(fecha).toUpperCase();
                        furacionAutomatica.setConceptoFactura(fechaFormateada);


                        furacionAutomatica.setFechaPago(rs.getString("fechaPago"));
                        furacionAutomatica.setSaldoFactura(rs.getDouble("saldoFactura"));

                        String fechaRecibida = rs.getString("mesFactura");
                        String[] partes = fechaRecibida.split(" - ");
                        String mesNumero = partes[0];
                        String mesIngles = partes[1];

                        // Convertir el número de mes (MM) a un objeto Month
                        int mesInt = Integer.parseInt(mesNumero);
                        Month month = Month.of(mesInt);

                        // Obtener el nombre del mes en español
                        String mesEspanol = month.getDisplayName(TextStyle.FULL, new Locale("es", "ES")).toUpperCase();

                        // Formatear la salida final "MM - MES_EN_ESPAÑOL"
                        String fechaFormateadaMes = mesNumero + " - " + mesEspanol;
                        furacionAutomatica.setMesFactura(fechaFormateadaMes);

                        furacionAutomatica.setTipoServicio(rs.getString("tipoServicio"));
                        furacionAutomatica.setIdCliente(rs.getInt("id_cliente"));
                        facturasAutomaticas.add(furacionAutomatica);
                        i++;
                    }
                 
                }
                
                return facturasAutomaticas;
            
        } catch (Exception e) {
            System.out.println("Error" + e);
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        } 
    }
    
    public List<Obj_ConceptoFactura> getDetalleFacturasAutomaticasMesesAnteriores(String clienteRFC, String NoPermiso,  String[] meses, String year) throws SQLException, DAOException{ 
        System.out.println("--------------FACTURA.obetner lista de encabezado facturacion automatica meses()--------------");
           ResultSet rs = null;
           PreparedStatement stmt = null;
           Obj_ConceptoFactura detalleFactura= null;
           List<Obj_ConceptoFactura> conceptosFacturas = new ArrayList<Obj_ConceptoFactura>();
           String sql="call obtener_detalle_facturacion_automatica_meses_anteriores (?,?)";
        try {
                stmt = prepareStatement(sql);
                stmt.setString(1, clienteRFC);
                stmt.setString(2, NoPermiso);
                rs=stmt.executeQuery();
                while(rs.next()){   
                    detalleFactura= new Obj_ConceptoFactura();

                    detalleFactura.setFolio(rs.getInt("folio"));
                    detalleFactura.setSerie(rs.getString("serie"));
                    detalleFactura.setFechaFactura(rs.getString("fechaFactura")); 
                    detalleFactura.setRenglon(rs.getString("renglon"));
                    detalleFactura.setProductoServicio(rs.getString("productoServicio")); 
                    detalleFactura.setCantidad(rs.getString("cantidad")); 
                    detalleFactura.setUnidadMedida(rs.getString("unidadMedida")); 
                    detalleFactura.setDescripcionUnidadMedida(rs.getString("descripcionUnidadMedida")); 
                    detalleFactura.setPrecioUnitario(rs.getString("preciounitario"));
                    detalleFactura.setImporteConcepto(rs.getString("importeConcepto"));
                    detalleFactura.setCuentaPredial(rs.getString("cuentaPredial"));
                    detalleFactura.setConcepto(rs.getString("concepto"));
                    detalleFactura.setRFC(rs.getString("rfc"));
                    detalleFactura.setPermiso(rs.getString("permiso"));
                    conceptosFacturas.add(detalleFactura);
                    
                }
                return conceptosFacturas;
            
        } catch (Exception e) {
            System.out.println("Error" + e);
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        } 
    }
    
    public List<Obj_ImpuestoConcepto> getImpuestosFacturasAutomaticasMesesAnteriores(String clienteRFC, String NoPermiso, String[] meses, String year) throws SQLException, DAOException{ 
        System.out.println("--------------FACTURA.obetner lista de encabezado facturacion automatica meses()--------------");
           ResultSet rs = null;
           PreparedStatement stmt = null;
           Obj_ImpuestoConcepto impuestoFactura= null;
           List<Obj_ImpuestoConcepto> impuestosFacturas = new ArrayList<Obj_ImpuestoConcepto>();
           String sql="call obtener_impuesto_facturacion_automatica_meses_anteriores (?,?)";
        try {
                stmt = prepareStatement(sql);
                stmt.setString(1, clienteRFC);
                stmt.setString(2, NoPermiso);
                rs=stmt.executeQuery();
                while(rs.next()){   
                    impuestoFactura= new Obj_ImpuestoConcepto();

                    impuestoFactura.setFolio(rs.getInt("folio"));
                    impuestoFactura.setSerie(rs.getString("serie"));
                    impuestoFactura.setFechaFactura(rs.getString("fechaFactura")); 
                    impuestoFactura.setRenglon(rs.getString("renglon"));
                    impuestoFactura.setTipoImpuesto(rs.getString("tipoImpuesto")); 
                    impuestoFactura.setTipoFactor(rs.getString("tipoFactor")); 
                    impuestoFactura.setTasaImpuesto(rs.getString("tasaImpuesto")); 
                    impuestoFactura.setImporteImpuesto(rs.getString("importeImpuesto")); 
                    impuestoFactura.setImpTrasRet(rs.getString("importeTrasRet"));
                    impuestoFactura.setRenglonConcepto(rs.getString("renglonConcepto"));
                    impuestoFactura.setImpuestoBase(rs.getString("impuestoBase"));
                    impuestoFactura.setRFC(rs.getString("rfc"));
                    impuestoFactura.setPermiso(rs.getString("permiso"));                    
                    impuestosFacturas.add(impuestoFactura);
                    
                }
                return impuestosFacturas;
            
        } catch (Exception e) {
            System.out.println("Eroor impuesto: " + e);
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        } 
    }
    
    //*************************************BUSCAR POR FOLIO Y SERIE********************************
    //ENCABEZADO
    public obj_Factura Buscar(int folio, String serie) throws SQLException, DAOException{
        System.out.println("--------------FACTURAS.  Find()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	System.out.println("FACTURAS B. Buscar por serie y folio()");
        obj_Factura fact=null;
        // Crear un formateador de fechas con el formato deseado
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Puedes ajustar el formato según tus necesidades
        // Convertir la fecha a una cadena


	String sql="SELECT * FROM factura_encabezado WHERE folio=? AND serie=?";
        
        System.out.println("FACTURAS B. find() - SQL - " + sql);
        
        try{
            System.out.println("FACTURAS B. find() - Ingresa TRY - ");
            stmt = prepareStatement(sql);
            stmt.setInt(1,folio);
            stmt.setString(2,serie);
            System.out.println("FACTURAS B. find() - STMT - " +stmt);
            rs=stmt.executeQuery();
            System.out.println("FACTURAS B. find() - RS - " +rs);
            if(rs.next()){
                fact = new obj_Factura();
                fact.setFolio(rs.getString("folio"));
                fact.setSerie(rs.getString("serie"));
//                fact.setIdComprobante(rs.getInt("id_comprobante"));
                fact.setIdCliente(rs.getString("id_cliente"));
                fact.setClaveCodigoPostal(rs.getString("cve_comprobante"));
                fact.setIdUsoCFDI(rs.getString("id_uso_cfdi"));
                fact.setIdMoneda(rs.getString("id_monedas"));
                fact.setTipoCambio(rs.getString("tipocambio"));
                fact.setIdFormaPago(rs.getString("id_forma_pago"));
                fact.setCuentaBancaria(rs.getString("noctabanco"));
                fact.setIdMetodoPago(rs.getString("id_metodo_pago"));
                fact.setIdTipoRelacion(rs.getString("id_tipo_rel"));
                fact.setCondicionesPago(rs.getString("condiciones"));
                fact.setNoPermiso(rs.getString("noPermiso"));
                fact.setSubtotal(rs.getString("subtotal"));
                fact.setIVA(rs.getString("iva"));
                fact.setTotal(rs.getString("total"));
                fact.setConceptoFactura("concepto");
                java.sql.Date fechaSQL= rs.getDate("fch_pago");
                java.util.Date FechaP= new java.util.Date(fechaSQL.getTime());
                String fechaPago = sdf.format(FechaP);
                fact.setFechaPago(fechaPago);
                java.sql.Date fechaSQL2= rs.getDate("fch_factura");
                java.util.Date FechaF= new java.util.Date(fechaSQL2.getTime());
                String fechaFactura = sdf.format(FechaF);
                fact.setFechaFactura(fechaFactura);
             return fact;
        
            }else{
            return null;
            }

        }catch(Exception ex){
            System.out.println("Error: " + ex);
            return null;
        }finally{
            closeResultSet(rs);
            closeStatement(stmt);
        }
 
    }
    
    //ENCABEZADO
public obj_Factura EncAut(obj_Factura autEnc) throws SQLException, DAOException{
    int folio = Integer.parseInt(autEnc.getFolio());
    PreparedStatement stmt=null;
    System.out.println("----------------ENCABEZADO, BUSCAR DAO---------------------");
    String sql="UPDATE factura_encabezado "
            + "SET estatus='A' ,cveusr_cambio=? ,fch_cambio=? "
            + "WHERE serie=? AND folio=? ";
    System.out.println("EncabezadoDAO.MODIFICAR()-SQL-");
    
    try{
        stmt= prepareStatement(sql);
   //     stmt.setString(1, autEnc.getCveusrCambio());
    //    stmt.setDate(2, (java.sql.Date) autEnc.getFchCambio());
        stmt.setString(3, autEnc.getSerie());
        stmt.setInt(4,folio);
        stmt.executeUpdate();
        return autEnc;        
    }catch(Exception ex){
            System.out.println("Error: " + ex);
            return null;
        }finally{
    closeStatement(stmt);
    }
}   

//DETALLE
public obj_Factura DetAut(obj_Factura detEnc) throws SQLException, DAOException{
    int folio = Integer.parseInt(detEnc.getFolio());
    PreparedStatement stmt=null;
    System.out.println("----------------DETALLE, BUSCAR DAO---------------------");
    String sql="UPDATE factura_detalle "
            + "SET estatus='A',cveusr_cambio=? ,fch_cambio=? "
            + "WHERE serie=? AND folio=? ";
    System.out.println("DetalleDAO.MODIFICAR()-SQL-");
    
    try{
        stmt= prepareStatement(sql);
       // stmt.setString(1, detEnc.getCveusrCambio());
       // stmt.setDate(2, (java.sql.Date) detEnc.getFchCambio());
        stmt.setString(3, detEnc.getSerie());
        stmt.setInt(4, folio);

        stmt.executeUpdate();
        return detEnc;        
    }catch(Exception ex){
            System.out.println("Error: " + ex);
            return null;
        }finally{
    closeStatement(stmt);
    }
}     

//IMPUESTOS
public obj_Factura ImpAut(obj_Factura impEnc) throws SQLException, DAOException{
    PreparedStatement stmt=null;
    int folio = Integer.parseInt(impEnc.getFolio());
    
    System.out.println("----------------IMPUESTOS, BUSCAR DAO---------------------");
    String sql="UPDATE factura_importe "
            + "SET estatus='A' ,cveusr_cambio=? ,fch_cambio=? "
            + "WHERE serie=? AND folio=? ";
    System.out.println("ImpuestosDAO.MODIFICAR()-SQL-");
    
    try{
        stmt= prepareStatement(sql);
     //   stmt.setString(1, impEnc.getCveusrCambio());
      //  stmt.setDate(2, (java.sql.Date) impEnc.getFchCambio());
        stmt.setString(3, impEnc.getSerie());
        stmt.setInt(4, folio);
        stmt.executeUpdate();
        return impEnc;        
    }catch(Exception ex){
            System.out.println("Error: " + ex);
            return null;
        }finally{
    closeStatement(stmt);
    }
}

 public List<obj_Factura> Slista() throws SQLException, DAOException{
      System.out.println("--------------FACTURA.Mostrar lista()--------------");
        ResultSet rs = null;
        PreparedStatement stmt = null;
	obj_Factura fac= null;
        List<obj_Factura> faclista = new ArrayList<obj_Factura>();
        
        String sql = "SELECT "
                            + "ef.folio, "
                            + "ef.serie, "
                            + "ef.id_comprobante, "
                            + "ef.id_cliente, "
                            + "ef.cve_codigo_postal, "
                            + "ef.id_uso_cfdi, "
                            + "ef.fch_factura, "
                            + "ef.hr_factura, "
                            + "ef.id_monedas, "
                            + "ef.tipocambio, "
                            + "ef.id_forma_pago, "
                            + "ef.noctabanco, "
                            + "ef.id_metodo_pago, "
                            + "ef.id_tipo_rel, "
                            + "ef.condiciones, "
                            + "ef.num_permiso_concepto, "
                            + "ef.subtotal, "
                            + "ef.iva, "
                            + "ef.total, "
                            + "ef.concepto, "
                            + "ef.fecha_pago, "
                            + "ef.usuario_autoriza, "
                            + "ef.cveusr_cambio, "
                            + "ef.fch_cambio, "
                            + "ef.estatus, "
                            + "df.renglon, "
                            + "df.id_prod_serv, "
                            + "df.cantidad, "
                            + "df.id_ud_medida, "
                            + "df.concepto, "
                            + "df.precio_unitario, "
                            + "df.importe, "
                            + "df.predial, "
                            + "imf.renglon, "
                            + "imf.importebase, "
                            + "imf.id_tipo_factor, "
                            + "imf.tasa_imp, "
                            + "imf.imp_impuesto, "
                            + "imf.tipo_impuesto "
                            + "FROM "
                            + "factura_encabezado ef "
                            + "INNER JOIN "
                            + "factura_detalle df ON ef.folio = df.folio AND ef.serie = df.serie "
                            + "INNER JOIN "
                            + "factura_importe imf ON ef.folio = imf.folio AND ef.serie = imf.serie "
                            + "-- WHERE ef.estatus = 'A' "
                            + "ORDER BY "
                            + "ef.folio ASC;";

        System.out.println("FACTURA.Mostar todo() - SQL - " + sql);
        
        try{
            stmt = prepareStatement(sql);
            rs=stmt.executeQuery();
            System.out.println("FACTURA.Mostar - EJECUTA SENTENCIA ======================");
            while(rs.next()){   
            fac= new obj_Factura();
            fac.setFolio(rs.getString("folio"));
            fac.setSerie(rs.getString("serie"));
//            fac.setIdComprobante(rs.getString("id_comprobante"));
            fac.setIdCliente(rs.getString("id_cliente"));
            fac.setClaveCodigoPostal(rs.getString("cve_codigo_postal"));
            fac.setIdUsoCFDI(rs.getString("id_uso_cfdi"));
            SimpleDateFormat ft = new SimpleDateFormat ("dd/MM/yyyy"); //Convierte el formato
            String currentDate = ft.format(rs.getDate("ef.fch_factura")); //La convierte en cadena
            fac.setFechaFactura(rs.getString("ef.fch_factura"));//ef.fch_factura
//            fac.setHrFactura(rs.getString("hr_factura"));
            fac.setIdMoneda(rs.getString("id_monedas"));
            fac.setTipoCambio(rs.getString("tipocambio"));
            fac.setIdFormaPago(rs.getString("id_forma_pago"));
            fac.setCuentaBancaria(rs.getString("noctabanco"));
            fac.setIdMetodoPago(rs.getString("id_metodo_pago"));
            fac.setIdTipoRelacion(rs.getString("id_tipo_rel"));
            fac.setCondicionesPago(rs.getString("condiciones"));
            fac.setNoPermiso(rs.getString("num_permiso_concepto"));
            fac.setSubtotal(rs.getString("subtotal"));
            fac.setIVA(rs.getString("iva"));
            fac.setTotal(rs.getString("total"));
            fac.setConceptoFactura(rs.getString("ef.concepto"));
            fac.setFechaPago(rs.getString("fecha_pago"));
            fac.setCveusrCambio(rs.getString("ef.cveusr_cambio"));
            fac.setUsuario(rs.getString("usuario_autoriza"));
            fac.setFchCambio(rs.getDate("ef.fch_cambio"));
            fac.setEstatus(rs.getString("ef.estatus"));
            //DETALLE
            fac.setRenglonProducto(rs.getString("df.renglon"));
            fac.setIdProductoServicio(rs.getString("df.id_prod_serv"));
            fac.setCantidad(rs.getString("df.cantidad"));
            fac.setIdUnidadMedida(rs.getString("df.id_ud_medida"));
            fac.setConceptoFactura(rs.getString("df.concepto"));
            fac.setPrecioUnitario(rs.getString("df.precio_unitario"));
            fac.setImpuesto(rs.getString("df.importe"));
            fac.setPredial(rs.getString("df.predial"));
            //IMPUESTOS
            fac.setRenglonImpuesto(rs.getString("imf.renglon"));
            fac.setImporteBase(rs.getString("imf.importebase"));
            fac.setIdTipoFactor(rs.getString("imf.id_tipo_factor"));
            fac.setTasa(rs.getFloat("imf.tasa_imp"));
            fac.setImporteImpuesto(rs.getString("imf.imp_impuesto"));
//            fac.setImpuesto(rs.getString("imf.tipo_impuesto"));
            faclista.add(fac);
            }

            return faclista;
            
        }catch(Exception ex){
            System.out.println("Error: " + ex);
            return null;
        }finally{
            closeStatement(stmt);
            closeResultSet(rs);
        }
    }  
}



