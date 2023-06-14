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
<%@ include file="auth.sec.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Home Renovation Nation - Sign-up</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
  </head>
<body>
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>
        <h2>Quotes </h2>
          <HR>
            <a href="<%=rootUpdate%>quote.new.sec.jsp/" tabindex="2"><i class="fas fa-plus"></i> Quote</a>
          <HR>
              <h3>Quote List <a href="<%=rootUpdate%>quote.list.csv.sec.jsp?csv=true" tabindex="2"><i class="fas fa-download"></i> CSV</a></h3>
            <%
                // Create an instance of the QuoteDAO
                QuoteDAO quoteDAO = new QuoteDAO();


                // Retrieve quotes by username
                List<Quote> quotes;
                try {
                    quotes = quoteDAO.selectQuotesByUsername(username);
                } catch (Exception e) {
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
