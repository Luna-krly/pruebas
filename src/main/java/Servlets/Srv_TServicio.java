/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_TServicio;
import Excepciones.Validaciones;
import Objetos.obj_Mensaje;
import Objetos.obj_TServicio;
import Objetos.obj_Usuario;
import java.io.IOException;
import java.util.List;
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
@WebServlet("/Srv_TServicio")
public class Srv_TServicio extends HttpServlet implements Servlet {
//--------------------------INICIA----

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("--------------------Ingresa a Srv_TServicio---------------------");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();

        obj_TServicio servicio = null;
        dao_TServicio call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        //Mostrar lista
        dao_TServicio dao3 = null;
        List<obj_TServicio> srvlista = null;

        //TOMA LOS VALORES DEL FORMULARIO
        String id = request.getParameter("idServicio");
        String clave = request.getParameter("claveServicio");
        String desc = request.getParameter("descripcionServicio");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_TServicio---------------------");
        System.out.println("ID: "+id);
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

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //Ningún botón ha sido seleccionado
            System.out.println("Srv_TServicio- Ningun boton-");
            try {
                dao3 = new dao_TServicio();
                srvlista = dao3.Listar();
                request.setAttribute("srvlista", srvlista);

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
            request.getRequestDispatcher("CatalogosSat/TipoServicio.jsp").forward(request, response);
            return;

            //--------------------------------------------GUARDAR---------------------------------------------------------------  
        } else {
            try {
                call = new dao_TServicio();
                servicio = new obj_TServicio();

                servicio.setClave(clave);
                servicio.setDescripcion(desc);
                servicio.setUsuario(usuario.getUsuario());//Nombre usuario

                mensaje = call.ctg_tipo_serv(act, servicio, id);
                session.setAttribute("mensaje", mensaje);

                dao3 = new dao_TServicio();
                srvlista = dao3.Listar();
                session.setAttribute("srvlista", srvlista);

                response.sendRedirect("Srv_TServicio");
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

//---------------FIN-----------------------------------------------  
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
