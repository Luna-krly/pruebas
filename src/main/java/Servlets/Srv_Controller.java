/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Excepciones.Validaciones;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.Servlet;
import java.io.IOException;
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
@WebServlet("/Srv_Controller")
public class Srv_Controller extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {    
        request.setCharacterEncoding("UTF-8");

        obj_Mensaje mensaje = new obj_Mensaje();

        Validaciones validar = new Validaciones();
        boolean respuesta = false;

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        obj_Usuario usuario = (obj_Usuario) session.getAttribute("usuario");
        respuesta = validar.verUsuario(usuario);

        if (respuesta != true) {
            //MANDA LA INFORMACION AL OBJETO ERROR
            mensaje = new obj_Mensaje();

            mensaje.setMensaje("Error");
            mensaje.setDescripcion("Favor de Iniciar Sesion");
            mensaje.setTipo(false);
            request.setAttribute("mensaje", mensaje);

            //Manda la pagina de eror si es que hay alguno 
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);

            return;
        }

        String action = request.getParameter("action"); //Nombre del grupo de botones o inputs
        try {
            switch (action) {
                case "101":
                    request.getRequestDispatcher("Principal.jsp").forward(request, response);
                    break;
                case "100":
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    break;
                case "201":
                    response.sendRedirect(request.getContextPath() + "/Srv_Concepto");
                    break;
                case "202":
                    response.sendRedirect(request.getContextPath() + "/Srv_Permisos");
                    break;
                case "203":
                    response.sendRedirect(request.getContextPath() + "/Srv_DepositoBancario");
                    break;
                case "204":
                    response.sendRedirect(request.getContextPath() + "/Srv_Bancos");
                    break;
                case "205":
                    response.sendRedirect(request.getContextPath() + "/Srv_CSat");
                    break;
                case "206":
                    response.sendRedirect(request.getContextPath() + "/Srv_CPostal");
                    break;
                case "207":
                    response.sendRedirect(request.getContextPath() + "/Srv_TCompr");
                    break;
                case "208":
                    response.sendRedirect(request.getContextPath() + "/Srv_FormaPago");
                    break;
                case "209":
                    response.sendRedirect(request.getContextPath() + "/Srv_Imp");
                    break;
                case "210":
                    response.sendRedirect(request.getContextPath() + "/Srv_MPago");
                    break;
                case "211":
                    response.sendRedirect(request.getContextPath() + "/Srv_Monedas");
                    break;
                case "212":
                    response.sendRedirect(request.getContextPath() + "/Srv_OImpuesto");
                    break;
                case "213":
                    response.sendRedirect(request.getContextPath() + "/Srv_Paises");
                    break;
                case "214":
                    response.sendRedirect(request.getContextPath() + "/Srv_Periodicidades");
                    break;
                case "215":
                    response.sendRedirect(request.getContextPath() + "/Srv_ProdServ");
                    break;
                case "216":
                    response.sendRedirect(request.getContextPath() + "/Srv_RegFiscal");
                    break;
                case "217":
                    response.sendRedirect(request.getContextPath() + "/Srv_TFactor");
                    break;
                case "218":
                    response.sendRedirect(request.getContextPath() + "/Srv_TRelacion");
                    break;
                case "219":
                    response.sendRedirect(request.getContextPath() + "/Srv_TServicio");
                    break;
                case "220":
                    response.sendRedirect(request.getContextPath() + "/Srv_UMedida");
                    break;
                case "221":
                    response.sendRedirect(request.getContextPath() + "/Srv_UCFDI");
                    break;
                case "222":
                    response.sendRedirect(request.getContextPath() + "/Srv_MGeneral");
                    break;
                case "223":
                    response.sendRedirect(request.getContextPath() + "/Srv_MArrendamiento");
                    break;
                case "224":
                    response.sendRedirect(request.getContextPath() + "/Srv_Facturas");
                    break;
                case "225":
                    response.sendRedirect(request.getContextPath() + "/Srv_FacturacionAutomatica");
                    break;
                case "226":
                    response.sendRedirect(request.getContextPath() + "/Srv_Autorizacion");
                 break;
                case "227":
                    response.sendRedirect(request.getContextPath() + "/Srv_Pagos");
                 break;
                case "228":
                    response.sendRedirect(request.getContextPath() + "/Srv_CancelacionFacturas");
                 break;
                default:
                    request.getRequestDispatcher("404.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
            return;
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
