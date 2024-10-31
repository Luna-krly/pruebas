/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_Autorizacion;
import DAO.dao_Facturas;
import Excepciones.Validaciones;
import Objetos.obj_Autorizacion;
import Objetos.obj_Factura;
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
@WebServlet("/Srv_Autorizacion")
public class Srv_Autorizacion extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();
        dao_Autorizacion call = null;
        obj_Autorizacion autorizacion = new obj_Autorizacion();
        obj_Usuario usuario = null;

        Validaciones validar = new Validaciones();
        boolean rsp = false;
        boolean rsp2 = false;
        //Mostrar lista FACTURAS
        dao_Autorizacion daoAU = null;
        List<obj_Autorizacion> autorizarLista = null;

        //ENCABEZADO             
        String serie = request.getParameter("serie");
        String folio = request.getParameter("folio");
        String fecha = request.getParameter("fecha");
        String importe = request.getParameter("importe");

        System.out.println("---------------------Srv_Facturas---------------------");

        System.out.println("Serie: " + serie);
        System.out.println("Folio: " + folio);

        //TOMA DATOS DEL USUARIO NOMBRE
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");
        rsp = validar.verUsuario(usuario);

        if (rsp != true) {
            //MANDA LA INFORMACION AL OBJETO ERROR
            mensaje = new obj_Mensaje();

            mensaje.setMensaje("Error");
            mensaje.setDescripcion("Favor de Iniciar Sesion");
            mensaje.setTipo(false);
            request.setAttribute("mensaje", mensaje);
            //Manda la pagina de eror si es que hay alguno 
            request.getRequestDispatcher("index.jsp").forward(request, response);

            return;
        }

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //nningun boton ha sido seleccionado
            try {
                daoAU = new dao_Autorizacion();//------------------Mostrar lista FACTURAS PARA AUTORIZAR
                autorizarLista = daoAU.Listar();
                request.setAttribute("autorizarLista", autorizarLista);
                request.getRequestDispatcher("Autorizaciones/Autorizaciones.jsp").forward(request, response);

            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("Ocurrio un error al enviar listas.");
                mensaje.setDescripcion(ex.getMessage());
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
            }
            //-------------------------------------------REVISAR PDF-------------------------------------------------------------
        } else if (act.equals("revisar")) {

            //---------------------------------------------AUTORIZAR-------------------------------------------------------------    
        } else if (act.equals("autorizar")) {
            try {
                mensaje = new obj_Mensaje();
                call = new dao_Autorizacion();
                mensaje = call.autorizacion(folio, serie,usuario.getUsuario());
                session.setAttribute("mensaje", mensaje);
                response.sendRedirect("Srv_Autorizacion");
                return;
            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("OCURRIÓ UN ERROR AL AUTORIZAR");
                mensaje.setDescripcion(ex.getMessage());
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
            }
            //------------------------------------------ELSE----------------------------------------------------------------
        } else {
//            someone has altered the HTML and sent a different value!
        }
        request.getRequestDispatcher("Autorizaciones/Autorizaciones.jsp").forward(request, response);

        //------     
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
