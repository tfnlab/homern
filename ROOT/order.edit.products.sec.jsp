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

    String comType = request.getParameter("comType");

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
      var encodedString = encodeURIComponent(text);
      var urlString = "<%=rootUpdate%>genmessage.sec.jsp/?orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString ;
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
        var urlString = "<%=rootUpdate%>GoogleAutocomplete.sec.jsp?search=" + search + "&sfor=" + sfor.name;
        xhttp.open("GET", urlString, true);
        xhttp.send();
      }
    }
    function getCom() {
      var select = document.getElementById("customer-touch-points");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "<%=rootUpdate%>order.edit.com.sec.jsp?orderId=" + orderId +  "&comType=" + com;
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
    function updateCome(){

    }
    function getInvEmail(){
        var confirmResult = confirm("Are you sure you want to move the request forward?");
        if (confirmResult == true) {
      var select = document.getElementById("type");
      var selectedOption = select.options[select.selectedIndex];
      var type = selectedOption.value;
      var orderId = <%=orderId%>;
      var encodedString = encodeURIComponent(document.getElementById("orderCom").value);

      var url = "<%=rootUpdate%>order.edit.products.email.sec.jsp?orderId=" + orderId + "&type=" + type +"&message=" + encodedString;
      window.open(url, "_blank");
         }
    }
    function getInv() {
      var select = document.getElementById("type");
      var selectedOption = select.options[select.selectedIndex];
      var type = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "<%=rootUpdate%>order.edit.products.print.sec.jsp?orderId=" + orderId + "&type=" + type;
      window.open(url, "_blank");
    }

    function getMessageInvoice() {
      //genmessage.jsp?comType=latepaymentrequest
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {

          document.getElementById("orderCom").innerHTML = this.responseText.trim();
        }
      };
      var select = document.getElementById("type");
      var selectedOption = select.options[select.selectedIndex];
      var text = selectedOption.text;
      var encodedString = encodeURIComponent(text);
      var urlString = "<%=rootUpdate%>genmessage.sec.jsp/?orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString ;
      xhttp.open("POST", urlString, true);
      xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xhttp.send("orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString + "&csrfmiddlewaretoken=" + document.getElementById("csrfmiddlewaretoken").value);
    }
  </script>
</head>

<body onload="getProductDetail()">
    <main id="main">
      <section id="blog" class="blog">
        <div class="container px-4 px-lg-5">
            <div class="container mt-5">
              <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
                <%
                Order order = dao.getOrderByOrderId(orderId, username);

                String name = request.getParameter("name");
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);
                ProductLineItemDao plDao = new ProductLineItemDao();

                String remove = request.getParameter("remove");
                if (remove != null && remove.trim().length() > 0) {
                  int plid = 0;
                  if (!request.getParameter("plid").isEmpty()) {
                    plid = Integer.parseInt(request.getParameter("plid"));
                  }
                  plDao.deleteProductLineItem(plid,username);
                }

                if (name != null && name.trim().length() > 0) {
                  int productId = 0;
                  if (request.getParameter("productsId") != null && !request.getParameter("productsId").isEmpty()) {
                    productId = Integer.parseInt(request.getParameter("productsId"));
                  }
                  BigDecimal price = new BigDecimal(request.getParameter("price"));
                  int units = Integer.parseInt(request.getParameter("units"));
                  String description = request.getParameter("description");
                  ProductLineItem li = new ProductLineItem(0, orderId, productId, units, price, currentTime, currentTime, username, username, name, description);
                  boolean is_excluding = Boolean.parseBoolean(request.getParameter("is_excluding"));
                  li.setExcluding(is_excluding);
                  plDao.insertProductLineItem(li);
                }
                %>

        <HR>

                    <div class="form-group">
                      Order:
                        <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
                    </div>

                              <HR>
                                <div class="form-group" style="display: flex;">
                                  <select class="selectpicker form-control" id="type" name="type" style="flex: 1;width:90%">
                                    <option value="Payment Schedule" >Payment Schedule</option>
                                    <option value="Material Delivery Note" >Material Delivery Note</option>
                                    <option value="Work Order" >Work Order</option>
                                    <option value="Proposal" >Proposal</option>
                                    <option value="Estimate" >Estimate</option>
                                    <option value="Invoice" >Invoice</option>
                                    <option value="Simple Invoice" >Simple Invoice</option>
                                    <option value="Past Due Invoice" >Past Due Invoice</option>
                                    <option value="Payment Request" >Payment Request</option>
                                    <option value="Payment Confirmation" >Payment Confirmation</option>
                                  </select>
                                  &nbsp;
                                  <button class="btn btn-primary" style="flex: 1;" onclick="getInv()">
                                    Download
                                    <span class="fas fa-download" ></span>
                                  </button>
                                </div>
                                   <HR>
                                      <a href="javascript:void(0)" onclick="getMessageInvoice()">Generate Message</a>
                                  <HR>
                                  <label for="orderId">Touch Point</label><br>
                                  <textarea class="form-control" id="orderCom" name="orderCom" rows="5" onkeyup=""></textarea>
                                   <HR>
                        <input type="checkbox" name="customers" value="customers"> Customers

                        <input type="checkbox" name="technicians" value="technicians"> Technicians


                                  <button class="btn btn-primary" onclick="getInvEmail()">
                                    Email
                                    <span class="fas fa-envelope" ></span>
                                  </button>

        <HR>
        <%
             List<Product> products = pDao.searchByCustomerIdIsActive(username);
         %>



         <form action="<%=rootUpdate%>order.edit.products.sec.jsp" method="POST" >
         <p>
              <div class="form-group">
               <label for="technicianId">Product:</label>
                <select class="form-group" id="productsId" name="productsId" onchange="getProductDetail()">
                   <% for (Product product : products) { %>
                     <option value="<%= product.getId() %>"><%= product.getName() %></option>
                   <% } %>
                </select>
             </div>
             <HR>
             <div class="form-group">
               <label for="title">Name</label>
               <input type="text" class="form-control" id="name" name="name" required   >
             </div>
             <div class="form-group">
               <label for="title">Description</label>
               <textarea class="form-control" id="description" name="description" rows="5"></textarea>

             </div>
             <div class="form-group">
               <label for="title">Price</label>
               <input type="text" class="form-control" id="price" name="price" required   onchange="calTotal()">
             </div>
             <div class="form-group">
               <label for="title">Units</label>
               <input type="text" class="form-control" id="units" name="units" required value="1"  onchange="calTotal()">
             </div>
             <HR>
             <div class="form-group">
               <label for="title">Total</label>
               <input type="text" class="form-control" id="total" name="total" required value="0"  readonly disabled>
             </div>
             <input type="hidden" id="orderId" name="orderId" value="<%= order.getOrderId() %>" >
             <HR>
                  <div class="form-group form-check">
            				<input type="checkbox" class="form-check-input" name="is_excluding" id="is_excluding" value="true" >
            				<label class="form-check-label" for="featured">Excluded</label>
            			</div>
             <HR>
             <input type="submit" value="Add Product">
         </p>
         </form>
         <hr>
           <%

               List<ProductLineItem> pliList = plDao.getProductLineItemsByInvoiceId(order.getOrderId());
               BigDecimal invTotal  = new BigDecimal("0");
               for (ProductLineItem plItem : pliList) {
              %>

      <%if (plItem.isExcluding()) {%>
        <div style="margin: 1.5rem;background-color: red;">
    <%} else {
        invTotal = invTotal.add(plItem.getTotal());
    %>
        <div>
    <%}%>
            <div style="margin: 1.5rem;">
                  ID: <%= plItem.getId() %><br>
                  Name: <%= plItem.getName() %><br>
                  Description: <%= plItem.getDescription() %><br>
                  Units: <%= plItem.getQuantity() %><br>
                  Price: $<%= plItem.getPrice() %><br>
                  Total Price: $<%= plItem.getTotal() %><br>
            </div>
                </div>
                  <hr>
                <a href="<%=rootUpdate%>order.edit.products.sec.jsp?remove=yes&orderId=<%=orderId%>&plid=<%= plItem.getId() %>" >remove<a><br>
                  <hr>
           <%
               }
           %>
                  Products Total $<%=invTotal%>
                  <hr>
    </div>
    </div>

    </section><!-- End Blog Section -->

    </main><!-- End #main -->

</body>

</html>
