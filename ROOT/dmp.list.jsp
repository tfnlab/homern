<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.disk.*" %>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.math.BigDecimal" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.ProductDashBoard" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ include file="auth.jsp" %>
<%
          User user = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
          String uuid = java.util.UUID.randomUUID().toString();

%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <%@ include file="include.header.jsp" %>
  <main id="main">
    <section class="breadcrumbs">
      <div class="container">
        <ol>
          <li><a href="user.menu.jsp">Home</a></li>
          <li>Service Operations Center</li>
        </ol>
      </div>
    </section>
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Template</h2>
        <HR>
        <%@ include file="user.menu.nav.jsp" %>

        <%
          boolean isMultipart = ServletFileUpload.isMultipartContent(request);
          if (isMultipart) {
              APIConfig conf = new APIConfig();

              String filepath = conf.getPdfloc();
              DiskFileItemFactory factory = new DiskFileItemFactory();
              factory.setSizeThreshold(1024 * 1024); // Set the size threshold for storing files in memory
              factory.setRepository(new File(filepath)); // Set the repository location for temporarily storing files
              ServletFileUpload upload = new ServletFileUpload(factory);
              List<FileItem> items = upload.parseRequest(request);
              String  filename = uuid + "." + username + ".csv";
              for (FileItem item : items) {
                if (!item.isFormField()) { // Check if the item is an uploaded file
                  InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
                  // Save the file to a local directory or database, or process the contents in some other way
                  //String fileName = item.getName(); // Get the original file name
                  FileOutputStream fos = new FileOutputStream(filepath  +  "dmp." + filename);
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
            %>
          <div class="container mt-5">
                    Data Management Platform
                    <HR>
                    <form method="post" action="dmp.list.jsp" enctype="multipart/form-data">
                      <input type="file" name="file" />
                      <input type="submit" value="Upload" />
                    </form>
          </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
  <%@ include file="include.footer.jsp" %>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/js/main.js"></script>
</body>
</html>
