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
        <%
            // Create an instance of the QuoteDAO
            QuoteDAO quoteDAO = new QuoteDAO();

            // Get the form data
            String customerName = request.getParameter("customer_name");

            // Create a new Quote object
            if (customerName != null) {
              String email = request.getParameter("email");
              String phoneNumber = request.getParameter("phone_number");
              String requestDate = request.getParameter("request_date");
              String productName = request.getParameter("product_name");
              String quantityParam = request.getParameter("quantity");
              int quantity = 0; // Default value in case the parameter is null or cannot be parsed

              if (quantityParam != null && !quantityParam.isEmpty()) {
                  try {
                      quantity = Integer.parseInt(quantityParam);
                  } catch (NumberFormatException e) {
                      // Handle the exception if the parameter cannot be parsed as an integer
                      // You can log the error or perform any necessary error handling here
                  }
              }
              String additionalNotes = request.getParameter("additional_notes");
              String installationAddress = request.getParameter("installation_address");
              String roofType = request.getParameter("roof_type");
              int avgMonthlyEnergyUsage = Integer.parseInt(request.getParameter("avg_monthly_energy_usage"));
              String additionalMessage = request.getParameter("additional_message");
              Quote quote = new Quote();
              quote.setCustomerName(customerName);
              quote.setEmail(email);
              quote.setPhoneNumber(phoneNumber);
              quote.setRequestDate(java.sql.Date.valueOf(requestDate));
              quote.setProductName(productName);
              quote.setQuantity(quantity);
              quote.setAdditionalNotes(additionalNotes);
              quote.setInstallationAddress(installationAddress);
              quote.setRoofType(roofType);
              quote.setAvgMonthlyEnergyUsage(avgMonthlyEnergyUsage);
              quote.setAdditionalMessage(additionalMessage);

              try {
                  // Insert the Quote into the database
                  quoteDAO.insertQuote(quote);
                  out.println("Quote saved successfully!");
              } catch (Exception e) {
                  out.println("Error saving the quote: " + e.getMessage());
              }
            }
        %>

            <HR>
              <a href="quote.list.jsp" tabindex="2"><i class="fas fa-list"></i> Quotes</a>
            <HR>
        <%@ include file="user.menu.nav.jsp" %>
          <div class="container mt-5">
            <form action="quote.new.jsp" method="POST">
              <div class="form-group">
                <label for="customer_name">Customer Name:</label>
                <input type="text" class="form-control" id="customer_name" name="customer_name" required>
              </div>
              <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
              </div>
              <div class="form-group">
                <label for="phone_number">Phone Number:</label>
                <input type="text" class="form-control" id="phone_number" name="phone_number" required>
              </div>
              <div class="form-group">
                <label for="request_date">Request Date:</label>
                <input type="date" class="form-control" id="request_date" name="request_date" required>
              </div>
              <div class="form-group">
                <label for="product_name">Product Name:</label>
                <input type="text" class="form-control" id="product_name" name="product_name" required>
              </div>
              <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" required>
              </div>
              <div class="form-group">
                <label for="additional_notes">Additional Notes:</label>
                <textarea class="form-control" id="additional_notes" name="additional_notes"></textarea>
              </div>
              <div class="form-group">
                <label for="installation_address">Installation Address:</label>
                <input type="text" class="form-control" id="installation_address" name="installation_address" required>
              </div>
              <div class="form-group">
                <label for="roof_type">Roof Type:</label>
                <select id="roof_type" name="roof_type" class="form-control" required>
                  <option value="">Select Roof Type</option>
                  <option value="Flat">Flat</option>
                  <option value="Sloped">Sloped</option>
                  <option value="Tile">Tile</option>
                  <option value="Metal">Metal</option>
                  <option value="Other">Other</option>
                </select>
              </div>
              <div class="form-group">
                <label for="avg_monthly_energy_usage">Average Monthly Energy Usage:</label>
                <input type="number" class="form-control" id="avg_monthly_energy_usage" name="avg_monthly_energy_usage" required>
              </div>
              <div class="form-group">
                <label for="additional_message">Additional Message:</label>
                <textarea class="form-control" id="additional_message" name="additional_message"></textarea>
              </div>
              <button type="submit" class="btn btn-primary">Submit</button>
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
