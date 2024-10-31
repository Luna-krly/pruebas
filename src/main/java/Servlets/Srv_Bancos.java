/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_Banco;
import Excepciones.Validaciones;
import Objetos.Obj_Banco;
import Objetos.obj_Mensaje;
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
@WebServlet("/Srv_Bancos")
public class Srv_Bancos extends HttpServlet implements Servlet {
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("--------------------Ingresa a Srv_Bancos---------------------");
        String act = request.getParameter("action");
        obj_Mensaje mensaje = new obj_Mensaje();
        Obj_Banco banco = null;
        dao_Banco call = null;
        obj_Usuario usuario = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        dao_Banco dao3 = null;
        List<Obj_Banco> bnlista = null;

        String id = request.getParameter("idBanco");
        String clave = request.getParameter("rfcBanco");
        String desc = request.getParameter("nombreBanco");

        System.out.println("---------------------Srv_Bancos---------------------");
        System.out.println("ID:" + id);
        System.out.println("Clave:" + clave);
        System.out.println("Descripcion:" + desc);

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");
        rsp = validar.verUsuario(usuario);

        if (!rsp) {
            mensaje.setMensaje("ERROR");
            mensaje.setDescripcion("FAVOR DE INICIAR SESIÓN");
            mensaje.setTipo(false);
            request.setAttribute("mensaje", mensaje);

            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        if (act == null) {
            System.out.println("Srv_Bancos- Ningun boton-");
            try {
                dao3 = new dao_Banco();
                bnlista = dao3.Listar();
                request.setAttribute("bnlista", bnlista);
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
            request.getRequestDispatcher("CatalogosSat/Bancos.jsp").forward(request, response);
            return;
        } else {
            try {
                call = new dao_Banco();
                banco = new Obj_Banco();
                banco.setRfc(clave);
                banco.setNombre(desc);
                banco.setUsuario(usuario.getUsuario());

                mensaje = call.ctg_banco(act, banco, id);
                session.setAttribute("mensaje", mensaje);
                
                dao3 = new dao_Banco();
                bnlista = dao3.Listar();
                session.setAttribute("bnlista", bnlista);
                

                response.sendRedirect("Srv_Bancos");
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
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

