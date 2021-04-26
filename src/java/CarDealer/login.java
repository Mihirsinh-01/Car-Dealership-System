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
import javax.servlet.http.HttpSession;

/**
 *
 * @author virad
 */
public class login implements Servlet {

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
            String pass=req.getParameter("password");
            System.out.println(name);

            String check="SELECT * FROM CAR.\"LOGIN\" WHERE USERNAME ='"+name+"' and PASSWORD ='"+pass+"'";
            ResultSet rs;
            int flag=0;
            try {
                rs = st.executeQuery(check);
                while(rs.next()){
                    flag=1;
                    HttpServletRequest re=(HttpServletRequest) req;
                    HttpSession session=re.getSession();
                    session.setAttribute("username", name);
                    session.setAttribute("query","SELECT * from CAR.CARINFO WHERE STATUS=true");
                    HttpServletResponse hsr=(HttpServletResponse)res;
                    hsr.sendRedirect("dashboard.jsp");
                }
                if(flag==0){
                    PrintWriter out=res.getWriter();
                    out.print("<script>alert(\"Username or Password is not matching !!!\");</script>");
                    RequestDispatcher rd = req.getRequestDispatcher("login.html");
                    rd.include(req, res);
                }
            } catch (SQLException ex) {
                Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (SQLException ex) {
            System.out.println("klnjk");
        }
        catch(ClassNotFoundException ex){
            System.out.println("hiihih");
        }
    }

    @Override
    public String getServletInfo() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void destroy() {
//        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
