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
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author virad
 */
public class register implements Servlet {

    @Override
    public void init(ServletConfig config) throws ServletException {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ServletConfig getServletConfig() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
        res.setContentType("text/html");
        
        String jdbcurl="jdbc:derby://localhost:1527/CarDealership";
        String username = "car";
        String password = "car";
        String driverclassname = "org.apache.derby.jdbc.ClientDriver";
        
        try {
            Class.forName(driverclassname);
            Connection Con = DriverManager.getConnection(jdbcurl, username, password);
            Statement st = Con.createStatement();
        
            System.out.println("Connection Created");

            String name=req.getParameter("username");
            String email=req.getParameter("email");
            String pass=req.getParameter("password");
            String confirm_pass=req.getParameter("confirm_password");
            System.out.println(name);
            System.out.println(email);

            String check="SELECT * FROM CAR.\"LOGIN\" WHERE USERNAME ='"+name+"'";
            ResultSet rs;
            int flag=0;
            try {
                rs = st.executeQuery(check);
                while(rs.next()){
                    flag=1;
                    PrintWriter out=res.getWriter();
                    out.print("<script>alert(\"Username is already exists !!!\");</script>");
                    RequestDispatcher rd = req.getRequestDispatcher("register.html");
                    rd.include(req, res);   
                    break;
                }
            } catch (SQLException ex) {
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }

            if(flag==0){
                String query="INSERT INTO CAR.\"LOGIN\" VALUES('"+name+"','"+pass+"','"+email+"')";
                try {
                    st.executeUpdate(query);
                } catch (SQLException ex) {
                    System.out.println("error");
                }

                RequestDispatcher rd = req.getRequestDispatcher("login.html");
                rd.forward(req, res);
            }
        } catch (SQLException ex) {
            System.out.println("klnjk");
        }
        catch(ClassNotFoundException ex){
            System.out.println("hiihih");
        }
        
    }

    @Override
    public void destroy() {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getServletInfo() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
