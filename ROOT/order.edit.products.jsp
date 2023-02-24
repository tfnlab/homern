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
<%@ include file="auth.jsp" %>


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

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
  <%
    OrderDao dao = new OrderDao();
    OrderTechniciansDAO otD = new OrderTechniciansDAO();
    EventDao evd = new EventDao();
    TechnicianDao technicianDao = new TechnicianDao();
    ProductDao pDao = new ProductDao();
    int orderId = 0;
    String username = (String) session.getAttribute("username");
    User usernameOBJ = (User) session.getAttribute("usernameOBJ");
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }

    String comType = request.getParameter("comType");

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

      var url = "order.edit.products.email.jsp?orderId=" + orderId + "&type=" + type +"&message=" + encodedString;
      window.open(url, "_blank");
         }
    }
    function getInv() {
      var select = document.getElementById("type");
      var selectedOption = select.options[select.selectedIndex];
      var type = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "order.edit.products.print.jsp?orderId=" + orderId + "&type=" + type;
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
      var urlString = "genmessage.jsp?orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString ;
      xhttp.open("POST", urlString, true);
      xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xhttp.send("orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString);
    }
  </script>
</head>

<body onload="getProductDetail()">

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="index.html">HRN</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt=""></a>-->

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto" href="index.html#hero">Home</a></li>
          <li><a class="nav-link scrollto active" href="avatar.html">Avatar</a></li>
          <li><a class="nav-link scrollto" href="index.html#services">Services</a></li>
          <li><a class="nav-link scrollto " href="index.html#portfolio">Portfolio</a></li>
          <li><a class="nav-link scrollto" href="index.html#team">Team</a></li>
          <li><a class="nav-link scrollto" href="#contact">Contact</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

      <a href="https://forms.gle/vdU9zvFTZJ9eKAsz6" class="get-started-btn scrollto">Get Started</a>
    </div>
  </header><!-- End Header -->

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">Home</a></li>
          <li>Order</li>
        </ol>
        <h2>Order</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Order - Products </h2>
        <%@ include file="user.menu.nav.jsp" %>
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
                        <a href="order.edit.jsp?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
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



         <form action="order.edit.products.jsp" method="POST" >
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
                <a href="order.edit.products.jsp?remove=yes&orderId=<%=orderId%>&plid=<%= plItem.getId() %>" >remove<a><br>
                  <hr>
           <%
               }
           %>
                  Products Total $<%=invTotal%>
                  <hr>
      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer">

    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-3 col-md-6 footer-contact">
            <h3>Presento<span>.</span></h3>
            <p>
              A108 Adam Street <br>
              New York, NY 535022<br>
              United States <br><br>
              <strong>Phone:</strong> +1 5589 55488 55<br>
              <strong>Email:</strong> info@example.com<br>
            </p>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 footer-links">
            <h4>Our Services</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
            </ul>
          </div>

          <div class="col-lg-4 col-md-6 footer-newsletter">
            <h4>Join Our Newsletter</h4>
            <p>
              Sign up to learn more about technology and information management.
            </p>
            <form action="" method="post">
              <input type="email" name="email"><input type="submit" value="Subscribe">
            </form>
          </div>

        </div>
      </div>
    </div>

    <div class="container d-md-flex py-4">

      <div class="me-md-auto text-center text-md-start">
        <div class="copyright">
          &copy; Copyright <strong><span>Presento</span></strong>. All Rights Reserved
        </div>
        <div class="credits">
          <!-- All the links in the footer should remain intact. -->
          <!-- You can delete the links only if you purchased the pro version. -->
          <!-- Licensing information: https://bootstrapmade.com/license/ -->
          <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/presento-bootstrap-corporate-template/ -->
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
      </div>
      <div class="social-links text-center text-md-end pt-3 pt-md-0">
        <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
        <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
        <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
        <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
        <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>


  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>
