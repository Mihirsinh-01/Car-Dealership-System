/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CarDealer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author virad
 */
@WebServlet(name = "filtering", urlPatterns = {"/filtering"})
public class filtering extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        
        String jdbcurl="jdbc:derby://localhost:1527/CarDealership";
        String username = "car";
        String password = "car";
        String driverclassname = "org.apache.derby.jdbc.ClientDriver";
        
        String company_name=request.getParameter("company_name");
        String model_name=request.getParameter("model_name");
        String t1=request.getParameter("price");
        String price_sort=request.getParameter("price_sort");
        String fuel_type[] = request.getParameterValues("fuel_type");
        
        Double price=-1.0;
        try{
            price=Double.parseDouble(t1);
        }
        catch(NumberFormatException nu){
//            out.print("price null");
        }
//        if(fuel_type==null)out.print("fuel null");
//        if(company_name.equals(""))out.print("company null");
        
//        String fuel_type=request.getParameter("fuel_type");
        
//        for (String fuel_type1 : fuel_type) {
//            out.println(fuel_type1);
//        }
//        
//        
//        out.print(price);
//        out.print(company_name);
//        out.print(model_name);
//        out.print(t1);

        String query="SELECT * FROM CAR.\"CARINFO\" WHERE STATUS=true";
        if(!company_name.equals(""))query+=" and COMPANY_NAME='"+company_name+"'";
        if(!model_name.equals(""))query+=" and MODEL_NAME='"+model_name+"'";
        if(price!=-1.0)query+=" and PRICE<="+price;
        if(fuel_type!=null){
            query+=" and (";
            for (int i=0;i<fuel_type.length;i++) {
                if(i>0)query+=" OR";
                query+=" FUEL_TYPE='"+fuel_type[i]+"'";
            }
            query+=")";
            
        }
        HttpSession session=request.getSession();
        session.setAttribute("query",query);
        response.sendRedirect("dashboard.jsp");
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
