<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.tfnlab.mysql.Payment" %>
<%@ page import="com.tfnlab.mysql.PaymentDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.mysql.ProductLineItem" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="java.util.UUID" %>
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

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <%
    int eId = 0;
    if (request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty()) {
      eId = Integer.parseInt(request.getParameter("customerId"));
    }
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }
  %>
  <!-- =======================================================
  * Template Name: Presento - v3.9.1
  * Template URL: https://bootstrapmade.com/presento-bootstrap-corporate-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script>
    function callGeo(sk, fNameLink) {
        document.getElementById(fNameLink.substring(0,fNameLink.length-2)).value = sk;
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            let items = this.responseText.split('<ITEM>');
            fNamenew = items[items.length-1];
            fNamenew = removeTrailingSpaces(fNamenew);
            document.getElementById(fNamenew+"lat").value = items[0];
            document.getElementById(fNamenew+"lng").value = items[1];


          }
        };
        const encodedString = encodeURIComponent(sk);
        var urlString = "GeocodingExample.jsp?search=" + encodedString + "&sfor=" + fNameLink;
        xhttp.open("GET", urlString, true);
        xhttp.send();
    }
    function removeTrailingSpaces(str) {
            return str.replace(/\s+$/g, "");
    }
    function callAC(sfor) {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          let items = this.responseText.split('<ITEM>');
          fName = items[items.length-1];
          fName = removeTrailingSpaces(fName);
          for (let i = 0; i < items.length-1; i++) {
            if (items[i].length > 5) {
              let newL = "<li>" + "<a href=\"javascript:void(0)\" onclick=\"callGeo('" + items[i] +"' , '" + fName+ "')\" >" + items[i] + "</a>" + "</li>";
              document.getElementById(fName).innerHTML = document.getElementById(fName).innerHTML  + newL;
            }
          }
        }
      };
      let elName = sfor.name + "ac";
      let search = document.getElementById(sfor.name).value;

      if (search.length > 5) {
        document.getElementById(elName).innerHTML = "";
        var urlString = "GoogleAutocomplete.jsp?search=" + search + "&sfor=" + sfor.name;
        xhttp.open("GET", urlString, true);
        xhttp.send();
      }
    }

  </script>
</head>

