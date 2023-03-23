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
<%@ include file="auth.jsp" %>
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
          String rootUpdate = "";
          if(rip.equals("144.202.119.205")){
              UserDao uDao = new UserDao();
              username = request.getParameter("username");
              usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
              rootUpdate = "../";
          }
    int orderId = 0;
    String client_request_key = "none";
    String description = "none";
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
            if (inputFieldName.equals("orderId")) {
                orderId = Integer.parseInt(inputFieldValue);
            }
           if (inputFieldName.equals("client_request_key")) {
                client_request_key = inputFieldValue;
           }
           if (inputFieldName.equals("description")) {
                description = inputFieldValue;
           }
           if (inputFieldName.equals("image_type")) {
                image_type = inputFieldValue;
           }

        }
      }

      if(!dao.isClient_request_key(client_request_key)){
          for (FileItem item : items) {
            if (!item.isFormField()) {

                      APIConfig conf = new APIConfig();
                      String uuid = java.util.UUID.randomUUID().toString();
                      String filepath = conf.getPdfloc();
                      String logofilepath  = filepath +  username + "." +  orderId + "." + uuid + ".png";
                      InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
                      FileOutputStream fos = new FileOutputStream(logofilepath);
                      byte[] buffer = new byte[1024];
                      int length;
                      while ((length = fileContent.read(buffer)) > 0) {
                        fos.write(buffer, 0, length);
                      }
                      fos.close();
                      fileContent.close();

                      ImageRepository ir = new ImageRepository();
                      ir.setFilename(uuid);
                      ir.setOrderId(orderId);
                      ir.setUsername(username);
                      ir.setUploadDate(currentTime);
                      ir.setFileType("PNG");
                      ir.setClient_request_key(client_request_key);
                      ir.setDescription(description);
                      ir.setFileSize(1);
                      ir.setType(image_type);
                      dao.insert(ir);
            }
          }
      }
      List<ImageRepository> images = dao.selectByUsernameAndOrderId(username, orderId);
           %>
           <div class="d-flex flex-wrap">
           <%
        for (ImageRepository image : images) {
                %>
                    <div class="d-flex mb-4 mr-4">
                <a href="<%=rootUpdate%>order.edit.images.view.sec.jsp/?filename=<%=image.getFilename()%>&orderId=<%=orderId%>" >
                    <img src="<%=rootUpdate%>order.edit.images.view.sec.jsp/?filename=<%=image.getFilename()%>&orderId=<%=orderId%>" class="img-fluid" alt="Responsive Image" style="width: 100px; height: 100px;" />
                </a>
                    </div>
                <%
        }
            %>
            </div>
            <%
    } catch (FileUploadException e) {
       %><%=e.getMessage()%><%
    }
  }
%>
