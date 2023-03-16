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
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.tfnlab.mysql.CustomerPayment" %>
<%@ page import="com.tfnlab.mysql.CustomerPaymentDao" %>
<%@ page import="java.math.BigDecimal" %>
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
              <li><a href="user.menu.jsp">Home</a></li>
              <li>Billing Center</li>
        </ol>
      </div>
    </section><!-- End Breadcrumbs -->
    <%
    UserDao dao = new UserDao();
    String firstName = request.getParameter("firstName");



    User user = dao.getUserByUsername(username);
    %>
    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Home Renovation Nation Billing</h2>
        <HR>
        <%@ include file="user.menu.nav.jsp" %>
        <HR>
          <%
          Calendar today = Calendar.getInstance();
          Calendar inputTimestamp = Calendar.getInstance();
          inputTimestamp.setTimeInMillis(user.getTs().getTime());
          long diff = today.getTimeInMillis() - inputTimestamp.getTimeInMillis();
          long diffDays = diff / (24 * 60 * 60 * 1000);
          %>
          <%
            CustomerPaymentDao cpDao = new CustomerPaymentDao();
            List<CustomerPayment> payments = cpDao.getPaymentsByCustomerId(user.getId());

            BigDecimal pTotal  = new BigDecimal("0");
            BigDecimal dTotal = new BigDecimal(Double.toString(diffDays*1.25));
           for (CustomerPayment cp : payments) {
                pTotal = pTotal.add(cp.getAmount());
          }%>

          <form id="payment-form" action="user.edit.pay.post.jsp">
            <div class="form-row">
              <label for="card-element">
                Credit or debit card
              </label>
              <div id="card-element">
                <!-- A Stripe Element will be inserted here. -->
              </div>

              <!-- Used to display form errors. -->
              <div id="card-errors" role="alert"></div>
            </div>
            <HR>
              <div class="amount-container">
                  <h3 class="amount-title">Amount</h3>
                  <div class="amount-details">
                      <div class="total">
                          <span class="label">Total:</span>
                          <span class="value"><%=dTotal%></span>
                      </div>
                      <div class="paid">
                          <span class="label">Paid:</span>
                          <span class="value"><%=pTotal%></span>
                      </div>
                      <div class="due">
                          <span class="label">Due:</span>
                          <span class="value"><%=dTotal.subtract(pTotal)%></span>
                      </div>
                  </div>
              </div>
            <HR>
              <div class="form-group">
                <label for="amount">Payment Amount</label>
                <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text">$</span>
                  </div>
                  <input type="text" class="form-control" id="amount" name="amount" placeholder="0.00" value="<%=dTotal.subtract(pTotal)%>">
                </div>
              </div>
              <HR>
            <HR>
            <button type="submit" class="btn btn-success">Submit Payment</button>
          </form>
          <HR>
          <%=user.getTs()%>
          <HR>
          Member for <a href="user.edit.pay.jsp" ><%=diffDays%></a> Days
          <HR>
      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->
  <script>
    var stripe = Stripe('pk_live_51MOr0QDUDMr9kEdwlALHcoImQwqHdYmr13cSRAcZz7MLezXjbU3iIbvXJDg34SkYxQlewUPW9uCkbFyi2IIXJXot00F7Eu5WxR');
    // Create an instance of Elements.
    var elements = stripe.elements();

    // Custom styling can be passed to options when creating an Element.
    // (Note that this demo uses a wider set of styles than the guide below.)
    var style = {
      base: {
        color: '#32325d',
        fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
        fontSmoothing: 'antialiased',
        fontSize: '16px',
        '::placeholder': {
          color: '#aab7c4'
        }
      },
      invalid: {
        color: '#fa755a',
        iconColor: '#fa755a'
      }
    };

    // Create an instance of the card Element.
    var card = elements.create('card', {style: style});

    // Add an instance of the card Element into the `card-element` <div>.
    card.mount('#card-element');

    // Handle real-time validation errors from the card Element.
    card.addEventListener('change', function(event) {
      var displayError = document.getElementById('card-errors');
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {
        displayError.textContent = '';
      }
    });

    // Handle form submission.
    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
      event.preventDefault();

      stripe.createToken(card).then(function(result) {
        if (result.error) {
          // Inform the customer that there was an error.
          var errorElement = document.getElementById('card-errors');
          errorElement.textContent = result.error.message;
        } else {
          // Send the token to your server.
          stripeTokenHandler(result.token);
        }
      });
    });

    function stripeTokenHandler(token) {
      // Insert the token ID into the form so it gets submitted to the server
      var form = document.getElementById('payment-form');
      var hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'stripeToken');
      hiddenInput.setAttribute('value', token.id);
      form.appendChild(hiddenInput);

      // Submit the form
      form.submit();
    }
  </script>


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
