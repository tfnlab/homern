<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.jsp" %>
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
          String rootUpdate = "";
          if(rip.equals("144.202.119.205")){
              UserDao uDao = new UserDao();
              username = request.getParameter("username");
              usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
              rootUpdate = "../";
          }
%>
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
  OrderDao dao = new OrderDao();

  int orderId = 0;
  if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
    orderId = Integer.parseInt(request.getParameter("orderId"));
  }
%>
  <script>
    function callCoreLocator(sk) {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            alert(this.responseText);
//          let items = this.responseText.split('<ITEM>');
//          fNamenew = items[items.length-1];
//          fNamenew = removeTrailingSpaces(fNamenew);
//          document.getElementById(fNamenew+"lat").value = items[0];
//          document.getElementById(fNamenew+"lng").value = items[1];
//          document.getElementById(fNamenew+"zip").value = items[2];
        }
      };
      myString = document.getElementById(sk.slice(0, -2)).value.replace("Los Angeles", "");
      const encodedString = encodeURIComponent(myString);
      var urlString = "corelogic.jsp?search=" + encodedString + "&zip=" + document.getElementById(sk+"zip").value;
      xhttp.open("GET", urlString, true);
      xhttp.send();

    }
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
            callCoreLocator(fNamenew);
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
    function getCom() {
      var orderId = <%=orderId%>;
      var url = "order.edit.com.jsp?orderId=" + orderId +  "&comType=greeting";
      window.open(url, "_self");
    }
    function getSchedule() {
      var orderId = <%=orderId%>;
      var url = "order.edit.schedule.jsp?orderId=" + orderId ;
      window.open(url, "_self");
    }
    function getProducts() {
      var orderId = <%=orderId%>;
      var url = "order.edit.products.jsp?orderId=" + orderId ;
      window.open(url, "_self");
    }
    function getDiscounts() {
      var orderId = <%=orderId%>;
      var url = "order.edit.discounts.jsp?orderId=" + orderId ;
      window.open(url, "_self");
    }

    function getCustomers() {
      var orderId = <%=orderId%>;
      var url = "order.edit.customers.jsp?orderId=" + orderId ;
      window.open(url, "_self");
    }
    function getPayments() {
      var orderId = <%=orderId%>;
      var url = "order.edit.payments.jsp?orderId=" + orderId ;
      window.open(url, "_self");
    }
    function getRebates() {
      var orderId = <%=orderId%>;
      var url = "order.edit.rebates.jsp?orderId=" + orderId ;
      window.open(url, "_self");
    }
    function getImages() {
      var orderId = <%=orderId%>;
      var url = "order.edit.images.jsp?orderId=" + orderId ;
      window.open(url, "_self");
    }

    function calculateFee(){
        var select = document.getElementById("paymentMethod");
        var selectedValue = select.options[select.selectedIndex].value;
        if(selectedValue == "stripe"){
            var amount = document.getElementById("orderTotal").value;
            var amount_percentage = <%=usernameOBJ.getStripe_fee()%>;
            var finalAmount = amount / (1 - (amount_percentage / 100));
            document.getElementById("orderTotalAfterFee").value = finalAmount.toFixed(2);
        }else{
            var amount = document.getElementById("orderTotal").value;
            document.getElementById("orderTotalAfterFee").value = amount;
        }
    }

    window.onload = function() {
        calculateFee();
    };
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
                          <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
        <HR>
        <h2>Order <%=orderId%></h2>
        <hr>
          <button class="btn btn-primary" onclick="getCom()"  tabindex="3"><i class="fas fa-envelope-open-text"></i> Message</button>
          <button class="btn btn-primary" onclick="getCustomers()" tabindex="4"><i class="fas fa-user-tie"></i> Customer</button>
          <button class="btn btn-primary" onclick="getSchedule()" tabindex="5"><i class="fas fa-calendar-alt"></i> Event</button>
          <button class="btn btn-primary" onclick="getDiscounts()" tabindex="6"><i class="fas fa-tags"></i> Discount</button>
          <button class="btn btn-primary" onclick="getRebates()" tabindex="7"><i class="fas fa-percentage"></i> Rebate</button>
          <button class="btn btn-primary" onclick="getProducts()" tabindex="8"><i class="fas fa-file-invoice"></i> Invoice</button>
          <button class="btn btn-primary" onclick="getPayments()" tabindex="9"><i class="fas fa-money-bill-alt"></i> Payment</button>
          <button class="btn btn-primary" onclick="getImages()" tabindex="10"><i class="fas fa-images"></i> Image</button>
        <hr>

        <%

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                String shippingAddress = request.getParameter("shippingAddress");
                // Validate form data
                String orderName = request.getParameter("orderName");
                if (orderName != null && orderName.trim().length() > 0) {

                      long currentTimeMillis = System.currentTimeMillis();
                      Timestamp currentTime = new Timestamp(currentTimeMillis);
                      String shippingAddressaclat = request.getParameter("shippingAddressaclat");
                      String shippingAddressaclng = request.getParameter("shippingAddressaclng");
                      String billingAddress = request.getParameter("billingAddress");
                      String billingAddressaclat = request.getParameter("billingAddressaclat");
                      String billingAddressaclng = request.getParameter("billingAddressaclng");
                      String paymentMethod = request.getParameter("paymentMethod");
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
                      Date orderDate = new Date();
                      Date shippingDate = new Date();
                        try{
                           orderDate = dateFormat.parse(request.getParameter("orderDate"));
                           shippingDate = dateFormat.parse(request.getParameter("shipDate"));
                        } catch (Exception e) {
                          %><%="Error parsing date and time string: " + e.getMessage()%><%
                      }
                      Timestamp createdAt = currentTime;
                      Timestamp updatedAt = currentTime;
                      Timestamp deletedAt = currentTime;
                      String orderDescription = request.getParameter("orderDescription");
                      String status = request.getParameter("status");
                      Order order = new Order(orderId, username, orderDate, shippingDate, shippingAddress, billingAddress, paymentMethod, orderTotal, createdAt, updatedAt, deletedAt, orderName, orderDescription, shippingAddressaclat, shippingAddressaclng, billingAddressaclat, billingAddressaclng, status);
                      order.setShippingAddressEstPrice(shippingAddressEstPrice);
                      order.setShippingAddressLastSalePrice(shippingAddressLastSalePrice);
                      order.setShippingAddressEstPriceHigh(shippingAddressEstPriceHigh);
                      order.setShippingAddressEstPriceLow(shippingAddressEstPriceLow);
                      dao.updateOrder(order);

                }
        %>
        <%
          Order order = dao.getOrderByOrderId(orderId, username);

            String currentStatus = order.getStatus();
        %>
        <!-- ======= Contact Section ======= -->

        <form action="order.edit.jsp" method="POST">
          <div class="form-group">
            <label for="order-status">Order Status</label>
            <select class="form-control" id="status" name="status">
              <%
                String[] statuses = {"Proposal", "Estimate", "Order Placement", "Invoicing", "Payment", "Delivery", "Fulfillment"};
                for (String sstatus : statuses) {
              %>
              <option value="<%= sstatus %>" <%= sstatus.equals(currentStatus) ? "selected" : "" %>><%= (new Translate()).translate(sstatus, usernameOBJ.getLanguage())%></option>
              <%
                }
              %>
            </select>
          </div>
                 <%
                    SimpleDateFormat formatterHH = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                 %>
          <label for="orderId">Order Name:</label><br>
          <input class="form-control" type="text" id="orderName" name="orderName" value="<%= order.getOrderName() %>"  tabindex="8"><br>
          <label for="orderId">Order Description:</label><br>
          <textarea class="form-control" id="orderDescription" name="orderDescription" rows="5"  tabindex="9"><%= order.getOrderDescription() %></textarea>
          <input type="hidden" id="orderId" name="orderId" value="<%= order.getOrderId() %>">
          <div class="form-group">
            <label for="endTime">Invoice Date:</label>
            <input type="datetime-local" class="form-control" name="orderDate" value="<%= formatterHH.format(order.getOrderDate()) %>" datepicker  tabindex="10">
          </div>
          <label for="shipDate">Project Date:</label><br>
          <input class="form-control" type="datetime-local" id="shipDate" name="shipDate" placeholder="yyyy-MM-dd" value="<%= formatterHH.format(order.getShipDate()) %>"  tabindex="11"><br>
          <label for="shippingAddress">Project Address:</label><br>
          <input class="form-control" type="text" id="shippingAddress" name="shippingAddress" value="<%= order.getShippingAddress() %>" onkeypress="callAC(this)"  tabindex="12"><br>
          <input type="hidden" id="shippingAddressaclat" name="shippingAddressaclat" value="<%= order.getShippingAddresslat() %>">
          <input type="hidden" id="shippingAddressaclng" name="shippingAddressaclng" value="<%= order.getShippingAddresslng() %>">
          <input type="hidden" id="shippingAddressaczip" name="shippingAddressaczip" value="" >
          <ul id="shippingAddressac" name="shippingAddressac"></ul>
          <hr>
            <%
              String uAddPls = usernameOBJ.getAddress().replace(" ", "+");
            if(usernameOBJ!=null && usernameOBJ.getAddress() !=null){
              String sAddSpcS = order.getShippingAddress().replace(" ", "-");
              String sAddPlsS = order.getShippingAddress().replace(" ", "+");
              String sAddEncS = URLDecoder.decode(order.getShippingAddress(), "UTF-8");

              String uAddEnc = URLDecoder.decode(usernameOBJ.getAddress(), "UTF-8");
                    %>
                    <a href="https://www.google.com/maps/search/?api=1&query=<%=sAddEncS%>">Google</a> |
                    <a href="https://maps.apple.com/?address=<%=sAddEncS%>">Apple</a> |
                    <a href="https://www.waze.com/en/directions?navigate=yes&latlng=<%=order.getShippingAddresslat()%>,<%=order.getShippingAddresslng()%>">Waze</a> |
                    <a href="https://wego.here.com/directions/mix//<%=sAddSpcS%>:e-eyJuYW1lIjoiMTMyNSBOLCBMYW1lciBBdmUsIEJ1cmJhaywgQ0EgOTA4NTAiLCJhZGRyZXNzIjoiMTMyNSBOLCBMYW1lciBBdmUsIEJ1cmJhaywgQ0EgOTA4NTAiLCJsYXRpdHVkZSI6MzQuMTgzNjYyLCJsb25naXR1ZGUiOi0xMTguMzI2MTAyfQ==?map=<%=order.getShippingAddresslat()%>,<%=order.getShippingAddresslng()%>,15,normal">HERE</a> |
                    <a href="https://www.bing.com/maps?osid=a8d44b60-4f0c-4e4a-b9c7-3a3b3f597628&cp=<%=order.getShippingAddresslat()%>~<%=order.getShippingAddresslng()%>&lvl=15&style=r">Bing</a> |
                    <a href="https://www.openstreetmap.org/search?query=<%=sAddEncS%>"#map=15/<%=order.getShippingAddresslat()%>/<%=order.getShippingAddresslng()%>">OSM</a> |
                    <a href="https://www.tomtom.com/en_gb/maps/maps/point?lat=<%=order.getShippingAddresslat()%>&lon=<%=order.getShippingAddresslng()%>">TomTom</a>
                    <hr>
                    <a href="https://www.google.com/maps/dir/?api=1&origin=<%=uAddPls%>&destination=<%=sAddPlsS%>">Get directions</a>
              <%
                  }
              %>

          <hr>

          <label for="billingAddress">Billing Address: <i class="fas fa-copy" onclick="copyAddress()" ></i> </label> <br>
          <input class="form-control" type="text" id="billingAddress" name="billingAddress" value="<%= order.getBillingAddress() %>" onkeypress="callAC(this)"  tabindex="13"><br>
          <input type="hidden" id="billingAddressaclat" name="billingAddressaclat" value="<%= order.getBillingAddresslat() %>">
          <input type="hidden" id="billingAddressaclng" name="billingAddressaclng" value="<%= order.getBillingAddresslng() %>">
          <input type="hidden" id="billingAddressaczip" name="billingAddressaczip" >
          <ul id="billingAddressac" name="billingAddressac"></ul>
          <hr>
            <%
              String sAddPls = order.getBillingAddress().replace(" ", "+");
              String sAddSpc = order.getBillingAddress().replace(" ", "-");
              String sAddEnc = URLDecoder.decode(order.getBillingAddress(), "UTF-8");
            %>
            <a href="https://www.google.com/maps/search/?api=1&query=<%=sAddEnc%>">Google</a> |
            <a href="https://maps.apple.com/?address=<%=sAddEnc%>">Apple</a> |
            <a href="https://www.waze.com/en/directions?navigate=yes&latlng=<%=order.getBillingAddresslat()%>,<%=order.getBillingAddresslng()%>">Waze</a> |
            <a href="https://wego.here.com/directions/mix//<%=sAddSpc%>:e-eyJuYW1lIjoiMTMyNSBOLCBMYW1lciBBdmUsIEJ1cmJhaywgQ0EgOTA4NTAiLCJhZGRyZXNzIjoiMTMyNSBOLCBMYW1lciBBdmUsIEJ1cmJhaywgQ0EgOTA4NTAiLCJsYXRpdHVkZSI6MzQuMTgzNjYyLCJsb25naXR1ZGUiOi0xMTguMzI2MTAyfQ==?map=34.18366,-118.3261,15,normal">HERE</a> |
            <a href="https://www.bing.com/maps?osid=a8d44b60-4f0c-4e4a-b9c7-3a3b3f597628&cp=<%=order.getBillingAddresslat()%>~<%=order.getBillingAddresslng()%>&lvl=15&style=r">Bing</a> |
            <a href="https://www.openstreetmap.org/search?query=<%=sAddEnc%>"#map=15/<%=order.getBillingAddresslat()%>/<%=order.getBillingAddresslng()%>">OSM</a> |
            <a href="https://www.tomtom.com/en_gb/maps/maps/point?lat=<%=order.getBillingAddresslat()%>&lon=<%=order.getBillingAddresslng()%>">TomTom</a>
            <hr>
            <a href="https://www.google.com/maps/dir/?api=1&origin=<%=uAddPls%>&destination=<%=sAddPls%>">Get directions</a>
          <hr>
