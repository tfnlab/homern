<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.mysql.Order"%>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
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
    %>
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
    function getPayments(){
        var eId = <%=eId%>;
        var url = "customer.edit.payments.jsp?customerId=" + eId ;
        window.open(url, "_self");
    }
    function getCom() {
      var select = document.getElementById("touchPoints");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.value;
      var eId = <%=eId%>;
      var url = "customer.edit.com.jsp?customerId=" + eId +  "&comType=" + com;
      window.open(url, "_self");
    }
    function getOrders() {
      var eId = <%=eId%>;
      var url = "customer.edit.orders.jsp?customerId=" + eId;
      window.open(url, "_self");
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
        <%
                // Validate form data
                Entity entity = new Entity();
                EntityDao ed = new EntityDao();
                  entity = ed.getEntityById(eId, username);
        %>
        <a href="<%=rootUpdate%>customer.edit.sec.jsp/?customerId=<%= entity.getId() %>" ><%= entity.getFirstName() %>, <%= entity.getLastName() %></a><br>
        <%= entity.getEmail() %><BR>
        <%= entity.getPhone() %><BR>
        <HR>
        <a href="<%=rootUpdate%>order.edit.customers.sec.jsp/?action=add&customerId=<%= entity.getId() %>" >Add Order</a>
        <HR>
                    <%

                    OrderDao orderDao = new OrderDao();
                    List<Order> orders  = orderDao.getOrdersByCustomerId(entity.getId(), username);

                    %>

                    <%
                        int tabindex = 4;

                            Calendar calendar = Calendar.getInstance();
                            Date today = calendar.getTime(); // current date
                    %>
                  <% for (Order order : orders) { %>
                    <% String color = order.getShipDate().after(today) ? "#C8E6C9" : "#FFCDD2"; %>
                    <div class="container-fluid p-5" style="background-color: <%=color%>">
                      <div class="card p-3">
                    ID: <%= order.getOrderId() %><br>
                    Order Status: <%= order.getStatus() %><br>
                    Name: <%= order.getOrderName() %><br>
                      Description: <%= order.getOrderDescription() %><br>
                    Date: <%= order.getOrderDate() %><br>
                    Project Address: <%= order.getShippingAddress() %><br>
                    <!-- Location : <%= order.getShippingAddresslat() %> ,<%= order.getShippingAddresslng() %><br> -->
                    Billing Address: <%= order.getBillingAddress() %><br>
                    <!-- Location : <%= order.getBillingAddresslat() %> ,<%= order.getBillingAddresslng() %><br> -->
                    Payment Method: <%= order.getPaymentMethod() %><br>
                    Total: <%= order.getOrderTotal() %><br>
                    <hr>
                    <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" class="btn btn-primary" tabindex="<%=tabindex%>" >More Info</a><br>

                    <%
                      tabindex +=1;
                    %>
                      </div>
                    </div>
                    <HR>
                  <% } %>

                                                 </div>
                                                 </div>

                                                 </section><!-- End Blog Section -->

                                                 </main><!-- End #main -->

</body>

</html>
