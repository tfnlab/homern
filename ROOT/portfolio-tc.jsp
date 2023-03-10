<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.tfnlab.mysql.Review" %>
<%@ page import="com.tfnlab.mysql.ReviewDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Portfolio Details - Technicolor Dream</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

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
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="index.html">HRN<span>.</span></a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt=""></a>-->

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto" href="tel:8444767376">(844) HRN-7376</a></li>
          <li><a class="nav-link scrollto" href="index.html/#about">About Us</a></li>
          <li><a class="nav-link scrollto" href="index.html/#services">Services</a></li>
          <li><a class="nav-link scrollto" href="index.html/#portfolio">Portfolio</a></li>
          <li><a class="nav-link scrollto" href="index.html/#team">Team</a></li>
          <li><a class="nav-link scrollto" href="https://wp.homerenovationnation.com/">Blog</a></li>
          <li><a class="nav-link scrollto" href="https://opensea.io/collection/home-renovation-nation">NFT</a></li>

          <!--
          <li class="dropdown"><a href="#"><span>More</span> <i class="bi bi-chevron-down"></i></a>
            <ul>
              <li><a class="nav-link scrollto" href="signin.jsp">Sign-In</a></li>
              <li><a class="nav-link scrollto" href="signup.jsp">Sign-Up</a></li>
            </ul>
          </li>
          -->
          <li><a class="nav-link scrollto" href="#contact">Contact</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

      <a href="#about" class="get-started-btn scrollto">Get Started</a>
    </div>
  </header><!-- End Header -->

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">Home</a></li>
          <li>Reviews</li>
        </ol>
        <h2>Review Rankings</h2>

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Portfolio Details Section ======= -->
    <section id="portfolio-details" class="portfolio-details">
      <div class="container">

        <div class="row gy-4">

          <div class="col-lg-8">
            <div class="portfolio-details-slider swiper">
              <div class="swiper-wrapper align-items-center">
                <%for(int j=0;j<23;j++){%>
                <div class="swiper-slide">
                  <img src="https://meta.makotodigital.art/image/<%=j%>.png"  alt="">
                  <HR>
                  <p><a href="https://opensea.io/assets/ethereum/0xa07493367869fdac5d5f2a44cbe28f055404ce62/<%=j%>" >Open Sea</a></p>
                </div>
               <%}%>
             </div>
              <div class="swiper-pagination"></div>
            </div>
          </div>

          <div class="col-lg-4">
            <div class="portfolio-info">
              <h3>Technicolor Dream</h3>
              <ul>
                <li><strong>Category</strong>: NFT</li>
                <li><strong>Project date</strong>: 1 March, 2023</li>
                <li><strong>Project URL</strong>: <a href="https://opensea.io/collection/shibui-2">opensea.io</a></li>
              </ul>
            </div>
            <div class="portfolio-description">
              <h2>Art and Utility Project</h2>
              <p>


                Overview:
                <HR>
                Welcome to the world's largest collection of 8 x 8 pixel art, with over 10,000 pieces to explore and enjoy. Mint Website <a href="https://makotodigital.art" >Technicolor Dream</a> is an NFT collection of 10,000 8x8 pixel images. Each image is a unique and intricate design made up of individual pixels, with colors and shapes that come together to form a larger picture. These images are not only visually striking, but also provide a sense of nostalgia and whimsy, evoking memories of classic video game graphics and pixel art.
                </p>
              </div>
            </div>
          </div>

        </div>
      </div>
      <div class="container">
        <div class="row " >
          <div class="col">
          Art Project:
          <HR>
          Technicolor Dream is a unique collection of 8 by 8 pixel art created by Home Renovation Nation. It is an art project that also serves as a utility to identify community members. Each pixel art piece is a small but colorful and vibrant representation of a member of the community.
          <HR>
          The collection consists of 10,000 pixel art pieces, each one distinct and unique. The colors used in each pixel art piece are bright and bold, making each piece stand out. The collection is inspired by the retro pixel art style of the 1980s, but with a modern twist.
          <HR>
          One of the main functions of the Technicolor Dream collection is to identify community members. Each member is assigned a pixel art piece that represents them. This makes it easy for members of the community to recognize each other and feel a sense of belonging.
          <HR>
          Aside from its utility, the Technicolor Dream collection is also an art project. Each pixel art piece is a work of art in itself, with its own unique color scheme and design. The collection as a whole is a colorful and vibrant representation of the community it represents.
          <HR>
          All of the pixel art pieces in the Technicolor Dream collection are available for purchase on OpenSea. This allows anyone to own a piece of the collection and support the Home Renovation Nation community. The pieces are also available as physical variations, which can be purchased from the community's online store.
          <HR>
          In conclusion, the Technicolor Dream collection is a unique and innovative project that seamlessly blends functionality with artistic expression. By serving as a means to identify community members and showcase their vibrant personalities, this collection provides a colorful and dynamic representation of the community. Notably, the collection is available for purchase on OpenSea and as physical variations from the community's online store, making it accessible to a wide range of audiences. From interior designers to home renovation enthusiasts, anyone can find inspiration from these art pieces, which can inject a burst of color and energy into any living space. Therefore, the Technicolor Dream collection is an excellent investment for those seeking to enhance their living space with original and visually striking artwork.
          <HR>
          </div>
        </div>
      </div>
    </section><!-- End Portfolio Details Section -->

  </main><!-- End #main -->

  <footer id="footer">

    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-3 col-md-6 footer-contact">
            <h3>Home Renovation Nation<span>.</span></h3>
            <p>
              13124 Saticoy St<br>
              Suite A <br>
              North Hollywood, California 91605<br>
              United States <br><br>
              <strong>Phone:</strong> 1 (844) HRN-7376<br>
              <strong>Email:</strong> info@HomeRenovationNation.com<br>
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
              <li><i class="bx bx-chevron-right"></i> <a href="#">Design</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Development</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Management</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Design</a></li>
            </ul>
          </div>

          <div class="col-lg-4 col-md-6 footer-newsletter">
            <h4>Join Our Newsletter</h4>
            <p>Sign up to learn more about Home Renovation Nation.</p>
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
          &copy; Copyright <strong><span>Home Renovation Nation</span></strong>. All Rights Reserved 2023
        </div>
      </div>
      <div class="social-links text-center text-md-end pt-3 pt-md-0">
        <a href="https://twitter.com/HRNhome" class="twitter"><i class="bx bxl-twitter"></i></a>
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
