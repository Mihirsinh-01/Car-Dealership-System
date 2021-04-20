<html>
   <head>
      <title>File Uploading Form</title>
   </head>
   
   <body>
      <h3>File Upload:</h3>
      Select a file to upload: <br />
      <form action = "upload" method = "post"
         enctype = "multipart/form-data">
          <input type = "file" name = "file" multiple/>
         <br />
         <input type = "submit" value = "Upload File" />
      </form>
      <form action="fetch.jsp">
          <input type = "text" name = "name" /><br/>
          <input type = "submit" value = "Fill the data" />
      </form>
     
   </body>
   
</html>