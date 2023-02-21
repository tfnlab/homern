<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%
UserDao dao = new UserDao();
String username = (String) session.getAttribute("username");
String firstName = request.getParameter("firstName");

int orderId = 0;
if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
  orderId = Integer.parseInt(request.getParameter("orderId"));
}
int customerId = 0;
if (!request.getParameter("customerId").isEmpty()) {
  customerId = Integer.parseInt(request.getParameter("customerId"));
}

User usernameOBJ = (User) session.getAttribute("usernameOBJ");
User user = dao.getUserByUsername(username);
%>
<%
  boolean isMultipart = ServletFileUpload.isMultipartContent(request);
  if (isMultipart) {
      APIConfig conf = new APIConfig();
      String filename = username + "."+ orderId + "." + customerId + ".png";
      String filepath = conf.getPdfloc();

      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(1024 * 1024); // Set the size threshold for storing files in memory
      factory.setRepository(new File(filepath)); // Set the repository location for temporarily storing files
      ServletFileUpload upload = new ServletFileUpload(factory);
      List<FileItem> items = upload.parseRequest(request);
      for (FileItem item : items) {
        if (!item.isFormField()) { // Check if the item is an uploaded file
          InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
          // Save the file to a local directory or database, or process the contents in some other way
          //String fileName = item.getName(); // Get the original file name
          FileOutputStream fos = new FileOutputStream(filepath  +  "order.customer.signature." + filename);
          byte[] buffer = new byte[1024];
          int length;
          while ((length = fileContent.read(buffer)) > 0) {
            fos.write(buffer, 0, length);
          }
          fos.close();
          fileContent.close();
        }
      }
  }
    %>File Save WOOHOO <%=request.getParameter("orderId")%>