<div class="form-group">
  <label for="paymentMethod">Payment Method</label>
  <select class="form-control" id="paymentMethod" name="paymentMethod" onchange="calculateFee()">
    <option value="cash" <%= "cash".equals(order.getPaymentMethod()) ? "selected" : "" %>>Cash</option>
    <option value="check" <%= "check".equals(order.getPaymentMethod()) ? "selected" : "" %>>Check</option>
    <option value="creditCard" <%= "creditCard".equals(order.getPaymentMethod()) ? "selected" : "" %>>Credit Card</option>
    <option value="debitCard" <%= "debitCard".equals(order.getPaymentMethod()) ? "selected" : "" %>>Debit Card</option>
    <option value="paypal" <%= "paypal".equals(order.getPaymentMethod()) ? "selected" : "" %>>Paypal</option>
    <option value="applePay" <%= "applePay".equals(order.getPaymentMethod()) ? "selected" : "" %>>Apple Pay</option>
    <option value="stripe" <%= "stripe".equals(order.getPaymentMethod()) ? "selected" : "" %>>Stripe</option>
    <option value="zelle" <%= "zelle".equals(order.getPaymentMethod()) ? "selected" : "" %>>Zelle</option>

  </select>
</div>


          <label for="orderTotal">Order Total:</label><br>
          <input type="text" id="orderTotal" name="orderTotal" value="<%= order.getOrderTotal() %>"  tabindex="15" onchange="calculateFee()" onkeypress="calculateFee()"><br>
          <hr>
          <label for="orderTotal">Order Total Payment Fee Included: (i.e. select 'Payment Method' (Stripe))</label><br>
          <input type="text" id="orderTotalAfterFee" name="orderTotalAfterFee"  tabindex="16"><br>
          <hr>
          <h4>Property Info</h4>
          <hr>
          <div class="form-group">
              <label for="shippingAddressEstPrice">Estimated Price:</label>
              <input type="number" class="form-control" id="shippingAddressEstPrice" name="shippingAddressEstPrice" step="0.01" value="<%= order.getShippingAddressEstPrice() %>" tabindex="9">
          </div>
          <div class="form-group">
              <label for="shippingAddressLastSalePrice">Last Sale Price:</label>
              <input type="number" class="form-control" id="shippingAddressLastSalePrice" name="shippingAddressLastSalePrice" step="0.01" value="<%= order.getShippingAddressLastSalePrice() %>" tabindex="10">
          </div>
          <div class="form-group">
              <label for="shippingAddressEstPriceHigh">Estimated High Price:</label>
              <input type="number" class="form-control" id="shippingAddressEstPriceHigh" name="shippingAddressEstPriceHigh" step="0.01" value="<%= order.getShippingAddressEstPriceHigh() %>" tabindex="11">
          </div>
          <div class="form-group">
              <label for="shippingAddressEstPriceLow">Estimated Low Price:</label>
              <input type="number" class="form-control" id="shippingAddressEstPriceLow" name="shippingAddressEstPriceLow" step="0.01" value="<%= order.getShippingAddressEstPriceLow() %>" tabindex="12">
          </div>
          <input type="submit" value="Submit"  tabindex="16">
        </form>


                                                         </div>
                                                         </div>

                                                         </section><!-- End Blog Section -->

                                                         </main><!-- End #main -->
  <script>
    $(function () {
     var bindDatePicker = function() {
  		$(".date").datetimepicker({
          format:'YYYY-MM-DD',
  			icons: {
  				time: "fa fa-clock-o",
  				date: "fa fa-calendar",
  				up: "fa fa-arrow-up",
  				down: "fa fa-arrow-down"
  			}
  		}).find('input:first').on("blur",function () {
  			// check if the date is correct. We can accept dd-mm-yyyy and yyyy-mm-dd.
  			// update the format if it's yyyy-mm-dd
  			var date = parseDate($(this).val());

  			if (! isValidDate(date)) {
  				//create date based on momentjs (we have that)
  				date = moment().format('YYYY-MM-DD');
  			}

  			$(this).val(date);
  		});
  	}

     var isValidDate = function(value, format) {
  		format = format || false;
  		// lets parse the date to the best of our knowledge
  		if (format) {
  			value = parseDate(value);
  		}

  		var timestamp = Date.parse(value);

  		return isNaN(timestamp) == false;
     }

     var parseDate = function(value) {
  		var m = value.match(/^(\d{1,2})(\/|-)?(\d{1,2})(\/|-)?(\d{4})$/);
  		if (m)
  			value = m[5] + '-' + ("00" + m[3]).slice(-2) + '-' + ("00" + m[1]).slice(-2);

  		return value;
     }

     bindDatePicker();
   });
  </script>
</body>

</html>
