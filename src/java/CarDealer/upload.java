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
import java.util.ArrayList;
import java.util.Collections;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        
        String path=getServletContext().getRealPath(File.separator);
        path=path.substring(0,path.lastIndexOf("build"));
        path=path+"web"+File.separator+"files"+File.separator;
        
        File folder = new File(path);
        File[] listOfFiles = folder.listFiles();
        ArrayList<Integer>array=new ArrayList<Integer>();
        for(int i=0;i<listOfFiles.length;i++){
            String fileName=listOfFiles[i].getName();
            String tmp=fileName.substring(0,fileName.lastIndexOf("."));
            array.add(Integer.parseInt(tmp));
        }
        Collections.sort(array);
        for(int i=0;i<array.size();i++){
            System.out.println(array.get(i));
        }
        Integer x=1;
        int i=0;
        for(Part part:request.getParts()){
            for ( ; i < array.size(); i++,x++) {
                if(x!=array.get(i))break;
            }
            String filePath=path+(x.toString()+".jpeg");
            System.out.println(x+"value");
            InputStream is=part.getInputStream();
            File file=new File(filePath);
            uploadFile(is,file);
            x++;
//            out.print(path);
        }
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
