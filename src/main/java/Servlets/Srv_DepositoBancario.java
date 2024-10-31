/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import DAO.dao_Banco;
import DAO.dao_DepositoBancario;
import Excepciones.Validaciones;
import Objetos.Obj_Banco;
import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import Objetos.obj_DepositoBancario;
import jakarta.servlet.Servlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_DepositoBancario")
public class Srv_DepositoBancario extends HttpServlet implements Servlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("--------------------Ingresa a Srv_DepositoBancario---------------------");
        String action = request.getParameter("action");
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_DepositoBancario deposito = null;
        dao_DepositoBancario call = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        obj_Usuario usuario = null;

        //Lista de bancos
        dao_Banco dao3 = null;
        List<Obj_Banco> bnlista = null;

        
        //Lista de bancos
        dao_DepositoBancario daoLista = null;
        List<obj_DepositoBancario> depositolista = null;
        
        //TOMA LOS VALORES DEL FORMULARIO 
        String id=request.getParameter("idDeposito");
        String idBanco = request.getParameter("id_banco");
        String nombreBanco = request.getParameter("banco");
        String cuentaBancaria=request.getParameter("cuentaBancaria");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_DepositoBancario---------------------");
        System.out.println("ID: "+id);
        System.out.println("Id Banco:" + idBanco);
        System.out.println("Nombre Banco:" + nombreBanco);
        System.out.println("Cuenta Bancaria:"+cuentaBancaria);
   
        
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

        if (action == null) {
            //Ningún botón ha sido seleccionado

            try {
                daoLista = new dao_DepositoBancario();
                depositolista=daoLista.Listar();
                request.setAttribute("depositolista", depositolista);
                
                dao3 = new dao_Banco();
                bnlista = dao3.Listar();
                request.setAttribute("bnlista", bnlista);

                request.getRequestDispatcher("Catalogos/DepositoBancario.jsp").forward(request, response);
                return;
            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("OCURRIO UN ERROR");
                mensaje.setDescripcion("NO SE PUEDEN ENVIAR LISTAS");
                mensaje.setTipo(false);

                System.out.println("Error en listas " + ex.getMessage());
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
                return;
            }

        } else {
            try {
                deposito = new obj_DepositoBancario();
                call = new dao_DepositoBancario();
                
                deposito.setIdBanco(idBanco);
                deposito.setNombreBanco(nombreBanco);
                deposito.setCuentaBancaria(cuentaBancaria);
                
                mensaje=call.ctg_depositoBancario(action, deposito, id);
                session.setAttribute("mensaje", mensaje);
                
                daoLista = new dao_DepositoBancario();
                depositolista=daoLista.Listar();
                request.setAttribute("depositolista", depositolista);
                
                dao3 = new dao_Banco();
                bnlista = dao3.Listar();
                request.setAttribute("bnlista", bnlista);

                request.getRequestDispatcher("Catalogos/DepositoBancario.jsp").forward(request, response);
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