<body>

        <main id="main">
          <section id="blog" class="blog">
            <div class="container px-4 px-lg-5">
                <div class="container mt-5">
                  <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>

        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);
                String paymentAmountStr = request.getParameter("paymentAmount");
                SimpleDateFormat defaultDateFormat = new SimpleDateFormat("yyyy-MM-dd");

                Entity entity = new Entity();
                EntityDao ed = new EntityDao();
                PaymentDao pDao = new PaymentDao();
                String remove = request.getParameter("remove");
                if (remove != null && remove.trim().length() > 0) {
                  int pid = 0;
                  if (!request.getParameter("pid").isEmpty()) {
                    pid = Integer.parseInt(request.getParameter("pid"));
                  }
                  pDao.deletePayment(pid,username);
                }
                if (paymentAmountStr != null && paymentAmountStr.trim().length() > 0) {
                      %>
                      <%
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Integer customerId = Integer.parseInt(request.getParameter("customerId"));
                        Date paymentDate = dateFormat.parse("1980-24-10");
                        Date expectedPostDate = dateFormat.parse("1980-24-10");
                        Date effectiveDate = dateFormat.parse("1980-24-10");
                        BigDecimal paymentAmount = BigDecimal.valueOf(Double.parseDouble(request.getParameter("paymentAmount")));
                        BigDecimal totalAmount = BigDecimal.valueOf(Double.parseDouble("0"));
                        String paymentMethod = request.getParameter("paymentMethod");
                        Boolean hasCleared = Boolean.parseBoolean(request.getParameter("hasCleared"));
                        Boolean hasReversed = Boolean.parseBoolean(request.getParameter("hasReversed"));
                        Date createdAt = dateFormat.parse("1980-24-10");
                        Date lastUpdatedAt = dateFormat.parse("1980-24-10");
                        String createdBy = username;
                        Integer lastModifiedBy = 0;

                        if (request.getParameter("paymentDate") != null) {
                            try {
                                paymentDate = dateFormat.parse(request.getParameter("paymentDate"));
                            } catch (ParseException e) {
                                paymentDate = dateFormat.parse("1980-24-10");
                            }
                        }
                        if (request.getParameter("expectedPostDate") != null) {
                            try {
                                expectedPostDate = dateFormat.parse(request.getParameter("expectedPostDate"));
                            } catch (ParseException e) {
                                expectedPostDate = dateFormat.parse("1980-24-10");
                            }
                        }
                        if (request.getParameter("effectiveDate") != null) {
                            try {
                                effectiveDate = dateFormat.parse(request.getParameter("effectiveDate"));
                            } catch (ParseException e) {
                                effectiveDate = dateFormat.parse("1980-24-10");
                            }
                        }
                        if (request.getParameter("createdAt") != null) {
                            try {
                                createdAt = dateFormat.parse(request.getParameter("createdAt"));
                            } catch (ParseException e) {
                                createdAt = dateFormat.parse("1980-24-10");
                            }
                        }
                        if (request.getParameter("lastUpdatedAt") != null) {
                            try {
                                lastUpdatedAt = dateFormat.parse(request.getParameter("lastUpdatedAt"));
                            } catch (ParseException e) {
                                lastUpdatedAt = dateFormat.parse("1980-24-10");
                            }
                        }

                        Payment payment = new Payment(0, customerId, paymentDate, expectedPostDate, effectiveDate, paymentAmount, paymentMethod, hasCleared, hasReversed, createdAt, lastUpdatedAt, createdBy, lastModifiedBy, totalAmount);
                        String uuid = java.util.UUID.randomUUID().toString();
                        payment.setPayment_uuid(uuid);
                        pDao.insertPayment(payment);
                      %>

                        Payment Saved
                      <%
                }
                  entity = ed.getEntityById(eId, username);

        %>
           <%
               ProductLineItemDao plDao = new ProductLineItemDao();
               List<ProductLineItem> pliList = plDao.getProductLineItemsByInvoiceId(orderId);
               BigDecimal invTotal  = new BigDecimal("0");
               for (ProductLineItem plItem : pliList) {
                      invTotal = invTotal.add(plItem.getTotal());
               }
           %>
                  Products Total <%=invTotal%>
        <form action="<%=rootUpdate%>customer.edit.payments.sec.jsp/" method="post">
            <hr>
          <div class="form-group">
            <a href="<%=rootUpdate%>customer.edit.sec.jsp/?customerId=<%= entity.getId() %>" ><%= entity.getId() %> - <%= entity.getFirstName() %> <%= entity.getLastName() %></a>
          </div>
            <input type="hidden" id="customerId" name="customerId" value="<%= entity.getId() %>" />
                      <hr>
          <%= entity.getEmail() %>
          <HR>
          <div class="form-group">
            <label for="phone">Phone</label>
            <input type="tel" class="form-control" id="phone" name="phone" disabled >
          </div>
          <div class="form-group">
            <label for="paymentDate">Payment Date</label>
            <input type="date" class="form-control" id="paymentDate" name="paymentDate" placeholder="Enter payment date" value="<%=defaultDateFormat.format(new Date())%>" >
          </div>
          <div class="form-group">
            <label for="expectedPostDate">Expected Post Date</label>
            <input type="date" class="form-control" id="expectedPostDate" name="expectedPostDate" placeholder="Enter expected post date" value="<%=defaultDateFormat.format(new Date())%>" >
          </div>
          <div class="form-group">
            <label for="effectiveDate">Effective Date </label>
            <input type="date" class="form-control" id="effectiveDate" name="effectiveDate" placeholder="Enter effective date" value="<%=defaultDateFormat.format(new Date())%>" >
          </div>
          <div class="form-group">
            <label for="paymentAmount">Payment Amount</label>
            <input type="number" class="form-control" id="paymentAmount" name="paymentAmount" placeholder="Enter payment amount" value="<%=invTotal%>">
          </div>
          <div class="form-group">
            <label for="paymentMethod">Payment Method</label>
            <input type="text" class="form-control" id="paymentMethod" name="paymentMethod" placeholder="Enter payment method" >
          </div>
              <HR>
          <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="hasCleared" name="hasCleared">
            <label class="form-check-label" for="hasCleared">Has Cleared</label>
          </div>
          <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="hasReversed" name="hasReversed">
                <label class="form-check-label" for="hasReversed">Has Reversed</label>
              </div>
              <HR>
              <button type="submit" class="btn btn-primary">Submit</button>
            </form>
            <HR>
            <%

                List<Payment> pList = pDao.getPayments(eId, username);
                BigDecimal pTotal  = new BigDecimal("0");
                for (Payment pItem : pList) {
                       pTotal = pTotal.add(pItem.getPaymentAmount());
               %>
                   Payment ID: <%= pItem.getPaymentId() %><br>
                    <% if(usernameOBJ.getStripe_key() != null && !usernameOBJ.getStripe_key().equals("")){%>
                            <a href="<%=rootUpdate%>customer.edit.payments.stripe.sec.jsp/?paymentId=<%= pItem.getPaymentId() %>" >Pay With Stripe</a><BR>
                    <% } %>
                   Payment Amount: <%= pItem.getPaymentAmount() %><br>
                   Posted Balance: <%= pItem.getPostTotal() %><br>
                   -- <a href="<%=rootUpdate%>customer.edit.payments.sec.jsp/?remove=yes&customerId=<%=eId%>&pid=<%= pItem.getPaymentId() %>" >remove<a><br>
                   <hr>

            <%
                }
            %>
                  Payments Total: <%=pTotal%>
                </div>
            </div>

          </section><!-- End Blog Section -->

        </main><!-- End #main -->
</body>

</html>
