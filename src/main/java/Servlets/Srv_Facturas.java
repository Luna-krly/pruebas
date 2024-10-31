/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_CFDI;
import DAO.dao_CltSat;
import DAO.dao_CodPostal;
import DAO.dao_FacturacionElectronica;
import DAO.dao_FormaPago;
import DAO.dao_Impuestos;
import DAO.dao_MPago;
import DAO.dao_Moneda;
import DAO.dao_Pais;
import DAO.dao_Periodicidades;
import DAO.dao_Permiso;
import DAO.dao_PrdServicio;
import DAO.dao_RegFiscal;
import DAO.dao_TComprobante;
import DAO.dao_TFactor;
import DAO.dao_TRelacion;
import DAO.dao_TServicio;
import DAO.dao_UMedida;
import Excepciones.Validaciones;
import Objetos.obj_CFDI;
import Objetos.obj_ClientesSAT;
import Objetos.obj_CodigoPostal;
import Objetos.obj_Factura;
import Objetos.obj_FormaPago;
import Objetos.obj_Impuestos;
import Objetos.obj_Mensaje;
import Objetos.obj_MetodoPago;
import Objetos.obj_Monedas;
import Objetos.obj_Paises;
import Objetos.obj_Periodicidades;
import Objetos.obj_Permiso;
import Objetos.obj_ProdServ;
import Objetos.obj_RegFiscal;
import Objetos.obj_TComprobante;
import Objetos.obj_TFactor;
import Objetos.obj_TRelacion;
import Objetos.obj_TServicio;
import Objetos.obj_UMedida;
import Objetos.obj_Usuario;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_Facturas")
public class Srv_Facturas extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("--------------------Ingresa a Srv_Facturas---------------------");
        String act = request.getParameter("action");
        obj_Mensaje mensaje = new obj_Mensaje();
        dao_FacturacionElectronica call = null;
        obj_Usuario usuario = null;
        obj_Factura facturaEncabezado = null;
        obj_Factura facturaDetalle = null;
        obj_Factura facturaImpuesto = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;

        //Mostrar lista TIPO DE COMPROBANTE 
        dao_TComprobante daoTC = null;
        List<obj_TComprobante> tclista = null;

        //Mostrar lista  CLIENTE SAT
        dao_CltSat daoCS = null;
        List<obj_ClientesSAT> cslista = null;

        //Mostrar lista CODIGOS POSTALES
        dao_CodPostal daoCP = null;
        List<obj_CodigoPostal> cpostlista = null;

        //MOSTRAR LISTA Pais
        dao_Pais daoP = null;
        List<obj_Paises> paislista = null;

        //MOSTRAR LISTA Regimen Fiscal
        dao_RegFiscal daoRF = null;
        List<obj_RegFiscal> rflista = null;

        //Mostrar lista PERIODICIDAD
        dao_Periodicidades daoPRD = null;
        List<obj_Periodicidades> prdlista = null;

        //Mostrar lista USO FACTURA
        dao_CFDI daoCFDI = null;
        List<obj_CFDI> cfdilista = null;

        //Mostrar lista MONEDA
        dao_Moneda daoMON = null;
        List<obj_Monedas> monlista = null;

        //Mostrar lista FORMA DE PAGO
        dao_FormaPago daoFP = null;
        List<obj_FormaPago> fplista = null;

        //MOSTRAR LISTA Método de Pago
        dao_MPago daoMP = null;
        List<obj_MetodoPago> mplista = null;

        //MOSTRAR LISTA Tipo de Relación
        dao_TRelacion daoTR = null;
        List<obj_TRelacion> trlista = null;

        //MOSTRAR LISTA Productos y Servicios
        dao_PrdServicio daoPS = null;
        List<obj_ProdServ> pslista = null;

        //MOSTRAR LISTA Unidades de medida
        dao_UMedida daoUM = null;
        List<obj_UMedida> umlista = null;

        //Mostrar lista TIPO IMPUESTOS
        dao_Impuestos daoIMP = null;
        List<obj_Impuestos> implista = null;

        //Mostrar lista TIPO FACTOR
        dao_TFactor daoTF = null;
        List<obj_TFactor> tflista = null;

        //Mostrar lista TIPO DE SERVICIO
        dao_TServicio daoTS = null;
        List<obj_TServicio> tslista = null;

        //MOSTRAR LISTA Permiso
        dao_Permiso daoPr = null;
        List<obj_Permiso> permisolista = null;

        //MOSTRAR LISTA FACTURAS
        dao_FacturacionElectronica daoFE = null;
        List<obj_Factura> listaFacturas = null;

        // Leer JSON del cuerpo de la solicitud
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String json = sb.toString();
        System.out.println("JSON received: " + json);

        String action = null;
        // Convertir JSON a un Map
        Gson gson = new Gson();
        Type type = new TypeToken<Map<String, Object>>() {
        }.getType();
        Map<String, Object> body = gson.fromJson(json, type);
        System.out.println("Body: " + body);
        if (body != null) {
            try {
                // Extraer datos del JSON con verificaciones null
                action = body.get("action") != null ? body.get("action").toString() : null;
                // Mostrar datos en consola para verificación
                System.out.println("Action: " + action);

            } catch (Exception e) {
                System.out.println("ERROOOOOOOOOR PELIGROOOOO" + e);
            }
        } else {
            // Manejar el caso cuando no se recibe JSON
            System.out.println("No se recibió JSON en la solicitud");
        }

        // TOMA DATOS DEL USUARIO NOMBRE
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");
        rsp = validar.verUsuario(usuario);

        if (!rsp) {
            mensaje.setMensaje("ERROR");
            mensaje.setDescripcion("FAVOR DE INICIAR SESIÓN");
            mensaje.setTipo(false);
            request.setAttribute("mensaje", mensaje);

            // Manda la pagina de error si es que hay alguno
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        //---------------------------********MENU
        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (action == null && act == null) {
            // Ningún botón ha sido seleccionado
            try {
                System.out.println("Srv_Facturas-- Action/Act NULL");

                request.setAttribute("memorandum", null);
                request.setAttribute("detallelista", null);
                // Mostrar lista Memorandum
                daoTC = new dao_TComprobante();//---------------TIPO DE COMPROBANTE
                tclista = daoTC.Listar();
                request.setAttribute("tclista", tclista);

                daoCS = new dao_CltSat();//----------------------CLIENTES SAT
                cslista = daoCS.Listar();
                request.setAttribute("cslista", cslista);

                daoCP = new dao_CodPostal();//----------------CODIGO POSTAL
                cpostlista = daoCP.Listar();
                request.setAttribute("cpostlista", cpostlista);

                daoP = new dao_Pais();//-----------------------PAIS
                paislista = daoP.Listar();
                request.setAttribute("paislista", paislista);

                daoRF = new dao_RegFiscal();//------------------REGIMEN FISCAL
                rflista = daoRF.Listar();
                request.setAttribute("rflista", rflista);

                daoPRD = new dao_Periodicidades();//--------------PERIODICIDAD
                prdlista = daoPRD.Listar();
                request.setAttribute("prdlista", prdlista);

                daoCFDI = new dao_CFDI();//---------------------USO DE CFDI
                cfdilista = daoCFDI.Listar();
                request.setAttribute("cfdilista", cfdilista);

                daoMON = new dao_Moneda();//---------------------MONEDA
                monlista = daoMON.Listar();
                request.setAttribute("monlista", monlista);

                daoFP = new dao_FormaPago();//--------------------FORMA DE PAGO
                fplista = daoFP.Listar();
                request.setAttribute("fplista", fplista);

                daoMP = new dao_MPago();//--------------------METODO DE PAGO
                mplista = daoMP.Listar();
                request.setAttribute("mplista", mplista);

                daoTR = new dao_TRelacion();//-------------------TIPO DE RELACION
                trlista = daoTR.Listar();
                request.setAttribute("trlista", trlista);

                daoPS = new dao_PrdServicio();//-------------------PRODUCTOS Y SERVICIOS
                pslista = daoPS.Listar();
                request.setAttribute("pslista", pslista);

                daoUM = new dao_UMedida();//-------------------UNIDAD DE MEDIDA
                umlista = daoUM.Listar();
                request.setAttribute("umlista", umlista);

                daoIMP = new dao_Impuestos();//-------------------IMPUESTOS
                implista = daoIMP.Listar();
                request.setAttribute("implista", implista);

                daoTF = new dao_TFactor();//-------------------TIPO DE FACTOR
                tflista = daoTF.Listar();
                request.setAttribute("tflista", tflista);

                daoTS = new dao_TServicio();//-------------------TIPO DE SERVICIO
                tslista = daoTS.Listar();
                request.setAttribute("tslista", tslista);

                daoPr = new dao_Permiso();//-------------------PERMISOS
                permisolista = daoPr.Listar();
                request.setAttribute("permisolista", permisolista);

                daoFE = new dao_FacturacionElectronica();//-------------------FACTURAS
                listaFacturas = daoFE.Listar();
                request.setAttribute("listaFacturas", listaFacturas);

                // Reenviar a la página JSP
                request.getRequestDispatcher("Documentos/Facturacion.jsp").forward(request, response);

            } catch (Exception ex) {
                ex.printStackTrace();

                mensaje.setMensaje("Ocurrio un error al enviar listas.");
                mensaje.setDescripcion(ex.getMessage());
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);

                // Reenviar a la página de errores
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);

            }
        } else if (action != null && action.equals("101") && act == null) {
            System.out.println("Entra a guardar-- ACTION JSON");
            try {
                facturaEncabezado = new obj_Factura();
                if (body != null) {
                    // Extraer datos del JSON con verificaciones null
                    String idTipoComprobante = body.get("idTipoComprobante") != null ? body.get("idTipoComprobante").toString() : null;
                    String idCliente = body.get("idCliente") != null ? body.get("idCliente").toString() : null;
                    String periodicidad = body.get("periodicidad") != null ? body.get("periodicidad").toString() : null;
                    String mes = body.get("mes") != null ? body.get("mes").toString() : null;
                    String conceptoFactura = body.get("conceptoFactura") != null ? body.get("conceptoFactura").toString() : null;
                    String fechaPago = body.get("fechaPago") != null ? body.get("fechaPago").toString() : null;
                    String observaciones = body.get("observaciones") != null ? body.get("observaciones").toString() : null;
                    String idUsoCFDI = body.get("idUsoCFDI") != null ? body.get("idUsoCFDI").toString() : null;
                    String fechaFactura = body.get("fechaFactura") != null ? body.get("fechaFactura").toString() : null;
                    String cpEmisorFactura = body.get("cpEmisorFactura") != null ? body.get("cpEmisorFactura").toString() : null;
                    String serie = body.get("serie") != null ? body.get("serie").toString() : null;
                    String moneda = body.get("moneda") != null ? body.get("moneda").toString() : null;
                    String tipoCambio = body.get("tipoCambio") != null ? body.get("tipoCambio").toString() : null;
                    String idFormaPago = body.get("idFormaPago") != null ? body.get("idFormaPago").toString() : null;
                    String cuentaBancaria = body.get("cuentaBancaria") != null ? body.get("cuentaBancaria").toString() : null;
                    String metodoPago = body.get("metodoPago") != null ? body.get("metodoPago").toString() : null;
                    String idTipoRelacion = body.get("idTipoRelacion") != null ? body.get("idTipoRelacion").toString() : null;
                    String tipoServicio = body.get("tipoServicio") != null ? body.get("tipoServicio").toString() : null;
                    String condicionPago = body.get("condicionPago") != null ? body.get("condicionPago").toString() : null;
                    String idPermiso = body.get("idPermiso") != null ? body.get("idPermiso").toString() : null;
                    String Subtotal = body.get("Subtotal") != null ? body.get("Subtotal").toString() : null;
                    String IVA = body.get("IVA") != null ? body.get("IVA").toString() : null;
                    String Total = body.get("Total") != null ? body.get("Total").toString() : null;
                    String totalLetras = body.get("totalLetras") != null ? body.get("totalLetras").toString() : null;

                    // Imprimir todos los valores
                    System.out.println("idTipoComprobante: " + idTipoComprobante);
                    System.out.println("idCliente: " + idCliente);
                    System.out.println("periodicidad: " + periodicidad);
                    System.out.println("mes: " + mes);
                    System.out.println("conceptoFactura: " + conceptoFactura);
                    System.out.println("fechaPago: " + fechaPago);
                    System.out.println("observaciones: " + observaciones);
                    System.out.println("idUsoCFDI: " + idUsoCFDI);
                    System.out.println("fechaFactura: " + fechaFactura);
                    System.out.println("cpEmisorFactura: " + cpEmisorFactura);
                    System.out.println("serie: " + serie);
                    System.out.println("moneda: " + moneda);
                    System.out.println("tipoCambio: " + tipoCambio);
                    System.out.println("idFormaPago: " + idFormaPago);
                    System.out.println("cuentaBancaria: " + cuentaBancaria);
                    System.out.println("metodoPago: " + metodoPago);
                    System.out.println("idTipoRelacion: " + idTipoRelacion);
                    System.out.println("tipoServicio: " + tipoServicio);
                    System.out.println("condicionPago: " + condicionPago);
                    System.out.println("idPermiso: " + idPermiso);
                    System.out.println("Subtotal: " + Subtotal);
                    System.out.println("IVA: " + IVA);
                    System.out.println("Total: " + Total);
                    System.out.println("totalLetras: " + totalLetras);

                    facturaEncabezado.setFolio("");
                    facturaEncabezado.setSerie(serie);
                    facturaEncabezado.setFechaFactura(fechaFactura);
                    facturaEncabezado.setIdTipoComprobante(idTipoComprobante);
                    facturaEncabezado.setIdCliente(idCliente);
                    facturaEncabezado.setCpEmisorFactura(cpEmisorFactura);
                    facturaEncabezado.setIdUsoCFDI(idUsoCFDI);
                    facturaEncabezado.setIdMoneda(moneda);
                    facturaEncabezado.setTipoCambio(tipoCambio);
                    facturaEncabezado.setIdFormaPago(idFormaPago);
                    facturaEncabezado.setCuentaBancaria(cuentaBancaria);
                    facturaEncabezado.setIdMetodoPago(metodoPago);
                    facturaEncabezado.setIdTipoRelacion(idTipoRelacion);
                    facturaEncabezado.setCondicionesPago(condicionPago);
                    facturaEncabezado.setIdPermiso(idPermiso);
                    facturaEncabezado.setSubtotal(Subtotal);
                    facturaEncabezado.setIVA(IVA);
                    facturaEncabezado.setTotal(Total);
                    facturaEncabezado.setTotalLetras(totalLetras);
                    facturaEncabezado.setConceptoFactura(conceptoFactura);
                    facturaEncabezado.setFechaPago(fechaPago);
                    facturaEncabezado.setObservaciones(observaciones);
                    facturaEncabezado.setIdPeriodicidad(periodicidad);
                    facturaEncabezado.setMes(mes);
                    facturaEncabezado.setIdTipoServicio(tipoServicio);
                    facturaEncabezado.setUsuario(usuario.getUsuario());

                    call = new dao_FacturacionElectronica();

                    Map<String, String> resultados = call.menu_factura_encabezado(action, facturaEncabezado);
                    if (resultados != null) {
                        String vs_folio = resultados.get("folio");
                        String vs_serie = resultados.get("serie");
                        String vs_fecha_factura = resultados.get("fechaFactura");

                        ArrayList<Map<String, String>> productos = (ArrayList<Map<String, String>>) body.get("productos");
                        ArrayList<Map<String, String>> impuestos = (ArrayList<Map<String, String>>) body.get("impuestos");
                        // Convertir el ArrayList a JSON
                        Gson gsonProductos = new Gson();
                        String jsonProductos = gsonProductos.toJson(productos);
                        // Convertir el ArrayList a JSON
                        Gson gsonImpuestos = new Gson();
                        String jsonImpuestos = gsonImpuestos.toJson(impuestos);

                        mensaje = new obj_Mensaje();
                        call = new dao_FacturacionElectronica();
                        mensaje = call.guardar_listas(jsonProductos, jsonImpuestos, vs_folio, vs_serie, vs_fecha_factura);

                        session.setAttribute("mensaje", mensaje);
                        System.out.println("MENSAJE TITULO " + mensaje.getMensaje());
                        System.out.println("MENSAJE descripcion " + mensaje.getDescripcion());
                        System.out.println("MENSAJE BOOLEAN " + mensaje.getTipo());
                        // mensaje = call.ctg_ref_permiso(act, referencia, id);
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put(mensaje.getMensaje());
                        messages.put(mensaje.getDescripcion());

                        String tipoMensaje = null;

                        if (mensaje.getTipo()) {
                            tipoMensaje = "Exito";
                        } else {
                            tipoMensaje = "Error";
                        }

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", tipoMensaje);

                        out.print(jsonResponse.toString());
                        out.flush();

                    } else {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put("NO SE PUDO GUARDAR EL ENCABEZADO");
                        //messages.put("Otro mensaje o información adicional");

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Error");

                        out.print(jsonResponse.toString());
                        out.flush();
                    }

                } else {
                    System.out.println("No llega nada en JSON");
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();

                    JSONArray messages = new JSONArray();
                    messages.put("NO LLEGÓ LA INFORMACIÓN DE FACTURA (JSON)");
                    //messages.put("Otro mensaje o información adicional");

                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("messages", messages);
                    jsonResponse.put("tipomensaje", "Error");

                    out.print(jsonResponse.toString());
                    out.flush();
                }

            } catch (Exception ex) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONArray messages = new JSONArray();
                messages.put("Ocurrio un error en el procedimiento " + ex);
                //messages.put("Otro mensaje o información adicional");

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("messages", messages);
                jsonResponse.put("tipomensaje", "Error");

                out.print(jsonResponse.toString());
                out.flush();
            } finally {
                if (call != null) {
                    call.closeConnection();
                }
            }
        } else if (action != null && action.equals("104") && act == null) {//Búscar
            try {
                obj_Factura encabezado = new obj_Factura();
                List<obj_Factura> detalles = null;
                List<obj_Factura> importes = null;
                String folioValido = null;
                call = new dao_FacturacionElectronica();
                Integer numeroFolio = body.get("numeroFolio") != null ? Integer.parseInt(body.get("numeroFolio").toString()) : null;
                folioValido = call.validaFolio(numeroFolio);

                encabezado = call.buscarEncabezado(numeroFolio);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                // Crear la respuesta JSON con los datos del encabezado
                JSONObject jsonEncabezado = new JSONObject();
                jsonEncabezado.put("idEncabezado", encabezado.getIdFactura());
                jsonEncabezado.put("folio", encabezado.getFolio());
                jsonEncabezado.put("serie", encabezado.getSerie());
                jsonEncabezado.put("idTipoComprobante", encabezado.getIdTipoComprobante());
                jsonEncabezado.put("idCliente", encabezado.getIdCliente());
                jsonEncabezado.put("mes", encabezado.getMes());
                jsonEncabezado.put("conceptoFactura", encabezado.getConceptoFactura());
                jsonEncabezado.put("fechaPago", encabezado.getFechaPago());
                jsonEncabezado.put("observaciones", encabezado.getObservaciones());
                jsonEncabezado.put("idUsoCFDI", encabezado.getIdUsoCFDI());
                jsonEncabezado.put("idMonedas", encabezado.getIdMoneda());
                jsonEncabezado.put("idTipoRelacion", encabezado.getIdTipoRelacion());
                jsonEncabezado.put("idTipoServicio", encabezado.getIdTipoServicio());
                jsonEncabezado.put("condiciones", encabezado.getCondicionesPago());
                jsonEncabezado.put("idPermiso", encabezado.getIdPermiso());
                jsonEncabezado.put("idPeriodicidad", encabezado.getIdPeriodicidad());
                jsonEncabezado.put("idFormaPago", encabezado.getIdFormaPago());
                jsonEncabezado.put("idMetodoPago", encabezado.getIdMetodoPago());
                jsonEncabezado.put("cuentaBanco", encabezado.getCuentaBancaria());
                jsonEncabezado.put("totalletras", encabezado.getTotalLetras());

                detalles = call.buscarDetalle(numeroFolio);

                JSONArray jsonDetalles = new JSONArray();
                for (obj_Factura detalle : detalles) {
                    JSONObject detalleJson = new JSONObject();
                    detalleJson.put("renglon", detalle.getRenglonProducto());
                    System.out.println("RENGLOOOOOOON ---------" + detalle.getRenglonProducto());
                    System.out.println("Folio: " + detalle.getFolio());
                    detalleJson.put("folio", detalle.getFolio());

                    System.out.println("ID Producto/Servicio: " + detalle.getIdProductoServicio());
                    detalleJson.put("idProducoServicio", detalle.getIdProductoServicio());

                    System.out.println("Cantidad: " + detalle.getCantidad());
                    detalleJson.put("cantidad", detalle.getCantidad());

                    System.out.println("ID Unidad Medida: " + detalle.getIdUnidadMedida());
                    detalleJson.put("idUnidadMedida", detalle.getIdUnidadMedida());

                    System.out.println("Concepto: " + detalle.getConceptoFactura());
                    detalleJson.put("concepto", detalle.getConceptoFactura());

                    System.out.println("Importe: " + detalle.getImporteConcepto());
                    detalleJson.put("importe", detalle.getImporteConcepto());

                    System.out.println("Predial: " + detalle.getPredial());
                    detalleJson.put("predial", detalle.getPredial());

                    System.out.println("Serie: " + detalle.getSerie());
                    detalleJson.put("serie", detalle.getSerie());

                    System.out.println("Fecha Factura: " + detalle.getFechaFactura());
                    detalleJson.put("fechaFactura", detalle.getFechaFactura());

                    System.out.println("Precio Unitario: " + detalle.getPrecioUnitario());
                    detalleJson.put("precioUnitario", detalle.getPrecioUnitario());

                    System.out.println("Nota Crédito Factura: " + detalle.getFacturaNC());
                    detalleJson.put("notaCreditoFactura", detalle.getFacturaNC());

                    System.out.println("Nota Crédito Serie: " + detalle.getSerieNC());
                    detalleJson.put("notaCreditoSerie", detalle.getSerieNC());

                    System.out.println("Nota Crédito Fecha: " + detalle.getFechaFacturaNC());
                    detalleJson.put("notaCreditoFecha", detalle.getFechaFacturaNC());

                    System.out.println("Nota Crédito Folio: " + detalle.getFolioFiscalNC());
                    detalleJson.put("notaCreditoFolio", detalle.getFolioFiscalNC());

                    jsonDetalles.put(detalleJson);
                }

                importes = call.buscarimportes(numeroFolio);

                JSONArray jsonImportes = new JSONArray();
                for (obj_Factura importe : importes) {
                    JSONObject importeJson = new JSONObject();
                    System.out.println("RENGLOOOOOOON ************" + importe.getRenglonImpuesto());
                    System.out.println("Renglon: " + importe.getRenglonImpuesto());
                    importeJson.put("renglon", importe.getRenglonImpuesto());

                    System.out.println("Impuesto: " + importe.getImpuesto());
                    importeJson.put("impuesto", importe.getImpuesto());

                    System.out.println("Tipo Impuesto: " + importe.getIdTipoimpuesto());
                    importeJson.put("tipoImpuesto", importe.getIdTipoimpuesto());

                    System.out.println("Tipo Factor: " + importe.getIdTipoFactor());
                    importeJson.put("tipoFactor", importe.getIdTipoFactor());

                    System.out.println("Porcentaje: " + importe.getTasa());
                    importeJson.put("porcentaje", importe.getTasa());

                    System.out.println("Importe Impuesto: " + importe.getImporteImpuesto());
                    importeJson.put("importeImpuesto", importe.getImporteImpuesto());

                    System.out.println("Importe Base: " + importe.getImporteBase());
                    importeJson.put("importeBase", importe.getImporteBase());

                    System.out.println("Renglon Producto/Servicio: " + importe.getRenglonProductoReferencia());
                    importeJson.put("renglonProductoServicio", importe.getRenglonProductoReferencia());

                    jsonImportes.put(importeJson);
                }

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("encabezado", jsonEncabezado);
                jsonResponse.put("detalles", jsonDetalles);
                jsonResponse.put("importes", jsonImportes);

                out.print(jsonResponse.toString());
                out.flush();

            } catch (Exception e) {
                System.out.println("ERRORRRRRRRRRRRRRRRRRR---" + e);
                System.out.println("ERRORRRRRRRRRRRRRRRRRR---" + e.getMessage());
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONArray messages = new JSONArray();
                messages.put("Ocurrio un error en el procedimiento " + e);
                //messages.put("Otro mensaje o información adicional");

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("messages", messages);
                jsonResponse.put("tipomensaje", "Error");

                out.print(jsonResponse.toString());
                out.flush();
            }
        } else if (action != null && action.equals("102") && act == null) {//MODIFICAR

            System.out.println("Entra a modificar-- ACTION JSON");
            try {
                facturaEncabezado = new obj_Factura();
                if (body != null) {
                    // Extraer datos del JSON con verificaciones null
                    String idTipoComprobante = body.get("idTipoComprobante") != null ? body.get("idTipoComprobante").toString() : null;
                    String idCliente = body.get("idCliente") != null ? body.get("idCliente").toString() : null;
                    String periodicidad = body.get("periodicidad") != null ? body.get("periodicidad").toString() : null;
                    String mes = body.get("mes") != null ? body.get("mes").toString() : null;
                    String conceptoFactura = body.get("conceptoFactura") != null ? body.get("conceptoFactura").toString() : null;
                    String fechaPago = body.get("fechaPago") != null ? body.get("fechaPago").toString() : null;
                    String observaciones = body.get("observaciones") != null ? body.get("observaciones").toString() : null;
                    String idUsoCFDI = body.get("idUsoCFDI") != null ? body.get("idUsoCFDI").toString() : null;
                    String fechaFactura = body.get("fechaFactura") != null ? body.get("fechaFactura").toString() : null;
                    String cpEmisorFactura = body.get("cpEmisorFactura") != null ? body.get("cpEmisorFactura").toString() : null;
                    String serie = body.get("serie") != null ? body.get("serie").toString() : null;
                    String moneda = body.get("moneda") != null ? body.get("moneda").toString() : null;
                    String tipoCambio = body.get("tipoCambio") != null ? body.get("tipoCambio").toString() : null;
                    String idFormaPago = body.get("idFormaPago") != null ? body.get("idFormaPago").toString() : null;
                    String cuentaBancaria = body.get("cuentaBancaria") != null ? body.get("cuentaBancaria").toString() : null;
                    String metodoPago = body.get("metodoPago") != null ? body.get("metodoPago").toString() : null;
                    String idTipoRelacion = body.get("idTipoRelacion") != null ? body.get("idTipoRelacion").toString() : null;
                    String tipoServicio = body.get("tipoServicio") != null ? body.get("tipoServicio").toString() : null;
                    String condicionPago = body.get("condicionPago") != null ? body.get("condicionPago").toString() : null;
                    String idPermiso = body.get("idPermiso") != null ? body.get("idPermiso").toString() : null;
                    String Subtotal = body.get("Subtotal") != null ? body.get("Subtotal").toString() : null;
                    String IVA = body.get("IVA") != null ? body.get("IVA").toString() : null;
                    String Total = body.get("Total") != null ? body.get("Total").toString() : null;
                    String totalLetras = body.get("totalLetras") != null ? body.get("totalLetras").toString() : null;
                    String folioEncontrado = body.get("folioEncontrado") != null ? body.get("folioEncontrado").toString() : null;

                    // Imprimir todos los valores
                    System.out.println("FOLIO ENCONTRADO: " + folioEncontrado);
                    System.out.println("idTipoComprobante: " + idTipoComprobante);
                    System.out.println("idCliente: " + idCliente);
                    System.out.println("periodicidad: " + periodicidad);
                    System.out.println("mes: " + mes);
                    System.out.println("conceptoFactura: " + conceptoFactura);
                    System.out.println("fechaPago: " + fechaPago);
                    System.out.println("observaciones: " + observaciones);
                    System.out.println("idUsoCFDI: " + idUsoCFDI);
                    System.out.println("fechaFactura: " + fechaFactura);
                    System.out.println("cpEmisorFactura: " + cpEmisorFactura);
                    System.out.println("serie: " + serie);
                    System.out.println("moneda: " + moneda);
                    System.out.println("tipoCambio: " + tipoCambio);
                    System.out.println("idFormaPago: " + idFormaPago);
                    System.out.println("cuentaBancaria: " + cuentaBancaria);
                    System.out.println("metodoPago: " + metodoPago);
                    System.out.println("idTipoRelacion: " + idTipoRelacion);
                    System.out.println("tipoServicio: " + tipoServicio);
                    System.out.println("condicionPago: " + condicionPago);
                    System.out.println("idPermiso: " + idPermiso);
                    System.out.println("Subtotal: " + Subtotal);
                    System.out.println("IVA: " + IVA);
                    System.out.println("Total: " + Total);
                    System.out.println("totalLetras: " + totalLetras);

                    facturaEncabezado.setFolio(folioEncontrado);
                    facturaEncabezado.setSerie(serie);
                    facturaEncabezado.setFechaFactura(fechaFactura);
                    facturaEncabezado.setIdTipoComprobante(idTipoComprobante);
                    facturaEncabezado.setIdCliente(idCliente);
                    facturaEncabezado.setCpEmisorFactura(cpEmisorFactura);
                    facturaEncabezado.setIdUsoCFDI(idUsoCFDI);
                    facturaEncabezado.setIdMoneda(moneda);
                    facturaEncabezado.setTipoCambio(tipoCambio);
                    facturaEncabezado.setIdFormaPago(idFormaPago);
                    facturaEncabezado.setCuentaBancaria(cuentaBancaria);
                    facturaEncabezado.setIdMetodoPago(metodoPago);
                    facturaEncabezado.setIdTipoRelacion(idTipoRelacion);
                    facturaEncabezado.setCondicionesPago(condicionPago);
                    facturaEncabezado.setIdPermiso(idPermiso);
                    facturaEncabezado.setSubtotal(Subtotal);
                    facturaEncabezado.setIVA(IVA);
                    facturaEncabezado.setTotal(Total);
                    facturaEncabezado.setTotalLetras(totalLetras);
                    facturaEncabezado.setConceptoFactura(conceptoFactura);
                    facturaEncabezado.setFechaPago(fechaPago);
                    facturaEncabezado.setObservaciones(observaciones);
                    facturaEncabezado.setIdPeriodicidad(periodicidad);
                    facturaEncabezado.setMes(mes);
                    facturaEncabezado.setIdTipoServicio(tipoServicio);
                    facturaEncabezado.setUsuario(usuario.getUsuario());

                    call = new dao_FacturacionElectronica();

                    Map<String, String> resultados = call.menu_factura_encabezado(action, facturaEncabezado);
                    if (resultados != null) {
                        String vs_folio = resultados.get("folio");
                        String vs_serie = resultados.get("serie");
                        String vs_fecha_factura = resultados.get("fechaFactura");

                        ArrayList<Map<String, String>> productos = (ArrayList<Map<String, String>>) body.get("productos");
                        ArrayList<Map<String, String>> impuestos = (ArrayList<Map<String, String>>) body.get("impuestos");
                        // Convertir el ArrayList a JSON
                        Gson gsonProductos = new Gson();
                        String jsonProductos = gsonProductos.toJson(productos);
                        // Convertir el ArrayList a JSON
                        Gson gsonImpuestos = new Gson();
                        String jsonImpuestos = gsonImpuestos.toJson(impuestos);

                        mensaje = new obj_Mensaje();
                        call = new dao_FacturacionElectronica();
                        mensaje = call.modificar_listas(jsonProductos, jsonImpuestos, vs_folio, vs_serie, vs_fecha_factura);

                        session.setAttribute("mensaje", mensaje);
                        System.out.println("MENSAJE TITULO " + mensaje.getMensaje());
                        System.out.println("MENSAJE descripcion " + mensaje.getDescripcion());
                        System.out.println("MENSAJE BOOLEAN " + mensaje.getTipo());
                        // mensaje = call.ctg_ref_permiso(act, referencia, id);
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put(mensaje.getMensaje());
                        messages.put(mensaje.getDescripcion());

                        String tipoMensaje = null;

                        if (mensaje.getTipo()) {
                            tipoMensaje = "Exito";
                        } else {
                            tipoMensaje = "Error";
                        }

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", tipoMensaje);

                        out.print(jsonResponse.toString());
                        out.flush();

                    } else {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put("NO SE PUDO MODIFICAR EL ENCABEZADO");
                        //messages.put("Otro mensaje o información adicional");

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Error");

                        out.print(jsonResponse.toString());
                        out.flush();
                    }

                } else {
                    System.out.println("No llega nada en JSON");
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();

                    JSONArray messages = new JSONArray();
                    messages.put("NO LLEGÓ LA INFORMACIÓN DE FACTURA (JSON)");
                    //messages.put("Otro mensaje o información adicional");

                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("messages", messages);
                    jsonResponse.put("tipomensaje", "Error");

                    out.print(jsonResponse.toString());
                    out.flush();
                }

            } catch (Exception ex) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONArray messages = new JSONArray();
                messages.put("Ocurrio un error en el procedimiento " + ex);
                //messages.put("Otro mensaje o información adicional");

                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("messages", messages);
                jsonResponse.put("tipomensaje", "Error");

                out.print(jsonResponse.toString());
                out.flush();
            } finally {
                if (call != null) {
                    call.closeConnection();
                }
            }

        }
//------------------------------------------
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
