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

  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
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


          <%@ include file="include.header.jsp" %>

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
            <hr>
        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);


                  // Get the form data from the request
                  String sku = request.getParameter("sku");
                  String name = request.getParameter("name");

                if (name != null && name.trim().length() > 0) {
                  int id = 0;
                  BigDecimal price = new BigDecimal("0");
                  int inventory = 0;
                  int reorderLevel = 0;
                  int leadTime = 0;
                  boolean featured = false;
                  BigDecimal rating = new BigDecimal("0");

                  String priceStr = request.getParameter("price");
                  if (priceStr != null) {
                    price = new BigDecimal(priceStr);
                  }

                  String inventoryStr = request.getParameter("inventory");
                  if (inventoryStr != null && inventoryStr.trim().length() > 0) {
                    inventory = Integer.parseInt(inventoryStr);
                  }

                  String reorderLevelStr = request.getParameter("reorder_level");
                  if (reorderLevelStr != null && reorderLevelStr.trim().length() > 0) {
                    reorderLevel = Integer.parseInt(reorderLevelStr);
                  }

                  String leadTimeStr = request.getParameter("lead_time");
                  if (leadTimeStr != null && leadTimeStr.trim().length() > 0) {
                    leadTime = Integer.parseInt(leadTimeStr);
                  }

                  String featuredStr = request.getParameter("featured");
                  if (featuredStr != null && featuredStr.trim().length() > 0) {
                    featured = Boolean.parseBoolean(featuredStr);
                  }

                  String ratingStr = request.getParameter("rating");
                  if (ratingStr != null && ratingStr.trim().length() > 0) {
                    rating = new BigDecimal(ratingStr);
                  }

                  String description = request.getParameter("description");
                  String imageUrl = request.getParameter("image_url");
                  Timestamp createdAt = currentTime;
                  Timestamp updatedAt = currentTime;
                  int categoryId = 0;
                  int manufacturerId = 0;
                  boolean availability = false;
                  BigDecimal weight = new BigDecimal("0");

                  String categoryIdStr = request.getParameter("category_id");
                  if (categoryIdStr != null && categoryIdStr.trim().length() > 0) {
                    categoryId = Integer.parseInt(categoryIdStr);
                  }

                  String manufacturerIdStr = request.getParameter("manufacturer_id");
                  if (manufacturerIdStr != null && manufacturerIdStr.trim().length() > 0) {
                    manufacturerId = Integer.parseInt(manufacturerIdStr);
                  }


                  availability = Boolean.parseBoolean(request.getParameter("availability"));

                  String weightStr = request.getParameter("weight");
                  if (weightStr != null && weightStr.trim().length() > 0) {
                    weight = new BigDecimal(weightStr);
                  }
                  String dimensions = request.getParameter("dimensions");
                  String customerId = username;

                  // Create a new Product object
                  Product product = new Product(id, sku, name, price, inventory, reorderLevel, leadTime, featured, rating, description, imageUrl, createdAt, updatedAt, categoryId, manufacturerId, availability, weight, dimensions, customerId);

                  // Create a new ProductDao object
                  ProductDao dao = new ProductDao();

                  // Insert the Product object into the database
                  try{
                      dao.insertProduct(product);
                  }catch(Exception ex){
                        %><%=ex.getMessage()%><%
                  }
                %>
                <p>Product successfully added to the database.</p>
                <HR>
                  <a href="product.new.jsp" tabindex="2"><i class="fas fa-plus"></i> Product</a>
                <HR>
                <HR>
                  <a href="product.list.jsp" tabindex="2"><i class="fas fa-list"></i> List Products</a>
                <HR>
                <%

                }else{

        %>
            <!-- ======= Contact Section ======= -->
            <HR>
                <a href="product.new.batch.jsp" >Bulk Create</a>
            <HR>
            <form action="product.new.jsp" method="post">
              <div class="form-group">
                <label for="sku">SKU:</label>
                <input type="text" class="form-control" id="sku" name="sku" tabindex="2">
              </div>
              <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" tabindex="3">
              </div>
              <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" class="form-control" id="price" name="price" tabindex="4" required>
              </div>
              <div class="form-group">
                <label for="inventory">Inventory:</label>
                <input type="number" class="form-control" id="inventory" name="inventory" tabindex="5">
              </div>
              <div class="form-group">
                <label for="reorder_level">Reorder Level:</label>
                <input type="number" class="form-control" id="reorder_level" name="reorder_level" tabindex="6">
              </div>
              <div class="form-group">
                <label for="lead_time">Lead Time:</label>
                <input type="number" class="form-control" id="lead_time" name="lead_time" tabindex="7">
              </div>
              <div class="form-group">
                <label for="featured">Featured:</label>
                <input type="checkbox" class="form-check-input" id="featured" name="featured" tabindex="8">
              </div>
              <div class="form-group">
                <label for="rating">Rating:</label>
                <input type="number" class="form-control" id="rating" name="rating" tabindex="9">
              </div>
              <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" id="description" name="description" tabindex="10"></textarea>
              </div>
              <div class="form-group">
                <label for="image_url">Image URL:</label>
                <input type="text" class="form-control" id="image_url" name="image_url" tabindex="11">
              </div>
              <div class="form-group">
                <label for="category_id">Category ID:</label>
                <input type="number" class="form-control" id="category_id" name="category_id" tabindex="12">
              </div>
              <div class="form-group">
                <label for="manufacturer_id">Manufacturer ID:</label>
                <input type="number" class="form-control" id="manufacturer_id" name="manufacturer_id" tabindex="13">
              </div>
              <div class="form-group">
                <label for="availability">Availability:</label>
                <input type="checkbox" class="form-check-input" id="availability" name="availability" tabindex="14">
              </div>
              <div class="form-group">
                <label for="weight">Weight:</label>
                <input type="number" class="form-control" id="weight" name="weight" tabindex="15">
              </div>
              <div class="form-group">
                <label for="dimensions">Dimensions:</label>
                <input type="text" class="form-control" id="dimensions" name="dimensions" tabindex="16">
              </div>
              <hr>
              <input type="submit" class="btn btn-primary" value="Submit" tabindex="17">
              </form>


                 <%}%>
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
