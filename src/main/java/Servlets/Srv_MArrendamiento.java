/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import DAO.dao_Conceptos;
import DAO.dao_MArrendamiento;
import DAO.dao_DepositoBancario;
import Excepciones.Validaciones;
import Objetos.obj_Conceptos;
import Objetos.obj_detalleArrendamiento;
import Objetos.obj_MArrendamiento;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import Objetos.obj_DepositoBancario;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import java.io.IOException;
import java.util.Date;
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
import java.io.File;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_MArrendamiento")
public class Srv_MArrendamiento extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("--------------------Ingresa a Srv_MArrendamiento---------------------");
        String act = request.getParameter("action");
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_MArrendamiento memorandum = null;
        obj_detalleArrendamiento detalle = null;
        dao_MArrendamiento call = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        obj_Usuario usuario = null;

        //tomar lista de detalles
        List<obj_detalleArrendamiento> detallelista = null;

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

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (action == null && act == null) {
            // Ningún botón ha sido seleccionado
            try {
                System.out.println("Srv_Memorandums-- Action/Act NULL");

                request.setAttribute("memorandum", null);
                request.setAttribute("detallelista", null);
                // Mostrar lista Memorandum

                dao_DepositoBancario daoDepoBancario = new dao_DepositoBancario();
                List<obj_DepositoBancario> depositoLista = daoDepoBancario.Listar();
                request.setAttribute("listDeposito", depositoLista);

                dao_MArrendamiento daoMemo = new dao_MArrendamiento();
                List<obj_MArrendamiento> memlista = daoMemo.Listar();
                request.setAttribute("memlista", memlista);

                dao_Conceptos dao3 = new dao_Conceptos(); // Mostrar lista CONCEPTOS
                List<obj_Conceptos> conceptolista = dao3.Listar();
                request.setAttribute("conceptolista", conceptolista);

                // Reenviar a la página JSP
                request.getRequestDispatcher("Documentos/MemoArrendamiento.jsp").forward(request, response);

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
                memorandum = new obj_MArrendamiento();
                if (body != null) {
                    // Extraer datos del JSON con verificaciones null
                    action = body.get("action") != null ? body.get("action").toString() : null;
                    String idMemorandum = body.get("idMemorandum") != null ? body.get("idMemorandum").toString() : null;
                    String idConcepto = body.get("idConcepto") != null ? body.get("idConcepto").toString() : null;
                    String concepto = body.get("concepto") != null ? body.get("concepto").toString() : null;
                    String noMemorandum = body.get("memorandum") != null ? body.get("memorandum").toString() : null;
                    String fechaM = body.get("fecha") != null ? body.get("fecha").toString() : null;
                    String remitente = body.get("remitente") != null ? body.get("remitente").toString() : null;
                    String destinatario = body.get("destinatario") != null ? body.get("destinatario").toString() : null;
                    String depositoBancario = body.get("Deposito") != null ? body.get("Deposito").toString() : null;
                    String cuentaBancaria = body.get("Cuenta") != null ? body.get("Cuenta").toString() : null;
                    String conceptoGeneral = body.get("GConcepto") != null ? body.get("GConcepto").toString() : null;
                    String monto = body.get("monto") != null ? body.get("monto").toString() : null;
                    String iva = body.get("iva") != null ? body.get("iva").toString() : null;
                    String retenido = body.get("retenido") != null ? body.get("retenido").toString() : null;
                    String total = body.get("total") != null ? body.get("total").toString() : null;
                    String importeLetras = body.get("importeLetras") != null ? body.get("importeLetras").toString() : null;
                    System.out.println("Total letras: " + importeLetras);
                    String voNombre = body.get("voNombre") != null ? body.get("voNombre").toString() : null;
                    String voPuesto = body.get("voPuesto") != null ? body.get("voPuesto").toString() : null;
                    String attNombre = body.get("attNombre") != null ? body.get("attNombre").toString() : null;
                    String attPuesto = body.get("attPuesto") != null ? body.get("attPuesto").toString() : null;

                    double subtotalM = 0;
                    double ivaM = 0;
                    double totalM = 0;
                    double retenidoM = 0;

                    // Verificar y convertir valores
                    if (monto != null && !monto.isEmpty()) {
                        subtotalM = Double.parseDouble(monto);
                    }

                    if (iva != null && !iva.isEmpty()) {
                        ivaM = Double.parseDouble(iva);
                    }

                    if (total != null && !total.isEmpty()) {
                        totalM = Double.parseDouble(total);
                    }

                    if (retenido != null && !retenido.isEmpty()) {
                        retenidoM = Double.parseDouble(retenido);
                    }

                    // Asignar valores al objeto memorandum
                    memorandum.setIdConcepto(idConcepto);
                    memorandum.setNombreConcepto(concepto);
                    memorandum.setIdMemorandum("");
                    memorandum.setNoMemorandum(noMemorandum);
                    memorandum.setFecha(fechaM);
                    memorandum.setRemitente(remitente);
                    memorandum.setDestinatario(destinatario);
                    memorandum.setCuentaBancaria(cuentaBancaria);
                    memorandum.setConceptoGeneral(conceptoGeneral);
                    memorandum.setSubtotal(subtotalM);
                    memorandum.setIva(ivaM);
                    memorandum.setRetenido(retenidoM);
                    memorandum.setTotal(totalM);
                    memorandum.setTotalLetras(importeLetras);
                    memorandum.setNombreVo(voNombre);
                    memorandum.setPuestoVo(voPuesto);
                    memorandum.setNombreAtt(attNombre);
                    memorandum.setPuestoAtt(attPuesto);
                    memorandum.setUsuario(usuario.getUsuario());

                    call = new dao_MArrendamiento();
                    int id_memorandum_encabezado = call.guardar_memo_arrendamiento(action, memorandum);
                    if (id_memorandum_encabezado != 0) {
                        String guarda_detalle = null;

                        ArrayList<Map<String, String>> importes = (ArrayList<Map<String, String>>) body.get("importes");
                        for (Map<String, String> importe : importes) {
                            detalle = new obj_detalleArrendamiento();
                            double detalle_importe = 0;

                            if (importe.get("importe") != null && !importe.get("importe").isEmpty()) {
                                detalle_importe = Double.parseDouble(importe.get("importe"));
                            }

                            detalle.setIdEncabezado(id_memorandum_encabezado);
                            detalle.setConsecutivo(importe.get("renglon"));
                            detalle.setConcepto_desglose(importe.get("concepto"));
                            detalle.setImporte(detalle_importe);
                            guarda_detalle = call.guardar_memo_arr_detalle(action, detalle);
                        }

                        if (guarda_detalle != null) {
                            System.out.println("--Guardar detalle no es nulo--");

                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            PrintWriter out = response.getWriter();

                            JSONArray messages = new JSONArray();
                            messages.put("SE GUARDÓ CORRECTAMENTE CON NÚMERO DE MEMORÁNDUM: " + guarda_detalle);
                            //messages.put("Otro mensaje o información adicional");

                            JSONObject jsonResponse = new JSONObject();
                            jsonResponse.put("messages", messages);
                            jsonResponse.put("tipomensaje", "Exito");
                            dao_MArrendamiento daoMemo = new dao_MArrendamiento();
                            List<obj_MArrendamiento> memlista = daoMemo.Listar();
                            jsonResponse.put("datalistImpresion", memlista);

                            out.print(jsonResponse.toString());
                            out.flush();

                            // Reenviar a la página JSP
                            //    request.getRequestDispatcher("Documentos/MemoArrendamiento.jsp").forward(request, response);
                        } else {
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            PrintWriter out = response.getWriter();

                            JSONArray messages = new JSONArray();
                            messages.put("NO SE GUARDARON LOS DETALLES DEL MEMORÁNDUM");
                            //messages.put("Otro mensaje o información adicional");

                            JSONObject jsonResponse = new JSONObject();
                            jsonResponse.put("messages", messages);
                            jsonResponse.put("tipomensaje", "Error");

                            out.print(jsonResponse.toString());
                            out.flush();
                        }

                    } else {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put("NO SE GUARDÓ CORRECTAMENTE EL ENCABEZADO DEL MEMORÁNDUM");
                        //messages.put("Otro mensaje o información adicional");

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Error");

                        out.print(jsonResponse.toString());
                        out.flush();
                    }

                } else {
                    System.out.println("No llega nada en JSON");
                }

            } catch (Exception ex) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONArray messages = new JSONArray();
                messages.put("OCURRIÓ UN ERROR EN EL PROCEDIMIENTO: " + ex);
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
        } else if (action != null && action.equals("102") && act == null) {//Modificar
            System.out.println("Entra a modificar-- ACTION JSON");
            try {
                memorandum = new obj_MArrendamiento();
                if (body != null) {
                    // Extraer datos del JSON con verificaciones null
                    action = body.get("action") != null ? body.get("action").toString() : null;
                    String idMemorandum = body.get("idMemorandum") != null ? body.get("idMemorandum").toString() : null;
                    String idConcepto = body.get("idConcepto") != null ? body.get("idConcepto").toString() : null;
                    String concepto = body.get("concepto") != null ? body.get("concepto").toString() : null;
                    String noMemorandum = body.get("memorandum") != null ? body.get("memorandum").toString() : null;
                    String fechaM = body.get("fecha") != null ? body.get("fecha").toString() : null;
                    String remitente = body.get("remitente") != null ? body.get("remitente").toString() : null;
                    String destinatario = body.get("destinatario") != null ? body.get("destinatario").toString() : null;
                    String depositoBancario = body.get("Deposito") != null ? body.get("Deposito").toString() : null;
                    String cuentaBancaria = body.get("Cuenta") != null ? body.get("Cuenta").toString() : null;
                    String conceptoGeneral = body.get("GConcepto") != null ? body.get("GConcepto").toString() : null;
                    String monto = body.get("monto") != null ? body.get("monto").toString() : null;
                    String iva = body.get("iva") != null ? body.get("iva").toString() : null;
                    String retenido = body.get("retenido") != null ? body.get("retenido").toString() : null;
                    String total = body.get("total") != null ? body.get("total").toString() : null;
                    String importeLetras = body.get("importeLetras") != null ? body.get("importeLetras").toString() : null;
                    String voNombre = body.get("voNombre") != null ? body.get("voNombre").toString() : null;
                    String voPuesto = body.get("voPuesto") != null ? body.get("voPuesto").toString() : null;
                    String attNombre = body.get("attNombre") != null ? body.get("attNombre").toString() : null;
                    String attPuesto = body.get("attPuesto") != null ? body.get("attPuesto").toString() : null;

                    double subtotalM = 0;
                    double ivaM = 0;
                    double totalM = 0;
                    double retenidoM = 0;

                    // Verificar y convertir valores
                    if (monto != null && !monto.isEmpty()) {
                        subtotalM = Double.parseDouble(monto);
                    }

                    if (iva != null && !iva.isEmpty()) {
                        ivaM = Double.parseDouble(iva);
                    }

                    if (total != null && !total.isEmpty()) {
                        totalM = Double.parseDouble(total);
                    }

                    if (retenido != null && !retenido.isEmpty()) {
                        retenidoM = Double.parseDouble(retenido);
                    }

                    // Asignar valores al objeto memorandum
                    memorandum.setIdConcepto(idConcepto);
                    memorandum.setNombreConcepto(concepto);
                    memorandum.setIdMemorandum(idMemorandum);
                    memorandum.setNoMemorandum(noMemorandum);
                    memorandum.setFecha(fechaM);
                    memorandum.setRemitente(remitente);
                    memorandum.setDestinatario(destinatario);
                    memorandum.setCuentaBancaria(cuentaBancaria);
                    memorandum.setConceptoGeneral(conceptoGeneral);
                    memorandum.setSubtotal(subtotalM);
                    memorandum.setIva(ivaM);
                    memorandum.setRetenido(retenidoM);
                    memorandum.setTotal(totalM);
                    memorandum.setTotalLetras(importeLetras);
                    memorandum.setNombreVo(voNombre);
                    memorandum.setPuestoVo(voPuesto);
                    memorandum.setNombreAtt(attNombre);
                    memorandum.setPuestoAtt(attPuesto);
                    memorandum.setUsuario(usuario.getUsuario());

                    call = new dao_MArrendamiento();
                    int id_memorandum_encabezado = call.guardar_memo_arrendamiento(action, memorandum);
                    if (id_memorandum_encabezado != 0) {
                        String guarda_detalle = null;

                        ArrayList<Map<String, String>> importes = (ArrayList<Map<String, String>>) body.get("importes");
                        for (Map<String, String> importe : importes) {
                            detalle = new obj_detalleArrendamiento();
                            double detalle_importe = 0;

                            if (importe.get("importe") != null && !importe.get("importe").isEmpty()) {
                                detalle_importe = Double.parseDouble(importe.get("importe"));
                            }

                            detalle.setIdEncabezado(id_memorandum_encabezado);
                            detalle.setConsecutivo(importe.get("renglon"));
                            detalle.setConcepto_desglose(importe.get("concepto"));
                            detalle.setImporte(detalle_importe);
                            guarda_detalle = call.guardar_memo_arr_detalle(action, detalle);
                        }

                        if (guarda_detalle != null) {
                            System.out.println("--Modificar detalle no es nulo--");

                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            PrintWriter out = response.getWriter();

                            JSONArray messages = new JSONArray();
                            messages.put("SE MODIFICÓ CORRECTAMENTE EL MEMORÁNDUM: " + guarda_detalle);
                            //messages.put("Otro mensaje o información adicional");

                            JSONObject jsonResponse = new JSONObject();
                            jsonResponse.put("messages", messages);
                            jsonResponse.put("tipomensaje", "Exito");
                            dao_MArrendamiento daoMemo = new dao_MArrendamiento();
                            List<obj_MArrendamiento> memlista = daoMemo.Listar();
                            jsonResponse.put("datalistImpresion", memlista);
                            out.print(jsonResponse.toString());
                            out.flush();

                            // Reenviar a la página JSP
                            //    request.getRequestDispatcher("Documentos/MemoArrendamiento.jsp").forward(request, response);
                        } else {
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            PrintWriter out = response.getWriter();

                            JSONArray messages = new JSONArray();
                            messages.put("NO SE ACTUALIZARON LOS DETALLES DEL MEMORÁNDUM");
                            //messages.put("Otro mensaje o información adicional");

                            JSONObject jsonResponse = new JSONObject();
                            jsonResponse.put("messages", messages);
                            jsonResponse.put("tipomensaje", "Error");

                            out.print(jsonResponse.toString());
                            out.flush();
                        }

                    } else {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put("NO SE ACTUALIZÓ CORRECTAMENTE EL ENCABEZADO DEL MEMORÁNDUM");
                        //messages.put("Otro mensaje o información adicional");

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Error");

                        out.print(jsonResponse.toString());
                        out.flush();
                    }

                } else {
                    System.out.println("No llega nada en JSON");
                }

            } catch (Exception ex) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONArray messages = new JSONArray();
                messages.put("OCURRIÓ UN ERROR EN EL PROCEDIMIENTO " + ex);
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

        } else if (action != null && action.equals("103") && act == null) {//CANCELAR
            System.out.println("Opcion 103");
            try {
                memorandum = new obj_MArrendamiento();
                if (body != null) {
                    // Extraer datos del JSON con verificaciones null
                    String noMemorandum = body.get("memorandum") != null ? body.get("memorandum").toString() : null;
                    String motivoCancelacion = body.get("motivoCancelacion") != null ? body.get("motivoCancelacion").toString() : null;

                    // Asignar valores al objeto memorandum
                    memorandum.setNoMemorandum(noMemorandum);
                    memorandum.setMotivos(motivoCancelacion);
                    memorandum.setUsuario(usuario.getUsuario());

                    call = new dao_MArrendamiento();
                    int id_memorandum_encabezado = call.guardar_memo_arrendamiento(action, memorandum);
                    String respuesta = Integer.toString(id_memorandum_encabezado);
                    System.out.println("Respuesta: " + respuesta);
                    if (respuesta != null && !respuesta.isEmpty()) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();
                        JSONArray messages = new JSONArray();
                        messages.put("SE DIÓ DE BAJA CORRECTAMENTE EL MEMORÁNDUM: " + noMemorandum);
                        //messages.put("Otro mensaje o información adicional");
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Exito");
                        dao_MArrendamiento daoMemo = new dao_MArrendamiento();
                        List<obj_MArrendamiento> memlista = daoMemo.Listar();
                        jsonResponse.put("datalistImpresion", memlista);
                        out.print(jsonResponse.toString());
                        out.flush();

                    } else {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put("NO SE PUDO REALIZAR LA CANCELACIÓN DEL MEMORÁNDUM " + noMemorandum);
                        //messages.put("Otro mensaje o información adicional");

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Error");

                        out.print(jsonResponse.toString());
                        out.flush();
                    }

                } else {
                    System.out.println("No llega nada en JSON");
                }

            } catch (Exception ex) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONArray messages = new JSONArray();
                messages.put("OCURRIÓ UN ERROR EN EL PROCEDIMIENTO " + ex);
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

        } else if (action != null && action.equals("106") && act == null) {//Activar
            System.out.println("Opcion 106");
            try {
                memorandum = new obj_MArrendamiento();
                if (body != null) {
                    // Extraer datos del JSON con verificaciones null
                    String noMemorandum = body.get("memorandum") != null ? body.get("memorandum").toString() : null;

                    // Asignar valores al objeto memorandum
                    memorandum.setNoMemorandum(noMemorandum);
                    memorandum.setUsuario(usuario.getUsuario());

                    call = new dao_MArrendamiento();
                    int id_memorandum_encabezado = call.guardar_memo_arrendamiento(action, memorandum);
                    String respuesta = Integer.toString(id_memorandum_encabezado);
                    System.out.println("Respuesta: " + respuesta);
                    if (respuesta != null && !respuesta.isEmpty()) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();
                        JSONArray messages = new JSONArray();
                        messages.put("SE ACTIVÓ CORRECTAMENTE EL MEMORÁNDUM: " + noMemorandum);
                        //messages.put("Otro mensaje o información adicional");
                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Exito");
                        dao_MArrendamiento daoMemo = new dao_MArrendamiento();
                        List<obj_MArrendamiento> memlista = daoMemo.Listar();
                        jsonResponse.put("datalistImpresion", memlista);
                        out.print(jsonResponse.toString());
                        out.flush();

                    } else {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();

                        JSONArray messages = new JSONArray();
                        messages.put("NO SE PUDO REALIZAR LA ACTIVACIÓN DEL MEMORÁNDUM " + noMemorandum);
                        //messages.put("Otro mensaje o información adicional");

                        JSONObject jsonResponse = new JSONObject();
                        jsonResponse.put("messages", messages);
                        jsonResponse.put("tipomensaje", "Error");

                        out.print(jsonResponse.toString());
                        out.flush();
                    }

                } else {
                    System.out.println("No llega nada en JSON");
                }

            } catch (Exception ex) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();

                JSONArray messages = new JSONArray();
                messages.put("OCURRIÓ UN ERROR EN EL PROCEDIMIENTO " + ex);
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

        } else if (act != null && act.equals("105") && action == null) {//Imprimir memorándum
            String imprimirUno = request.getParameter("imprimirMemorandum");
            String imprimirLista = request.getParameter("imprimirListadoMemorandum");
            String imprimirRango = request.getParameter("imprimirRangoMemorandum");
            if (imprimirUno != null) {
                System.out.println("--IMPRIMIR UNO--");
                String noMemorandumImpresion = request.getParameter("listaMemorandumImpresion");
                System.out.println("Memo: " + noMemorandumImpresion);

                try {
                    memorandum = new obj_MArrendamiento();
                    call = new dao_MArrendamiento();
                    dao_MArrendamiento callDetalle = new dao_MArrendamiento();
                    int resultadoEstatus = call.CambiarEstatus(noMemorandumImpresion);
                    if (resultadoEstatus != 1) {
                        mensaje.setMensaje("OCURRIO UN ERROR.");
                        mensaje.setDescripcion("NO SE PUDO CAMBIAR ESTATUS");
                        mensaje.setTipo(false);
                        session.setAttribute("mensaje", mensaje);
                        response.sendRedirect("Srv_MArrendamiento");
                    }
                    memorandum = call.buscarparaImpresion(noMemorandumImpresion);

                                   
                    List<obj_detalleArrendamiento> detallelista2 = callDetalle.buscarDetalle(noMemorandumImpresion); // Asegúrate de que este método retorne la lista adecuada
                   
                    if (memorandum != null) {
                        DecimalFormat df = new DecimalFormat("#,##0.00");
                        String totalFormateado = df.format(memorandum.getTotal());

                        StringBuilder detalleString = new StringBuilder(); // Usamos StringBuilder para construir el string de detalles
                         // Recorremos la lista de detalles y construimos el string
                        for (obj_detalleArrendamiento detalleImpresion : detallelista2) {
                            detalleString.append(detalleImpresion.getConsecutivo())
                                         .append(" - ")
                                         .append(detalleImpresion.getConcepto_desglose())
                                         .append(" : ")
                                         .append(df.format(detalleImpresion.getImporte())) // Formateamos el importe
                                         .append("\n");
                        }

                        String qrContent = "No. MEMORANDUM: " + memorandum.getNoMemorandum() + "\n"
                                + "FECHA: " + memorandum.getFecha() + "\n"
                                + "IMPORTE TOTAL: " + totalFormateado + "\n"
                                + "DESGLOSE DE CONCEPTOS:\n" + detalleString.toString(); 
                        // Especifica la ruta donde se guardará la imagen
                        String filePath = "C:\\DocumentosFacturacion\\MemorandumsArrendamiento\\"
                                + memorandum.getNoMemorandum() + ".png";
                        Path path = Paths.get(filePath);

                        // Verifica si el archivo ya existe
                        File existingFile = new File(filePath);
                        if (existingFile.exists()) {
                            // Elimina el archivo si ya existe
                            existingFile.delete();
                        }
                        // Generar el código QR
                        BitMatrix bitMatrix = new MultiFormatWriter().encode(qrContent, BarcodeFormat.QR_CODE, 300, 300);
                        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);

                        request.setAttribute("qrDireccion", filePath);
                        request.setAttribute("memorandum", memorandum);
                        request.getRequestDispatcher("Reportes/reporte_memo_arrendamiento_individual.jsp").forward(request, response);
                    } else {
                        mensaje.setMensaje("OCURRIO UN ERROR.");
                        mensaje.setDescripcion("NO EXISTE EL MEMORÁNDUM");
                        mensaje.setTipo(false);
                        session.setAttribute("mensaje", mensaje);
                        response.sendRedirect("Srv_MArrendamiento");
                        return;
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    mensaje.setMensaje("OCURRIÓ UN ERROR EN MOSTRAR LISTAS.");
                    mensaje.setDescripcion(ex.getMessage());
                    mensaje.setTipo(false);
                    session.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                } finally {
                    if (call != null) {
                        call.closeConnection();
                    }
                    return;

                }

            } else if (imprimirLista != null) {
                System.out.println("--IMPRIMIR LISTA--");
                String fechaInicio = request.getParameter("fechaInicio");
                String fechaFin = request.getParameter("fechaFin");
                String estatus = request.getParameter("estatusImpresion");
                System.out.println("Fecha inicio: " + fechaInicio);
                System.out.println("Fecha fin; " + fechaFin);
                System.out.println("Estatus: " + estatus);
                try {
                    //Mostrar lista Memorandum
                    call = new dao_MArrendamiento();
                    List<obj_MArrendamiento> memlista = null;
                    memlista = call.ImpresionLista(fechaInicio, fechaFin, estatus);
                    request.setAttribute("listaMemorandum", memlista);
                    request.getRequestDispatcher("Reportes/reporte_memorandum_lista_arrendamiento.jsp").forward(request, response);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    mensaje.setMensaje("OCURRIÓ UN ERROR EN MOSTRAR LISTAS.");
                    mensaje.setDescripcion(ex.getMessage());
                    mensaje.setTipo(false);
                    session.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                } finally {
                    if (call != null) {
                        call.closeConnection();
                    }
                    return;

                }

            } else if (imprimirRango != null) {

            } else {
                mensaje.setMensaje("OCURRIO UN ERROR.");
                mensaje.setDescripcion("NO EXISTE OPCIÓN A REALIZAR");
                mensaje.setTipo(false);
                session.setAttribute("mensaje", mensaje);
                response.sendRedirect("Srv_MArrendamiento");
                return;
            }

        } else if (act.equals("104") && action == null) { //BUSCAR
            System.out.println("Opcion 104");
            try {

                String noMemo = request.getParameter("memorandum");
                if (noMemo != null && !noMemo.isEmpty()) {
                    memorandum = new obj_MArrendamiento();
                    call = new dao_MArrendamiento();
                    memorandum = call.buscarMemorandum(noMemo);
                    if (memorandum != null) {
                        request.setAttribute("memorandum", memorandum);
                        detallelista = call.buscarDetalle(noMemo);
                        request.setAttribute("detallelista", detallelista);
                    } else {
                        mensaje.setMensaje("OCURRIÓ UN ERROR");
                        mensaje.setDescripcion("NO SE ENCONTRÓ EL MEMORÁNDUM");
                        mensaje.setTipo(false);
                        session.setAttribute("mensaje", mensaje);
                        request.setAttribute("memorandum", null);
                        request.setAttribute("detallelista", null);
                    }

                }
                dao_DepositoBancario daoDepoBancario = new dao_DepositoBancario();
                List<obj_DepositoBancario> depositoLista = daoDepoBancario.Listar();
                request.setAttribute("listDeposito", depositoLista);

                dao_MArrendamiento daoMemo = new dao_MArrendamiento();
                List<obj_MArrendamiento> memlista = daoMemo.Listar();
                request.setAttribute("memlista", memlista);

                dao_Conceptos dao3 = new dao_Conceptos(); // Mostrar lista CONCEPTOS
                List<obj_Conceptos> conceptolista = dao3.Listar();
                request.setAttribute("conceptolista", conceptolista);
                request.getRequestDispatcher("Documentos/MemoArrendamiento.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("OCURRIÓ UN ERROR EN PROCEDIMEINTO.");
                mensaje.setDescripcion(ex.getMessage());
                mensaje.setTipo(false);
                session.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
            } finally {
                if (call != null) {
                    call.closeConnection();
                }
                return;

            }
        }

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
