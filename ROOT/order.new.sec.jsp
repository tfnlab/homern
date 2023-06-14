<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
            document.getElementById(fNamenew+"zip").value = items[2];
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
    function copyAddress(){
      document.getElementById("billingAddress").value = document.getElementById("shippingAddress").value;
      document.getElementById("billingAddressaclat").value = document.getElementById("shippingAddressaclat").value;
      document.getElementById("billingAddressaclng").value = document.getElementById("shippingAddressaclng").value;
    }
  </script>
</head>

<body>


            <main id="main">
              <section id="blog" class="blog">
                <div class="container px-4 px-lg-5">
                    <div class="container mt-5">
                      <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
        <HR>
        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);




                String shippingAddress = request.getParameter("shippingAddress");
                String billingAddress = request.getParameter("billingAddress");
                String paymentMethod = request.getParameter("paymentMethod");
                String orderName = request.getParameter("orderName");
                String orderDescription = request.getParameter("orderDescription");
                String shippingAddressaclat = request.getParameter("shippingAddressaclat");
                String shippingAddressaclng = request.getParameter("shippingAddressaclng");
                String billingAddressaclat = request.getParameter("billingAddressaclat");
                String billingAddressaclng = request.getParameter("billingAddressaclng");


                String status = request.getParameter("status");
                String uuid = java.util.UUID.randomUUID().toString();



                // Validate form data
                if (orderName != null && orderName.trim().length() > 0) {
                      int orderId = 0;
                      if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
                        orderId = Integer.parseInt(request.getParameter("orderId"));
                      }
                      BigDecimal orderTotal = new BigDecimal("0");
                      if (request.getParameter("orderTotal") != null && !request.getParameter("orderTotal").isEmpty()) {
                        orderTotal = new BigDecimal(request.getParameter("orderTotal"));
                      }
                      if (request.getParameter("shippingAddressaclat") == null || request.getParameter("shippingAddressaclat").isEmpty()) {
                        shippingAddressaclat = "0.0";
                      }
                      if (request.getParameter("shippingAddressaclng") == null || request.getParameter("shippingAddressaclng").isEmpty()) {
                        shippingAddressaclng = "0.0";
                      }
                      if (request.getParameter("billingAddressaclat") == null || request.getParameter("billingAddressaclat").isEmpty()) {
                        billingAddressaclat = "0.0";
                      }
                      if (request.getParameter("billingAddressaclng") == null || request.getParameter("billingAddressaclng").isEmpty()) {
                        billingAddressaclng = "0.0";
                      }

                      BigDecimal shippingAddressEstPrice = new BigDecimal("0");
                      if (request.getParameter("shippingAddressEstPrice") != null && !request.getParameter("shippingAddressEstPrice").isEmpty()) {
                          shippingAddressEstPrice = new BigDecimal(request.getParameter("shippingAddressEstPrice"));
                      }

                      BigDecimal shippingAddressLastSalePrice = new BigDecimal("0");
                      if (request.getParameter("shippingAddressLastSalePrice") != null && !request.getParameter("shippingAddressLastSalePrice").isEmpty()) {
                          shippingAddressLastSalePrice = new BigDecimal(request.getParameter("shippingAddressLastSalePrice"));
                      }

                      BigDecimal shippingAddressEstPriceHigh = new BigDecimal("0");
                      if (request.getParameter("shippingAddressEstPriceHigh") != null && !request.getParameter("shippingAddressEstPriceHigh").isEmpty()) {
                          shippingAddressEstPriceHigh = new BigDecimal(request.getParameter("shippingAddressEstPriceHigh"));
                      }

                      BigDecimal shippingAddressEstPriceLow = new BigDecimal("0");
                      if (request.getParameter("shippingAddressEstPriceLow") != null && !request.getParameter("shippingAddressEstPriceLow").isEmpty()) {
                          shippingAddressEstPriceLow = new BigDecimal(request.getParameter("shippingAddressEstPriceLow"));
                      }

                      Timestamp createdAt = currentTime;
                      Timestamp updatedAt = currentTime;
                      Timestamp deletedAt = currentTime;
                      Date orderDate = new Date();
                      Date shippingDate = new Date();
                      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                        try{
                           orderDate = dateFormat.parse(request.getParameter("orderDate"));
                        } catch (Exception e) {
                           orderDate = new Date(currentTime.getTime());
                        }
                        try{
                          shippingDate = dateFormat.parse(request.getParameter("shipDate"));
                        } catch (Exception e) {
                          shippingDate = new Date(currentTime.getTime());
                        }

                      Order order = new Order(orderId, username, orderDate, shippingDate, shippingAddress, billingAddress, paymentMethod, orderTotal, createdAt, updatedAt, deletedAt, orderName, orderDescription, shippingAddressaclat, shippingAddressaclng, billingAddressaclat, billingAddressaclng, status);
                      order.setShippingAddressEstPrice(shippingAddressEstPrice);
                      order.setShippingAddressLastSalePrice(shippingAddressLastSalePrice);
                      order.setShippingAddressEstPriceHigh(shippingAddressEstPriceHigh);
                      order.setShippingAddressEstPriceLow(shippingAddressEstPriceLow);

                      order.setUuid(uuid);
                      OrderDao dao = new OrderDao();
                      try{
                        dao.insertOrder(order);
                        order = dao.getOrderByUuid(uuid, username);
                      } catch (Exception e) {
                            %><%=e.getMessage()%><%
                      }
                      %>
                        <a href="order.edit.jsp?orderId=<%= order.getOrderId() %>" class="btn btn-primary" tabindex="2" >
                        <div class="alert alert-success" role="alert">
                          Order Saved. ID: <%= order.getOrderId() %>
                        </div>
                        </a>
                      <%
                }else{

        %>
            <!-- ======= Contact Section ======= -->

                <form action="<%=rootUpdate%>order.new.sec.jsp/" method="POST">

                <div class="form-group">
                  <label for="order-status">Order Status</label>
                  <select class="form-control" id="status" name="status">
                  <%
                    String[] statuses = {"Proposal", "Estimate", "Order Placement", "Invoicing", "Payment", "Delivery", "Fulfillment"};
                    for (String sstatus : statuses) {
                  %>
                  <option value="<%= sstatus %>"  ><%= (new Translate()).translate(sstatus, usernameOBJ.getLanguage())%></option>
                  <%
                    }
                  %>
                  </select>
                </div>

                <label for="orderId">Order Name:</label><br>
                <input class="form-control"  type="text" id="orderName" name="orderName" tabindex="2" required ><br>
                <label for="orderId">Order Description:</label><br>
                <textarea class="form-control" id="orderDescription" name="orderDescription" rows="5" tabindex="3"></textarea>
                <label class="form-label" for="textAreaExample">Request Info</label>
                <label for="orderDate">Invoice Date:</label><br>
                <input type="datetime-local" id="orderDate" name="orderDate" placeholder="yyyy-MM-dd" tabindex="4"><br>
                <label for="shipDate">Project Date:</label><br>
                <input type="datetime-local" id="shipDate" name="shipDate" placeholder="yyyy-MM-dd" tabindex="5"><br>
                <label for="shippingAddress">Project Address:</label><br>
                <input class="form-control" type="text" id="shippingAddress" name="shippingAddress" onkeypress="callAC(this)"  tabindex="6"><br>
                <input type="hidden" id="shippingAddressaclat" name="shippingAddressaclat" >
                <input type="hidden" id="shippingAddressaclng" name="shippingAddressaclng" >
                <input type="hidden" id="shippingAddressaczip" name="shippingAddressaczip" >
                <ul id="shippingAddressac" name="shippingAddressac"></ul>
                <hr>
                <label for="billingAddress">Billing Address:</label> <i class="fas fa-copy" onclick="copyAddress()" ></i>  <br>
                <input class="form-control" type="text" id="billingAddress" name="billingAddress" onkeypress="callAC(this)"  tabindex="7"><br>
                <input type="hidden" id="billingAddressaclat" name="billingAddressaclat" >
                <input type="hidden" id="billingAddressaclng" name="billingAddressaclng" >
                <input type="hidden" id="billingAddressaczip" name="billingAddressaczip" >
                <ul id="billingAddressac" name="billingAddressac"></ul>
                <hr>
                <!-- HTML -->
                <div class="form-group">
                  <label for="payment-options">Payment Options</label>
                  <select class="form-control" id="paymentMethod" name="paymentMethod"  tabindex="8">
                    <option value="cash">Cash</option>
                    <option value="check">Check</option>
                    <option value="credit-card">Credit Card</option>
                    <option value="debit-card">Debit Card</option>
                    <option value="electronic-payment">Electronic Payment</option>
                    <option value="paypal">PayPal</option>
                    <option value="google-pay">Google Pay</option>
                    <option value="apple-pay">Apple Pay</option>
                    <option value="bank-transfer">Bank Transfer</option>
                    <option value="money-order">Money Order</option>
                    <option value="gift-card">Gift Card</option>
                    <option value="cryptocurrency">Cryptocurrency</option>
                    <option value="doge">Doge</option>
                    <option value="bitcoin">Bitcoin</option>
                    <option value="eth">ETH</option>
                    <option value="zelle">Zelle</option>
                  </select>
                </div>

                <label for="orderTotal">Order Total:</label><br>
                <input type="text" id="orderTotal" name="orderTotal"  tabindex="9"><br>
                <HR>
                <div class="form-group">
                  <label for="shippingAddressEstPrice">Estimated Price:</label>
                  <input type="number" class="form-control" id="shippingAddressEstPrice" name="shippingAddressEstPrice" step="0.01" tabindex="9">
                </div>

                <div class="form-group">
                  <label for="shippingAddressLastSalePrice">Last Sale Price:</label>
                  <input type="number" class="form-control" id="shippingAddressLastSalePrice" name="shippingAddressLastSalePrice" step="0.01" tabindex="10">
                </div>

                <div class="form-group">
                  <label for="shippingAddressEstPriceHigh">Estimated High Price:</label>
                  <input type="number" class="form-control" id="shippingAddressEstPriceHigh" name="shippingAddressEstPriceHigh" step="0.01" tabindex="11">
                </div>

                <div class="form-group">
                  <label for="shippingAddressEstPriceLow">Estimated Low Price:</label>
                  <input type="number" class="form-control" id="shippingAddressEstPriceLow" name="shippingAddressEstPriceLow" step="0.01" tabindex="12">
                </div>
                <HR>


                <input type="submit" value="Submit"  tabindex="10" class="btn btn-primary" >
                  	</form>

                 <%}%>

                               </div>
                               </div>

                               </section><!-- End Blog Section -->

                               </main><!-- End #main -->
</body>

</html>
