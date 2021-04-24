/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package CarDealer;

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
//        for(int i=0;i<array.size();i++){
//            System.out.println(array.get(i));
//        }
        Integer x=1;
        int i=0;
        for(Part part:request.getParts()){
            if(!part.getName().equals("file1") && !part.getName().equals("file2"))continue;
            for ( ; i < array.size(); i++,x++) {
                if(x!=array.get(i))break;
            }
            String filePath=path+(x.toString()+".jpeg");
            if(!part.getName().equals("file1")){
                car_image_array.add(x.toString()+".jpeg");
            }
            else{
                display_img=x.toString()+".jpeg";
            }
            
//            System.out.println(x+"value");
            InputStream is=part.getInputStream();
            File file=new File(filePath);
            uploadFile(is,file);
            x++;
//            out.print(path);
        }
        
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
                    RequestDispatcher rd = request.getRequestDispatcher("sellingForm.jsp");
                    rd.include(request, response);
                }
                else{
                    String car_image=String.join(";",car_image_array); 
                    String query="INSERT INTO CAR.\"CARINFO\" VALUES('"+number_plate+"','"+u_name+"',true,"+model_year+
                           ",'"+company_name+"','"+model_name+"',"+mileage+",'"+car_image+"',"+price+","+kilometer+",'"+fuel_type+"','"+display_img+"')";
                   
                    try {
                        st.executeUpdate(query);
                    } catch (SQLException ex) {
                        System.out.println(query);
                        System.out.println("error");
                    }

                    RequestDispatcher rd = request.getRequestDispatcher("sellingForm.jsp");
                    rd.forward(request, response); 
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
        
        
//        System.out.println("chalu ayathi");
//        System.out.println(number_plate);
//        System.out.println(model_year);
//        System.out.println(company_name);
//        System.out.println(model_name);
//        System.out.println(mileage);
//        System.out.println(price);
//        System.out.println(kilometer);
        
        
        RequestDispatcher rd=request.getRequestDispatcher("sellingForm.jsp");
        rd.include(request, response);
        
        
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
