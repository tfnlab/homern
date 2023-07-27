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
<%@ page import="com.tfnlab.mysql.Payment" %>
<%@ page import="com.tfnlab.mysql.PaymentDao" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.math.BigDecimal" %>
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

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

  <script src="https://js.stripe.com/v3/"></script>

</head>

<body>
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>

    <%
    String firstName = request.getParameter("firstName");



    %>

  <%
    int pId = 0;
    if (request.getParameter("paymentId") != null && !request.getParameter("paymentId").isEmpty()) {
      pId = Integer.parseInt(request.getParameter("paymentId"));
    }
  %>
          <%
                PaymentDao pDao = new PaymentDao();
                Payment payment = pDao.getPayment(pId, username);

              APIConfig conf = new APIConfig();
              Stripe.apiKey = usernameOBJ.getStripe_key();
          Map<String, Object> chargeParams = new HashMap<>();

          double value = Double.parseDouble(payment.getPaymentAmount().toString());
          int amount_int = Math.round((float)value * 100);
          chargeParams.put("amount", amount_int); // $10.00 in cents
          chargeParams.put("currency", "usd");
          chargeParams.put("source", request.getParameter("stripeToken")); // obtained with Stripe.js

          //CHARGE CARD
          Charge charge = Charge.create(chargeParams);
          long currentTimeMillis = System.currentTimeMillis();
          Timestamp currentTime = new Timestamp(currentTimeMillis);

          %>
          <%=charge.getStatus()%>


                      </div>
                      </div>

                      </section><!-- End Blog Section -->

                      </main><!-- End #main -->

  <!-- Vendor JS Files -->

</body>

</html>
