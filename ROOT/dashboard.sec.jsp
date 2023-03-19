<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.math.BigDecimal" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.ProductDashBoard" %>
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
          OrderDao oDao = new OrderDao();
          EntityDao eDao = new EntityDao();
          EventDao eventDao = new EventDao();
          TechnicianDao tDao = new TechnicianDao();
          ProductDao pDao = new ProductDao();

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
</head>

<body>


  <main id="main">


    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h4><%=usernameOBJ.getBusiness_name()%> <%= (new Translate()).translate("Dashboard", usernameOBJ.getLanguage())%></h4>
            <a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" ><</a>
            <HR>
              <%=usernameOBJ.getTs()%>
              <%
              Calendar today = Calendar.getInstance();

              // Get the calendar object for the given java.sql.Timestamp object
              Calendar inputTimestamp = Calendar.getInstance();
              inputTimestamp.setTimeInMillis(usernameOBJ.getTs().getTime());

              // Subtract the input timestamp from the current date
              long diff = today.getTimeInMillis() - inputTimestamp.getTimeInMillis();

              // Divide the difference by the number of milliseconds in a day to get the number of days
              long diffDays = diff / (24 * 60 * 60 * 1000);

              %> <%= (new Translate()).translate("Member for", usernameOBJ.getLanguage())%> <a href="user.edit.pay.jsp" ><%=diffDays%></a> <%= (new Translate()).translate("Days", usernameOBJ.getLanguage())%>
            <HR>
            <%= (new Translate()).translate("Orders", usernameOBJ.getLanguage())%>: <%=oDao.getCustomerOrderCount(username)%>
            <HR>
            <table class="table" border=1>

                <tr>
                  <td ><%= (new Translate()).translate("Status", usernameOBJ.getLanguage())%></th>
                  <td align="right" sytle="text-align: right;"><%= (new Translate()).translate("Count", usernameOBJ.getLanguage())%></td>
                  <td align="right" sytle="text-align: right;"><%= (new Translate()).translate("Total", usernameOBJ.getLanguage())%></td>
                </tr>
                <%
//                  String[] statuses = {};
                  String[] statuses = {"Proposal", "Estimate", "Order Placement", "Invoicing", "Payment", "Delivery", "Fulfillment"};
                  for (String sstatus : statuses) {
                %>
                <tr>
                  <td><a href="order.list.jsp?searchKey=<%= sstatus %>" ><%= (new Translate()).translate(sstatus, usernameOBJ.getLanguage())%></a></td>
                  <td align="right">
                      <% int count = oDao.getCustomerOrderCount(username, sstatus);%>
                      <%= count %>
                  </td>
                  <td align="right">
                      <%if(count>0){%>
                          <% try{
                              %><%=oDao.getCustomerOrderTotal(username, sstatus)%><%
                            }catch(Exception ex){
                              %><%=ex.getMessage()%><%
                            }
                          %>
                      <%}else{%>
                        0
                      <%}%>
                  </td>

                </tr>
                <%
                  }
                %>
            </table>

            <HR>
            <%= (new Translate()).translate("Customers", usernameOBJ.getLanguage())%>: <a href="customer.list.jsp"><%=eDao.getEntityCountByUsername(username)%></a>
            <HR>
            <%= (new Translate()).translate("Products", usernameOBJ.getLanguage())%>:   <a href="product.list.jsp"><%=pDao.getCountByUsername(username)%></a>
            <HR>
            <%
                ProductLineItemDao plDao = new ProductLineItemDao();
            %>
            <%
                try{
                    Map<Product, ProductDashBoard> groupedProducts = plDao.getGroupedProductsByInvoiceId(username, false);
                    %>
                                <table class="table">

                <tr>
                  <td scope="col"><%= (new Translate()).translate("Product", usernameOBJ.getLanguage())%></td>
                  <td align="right" scope="col"><%= (new Translate()).translate("Quantity", usernameOBJ.getLanguage())%></td>
                  <td align="right" scope="col"><%= (new Translate()).translate("Total", usernameOBJ.getLanguage())%></td>
                </tr>
     <% for (Map.Entry<Product, ProductDashBoard> entry : groupedProducts.entrySet()) { %>
    <tr>
        <td><%= entry.getKey().getName() %></td>
        <td align="right"><%= entry.getValue().getQuantity() %></td>
        <td align="right"><%= entry.getValue().getTotal_amount() %></td>
    </tr>
    <% } %>
                </table>
                    <%
                }catch(Exception ex){
                    %><%=ex.getMessage()%><%
                }
            %>
            <%
                try{
                    Map<Product, ProductDashBoard> groupedProducts = plDao.getGroupedProductsByInvoiceId(username, true);
                    %>
                                <table class="table">

                <tr>
                  <td scope="col"><%= (new Translate()).translate("Excluded Product", usernameOBJ.getLanguage())%></td>
                  <td align="right" scope="col"><%= (new Translate()).translate("Quantity", usernameOBJ.getLanguage())%></td>
                  <td align="right" scope="col"><%= (new Translate()).translate("Total", usernameOBJ.getLanguage())%></td>
                </tr>

     <% for (Map.Entry<Product, ProductDashBoard> entry : groupedProducts.entrySet()) { %>
    <tr>
        <td><%= entry.getKey().getName() %></td>
        <td align="right"><%= entry.getValue().getQuantity() %></td>
        <td align="right"><%= entry.getValue().getTotal_amount() %></td>
    </tr>
    <% } %>
                </table>
                    <%
                }catch(Exception ex){
                    %><%=ex.getMessage()%><%
                }
            %>

            <HR>
            <%= (new Translate()).translate("Technicians", usernameOBJ.getLanguage())%>:  <a href="technician.list.jsp"><%=tDao.getTechnicianCountByUsername(username)%></a>
            <HR>
            <%= (new Translate()).translate("Events", usernameOBJ.getLanguage())%>: <a href="event.list.jsp"><%=eventDao.getEventCountByUsername(username)%></a>
            <HR>
          </div>
      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->



</body>

</html>
