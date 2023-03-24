<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html lang="en">
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
%>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="<%=rootUpdate%>assets/img/favicon.png" rel="icon">
  <link href="<%=rootUpdate%>assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%=rootUpdate%>assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="<%=rootUpdate%>assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=rootUpdate%>assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="<%=rootUpdate%>assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="<%=rootUpdate%>assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="<%=rootUpdate%>assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="<%=rootUpdate%>assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=rootUpdate%>assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: Presento - v3.9.1
  * Template URL: https://bootstrapmade.com/presento-bootstrap-corporate-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
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

  <%@ include file="include.header.jsp" %>

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">
        <ol>
          <li><a href="user.menu.jsp"><%= (new Translate()).translate("Home", usernameOBJ.getLanguage())%></a></li>
          <li><%= (new Translate()).translate("Service Operations Center", usernameOBJ.getLanguage())%></li>
        </ol>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container">
            <h4><%=usernameOBJ.getBusiness_name()%></h4>
              <style>
                .fa {
                  font-size: 48px;
                  margin-right: 10px;
                }
                a:hover {
                  color: blue;
                  text-decoration: underline;
                }
                .link-col {
                  display: flex;
                  flex-direction: column;
                  align-items: center;
                }
                a {
                  padding: 10px;
                }
              </style>

              <div class="row">
                <div class="col-3 link-col">
                  <a href="<%=rootUpdate%>user.menu.jsp" tabindex="1" ><i class="fa fa-home"></i></a>
                  <p><%= (new Translate()).translate("Home", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="<%=rootUpdate%>dashboard.jsp" tabindex="2" ><i class="fa fa-tachometer-alt"></i></a>
                  <p><%= (new Translate()).translate("Dashboard", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="<%=rootUpdate%>user.edit.jsp" tabindex="3" ><i class="fa fa-cog"></i></a>
                  <p><%= (new Translate()).translate("Settings", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="technician.list.jsp" tabindex="4" ><i class="fa fa-wrench"></i></a>
                  <p><%= (new Translate()).translate("Technicians", usernameOBJ.getLanguage())%></p>
                </div>
              </div>
              <div class="row">
                <div class="col-3 link-col">
                  <a href="product.list.jsp" tabindex="5" ><i class="fa fa-box"></i></a>
                  <p><%= (new Translate()).translate("Products", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="customer.list.jsp" tabindex="6" ><i class="fa fa-users"></i></a>
                  <p><%= (new Translate()).translate("Customers", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="order.list.jsp" tabindex="7" ><i class="fa fa-shopping-cart"></i></a>
                  <p><%= (new Translate()).translate("Orders", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="event.list.jsp" tabindex="8" ><i class="fa fa-calendar"></i></a>
                  <p><%= (new Translate()).translate("Events", usernameOBJ.getLanguage())%></p>
                </div>
              </div>
              <div class="row">
                <div class="col-3 link-col">
                  <a href="discount.list.jsp" tabindex="9" ><i class="fa fa-gift"></i></a>
                  <p><%= (new Translate()).translate("Discounts", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="rebate.list.jsp" tabindex="10" ><i class="fa fa-wallet"></i></a>
                  <p><%= (new Translate()).translate("Rebates", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="inventory.list.jsp" tabindex="11" ><i class="fa fa-box-open"></i></a>
                  <p><%= (new Translate()).translate("Inventory", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="timesheet.list.jsp" tabindex="12" ><i class="fa fa-clock"></i></a>
                  <p><%= (new Translate()).translate("Time Sheet", usernameOBJ.getLanguage())%></p>
                </div>
              </div>

              <div class="row">
                <div class="col-3 link-col">
                  <a href="expense.list.jsp" tabindex="13" ><i class="fa fa-plane"></i></a>
                  <p><%= (new Translate()).translate("Expenses", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="user.edit.social.jsp" tabindex="14" ><i class="fa fa-share-square"></i></a>
                  <p><%= (new Translate()).translate("Social Media", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="user.edit.referred_by.jsp" tabindex="15" ><i class="fa fa-people-arrows"></i></a>
                  <p><%= (new Translate()).translate("Referral", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="dmp.list.jsp" tabindex="16" ><i class="fa fa-database"></i></a>
                  <p><%= (new Translate()).translate("Data Management Platform", usernameOBJ.getLanguage())%></p>
                </div>
              </div>

              <div class="row">
                <div class="col-3 link-col">
                  <a href="#" tabindex="17" ><i class="fa fa-money-bill-alt"></i></a>
                  <p><%= (new Translate()).translate("Assets", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="#" tabindex="18" ><i class="fa fa-file-invoice-dollar"></i></a>
                  <p><%= (new Translate()).translate("Liabilities", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="#" tabindex="19" ><i class="fa fa-chart-pie"></i></a>
                  <p><%= (new Translate()).translate("Equity", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="#" tabindex="20" ><i class="fa fa-chart-line"></i></a>
                  <p><%= (new Translate()).translate("Forecasting", usernameOBJ.getLanguage())%></p>
                </div>
              </div>
              <div class="row">
                <div class="col-3 link-col">
                  <a href="vendor.list.jsp" tabindex="21" ><i class="fa fa-truck"></i></a>
                  <p><%= (new Translate()).translate("Vendors", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="#" tabindex="22" ><i class="fa fa-user-secret"></i></a>
                  <p><%= (new Translate()).translate("top secret", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="#" tabindex="23" ><i class="fa fa-user-secret"></i></a>
                  <p><%= (new Translate()).translate("top secret", usernameOBJ.getLanguage())%></p>
                </div>
                <div class="col-3 link-col">
                  <a href="#" tabindex="24" ><i class="fa fa-user-secret"></i></a>
                  <p><%= (new Translate()).translate("top secret", usernameOBJ.getLanguage())%></p>
                </div>
              </div>

            <HR>
            <p>Our home service software offers a range of features to help companies streamline their operations:</p>
            <ul>
              <li><strong>Scheduling and dispatch:</strong> our software can help schedule and dispatch technicians to service calls and manage their work schedules.</li>
              <li><strong>Customer relationship management (CRM):</strong> our software can help companies manage customer relationships by storing customer information, tracking interactions, and managing communication with customers.</li>
              <li><strong>Invoicing and billing:</strong> our software can help companies create and manage invoices, process payments, and track billing.</li>
              <li><strong>Inventory management:</strong> our software can help companies track inventory levels, reorder supplies, and manage the purchase and use of parts and equipment.</li>
              <li><strong>Service history:</strong> our software can help companies track service history for individual customers and equipment, including the type of service provided, the technician who performed the service, and the parts used.</li>
              <li><strong>Reporting:</strong> our software can generate reports on a variety of metrics, such as service history, customer interactions, and financial performance.</li>
              <li><strong>Mobile functionality:</strong> many of our software programs have mobile apps that allow technicians to access and update information on the go.</li>
              <li><strong>Integration with other systems:</strong> our software may integrate with other business systems, such as accounting software or CRM software, to streamline workflows and improve efficiency.</li>
            </ul>
            <HR>
            <h4>Mind-Blowing Updates: What's in Store</h4>
            <p>Get ready to have your minds blown, because we've got a whole bunch of new features and bug fixes that are sure to blow your socks off. These updates are going to take your user experience to a whole new level, and we can't wait for you to get your hands on them. Trust us, these are the kinds of features and bug fixes that you'll be talking about for years to come. So stay tuned and get ready to take your productivity (or whatever else you're using our product for) to the next level!</p>


          </div>
      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->


    <%@ include file="include.footer.jsp" %>

    <%@ include file="include.shortcut.jsp" %>
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
