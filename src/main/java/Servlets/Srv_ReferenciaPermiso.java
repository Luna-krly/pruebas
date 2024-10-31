/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.dao_ReferenciaPermiso;
import Excepciones.Validaciones;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import Objetos.obj_detalleArrendamiento;
import Objetos.obj_referenciaPermiso;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.Servlet;
import java.io.IOException;
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
import com.google.gson.Gson;

/**
 *
 * @author Leilani
 */
@WebServlet("/Srv_ReferenciaPermiso")
public class Srv_ReferenciaPermiso extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("--------------------Ingresa a Srv_ReferenciaPermiso---------------------");
        request.setCharacterEncoding("UTF-8");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        //generales
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;

        //Servlet
        dao_ReferenciaPermiso call = null;

        //TOMA DATOS DEL USUARIO NOMBRE
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");
        rsp = validar.verUsuario(usuario);

        if (rsp != true) {
            //MANDA LA INFORMACION AL OBJETO ERROR
            mensaje = new obj_Mensaje();

            mensaje.setMensaje("ERROR");
            mensaje.setDescripcion("FAVOR DE INICIAR SESIÓN");
            mensaje.setTipo(false);
            request.setAttribute("mensaje", mensaje);

            //Manda la pagina de eror si es que hay alguno 
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        // Leer JSON del cuerpo de la solicitud
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String json = sb.toString();


        String action = null;
        // Convertir JSON a un Map
        Gson gson = new Gson();
        Type type = new TypeToken<Map<String, Object>>() {
        }.getType();
        Map<String, Object> body = gson.fromJson(json, type);
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

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_ReferenciaPermiso---------------------");

        if (action == null && act == null) {
            response.sendRedirect(request.getContextPath() + "/Srv_CSat");
            return;
        } else {
            if (body != null) {
                try {
                    String idCliente = body.get("rfcCliente") != null ? body.get("rfcCliente").toString() : null;
                    if(idCliente!=null && idCliente.equals("")){
                        idCliente=null;
                    }
                    ArrayList<Map<String, String>> datosReferencias = (ArrayList<Map<String, String>>) body.get("datosReferencias");
//                    for (Map<String, String> referencia : datosReferencias) {
//                        String renglon = referencia.get("renglon");
//                        String rfcArrendatario = referencia.get("rfcArrendatario");
//                        String nombreArrendatario = referencia.get("nombreArrendatario");
//                        String permiso = referencia.get("permiso");
//                        String numero = referencia.get("numero");
//                        String descripcion = referencia.get("descripcion");
//                        String referenciaqr = referencia.get("referenciaqr");
//                        String numeroPATR = referencia.get("numeroPATR");
//                        String iniciaVigencia = referencia.get("iniciaVigencia");
//                        String finVigencia = referencia.get("finVigencia");
//                        String usuarioResponsable = referencia.get("usuarioResponsable");
//                        String sefactura = referencia.get("sefactura");
//                        String importeConcepto = referencia.get("importeConcepto");
//                        String importeIva = referencia.get("importeIva");
//                        String importeRenta = referencia.get("importeRenta");
//                        
//                        System.out.println("Renglon: " + renglon);
//                        System.out.println("RFC Arrendatario: " + rfcArrendatario);
//                        System.out.println("Nombre Arrendatario: " + nombreArrendatario);
//                        System.out.println("Permiso: " + permiso);
//                        System.out.println("Numero: " + numero);
//                        System.out.println("Descripcion: " + descripcion);
//                        System.out.println("Referencia QR: " + referenciaqr);
//                        System.out.println("Numero PATR: " + numeroPATR);
//                        System.out.println("Inicia Vigencia: " + iniciaVigencia);
//                        System.out.println("Fin Vigencia: " + finVigencia);
//                        System.out.println("Usuario Responsable: " + usuarioResponsable);
//                        System.out.println("SE Factura: " + sefactura);
//                        System.out.println("Importe Concepto: " + importeConcepto);
//                        System.out.println("Importe IVA: " + importeIva);
//                        System.out.println("Importe Renta: " + importeRenta);
//                    }
                    // Convertir el ArrayList a JSON
                    Gson gsonReferencias = new Gson();
                    String jsonReferencias = gsonReferencias.toJson(datosReferencias);

                    call = new dao_ReferenciaPermiso();
                    if(action.equals("101")){
                        mensaje = call.guardar_referencias(usuario.getUsuario(),idCliente,jsonReferencias);
                    }else{
                        mensaje.setMensaje("Error");
                        mensaje.setDescripcion("NO SE ENCONTRÓ LA OPCIÓN A REALIZAR");
                        mensaje.setTipo(false);
                    }      
                    // mensaje = call.ctg_ref_permiso(act, referencia, id);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();

                    JSONArray messages = new JSONArray();
                    messages.put(mensaje.getMensaje() );
                    messages.put(mensaje.getDescripcion());

                    String tipoMensaje=null;
                    
                    if(mensaje.getTipo()){
                        tipoMensaje="Exito";
                    }else{
                        tipoMensaje="Error";
                    }
                        
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("messages", messages);
                    jsonResponse.put("tipomensaje", tipoMensaje);

                    out.print(jsonResponse.toString());
                    out.flush();

                } catch (Exception ex) {
                    mensaje.setMensaje("OCURRIÓ UN ERROR.");
                    mensaje.setDescripcion("FAVOR DE VERIFICAR CON ADMINISTRADOR");
                    mensaje.setTipo(false);
                    System.out.println("Error en el catch " + ex);

                    request.setAttribute("mensaje", mensaje);
                    request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                    return;

                } finally {
                    if (call != null) {
                        call.closeConnection();
                    }
                    return;

                }

            }
            System.out.println("Hay a un boton de referencia permiso");

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
