/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_CodPostal;
import Excepciones.Validaciones;
import Objetos.obj_CodigoPostal;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
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

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_CPostal")
public class Srv_CPostal extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Ingresa al servletcodigospostales");
        request.setCharacterEncoding("UTF-8");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_CodigoPostal codpos = null;
        dao_CodPostal call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        //Mostrar lista
        dao_CodPostal dao3 = null;
        List<obj_CodigoPostal> cpostlista = null;

        //TOMA LOS VALORES DEL FORMULARIO 
        String id = request.getParameter("idCodigoPostal");
        String cp = request.getParameter("codigoPostal");
        String col = request.getParameter("colonia");
        String cdad = request.getParameter("ciudad");
        String mun = request.getParameter("municipio");
        String est = request.getParameter("estado");
        String esat = request.getParameter("estadoSat");

        //Muestra lo que toma de formulario
        System.out.println("--------------------CodigoPostalServlet---------------------");
        System.out.println("ID:" + id);
        System.out.println("Codigo:" + cp);
        System.out.println("Colonia:" + col);
        System.out.println("Ciudad:" + cdad);
        System.out.println("Municipio:" + mun);
        System.out.println("Estado:" + est);
        System.out.println("Esat:" + esat);

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

        //------------------------------NO SE SELECCIONAN BOTONES--------------------------------------------------
        if (act == null) {
            //nningun boton ha sido seleccionado Mostrar lista
            System.out.println("-Lista servlet Ningun boton- Ingresa a TRY");
            try {
                System.out.println("-Lista servlet- Ingresa a TRY");
                dao3 = new dao_CodPostal();
                cpostlista = dao3.Listar();

                request.setAttribute("cpostlista", cpostlista);
                System.out.println("-Lista servlet- Envia lista");
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
            request.getRequestDispatcher("CatalogosSat/CodigoPostal.jsp").forward(request, response);
            return;

//---------------------------------------------PROCEDIMIENTO------------------------------------------------------
        } else {
            try {
                call = new dao_CodPostal();
                codpos = new obj_CodigoPostal();
                
                codpos.setCodigo(cp);
                codpos.setColonia(col);
                codpos.setCiudad(cdad);
                codpos.setDelegacion(mun);
                codpos.setEstado(est);
                codpos.setEstadoSAT(esat);
                codpos.setUsuario(usuario.getUsuario());//TOMA AL USUARIO DE LA SESION

                mensaje = call.ctg_codigopostal(act, codpos, id);
                session.setAttribute("mensaje", mensaje);

                dao3 = new dao_CodPostal();
                cpostlista = dao3.Listar();
                session.setAttribute("cpostlista", cpostlista);

                response.sendRedirect("Srv_CPostal");
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
