<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Portfolio Details - Presento Bootstrap Template</title>
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
  <script >
  // get the form data
  function postReview(event) {
    event.preventDefault();
    const form = document.getElementById('review-form');
    const name = form.elements['name'].value;
    const email = form.elements['email'].value;
    const rating = form.elements['rating'].value;
    const comment = form.elements['comment'].value;
    const token_id = form.elements['token_id'].value;
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'profile.save.jsp');
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function() {
      if (xhr.status === 200) {
        document.getElementById('portfolio_description_panel').innerHTML = xhr.responseText;
        console.log(xhr.responseText);
        loadReviews();

      } else {
        console.error(xhr.statusText);
      }
    };
    xhr.onerror = function() {
      console.error('Request failed.');
    };
    const formData = 'name=' + encodeURIComponent(name) + '&email=' + encodeURIComponent(email) + '&rating=' + encodeURIComponent(rating) + '&comment=' + encodeURIComponent(comment) + '&token_id=' + token_id;
    xhr.send(formData);
  }


  window.onload = function() {
    // Get a reference to the div element
    loadReviews();
  };
  function loadReviews() {
    const div = document.getElementById('portfolio_description_panel_token');

    // Create an XMLHttpRequest object
    const xhr = new XMLHttpRequest();

    // Set up the request
    xhr.open('GET', 'profile.load.jsp?token_id=<%=request.getParameter("token_id")%>');

    // Set the response type
    xhr.responseType = 'text';

    // Set up the onload handler
    xhr.onload = function() {
      if (xhr.status === 200) {
        div.innerHTML = xhr.responseText;
      } else {
        console.error(xhr.statusText);
      }
    };

    // Set up the onerror handler
    xhr.onerror = function() {
      console.error('Request failed.');
    };

    // Send the request
    xhr.send();
  }
  </script>
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="/">HRN</a></h1>
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

      <a href="signin.jsp" class="get-started-btn scrollto">Sign-In</a>
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

      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Portfolio Details Section ======= -->
    <section id="portfolio-details" class="portfolio-details">
      <div class="container">

        <div class="row gy-4">

          <div class="col-lg-8">
            <div class="portfolio-details-slider swiper">
              <div class="swiper-wrapper align-items-center">

                  <img src="technician.edit.getowner.view.jsp?contract_id=0xcFE9f30CB7C339039782DC5E4a1a24632CaF0D83&token_id=<%=request.getParameter("token_id")%>" " alt="">


              </div>
            </div>
          </div>

          <div class="col-lg-4">
            <div class="portfolio-info">
              <h3><a href="portfolio-lcd.jsp" >Home Renovation Nation</a></h3>
              <ul>
                <li><strong>Digital ID</strong>: <%=request.getParameter("token_id")%></li>
                <li><strong>URL</strong>: <a href="https://opensea.io/assets/ethereum/0xcfe9f30cb7c339039782dc5e4a1a24632caf0d83/<%=request.getParameter("token_id")%>" >opensea.io</a></li>
              </ul>
            </div>
            <div class="portfolio-description">
              <form name="review-form" id="review-form">
                    <input type="hidden" class="form-control" id="token_id" name="token_id" value="<%=request.getParameter("token_id")%>" placeholder="Enter your name">
                  <div class="form-group">
                    <label for="nameInput">Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name">
                  </div>
                  <hr>
                  <div class="form-group">
                    <label for="emailInput">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email">
                  </div>
                  <hr>
                  <div class="form-group">
                    <label for="reviewTextarea">Comments</label>
                    <textarea class="form-control" id="comment" name="comment" rows="3" placeholder="Enter your review here..."></textarea>
                  </div>
                  <HR>
                  <div class="form-group">
                    <label for="ratingInput">Rating</label>
                    <div class="d-flex">
                      <input type="radio" name="rating" id="rating1" value="1">
                      <label class="ml-2" for="rating1">1</label>
                      &nbsp;&nbsp;
                      <input type="radio" name="rating" id="rating2" value="2">
                      <label class="ml-2" for="rating2">2</label>
                      &nbsp;&nbsp;
                      <input type="radio" name="rating" id="rating3" value="3">
                      <label class="ml-2" for="rating3">3</label>
                      &nbsp;&nbsp;
                      <input type="radio" name="rating" id="rating4" value="4">
                      <label class="ml-2" for="rating4">4</label>
                      &nbsp;&nbsp;
                      <input type="radio" name="rating" id="rating5" value="5">
                      <label class="ml-2" for="rating5">5</label>
                    </div>
                  </div>
                  <HR>
                  <button type="submit" class="btn btn-primary" onclick="postReview(event)">Submit Review</button>
                </form>
                <p>
                  <HR>
                  <div class="portfolio_description_panel" id="portfolio_description_panel">


                  </div>
                </p>
            </div>
          </div>

        </div>
        <div class="row gy-4">
          <HR>
          <div class="portfolio_description_panel_token" id="portfolio_description_panel_token">

            Main for Nat Reviews

          </div>
        </div>
      </div>
    </section><!-- End Portfolio Details Section -->

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
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
