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
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.OrderTechnicians" %>
<%@ page import="com.tfnlab.mysql.OrderTechniciansDAO" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.ProductLineItem" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.OrderCustomer" %>
<%@ page import="com.tfnlab.mysql.OrderCustomerDao" %>
<%@ page import="com.tfnlab.mysql.OrderRebateDAO" %>
<%@ page import="com.tfnlab.mysql.OrderRebate" %>
<%@ page import="com.tfnlab.mysql.Rebate"%>
<%@ page import="com.tfnlab.mysql.RebateDao"%>
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
    OrderTechniciansDAO otD = new OrderTechniciansDAO();
    EventDao evd = new EventDao();
    TechnicianDao technicianDao = new TechnicianDao();
    ProductDao pDao = new ProductDao();
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
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
    function getMessage() {
      //genmessage.jsp?comType=latepaymentrequest
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {

          document.getElementById("orderCom").innerHTML = this.responseText.trim();
        }
      };
      var select = document.getElementById("customer-touch-points");
      var selectedOption = select.options[select.selectedIndex];
      var text = selectedOption.text;
      const encodedString = encodeURIComponent(text);
      var urlString = "genmessage.jsp?orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString ;
      xhttp.open("GET", urlString, true);
      xhttp.send();
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
      var select = document.getElementById("customer-touch-points");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "order.edit.com.jsp?orderId=" + orderId +  "&comType=" + com;
      window.open(url, "_self");
    }
    function getProductDetail() {
      var select = document.getElementById("productsId");
      var selectedOption = select.options[select.selectedIndex];
      var productsId = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "product.xml.jsp?productId=" + productsId ;
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("name").value = removeTrailingSpaces(this.responseText.split("<HRNITEM>")[0].trim());
          document.getElementById("description").innerHTML = removeTrailingSpaces(this.responseText.split("<HRNITEM>")[1].trim());
          document.getElementById("price").value = removeTrailingSpaces(this.responseText.split("<HRNITEM>")[2].trim());
          calTotal();
        }
      };
      xhttp.open("GET", url, true);
      xhttp.send();
    }
    function calTotal() {
        document.getElementById("total").value = document.getElementById("units").value * document.getElementById("price").value;
    }

    function getInv() {
      var orderId = <%=orderId%>;
      var url = "order.edit.products.print.jsp?orderId=" + orderId;
      window.open(url, "_blank");
    }
    function searchCustomer() {
      var orderId = <%=orderId%>;
      var url = "order.edit.customers.search.jsp?searchKey=" + document.getElementById("search").value  + "&orderId=" + orderId ;
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("searchR").innerHTML = this.responseText;
        }
      };
      xhttp.open("GET", url, true);
      xhttp.send();
    }
  </script>
</head>

<body onload="getProductDetail()">
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
        <HR>
                <%
                ProductLineItemDao plDao = new ProductLineItemDao();
                OrderRebateDAO orDao = new OrderRebateDAO();
                RebateDao rDao = new RebateDao();
                Order order = dao.getOrderByOrderId(orderId, username);
                String action = request.getParameter("action");
                if (action != null && action.trim().length() > 0) {
                  if(action.equals("add")){
                    int rId = 0;
                    if (!request.getParameter("rebateId").isEmpty()) {
                      rId = Integer.parseInt(request.getParameter("rebateId"));
                    }
                    long currentTimeMillis = System.currentTimeMillis();
                    Timestamp currentTime = new Timestamp(currentTimeMillis);
                    OrderRebate or = new OrderRebate();
                    or.setOrder(order);
                    or.setRebate(rDao.getRebateByIdAndUsername(rId, username));
                    or.setCreatedAt(currentTime);
                    or.setUsername(username);
                    try{
                        orDao.insert(or);
                    }catch(Exception ex){
                      %><%=ex.getMessage()%><%
                    }
                  }
                  if(action.equals("remove")){
                    int orId = 0;
                    if (!request.getParameter("orId").isEmpty()) {
                      orId = Integer.parseInt(request.getParameter("orId"));
                    }
                    orDao.remove(orId, username);
                  }
                }
                %>
                <div class="form-group">
                  Order:
                    <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
                </div>
        <hr>
           <div class="container" id="searchR" name="searchR" >
             <h3>Rebates</h3>
             <HR>
             <%

                 List<Rebate> rebates = rDao.getRebatesByUsername(username);
                 if(rebates!= null && !rebates.isEmpty()){
                     for (Rebate rebate : rebates) {
                       %>
                       <div class="card">
                           <div class="card-body">
                               <h5 class="card-title"><a href="<%=rootUpdate%>rebate.edit.sec.jsp/?rebateId=<%= rebate.getRebateId() %>" ><%= rebate.getName() %></a></h5>
                               <p class="card-text">Percentage: <%= rebate.getPercentage() %></p>
                               <p class="card-text">Amount: <%= rebate.getAmount() %></p>
                               <p class="card-text">Start Date: <%= rebate.getStartDate() %></p>
                               <p class="card-text">End Date: <%= rebate.getEndDate() %></p>
                               <p class="card-text">
                                 <a href="<%=rootUpdate%>order.edit.rebates.sec.jsp/?action=add&orderId=<%=orderId%>&rebateId=<%= rebate.getRebateId() %>" >Add</a><br>
                               </p>
                           </div>
                       </div>
                       <%
                     }
                }else{ %>
                       <div class="alert alert-warning" role="alert">
                           No rebate available for this user
                       </div>
                 <% }
                 %>
                  <HR>
                 <h3>Rebates Applied</h3>
                 <%
                 List<OrderRebate> orList = orDao.getOrderRebatesByUsernameAndOrderId(username, orderId);
                 for (OrderRebate orItem : orList) {
                    %>
                    <div class="card">
                        <div class="card-body">
                        <p>
                    <%=orItem.getRebate().getName()%> <BR>
                    <%=orItem.getRebate().getAmount()%> <BR>
                    <a href="<%=rootUpdate%>order.edit.rebates.sec.jsp?action=remove&orderId=<%=orderId%>&orId=<%= orItem.getId() %>" class="btn btn-danger">REMOVE</a><BR>
                        </p>
                        </div>
                    </div>
                    <%
                 }
             %>

             </div>
             </div>
             </div>

             </section><!-- End Blog Section -->

             </main><!-- End #main -->

</body>

</html>
