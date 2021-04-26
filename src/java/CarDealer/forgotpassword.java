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
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "forgotpassword", urlPatterns = {"/forgotpassword"})
public class forgotpassword extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            String email=request.getParameter("username");
            
            RequestDispatcher rd = request.getRequestDispatcher("forgotPassword.jsp");
            rd.include(request, response);
            
            out.print("<script>"
                    + "document.getElementById(\"username\").value=\""+ email+"\";"
                    + "</script>");
            boolean flag=false;
            String query="SELECT * FROM CAR.LOGIN WHERE EMAIL='"+email+"'";
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                flag=true;
            }
            if(flag){
                String result;
                final String to = request.getParameter("username");
                final String subject = "One Time Password Verification for Car Dealership System";
                int otp=(int) (Math.random()*(9999-1000)+1000);
                HttpSession hs=request.getSession();
                hs.setAttribute("otp", otp);
                hs.setAttribute("email", email);
                final String messg ="OTP for your Password RESET Request is "+otp;

                final String from = "noreply.cardealership@gmail.com";

                final String pass = "alpqpsj34hdf7343n";

                String host = "smtp.gmail.com";

                Properties props = new Properties();
                props.put("mail.smtp.host", host);
                props.put("mail.transport.protocol", "smtp");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.user", from);
                props.put("mail.password", pass);
                props.put("mail.port", "465");

                Session mailSession= Session.getInstance(props, new javax.mail.Authenticator() {
                         @Override
                         protected javax.mail.PasswordAuthentication getPasswordAuthentication() {

                        return new javax.mail.PasswordAuthentication(from, pass);
                    }
                    });

                try {
                    MimeMessage message = new MimeMessage(mailSession);
                        try {
                            message.setFrom(new InternetAddress(from));
                        } catch (MessagingException ex) {
                            Logger.getLogger(forgotpassword.class.getName()).log(Level.SEVERE, null, ex);
                        }

                    message.addRecipient(Message.RecipientType.TO,
                            new InternetAddress(to));
                    message.setSubject(subject);
                    message.setText(messg);
                    Transport.send(message);
                    result = "Your mail sent successfully....";

                } catch (MessagingException mex) {
                    mex.printStackTrace();
                    result = "Error: unable to send mail....";
                }
                response.sendRedirect("getotp.jsp");
            }
            else{
                out.print("<script>"
                    + "document.getElementById(\"msg1\").innerHTML=\"Email Doesnt Exist !!!\";"
                    + "</script>");
            }
        }
        catch(Exception e){
            
        }
    //Creating a result for getting status that messsage is delivered or not!

    
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
