/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CarDealer;

import static CarDealer.register.username_validation2;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import static org.apache.catalina.connector.InputBuffer.DEFAULT_BUFFER_SIZE;

/**
 *
 * @author virad
 */
@MultipartConfig
public class upload extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session=request.getSession();
        String u_name=(String)session.getAttribute("username");
        
        Boolean submit=true;
        
        String jdbcurl="jdbc:derby://localhost:1527/CarDealership";
        String username = "car";
        String password = "car";
        String driverclassname = "org.apache.derby.jdbc.ClientDriver";
        
        String number_plate=request.getParameter("number_plate");
        String t1=request.getParameter("model_year");
        String company_name=request.getParameter("company_name");
        String model_name=request.getParameter("model_name");
        String t2=request.getParameter("mileage");
        String t3=request.getParameter("price");
        String t4=request.getParameter("kilometer");
        String fuel_type=request.getParameter("fuel_type");
        String display_img="";
        Integer model_year=Integer.parseInt(t1);
        Double mileage=Double.parseDouble(t2);
        Double price=Double.parseDouble(t3);
        Integer kilometer=Integer.parseInt(t4);
        
        RequestDispatcher rd = request.getRequestDispatcher("sellingForm.jsp");
        rd.include(request, response);
        
        out.print("<script>"
                    + "document.getElementById(\"company_name\").value=\""+company_name+"\";"
                    + "document.getElementById(\"model_name\").value=\""+ model_name+"\";"
                    + "document.getElementById(\"price\").value=\""+price+"\";"
                    + "document.getElementById(\"kilometer\").value=\""+kilometer+"\";"
                    + "document.getElementById(\"number_plate\").value=\""+number_plate+"\";"
                    + "document.getElementById(\"model_year\").value=\""+model_year+"\";"
                    + "document.getElementById(\"mileage\").value=\""+mileage+"\";"
                    + "</script>");
        
        if(fuel_type.equals("Petrol"))out.print("<script>document.getElementById(\"petrol\").checked=true;</script>");
	else if(fuel_type.equals("Diesel"))out.print("<script>document.getElementById(\"diesel\").checked=true;</script>");
        else out.print("<script>document.getElementById(\"cng\").checked=true;</script>");
        
        if(!company_validation(company_name)){
            submit=false;
            out.print("<script>"
                + "var x=document.getElementById(\"msg3\");"
                + " x.style.visibility = 'visible';"
                + "</script>");
        }
        if(!model_validation(model_name)){
            submit=false;
            out.print("<script>"
                + "var x=document.getElementById(\"msg4\");"
                + " x.style.visibility = 'visible';"
                + "</script>");
        }
        if(!plate_validation(number_plate)){
            submit=false;
            out.print("<script>"
                + "var x=document.getElementById(\"msg7\");"
                + " x.style.visibility = 'visible';"
                + "</script>");
        }
        
        
        String path=getServletContext().getRealPath(File.separator);
        path=path.substring(0,path.lastIndexOf("build"));
        path=path+"web"+File.separator+"files"+File.separator;
        
        File folder = new File(path);
        File[] listOfFiles = folder.listFiles();
        ArrayList<Integer>array=new ArrayList<Integer>();
        ArrayList<String>car_image_array=new ArrayList<String>();
        for(int i=0;i<listOfFiles.length;i++){
            String fileName=listOfFiles[i].getName();
            String tmp=fileName.substring(0,fileName.lastIndexOf("."));
            array.add(Integer.parseInt(tmp));
        }
        Collections.sort(array);
