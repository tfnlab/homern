<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.jsp" %>
<%
          User usernameOBJ = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Home Renovation Nation - Product - Edit</title>
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
          <li>Product</li>
        </ol>
        <h2>Product</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Product</h2>
        <%@ include file="user.menu.nav.jsp" %>

        <%

                int id = Integer.parseInt(request.getParameter("productId"));
                ProductDao dao = new ProductDao();

                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);


                  // Get the form data from the request
                  String sku = request.getParameter("sku");
                  String name = request.getParameter("name");

                if (name != null && name.trim().length() > 0) {

                  BigDecimal price = new BigDecimal(request.getParameter("price"));
                  int inventory = Integer.parseInt(request.getParameter("inventory"));
                  int reorderLevel = 0;
                  int leadTime = 0;
                  boolean featured = Boolean.parseBoolean(request.getParameter("featured"));
                  BigDecimal rating = new BigDecimal(request.getParameter("rating"));

                  String description = request.getParameter("description");
                  String imageUrl = request.getParameter("image_url");
                  Timestamp createdAt = currentTime;
                  Timestamp updatedAt = currentTime;
                  int categoryId = 0;
                  int manufacturerId = 0;
                  boolean availability = Boolean.parseBoolean(request.getParameter("availability"));
                  BigDecimal weight = new BigDecimal(request.getParameter("weight"));
                  String dimensions = request.getParameter("dimensions");

                  String customerId = username;

                  // Create a new Product object
                 Product product = new Product(id, sku, name, price, inventory, reorderLevel, leadTime, featured, rating, description, imageUrl, createdAt, updatedAt, categoryId, manufacturerId, availability, weight, dimensions, customerId);

                  // Create a new ProductDao object

                  // Insert the Product object into the database
                  dao.updateProductById(product);
                %>
                <p>Product successfully Saved to the database.</p>
                <%

              }


                  Product product = dao.getProductById(id, username);

        %>
            <!-- ======= Contact Section ======= -->
            <body>
            	<div class="container mt-5">
            		<form action="product.edit.jsp" method="post" class="form">
            			<div class="form-group">
            				<label for="sku">ID:</label>
            				<input type="text" class="form-control" name="productId" id="productId" value="<%= product.getId() %>">
            			</div>
            			<div class="form-group">
            				<label for="sku">SKU:</label>
            				<input type="text" class="form-control" name="sku" id="sku" value="<%= product.getSku() %>">
            			</div>
            			<div class="form-group">
            				<label for="name">Name:</label>
            				<input type="text" class="form-control" name="name" id="name" value="<%= product.getName() %>">
            			</div>
            			<div class="form-group">
            				<label for="price">Price:</label>
            				<input type="text" class="form-control" name="price" id="price" value="<%= product.getPrice() %>">
            			</div>
            			<div class="form-group">
            				<label for="inventory">Inventory:</label>
            				<input type="text" class="form-control" name="inventory" id="inventory" value="<%= product.getInventory() %>">
            			</div>
            			<div class="form-group">
            				<label for="reorderLevel">Reorder Level:</label>
            				<input type="text" class="form-control" name="reorderLevel" id="reorderLevel" value="<%= product.getReorderLevel() %>">
            			</div>
            			<div class="form-group">
            				<label for="leadTime">Lead Time:</label>
            				<input type="text" class="form-control" name="leadTime" id="leadTime" value="<%= product.getLeadTime() %>">
            			</div>

                  <div class="form-group form-check">
            				<input type="checkbox" class="form-check-input" name="featured" id="featured" value="true" <%= product.isFeatured() ? "checked" : "" %>>
            				<label class="form-check-label" for="featured">Featured</label>
            			</div>
            			<div class="form-group">
            				<label for="rating">Rating:</label>
            				<input type="text" class="form-control" name="rating" id="rating" value="<%= product.getRating() %>">
            			</div>
            			<div class="form-group">
            				<label for="description">Description:</label>
                    <textarea class="form-control" id="description" name="description"><%= product.getDescription() %></textarea><br>
            			</div>
            			<div class="form-group">
            				<label for="imageUrl">Image URL:</label>
            				<input type="text" class="form-control" name="imageUrl" id="imageUrl" value="<%= product.getImageUrl() %>">
            			</div>
            			<div class="form-group">
            				<label for="createdAt">Created At:</label>
            				<input type="text" class="form-control" name="createdAt" id="createdAt" value="<%= product.getCreatedAt() %>">
            			</div>
            			<div class="form-group">
            				<label for="updatedAt">Updated At:</label>
            				<input type="text" class="form-control" name="updatedAt" id="updatedAt" value="<%= product.getUpdatedAt() %>">
            			</div>
            			<div class="form-group">
            				<label for="categoryId">Category ID:</label>
            				<input type="text" class="form-control" name="categoryId" id="categoryId" value="<%= product.getCategoryId() %>">
            			</div>
            			<div class="form-group">
            				<label for="manufacturerId">Manufacturer ID:</label>
            				<input type="text" class="form-control" name="manufacturerId" id="manufacturerId" value="<%= product.getManufacturerId() %>">
            			</div>
            			<div class="form-group form-check">
            				<input type="checkbox" class="form-check-input" name="availability" id="availability" value="true" <%= product.isAvailability() ? "checked" : "" %>>
            				<label class="form-check-label" for="availability">Availability</label>
            			</div>
                  <div class="form-group">
            				<label for="weight">Weight:</label>
            				<input type="text" class="form-control" name="weight" id="weight" value="<%= product.getWeight() %>">
            			</div>
            			<div class="form-group">
            				<label for="dimensions">Dimensions:</label>
            				<input type="text" class="form-control" name="dimensions" id="dimensions" value="<%= product.getDimensions() %>">
            			</div>
            			<div class="form-group">
            				<label for="customerId">Customer ID:</label>
            				<input type="text" class="form-control" name="customerId" id="customerId" value="<%= product.getCustomerId() %>">
            			</div>
            			<button type="submit" class="btn btn-primary">Save</button>
            		</form>
            	</div>


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
