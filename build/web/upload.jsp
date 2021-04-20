<%--<%@page import="org.apache.tomcat.util.http.fileupload.FileItemIterator"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>

<%
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
//   ServletContext context = pageContext.getServletContext();
   String filePath=(String)pageContext.getAttribute("file-upload");
//   String filePath = pageontext.getAttribute("file-upload");

   // Verify the content type
   String contentType = request.getContentType();
   
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      try { 
         // Parse the request to get file items.
         FileItemIterator i=upload.getItemIterator(request);
//         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
//         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () ) {
               // Get the uploaded file parameters
               String fieldName = fi.getFieldName();
               String fileName = fi.getName();
               boolean isInMemory = fi.isInMemory();
               long sizeInBytes = fi.getSize();
            
               // Write the file
               if( fileName.lastIndexOf("\\") >= 0 ) {
                  file = new File( filePath + 
                  fileName.substring( fileName.lastIndexOf("\\"))) ;
               } else {
                  file = new File( filePath + 
                  fileName.substring(fileName.lastIndexOf("\\")+1)) ;
               }
               fi.write( file ) ;
               out.println("Uploaded Filename: " + filePath + 
               fileName + "<br>");
            }
         }
         out.println("</body>");
         out.println("</html>");
      } catch(Exception ex) {
         System.out.println(ex);
      }
   } else {
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>--%>
<%@page import="org.apache.tomcat.util.http.fileupload.RequestContext"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%--<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>  
<%  
    String nam=request.getParameter("name");
    out.print(nam);
    String filePath = "D:\\desktop\\AJ\\CAR\\";
//    MultipartRequest m = new MultipartRequest(request, filePath);
    Integer x=new File(filePath).listFiles().length;
    out.print(x+" successfully uploaded");  
    for (Part part : request.getParts()) {
//            String fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
//            fileName = new File(fileName).getName();
//            part.write(savePath + File.separator + fileName);
        x++;
        out.println(x);
        part.write(filePath+"abc.jpg");
//        part.write(filePath+x.toString()+".jpg");
    }
%>--%>
<%
//try {
               String fname = null;
               String fsize = null;
               String ftype = null;
//               RequestContext re=;
               String filePath = "D:\\desktop\\AJ\\CAR\\";
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest((RequestContext)request);
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        fname = new File(item.getName()).getName();
                        fsize = new Long(item.getSize()).toString();
                        ftype = item.getContentType();
                        out.println("ok");
                        item.write( new File(filePath+ fname));
                    }
                }
               //File uploaded successfully
               request.setAttribute("message", "File Uploaded Successfully");
               request.setAttribute("name", fname);
               request.setAttribute("size", fsize);
               request.setAttribute("type", ftype);
//            } catch (Exception ex) {
//                System.out.println(ex);
//               request.setAttribute("message", "File Upload Failed due to " + ex);
//            }
            %>

<%--<%@page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>  
<%  
    String nam=request.getParameter("name");
    out.print(nam);
    String filePath = "D:\\desktop\\AJ\\CAR\\";
//    MultipartRequest m = new MultipartRequest(request, filePath);
    Integer x=new File(filePath).listFiles().length;
    out.print(x+" successfully uploaded");  
    for (Part part : request.getParts()) {
//            String fileName = extractFileName(part);
            // refines the fileName in case it is an absolute path
//            fileName = new File(fileName).getName();
//            part.write(savePath + File.separator + fileName);
        x++;
        out.println(x);
        part.write(filePath+x.toString()+".jpg");
    }
%>--%>


