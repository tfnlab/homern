<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.disk.*" %>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.ImageRepository" %>
<%@ page import="com.tfnlab.mysql.ImageRepositoryDAO" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.Collection" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.UUID" %>
<%
    String client_request_key = "none";
    String image_type = "none";
%>
<%
  boolean isMultipart = ServletFileUpload.isMultipartContent(request);

  if (isMultipart) {
    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);
    try {
      List<FileItem> items = upload.parseRequest(request);
      ImageRepositoryDAO dao = new ImageRepositoryDAO();
      for (FileItem item : items) {
        if (item.isFormField()) {
            String inputFieldName = item.getFieldName();
            String inputFieldValue = item.getString();
           if (inputFieldName.equals("client_request_key")) {
                client_request_key = inputFieldValue;
           }
           if (inputFieldName.equals("image_type")) {
                image_type = inputFieldValue;
           }

        }
      }

          for (FileItem item : items) {
            if (!item.isFormField()) {

                      APIConfig conf = new APIConfig();
                      String uuid = java.util.UUID.randomUUID().toString();
                      String filepath = conf.getPdfloc();
                      String logofilepath  = filepath + "serverupload." + client_request_key + "." + image_type ;
                      InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
                      FileOutputStream fos = new FileOutputStream(logofilepath);
                      byte[] buffer = new byte[1024];
                      int length;
                      while ((length = fileContent.read(buffer)) > 0) {
                        fos.write(buffer, 0, length);
                      }
                      fos.close();
                      fileContent.close();
                        %>FILE SAVED<%

          }
        }
    } catch (FileUploadException e) {
       %><%=e.getMessage()%><%
    }
  }
%>REQUEST DONE

<!DOCTYPE html>
<html>
<head>
    <title>Image Upload Form</title>
</head>
<body>
    <form action="fileupload.jsp" method="post" enctype="multipart/form-data">
        <input type="hidden" name="MAX_FILE_SIZE" value="1048576" /> <!-- Max file size in bytes -->
        <label for="client_request_key">Client Request Key:</label>
        <input type="text" name="client_request_key" value="<%=UUID.randomUUID().toString()%>"/><br/>

        <label for="image_type">Image Type:</label>
        <input type="text" name="image_type" /><br/>

        <label for="image_file">Image File:</label>
        <input type="file" name="image_file" /><br/>

        <input type="submit" value="Upload Image" />
    </form>
</body>
</html>
