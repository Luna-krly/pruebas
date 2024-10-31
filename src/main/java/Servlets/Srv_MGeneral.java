/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DAO.dao_Conceptos;
import DAO.dao_MGeneral;
import DAO.dao_TIngresos;
import Excepciones.Validaciones;
import Objetos.obj_Conceptos;
import Objetos.obj_MGeneral;
import Objetos.obj_Mensaje;
import Objetos.obj_TIngreso;
import Objetos.obj_Usuario;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
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
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DecimalFormat;

/**
 *
 * @author Ing. Evelyn Leilani Avendaño
 */
@WebServlet("/Srv_MGeneral")
public class Srv_MGeneral extends HttpServlet implements Servlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("--------------------Ingresa a Srv_Memorandum---------------------");
        request.setCharacterEncoding("UTF-8");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        System.out.println("ACTION: " + act);
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_MGeneral memorandum = null;
        dao_MGeneral call = null;
        Validaciones validar = new Validaciones();
        boolean rsp = false;
        obj_Usuario usuario = null;

        double subtotalM = 0;
        double ivaM = 0;
        double totalM = 0;
        double retenidoM = 0;

        //TOMA LOS VALORES DEL FORMULARIO 
        String idConcepto = request.getParameter("idConcepto");
        String idMemorandum = request.getParameter("idMemorandum");
        String noMemorandum = request.getParameter("noMemorandum");
        String nombreConcepto = request.getParameter("nombreConcepto");
        String fecha = request.getParameter("fecha");
        String remitente = request.getParameter("remitente");
        String destinatario = request.getParameter("destinatario");
        String idTipoIngreso = request.getParameter("tipoIngreso");
        String conceptoGeneral = request.getParameter("conceptoGeneral");
        String total = request.getParameter("total");
        String retenido = request.getParameter("retenido");
        String iva = request.getParameter("IVA");
        String subtotal = request.getParameter("monto");
        String totalLetras = request.getParameter("importeTotalLetras");
        String nombreVo = request.getParameter("nombreVo");
        String puestoVo = request.getParameter("puestoVo");
        String nombreAtt = request.getParameter("nombreAtentamente");
        String puestoAtt = request.getParameter("puestoAtentamente");

        String motivoCancelacion = request.getParameter("conceptoCancelacion");

        //Muestra lo que toma de formulario
        System.out.println("---------------------Srv_Memorandum General---------------------");
        System.out.println("id concepto: " + idConcepto);
        System.out.println("concepto:" + nombreConcepto);
        System.out.println("id Memorandum: " + idMemorandum);
        System.out.println("no Memorandum: " + noMemorandum);
        System.out.println("fecha:" + fecha);
        System.out.println("remitente: " + remitente);
        System.out.println("destinatario: " + destinatario);
        System.out.println("id tipo ingreso:" + idTipoIngreso);
        System.out.println("conceptogeneral:" + conceptoGeneral);
        System.out.println("total:" + total);
        System.out.println("Retenido" + retenido);
        System.out.println("iva:" + iva);
        System.out.println("subtotal:" + subtotal);
        System.out.println("total Letras:" + totalLetras);
        System.out.println("nombre vo" + nombreVo);
        System.out.println("puesto vo:" + puestoVo);
        System.out.println("nombre att:" + nombreAtt);
        System.out.println("puesto att:" + puestoAtt);
        //Mostrar lista
        dao_Conceptos dao3 = null;
        List<obj_Conceptos> conceptolista = null;

        //Mostrar lista Memorandum
        dao_MGeneral daoMM = null;
        List<obj_MGeneral> memlista = null;

        //Mostrar lista TIPO INGRESOS
        dao_TIngresos dao4 = null;
        List<obj_TIngreso> ingresosclista = null;

        //TOMA DATOS DEL USUARIO NOMBRE
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");
        rsp = validar.verUsuario(usuario);

        if (rsp != true) {

            mensaje.setMensaje("ERROR");
            mensaje.setDescripcion("FAVOR DE INICIAR SESIÓN");
            mensaje.setTipo(false);
            request.setAttribute("mensaje", mensaje);

            //Manda la pagina de eror si es que hay alguno 
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);

            return;
        }

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //nningun boton ha sido seleccionado

            try {
                System.out.println("Srv_Memorandums-Lista servlet- Ingresa a TRY");
                dao3 = new dao_Conceptos();//--------------Mostrar lista CONCEPTOS
                conceptolista = dao3.Listar();
                request.setAttribute("conceptolista", conceptolista);

                daoMM = new dao_MGeneral();//------------------Mostrar lista MEMORANDUM
                memlista = daoMM.Listar();
                request.setAttribute("memlista", memlista);

                dao4 = new dao_TIngresos();//------------------Mostrar lista tipo de ingreso
                ingresosclista = dao4.Listar();
                request.setAttribute("ingresosclista", ingresosclista);

            } catch (Exception ex) {
                ex.printStackTrace();

                mensaje.setMensaje("Ocurrio un error al enviar listas.");
                mensaje.setDescripcion(ex.getMessage());
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);

            }
            request.getRequestDispatcher("Documentos/MemoGeneral.jsp").forward(request, response);
            return;

            //-------------------------------------------IMPRIMIR---------------------------------------------------------------
        } else if (act.equals("105")) {

            String imprimirUno = request.getParameter("imprimirMemorandum");
            String imprimirLista = request.getParameter("imprimirListadoMemorandum");
            String imprimirRango = request.getParameter("imprimirRangoMemorandum");
            if (imprimirUno != null) {
                System.out.println("--IMPRIMIR UNO--");
                String noMemorandumImpresion = request.getParameter("noMemorandumImpresion");
                String recursosFinancieros = request.getParameter("gerenciaRecursosFinancieros");
                String areaEmisora = request.getParameter("areaEmisora");
                String gerenciaPresupuestos = request.getParameter("gerenciaPresupuestos");
                String gerenciaContabilidad = request.getParameter("gerenciaContabilidad");
                String cliente = request.getParameter("cliente");

                if (recursosFinancieros != null) {
                    recursosFinancieros = "RECURSOS FINANCIEROS";
                } else {
                    recursosFinancieros = null;
                }
                if (areaEmisora != null) {
                    areaEmisora = "ÁREA EMISORA";
                } else {
                    areaEmisora = null;
                }
                if (gerenciaPresupuestos != null) {
                    gerenciaPresupuestos = "GERENCIA DE PRESUPUESTOS";
                } else {
                    gerenciaPresupuestos = null;
                }
                if (gerenciaContabilidad != null) {
                    gerenciaContabilidad = "GERENCIA DE CONTABILIDAD";
                } else {
                    gerenciaContabilidad = null;
                }
                if (cliente != null) {
                    cliente = "CLIENTE";
                } else {
                    cliente = null;
                }

                try {
                    memorandum = new obj_MGeneral();
                    call = new dao_MGeneral();
                    int resultadoEstatus = call.CambiarEstatus(noMemorandumImpresion);
                    if (resultadoEstatus != 1) {
                        mensaje.setMensaje("OCURRIO UN ERROR.");
                        mensaje.setDescripcion("NO SE PUDO CAMBIAR ESTATUS");
                        mensaje.setTipo(false);
                        session.setAttribute("mensaje", mensaje);
                    }
                    memorandum = call.buscarMemorandum(noMemorandumImpresion);
                    if (memorandum != null) {
                        DecimalFormat df = new DecimalFormat("#,##0.00");
                        String totalFormateado = df.format(memorandum.getTotal());
    
                        String qrContent = "No. MEMORANDUM: " + memorandum.getNoMemorandum() + "\n"
                                + "FECHA: " + memorandum.getFecha() + "\n"
                                + "IMPORTE TOTAL: " + totalFormateado + "\n";
                        // Especifica la ruta donde se guardará la imagen
                        String filePath = "C:\\DocumentosFacturacion\\MemorandumsGenerales\\"
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

                        request.setAttribute("memorandum", memorandum);
                        request.setAttribute("qrDireccion", filePath);
                        request.setAttribute("recursosFinancieros", recursosFinancieros);
                        request.setAttribute("areaEmisora", areaEmisora);
                        request.setAttribute("gerenciaPresupuestos", gerenciaPresupuestos);
                        request.setAttribute("gerenciaContabilidad", gerenciaContabilidad);
                        request.setAttribute("cliente", cliente);
                        request.getRequestDispatcher("Reportes/reporte_memorandum_individual.jsp").forward(request, response);
                    } else {
                        mensaje.setMensaje("OCURRIO UN ERROR.");
                        mensaje.setDescripcion("NO EXISTE EL MEMORÁNDUM");
                        mensaje.setTipo(false);
                        session.setAttribute("mensaje", mensaje);
                        response.sendRedirect("Srv_MGeneral");
                        return;
                    }

                } catch (Exception ex) {
                    ex.printStackTrace();
                    mensaje.setMensaje("Ocurrio un error en mostrar listas.");
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
                    daoMM = new dao_MGeneral();
                    memlista = daoMM.ImpresionLista(fechaInicio, fechaFin, estatus);
                    request.setAttribute("listaMemorandum", memlista);
                    request.getRequestDispatcher("Reportes/reporte_memorandum_lista.jsp").forward(request, response);
                } catch (Exception ex) {
                    ex.printStackTrace();
                    mensaje.setMensaje("Ocurrio un error en mostrar listas.");
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

            } else if(imprimirRango!=null){
                
                
                
            
            } else {
                mensaje.setMensaje("OCURRIO UN ERROR.");
                mensaje.setDescripcion("NO EXISTE OPCIÓN A REALIZAR");
                mensaje.setTipo(false);
                session.setAttribute("mensaje", mensaje);
                response.sendRedirect("Srv_MGeneral");
                return;
            }

        } else {
            try {

                // Verificar y convertir subtotal
                if (subtotal != null && !subtotal.isEmpty()) {
                    subtotalM = Double.parseDouble(subtotal);
                }

                // Verificar y convertir iva
                if (iva != null && !iva.isEmpty()) {
                    ivaM = Double.parseDouble(iva);
                }

                // Verificar y convertir total
                if (total != null && !total.isEmpty()) {
                    totalM = Double.parseDouble(total);
                }

                // Verificar y convertir retenido
                if (retenido != null && !retenido.isEmpty()) {
                    retenidoM = Double.parseDouble(retenido);
                }
                call = new dao_MGeneral();
                memorandum = new obj_MGeneral();

                memorandum.setIdConcepto(idConcepto);
                memorandum.setNombreConcepto(nombreConcepto);
                memorandum.setIdMemorandum(idMemorandum);
                memorandum.setNoMemorandum(noMemorandum);
                memorandum.setFecha(fecha);
                memorandum.setRemitente(remitente);
                memorandum.setDestinatario(destinatario);
                memorandum.setIdTIngreso(idTipoIngreso);
                memorandum.setConceptoGeneral(conceptoGeneral);
                memorandum.setTotal(totalM);
                memorandum.setRetenido(retenidoM);
                memorandum.setIva(ivaM);
                memorandum.setSubtotal(subtotalM);
                memorandum.setTotalLetras(totalLetras);
                memorandum.setNombreVo(nombreVo);
                memorandum.setPuestoVo(puestoVo);
                memorandum.setNombreAtt(nombreAtt);
                memorandum.setPuestoAtt(puestoAtt);
                memorandum.setUsuario(usuario.getUsuario());
                memorandum.setCancelacion(motivoCancelacion);

                //si no muestra mensaje cambiar por request
                mensaje = call.guardar_memo(act, memorandum);
                session.setAttribute("mensaje", mensaje);

                response.sendRedirect("Srv_MGeneral");
                return;

            } catch (Exception ex) {
                ex.printStackTrace();
                mensaje.setMensaje("Ocurrio un error en procedimiento.");
                mensaje.setDescripcion(ex.getMessage());
                mensaje.setTipo(false);
                request.setAttribute("mensaje", mensaje);
                request.getRequestDispatcher("ErroresGenerales.jsp").forward(request, response);
            } finally {
                if (call != null) {
                    call.closeConnection();
                }
                return;

            }

        }

        //----    
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
