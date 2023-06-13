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
<%@ include file="auth.sec.jsp" %>
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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
    <script src="https://js.stripe.com/v3/"></script>
</head>

<body>


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
    var stripe = Stripe('pk_live_51Mm5XGLLpu03noQ07W153qfNBlwxnviE8UhcLvoSjffhDylJQ2YFUx5dDXVMvNdpIuo7f4UtqtbgppYggfyPioxq00f0KRR4kY');
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






</body>

</html>
