<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.hrn.mysql.User"%>
<%@ page import="com.hrn.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
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
    function callTFNLab() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("status").innerHTML = this.responseText;
          const el = document.createElement('textarea');
          el.value =  this.responseText;
          el.setAttribute('readonly', '');
          el.style.position = 'absolute';
          el.style.left = '-9999px';
          document.body.appendChild(el);
          el.select();
          document.execCommand('copy');
          document.body.removeChild(el);

        }
      };
      var urlString = "gennft.jsp?walletid=" + document.getElementById("walletid").value
      document.getElementById("start").style.display="none";
      document.getElementById("status").innerHTML = "Started Avatar Generation, give it a minute. <img src=\"assets/img/wait.gif\" />";
      xhttp.open("GET", urlString, true);
      xhttp.send();
    }

    function callCopy() {
      const el = document.createElement('textarea');
      el.value =  document.getElementById("status").innerHTML;
      el.setAttribute('readonly', '');
      el.style.position = 'absolute';
      el.style.left = '-9999px';
      document.body.appendChild(el);
      el.select();
      document.execCommand('copy');
      document.body.removeChild(el);
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
            <a href="<%=rootUpdate%>order.new.sec.jsp/" tabindex="2" ><i class="fas fa-plus"></i> Order</a>
          <HR>
        <%
                String searchKey = request.getParameter("searchKey");
                OrderDao orderDao = new OrderDao();

                List<Order> orders = null;
                HashMap<Integer, Order> ordersMap = new HashMap<>();
                if (searchKey != null && searchKey.trim().length() > 0) {
                    try{
                        orders = orderDao.getCustomerOrdersSearchKey(searchKey, username);
                    }catch(Exception ex){
                        %><%=ex.getMessage()%><%
                    }
                }else{
                    searchKey = "";
                    orders = orderDao.getCustomerOrdersDetails(username);
                }
                    ordersMap = orderDao.getCustomerOrdersDetailsPaid(username);
                %>
                <form action="<%=rootUpdate%>order.list.sec.jsp/" method="post">
                  <div class="form-group">
                    <label for="firstName">Search Key</label>
                    <input type="text" class="form-control" id="searchKey" name="searchKey" value="<%= searchKey %>" tabindex="3">
                  </div>
                  <HR>
                  <button type="submit" class="btn btn-primary" tabindex="4" >Search</button>
                </form>
                <HR>
                <%
                    int tabindex = 5;

                        Calendar calendar = Calendar.getInstance();
                        Date today = calendar.getTime(); // current date
                %>
              <% for (Order order : orders) {
                    try{
                %>
                <% String color = order.getShipDate().after(today) ? "#C8E6C9" : "#FFCDD2"; %>
                <div class="container-fluid p-5" style="background-color: <%=color%>">
                  <div class="card p-3">
                    Order ID: <%= order.getOrderId() %><br>
                    Order Status: <%= (new Translate()).translate(order.getStatus(), usernameOBJ.getLanguage())%><br>
                    Name: <%= order.getOrderName() %><br>
                      Description: <%= order.getOrderDescription() %><br>
                    Date: <%= order.getOrderDate() %><br>
                    Project Address: <%= order.getShippingAddress() %><br>
                    <!-- Location : <%= order.getShippingAddresslat() %> ,<%= order.getShippingAddresslng() %><br> -->
                    Billing Address: <%= order.getBillingAddress() %><br>
                    <!-- Location : <%= order.getBillingAddresslat() %> ,<%= order.getBillingAddresslng() %><br> -->

                    Payment Method: <%= order.getPaymentMethod() %><br>
                    Order Total: <%= order.getOrderTotal() %><br>
                    <div class="panel-body" style="text-align: right;">
                    <%
                        try{
                    %>
                    <%if(ordersMap.get(order.getOrderId())!=null && order.getOrderTotal_sql() !=null){%>
                    Total: <%= order.getOrderTotal_sql() %><br>
                    Paid: <%= (ordersMap.get(order.getOrderId())).getOrderTotal_paid_sql() %><br>
                    Due: <%
                      BigDecimal amountDue = order.getOrderTotal_sql().subtract((ordersMap.get(order.getOrderId())).getOrderTotal_paid_sql());
                      String colorT = (amountDue.compareTo(BigDecimal.ZERO) == 0) ? "green" : "red";
                      if(amountDue.compareTo(BigDecimal.ZERO) != 0)
                      colorT = ((ordersMap.get(order.getOrderId())).getOrderTotal_paid_sql().compareTo(BigDecimal.ZERO) == 0) ? "red" : "#9B870C";
                    %>
                    <span style="color: <%= colorT %>;">
                      <%=amountDue%>
                    </span>
                    <br>

                    <%}%>
                    <%
                    }catch(Exception ex){
                        %>
                        <a href="<%=rootUpdate%>order.edit.products.sec.jsp/?orderId=<%=order.getOrderId()%>" >(No Products)</a>
                        <%
                    }
                    %>
                    </div>
                    <hr>
                    <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" class="btn btn-primary" tabindex="<%=tabindex%>" >More Info</a><br>

                <%
                  tabindex +=1;
                %>
                  </div>
                </div>
                <HR>
              <%
                    }catch(Exception ex){
                        %><%=ex.getMessage()%><%
                    }
              } %>



              </div>
              </div>

              </section><!-- End Blog Section -->

              </main><!-- End #main -->

</body>

</html>
