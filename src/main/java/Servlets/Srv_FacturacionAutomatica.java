package Servlets;

import Objetos.obj_Mensaje;
import Objetos.obj_Usuario;
import Objetos.Obj_FacturacionAutomatica;
import Objetos.Obj_ConceptoFactura;
import Objetos.Obj_ImpuestoConcepto;
import Objetos.obj_referenciaPermiso;
import DAO.dao_Usuario;
import DAO.dao_Facturas;
import DAO.dao_ReferenciaPermiso;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
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
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.time.LocalDate;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Ivan Velazquez
 */
@WebServlet("/Srv_FacturacionAutomatica")
public class Srv_FacturacionAutomatica extends HttpServlet implements Servlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        System.out.println("--------------------Ingresa a Srv_FacturacionAutomatica---------------------");
        String act = request.getParameter("action"); //Nombre del grupo de botones o inputs
        obj_Mensaje mensaje = new obj_Mensaje();
        obj_Usuario usuario = null;
        //Lista de usuarios
        dao_Usuario daoUsuario = null;
        dao_Facturas daoFacturas = null;
        List<obj_Usuario>  usuariosLista = null; 
        List<Obj_FacturacionAutomatica>  facturasAutomaticas = null;
        dao_ReferenciaPermiso daoReferenciaPermiso  = null;
        List<obj_referenciaPermiso> listaPermisos = null;
        //TOMA DATOS DEL USUARIO NOMBRE
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(15 * 60);
        usuario = (obj_Usuario) session.getAttribute("usuario");

        if (usuario == null) {
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
        
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        
        Gson gson = new Gson();
        try {
             JsonObject jsonObject = JsonParser.parseString(sb.toString()).getAsJsonObject();
            if(jsonObject != null){
                String action = jsonObject.get("action").getAsString();
                if(action.equals("104")){
                    daoReferenciaPermiso = new dao_ReferenciaPermiso();
                    String monthsStr = jsonObject.get("months").getAsString();
                    
                     String[] months = monthsStr.split(",");
                    
                    String year = jsonObject.get("year").getAsString();
                    String usuarioResponsable = jsonObject.get("userMonths").getAsString();
                    listaPermisos = daoReferenciaPermiso.obtenerPermisos(usuarioResponsable, year, months);
                    
                    JSONArray permisosArray = new JSONArray();
                    for (obj_referenciaPermiso permiso : listaPermisos) {
                        // Convertir cada objeto Permiso a JSONObject
                        JSONObject permisoObject = new JSONObject();
                        permisoObject.put("id", permiso.getIdReferencia());
                        permisoObject.put("permiso", permiso.getPermiso());
                        permisoObject.put("rfc", permiso.getRfcCliente());
                        permisoObject.put("usuarioResponsable", permiso.getUsuario());
                        permisosArray.put(permisoObject);
                    }
                    
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    
                    // Crear el JSONObject de respuesta
                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("permisos", permisosArray);
                    jsonResponse.put("tipomensaje", "Exito");
                    // Escribir la respuesta JSON
                    out.print(jsonResponse.toString());
                    out.flush();
                    out.close();
                        
                }else{
                        daoFacturas = new dao_Facturas();
                        Type encabezadoListType = new TypeToken<List<Obj_FacturacionAutomatica>>(){}.getType();
                        List<Obj_FacturacionAutomatica> listaEncabezado = gson.fromJson(jsonObject.get("listaEncabezado"), encabezadoListType);

                        Type detalleListType = new TypeToken<List<Obj_ConceptoFactura>>(){}.getType();
                        List<Obj_ConceptoFactura> listaDetalle = gson.fromJson(jsonObject.get("listaDetalle"), detalleListType);

                        Type impuestoConceptoListType = new TypeToken<List<Obj_ImpuestoConcepto>>(){}.getType();
                        List<Obj_ImpuestoConcepto> listaImpuestos = gson.fromJson(jsonObject.get("ListaImpuestos"), impuestoConceptoListType);

        //                

                        LocalDate currentDate = LocalDate.now();
                        int monthValue = currentDate.getMonthValue();
                         // Formatear el mes como dos dígitos
                        String formattedMonth = String.format("%02d", monthValue);

                        for (Obj_FacturacionAutomatica encabezadoFactura : listaEncabezado) {
                            int idDetalle = 0,idImporte = 0 ;  
                            int idEncabezado = daoFacturas.saveEncabezadoFacturaAutomatica(encabezadoFactura);
                            int folioEncabezado = encabezadoFactura.getFolio();
                            if(idEncabezado >=1){
                                 for (Obj_ConceptoFactura detalleFactura : listaDetalle){

                                    if(detalleFactura.getRFC().equals(encabezadoFactura.getRFC()) && detalleFactura.getPermiso().equals(encabezadoFactura.getNoPermiso()) && detalleFactura.getFolio() == encabezadoFactura.getFolio()){
                                        idDetalle = daoFacturas.saveDetalleFacturaAutomatica(detalleFactura, idEncabezado,folioEncabezado);
                                    }
                                }

                                for( Obj_ImpuestoConcepto importeFactura : listaImpuestos){
                                    if(importeFactura.getRFC().equals(encabezadoFactura.getRFC()) && importeFactura.getPermiso().equals(encabezadoFactura.getNoPermiso()) && importeFactura.getFolio() == encabezadoFactura.getFolio()){
                                         idImporte = daoFacturas.saveImporteFacturaAutomatica(importeFactura, idEncabezado,folioEncabezado);
                                    }
                                }

                                daoFacturas.updateMonthCreateFactura(encabezadoFactura, formattedMonth);

                            }else{
                                System.out.println("Ocurrio un error al registrar encabezado.");
                            }

                        }
                
                            response.setContentType("application/json");
                            response.setCharacterEncoding("UTF-8");
                            PrintWriter out = response.getWriter();

                            JSONArray messages = new JSONArray();
                            messages.put("Se crearon correctamente las facturas: ");

                            JSONObject jsonResponse = new JSONObject();
                            jsonResponse.put("messages", messages);
                            jsonResponse.put("tipomensaje", "Exito");

                            out.print(jsonResponse.toString());
                            out.flush();
                }
                
                
           }   
        } catch (Exception e) {
            System.out.println(e.getMessage());
           if (e.getMessage().equals("Not a JSON Object: null|#]")) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    JSONArray messages = new JSONArray();
                    messages.put("Ocurrió un error en el procedimiento: " + e.getMessage());

                    JSONObject jsonResponse = new JSONObject();
                    jsonResponse.put("messages", messages);
                    jsonResponse.put("tipomensaje", "Error");

                    out.print(jsonResponse.toString());
                    out.flush();
                } catch (IOException ioException) {
                    // Manejar el error de IO aquí si es necesario
                }
            }
        }
        
    

        //-----------------------------------NO SE HAN SELECCIONADO BOTONES----------------------------------------------
        if (act == null) {
            //Ningún botón ha sido seleccionado
            System.out.println("Srv_FacturacionAutomatica- Ningun boton- Ingresa a TRY");
            try {
                System.out.println("Srv_FacturacionAutomatica- Lista servlet- Ingresa a TRY");
                daoUsuario = new dao_Usuario();
                usuariosLista = daoUsuario.Listar();
                request.setAttribute("usuarios", usuariosLista);

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
            RequestDispatcher rd = request.getRequestDispatcher("Documentos/FacturacionAutomatica.jsp");
            rd.forward(request, response);
            return;
            //--------------------------------------------GUARDAR---------------------------------------------------------------  
        } else {
            try {
                //PARA BUSQUEDA DE FACTURAS POR USUARIO
                if(act.equals("104")){
                    System.out.println("Entro a hacer la busqueda de facturas");
                    daoUsuario = new dao_Usuario();
                    usuariosLista = daoUsuario.Listar();
                    request.setAttribute("usuarios", usuariosLista);
                    
                    String usuarioResponsable = request.getParameter("usuarioResponsable");
                    List<Obj_ConceptoFactura> todosLosConceptos = new ArrayList<>();
                    List<Obj_ImpuestoConcepto> todosLosImpuestos = new ArrayList<>();
                
                        daoFacturas = new dao_Facturas();
                        facturasAutomaticas = daoFacturas.getEncabezadoFacturasAutomaticas(usuarioResponsable.toLowerCase());
                        boolean esPrimeraIteracionDetalle = true;
                        boolean esPrimeraIteracionImpuesto = true;
                        int folioImpuesto = 0;
                        int folioDetalle = 0;

                            for (Obj_FacturacionAutomatica factura : facturasAutomaticas) {
                                String rfc = factura.getRFC();
                                String numeroPermiso = factura.getNoPermiso();

                                // Obtener los detalles de la factura
                                List<Obj_ConceptoFactura> detalleFacturas = daoFacturas.getDetalleFacturasAutomaticas(rfc, numeroPermiso);
                                List<Obj_ImpuestoConcepto> impuestosFacturas = daoFacturas.getImpuestosFacturasAutomaticas(rfc, numeroPermiso);

                                // Actualizar folios de impuestos
                                for (Obj_ImpuestoConcepto impuesto : impuestosFacturas) {
                                    if(impuesto.getRFC().equals(factura.getRFC()) && impuesto.getPermiso().equals(factura.getNoPermiso())){
                                         impuesto.setFolio(factura.getFolio());
                                    }
                                }

                                // Actualizar folios de conceptos
                                for (Obj_ConceptoFactura concepto : detalleFacturas) {
                                   if(concepto.getRFC().equals(factura.getRFC()) && concepto.getPermiso().equals(factura.getNoPermiso())){
                                         concepto.setFolio(factura.getFolio());
                                    }
                                }

                                // Agregar conceptos e impuestos a las listas
                                todosLosConceptos.addAll(detalleFacturas);
                                todosLosImpuestos.addAll(impuestosFacturas);
                            }
                            
                            request.setAttribute("impuestos", todosLosImpuestos); 
                            request.setAttribute("detalles", todosLosConceptos);                                
                            request.setAttribute("facturacionesAutomaticas", facturasAutomaticas);
                        }else if(act.equals("buscarInfoMesesAnteriores")){
                            daoUsuario = new dao_Usuario();
                            usuariosLista = daoUsuario.Listar();
                            request.setAttribute("usuarios", usuariosLista);

                              System.out.println("Entro a hacer la busqueda de facturas");
                              String usuarioResponsable = request.getParameter("usuarioMeses");
                               String[] months = request.getParameterValues("months[]");
                              String year = request.getParameter("year");
                              String permiso = request.getParameter("permiso");
                              String rfc = request.getParameter("rfc");
                              daoFacturas = new dao_Facturas();
             
                               
                               
                        List<Obj_ConceptoFactura> todosLosConceptos = new ArrayList<>();
                        List<Obj_ImpuestoConcepto> todosLosImpuestos = new ArrayList<>();
                        facturasAutomaticas = daoFacturas.getEncabezadoFacturasAutomaticasMesesAnteriores(usuarioResponsable.toLowerCase(), rfc, permiso, months, year);
                        boolean esPrimeraIteracionDetalle = true;
                        boolean esPrimeraIteracionImpuesto = true;
                        int folioImpuesto = 0;
                        int folioDetalle = 0;

                            for (Obj_FacturacionAutomatica factura : facturasAutomaticas) {
                                String rfcEncabezado = factura.getRFC();
                                String numeroPermiso = factura.getNoPermiso();

                                // Obtener los detalles de la factura
                                List<Obj_ConceptoFactura> detalleFacturas = daoFacturas.getDetalleFacturasAutomaticasMesesAnteriores(rfcEncabezado, numeroPermiso, months, year);
                                List<Obj_ImpuestoConcepto> impuestosFacturas = daoFacturas.getImpuestosFacturasAutomaticasMesesAnteriores(rfcEncabezado, numeroPermiso, months, year);

                                // Actualizar folios de impuestos
                                for (Obj_ImpuestoConcepto impuesto : impuestosFacturas) {
                                    if(impuesto.getRFC().equals(factura.getRFC()) && impuesto.getPermiso().equals(factura.getNoPermiso())){
                                         impuesto.setFolio(factura.getFolio());
                                    }
//                                   
                                }

                                // Actualizar folios de conceptos
                                for (Obj_ConceptoFactura concepto : detalleFacturas) {
                                    
                                    if(concepto.getRFC().equals(factura.getRFC()) && concepto.getPermiso().equals(factura.getNoPermiso())){
                                         concepto.setFolio(factura.getFolio());
                                    }
                                    
                                }

                                // Agregar conceptos e impuestos a las listas
                                todosLosConceptos.addAll(detalleFacturas);
                                todosLosImpuestos.addAll(impuestosFacturas);
                            }
                            
                          
                            request.setAttribute("impuestosMeses", todosLosImpuestos); 
                            request.setAttribute("detallesMeses", todosLosConceptos);                                
                            request.setAttribute("facturacionesAutomaticasMeses", facturasAutomaticas);  
                        }
                        RequestDispatcher rd = request.getRequestDispatcher("Documentos/FacturacionAutomatica.jsp");
                        rd.forward(request, response);
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
//                if (call != null) {
//                    call.closeConnection();
//                }
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
