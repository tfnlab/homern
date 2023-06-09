<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.Quote" %>
<%@ page import="com.tfnlab.mysql.QuoteDAO" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.jsp" %>
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
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
        <%@ include file="user.menu.nav.jsp" %>
          <HR>
            <a href="quote.new.jsp" tabindex="2"><i class="fas fa-plus"></i> Quote</a>
          <HR>
            <%
                // Create an instance of the QuoteDAO
                QuoteDAO quoteDAO = new QuoteDAO();


                // Retrieve quotes by username
                List<Quote> quotes;
                try {
                    quotes = quoteDAO.selectQuotesByUsername(username);
                } catch (SQLException e) {
                    out.println("Error retrieving quotes: " + e.getMessage());
                    return;
                }

                for (Quote quote : quotes) {
            %>
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title"><%= quote.getCustomerName() %></h5>
                        <p class="card-text"><strong>Email: </strong><%= quote.getEmail() %></p>
                        <p class="card-text"><strong>Phone Number: </strong><%= quote.getPhoneNumber() %></p>
                        <p class="card-text"><strong>Request Date: </strong><%= quote.getRequestDate() %></p>
                        <p class="card-text"><strong>Product Name: </strong><%= quote.getProductName() %></p>
                        <p class="card-text"><strong>Quantity: </strong><%= quote.getQuantity() %></p>
                        <p class="card-text"><strong>Additional Notes: </strong><%= quote.getAdditionalNotes() %></p>
                        <p class="card-text"><strong>Installation Address: </strong><%= quote.getInstallationAddress() %></p>
                        <p class="card-text"><strong>Roof Type: </strong><%= quote.getRoofType() %></p>
                        <p class="card-text"><strong>Average Monthly Energy Usage: </strong><%= quote.getAvgMonthlyEnergyUsage() %></p>
                        <p class="card-text"><strong>Additional Message: </strong><%= quote.getAdditionalMessage() %></p>
                    </div>
                </div>
            </div>
            <%
                }
            %>
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