//        
        for(Part part:request.getParts()){
            if(!part.getName().equals("file1") && !part.getName().equals("file2"))continue;
            boolean flag=true;
            for (String cd : part.getHeader("content-disposition").split(";")) {
                if (cd.trim().startsWith("filename")) {
                    String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                    filename=filename.toLowerCase();
                    System.out.println(filename);
                    if(!filename.trim().endsWith(".png") && !filename.trim().endsWith(".jpg") && !filename.trim().endsWith(".jpeg")){
                        submit=false;
                        flag=false;
                    }
                }
            }
            if(!flag){
                submit=false;
                if(part.getName().equals("file1")){
                    out.print("<script>"
                        + "var x=document.getElementById(\"msg1\");"
                        + "x.style.visibility = 'visible';"
                        + "</script>");
                }
                else{
                    out.print("<script>"
                        + "var x=document.getElementById(\"msg2\");"
                        + "x.style.visibility = 'visible';"
                        + "</script>");
                }   
            }
            
        }
        if(submit){
            try {
                Class.forName(driverclassname);
                Connection Con = DriverManager.getConnection(jdbcurl, username, password);
                Statement st = Con.createStatement();

                System.out.println("Connection Created");

                String check="SELECT * FROM CAR.\"CARINFO\" WHERE USERNAME ='"+u_name+"' and NUMBER_PLATE='"+number_plate+"' and STATUS=true";
                ResultSet rs;
                int flag=0;
                try {
                    rs = st.executeQuery(check);
                    while(rs.next()){
                        flag=1;
                        break;
                    }
                    if(flag==1){
                        out.print("<script>alert(\"This car is already in sell !!!\");</script>");
                    }
                    else{
                        Integer x=1;
                        int i=0;
                        for(Part part:request.getParts()){
                            if(!part.getName().equals("file1") && !part.getName().equals("file2"))continue;
                            for ( ; i < array.size(); i++,x++) {
                                if(x!=array.get(i))break;
                            }
                            String extension="no";
                            for (String cd : part.getHeader("content-disposition").split(";")) {
                                if (cd.trim().startsWith("filename")) {
                                    String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                                    filename=filename.toLowerCase();
                                    System.out.println(filename);
                //                    return filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
                                    if (filename.trim().endsWith(".png")){
                                        extension=".png";
                                    }
                                    else if (filename.trim().endsWith(".jpg")){
                                        extension=".jpg";
                                    }
                                    else if (filename.trim().endsWith(".jpeg")){
                                        extension=".jpeg";
                                    }
                                }
                //                System.out.println(cd);
                            }

                            String filePath=path+(x.toString()+extension);
                            if(part.getName().equals("file1")){
                                display_img=x.toString()+extension;
                            }
                            car_image_array.add(x.toString()+extension);
                            

                //            System.out.println(x+"value");
                            InputStream is=part.getInputStream();
                            File file=new File(filePath);
                            uploadFile(is,file);
                            x++;
                //            out.print(path);
                        }
                        String car_image=String.join(";",car_image_array); 
                        String query="INSERT INTO CAR.\"CARINFO\" VALUES('"+number_plate+"','"+u_name+"',true,"+model_year+
                               ",'"+company_name+"','"+model_name+"',"+mileage+",'"+car_image+"',"+price+","+kilometer+",'"+fuel_type+"','"+display_img+"')";

                        try {
                            st.executeUpdate(query);
                            response.sendRedirect("dashboard.jsp");
                        } catch (SQLException ex) {
                            System.out.println(query);
                            System.out.println("error");
                        }                        

                    }

                } catch (SQLException ex) {
                    Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
                }
            } catch (SQLException ex) {
    //            System.out.println("klnjk");
            }
            catch(ClassNotFoundException ex){
    //            System.out.println("hiihih");
            }
        }
        
        
//        System.out.println("chalu ayathi");
//        System.out.println(number_plate);
//        System.out.println(model_year);
//        System.out.println(company_name);
//        System.out.println(model_name);
//        System.out.println(mileage);
//        System.out.println(price);
//        System.out.println(kilometer);
        
        
        
        
        
    }
    public void uploadFile(InputStream is,File file) throws FileNotFoundException, IOException{
         try (FileOutputStream outputStream = new FileOutputStream(file, false)) {
            int read;
            byte[] bytes = new byte[DEFAULT_BUFFER_SIZE];
            while ((read = is.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }
    }
    static boolean company_validation(String company) {
        String regex = "^[a-zA-Z]+$";
        return company.matches(regex);
    }
    
    static boolean model_validation(String model) {
        String regex = "^[a-zA-Z0-9 ]+$";
        return model.matches(regex);
    }
    
    static boolean plate_validation(String plate) {
        String regex = "^[a-zA-Z][a-zA-Z][0-9][0-9][a-zA-Z][a-zA-Z][0-9][0-9][0-9][0-9]$";
        return plate.matches(regex);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
