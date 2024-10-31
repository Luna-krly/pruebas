/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_Impuestos;
import Excepciones.Validaciones;
import Objetos.obj_Impuestos;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
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

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_Imp")
public class Srv_Imp extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //--------------------------INICIA----
        request.setCharacterEncoding("UTF-8");
        System.out.println("--------------------Ingresa a Srv_Imp---------------------");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_Impuestos imp = null;
        dao_Impuestos call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        //Mostrar lista
        dao_Impuestos dao3 = null;
        List<obj_Impuestos> implista = null;

        //TOMA LOS VALORES DEL FORMULARIO 
        String id = request.getParameter("idImpuestos");
        String clave = request.getParameter("claveImpuesto");
        if (clave != null) clave = clave.trim();
        String desc = request.getParameter("descripcionImpuesto");
        String retencion = request.getParameter("esRetenido");
        String traslado = request.getParameter("esTraslado");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_Imp---------------------");
        System.out.println("Clave:" + clave);
        System.out.println("Descripcion:" + desc);

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
        //TOMA FECHA DE SESION ACTUAL
        Date date = new Date();
        long d = date.getTime(); //guardamos en un long el tiempo
        java.sql.Date fecha = new java.sql.Date(d);// parseamos al formato del sql  

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //Ningún botón ha sido seleccionado
            System.out.println("Srv_Imp- Ningun boton- Ingresa a TRY");
            try {
                System.out.println("Srv_Imp- Lista servlet- Ingresa a TRY");
                dao3 = new dao_Impuestos();
                implista = dao3.Listar();
                request.setAttribute("implista", implista);
                System.out.println("Srv_Imp- Lista servlet- Envia lista");

            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("OCURRIO UN ERROR");
                mensaje.setDescripcion("NO SE PUEDEN ENVIAR LISTAS");
                mensaje.setTipo(false);
                
                System.out.println("Error en listas "+ex.getMessage());
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("CatalogosSat/Impuestos.jsp").forward(request, response);
            return;

            //--------------------------------------------PROCEDIMIENTO---------------------------------------------------------------  
        } else {
            //someone has altered the HTML and sent a different value!
            try {
                //Validación retencion y traslado
                if (retencion != null) {
                    retencion = "SI";
                } else {
                    retencion = "NO";
                }
                if (traslado != null) {
                    traslado = "SI";
                } else {
                    traslado = "NO";
                }
                call = new dao_Impuestos();
                imp = new obj_Impuestos();
                imp.setClaveImpuesto(clave);
                imp.setDescripcionImpuesto(desc);
                imp.setRetencion(retencion);
                imp.setTraslado(traslado);
                imp.setUsuario(usuario.getUsuario());//Nombre usuario

                mensaje = call.ctg_impuestos(act, imp, id);
                session.setAttribute("mensaje", mensaje);

                dao3 = new dao_Impuestos();
                implista = dao3.Listar();
                session.setAttribute("implista", implista);

                response.sendRedirect("Srv_Imp");
                return;

            } catch (Exception ex) {
                mensaje.setMensaje("OCURRIO UN ERROR.");
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
