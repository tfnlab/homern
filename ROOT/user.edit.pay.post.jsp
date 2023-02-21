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
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.Date" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="com.stripe.Stripe"%>
<%@ page import="com.stripe.model.Charge"%>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="com.tfnlab.mysql.CustomerPayment" %>
<%@ page import="com.tfnlab.mysql.CustomerPaymentDao" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Presento - v3.9.1
  * Template URL: https://bootstrapmade.com/presento-bootstrap-corporate-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://js.stripe.com/v3/"></script>

</head>

<body>

      <%@ include file="include.header.jsp" %>

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">Home</a></li>
          <li>Home</li>
        </ol>
        <h2>User</h2>
      </div>
    </section><!-- End Breadcrumbs -->
    <%
    UserDao dao = new UserDao();
    String username = (String) session.getAttribute("username");
    String firstName = request.getParameter("firstName");



    User usernameOBJ = (User) session.getAttribute("usernameOBJ");
    User user = dao.getUserByUsername(username);
    %>
    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Upload Logo</h2>
        <HR>
        <%@ include file="user.menu.nav.jsp" %>
        <HR>
          <%
              APIConfig conf = new APIConfig();
              Stripe.apiKey = conf.getStripe();
          Map<String, Object> chargeParams = new HashMap<>();

          double value = Double.parseDouble(request.getParameter("amount"));
          int amount_int = Math.round((float)value * 100);
          chargeParams.put("amount", amount_int); // $10.00 in cents
          chargeParams.put("currency", "usd");
          chargeParams.put("source", request.getParameter("stripeToken")); // obtained with Stripe.js

          //CHARGE CARD
          Charge charge = Charge.create(chargeParams);


          CustomerPaymentDao cpDao = new CustomerPaymentDao();

          long currentTimeMillis = System.currentTimeMillis();
          Timestamp currentTime = new Timestamp(currentTimeMillis);
          CustomerPayment cp = new CustomerPayment();
          cp.setCustomerId(user.getId());
          cp.setAmount(new BigDecimal(request.getParameter("amount")));
          cp.setTs(currentTime);
          cp.setPaymentDate(new Date(currentTime.getTime()));
          cp.setPaymentMethod("Stripe");
          cp.setPaymentUuid(UUID.randomUUID());
          cp.setTransactionId(charge.getId());
          cpDao.insertCustomerPayment(cp);

          %>
          <%=charge.getStatus()%>


      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->

    <%@ include file="include.footer.jsp" %>

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>
