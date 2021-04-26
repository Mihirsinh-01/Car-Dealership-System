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
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Asus
 */
@WebServlet(name = "otpcheck", urlPatterns = {"/otpcheck"})
public class otpcheck extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        PrintWriter out=response.getWriter();
        
        String jdbcurl="jdbc:derby://localhost:1527/CarDealership";
        String username = "car";
        String password = "car";
        String driverclassname = "org.apache.derby.jdbc.ClientDriver";
        try{
            Class.forName(driverclassname);
            Connection Con = DriverManager.getConnection(jdbcurl, username, password);
            Statement st = Con.createStatement();
            
            int otp=Integer.parseInt(request.getParameter("username"));
            String pass=request.getParameter("password");
            String confirm_pass=request.getParameter("confirmpassword");
            
            RequestDispatcher rd = request.getRequestDispatcher("getotp.jsp");
            rd.include(request, response);

            
            out.print("<script>"
                    + "document.getElementById(\"username\").value=\""+ otp+"\";"
            +"</script>");
            Boolean submit=true;
            HttpSession hs=request.getSession();
            if(otp!=(int)(hs.getAttribute("otp"))){
                submit=false;
                out.print("<script>"
                    + "document.getElementById(\"msg1\").innerHTML=\"OTP Not Matching !!!\";"
                    + "</script>");
            }
            
            if(pass.length()<8){
                submit=false;
                out.print("<script>"
                    + "document.getElementById(\"msg3\").innerHTML=\"Length of password should atleast 8 !!!\";"
                    + "</script>");
            }
            if(!pass.equals(confirm_pass)){
                submit=false;
                out.print("<script>"
                    + "document.getElementById(\"msg4\").innerHTML=\"Password and confirm password should be matched !!!\";"
                    + "</script>");
            }
            if(submit){
                System.out.println("HIIIIII");
                String query1="UPDATE CAR.LOGIN SET PASSWORD='"+pass+"' WHERE EMAIL='"+hs.getAttribute("email")+"'";
                System.out.println(query1);
                st.executeUpdate(query1);
                response.sendRedirect("login.html");
            }
            
        }
        catch(Exception e){
            
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
