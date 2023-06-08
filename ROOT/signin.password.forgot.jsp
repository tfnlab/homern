<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
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

  <!-- ======= Header ======= -->
  <header id="header" class="fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center">
      <h1 class="logo me-auto"><a href="index.html">HRN</a></h1>
      <!-- Uncomment below if you prefer to use an image logo -->
      <!-- <a href="index.html" class="logo me-auto"><img src="assets/img/logo.png" alt=""></a>-->

      <nav id="navbar" class="navbar order-last order-lg-0">
        <ul>
          <li><a class="nav-link scrollto" href="tel:8669325118">(866) 932-5118</a></li>
          <li><a class="nav-link scrollto" href="index.html#hero">Home</a></li>
          <li><a class="nav-link scrollto" href="index.html#services">Services</a></li>
          <li><a class="nav-link scrollto" href="index.html#portfolio">Portfolio</a></li>
          <li><a class="nav-link scrollto" href="index.html#team">Team</a></li>
          <li><a class="nav-link scrollto" href="index.html#contact">Contact</a></li>
        </ul>
        <i class="bi bi-list mobile-nav-toggle"></i>
      </nav><!-- .navbar -->

      <a href="signup.jsp" class="get-started-btn scrollto">Sign-Up</a>
    </div>
  </header><!-- End Header -->

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">Home</a></li>
          <li>Sign-In</li>
        </ol>
        <h2>Sign-In</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Forgot password</h2>
        <%

        String username = request.getParameter("username");
        String prc_user = request.getParameter("prc");
        String password = request.getParameter("password");
        String email_user = request.getParameter("email");

                // Validate form datadata
                if (password != null && password.trim().length() > 0) {
                    UserDao dao = new UserDao();
                    dao.updateUserPassword(email_user, username, prc_user, password);

                    %>Password has been reset<%

                }else if (prc_user != null && prc_user.trim().length() > 0) {
                  %>
                  <form action="signin.password.forgot.jsp" method="POST" class="mx-5">
                    <input type="hidden" id="prc" name="prc" value="<%=request.getParameter("prc")%>" />
                    <div class="form-group mt-5">
                      <label for="username" class="h4">Email:</label>
                      <input type="email" class="form-control" id="email" name="email" required tabindex="1">
                      <small id="usernameHelp" class="form-text text-muted mt-2">Enter your email to change password.</small>
                    </div>
                    <div class="form-group mt-5">
                      <label for="username" class="h4">Username:</label>
                      <input type="text" class="form-control" id="username" name="username" required tabindex="1">
                      <small id="usernameHelp" class="form-text text-muted mt-2">Enter your username to change password.</small>
                    </div>
                    <hr class="my-5">

                    <div class="form-group mt-5">
                      <label for="password" class="h4">New Password:</label>
                      <input type="password" class="form-control" id="password" name="password" required  tabindex="2">
                      <small id="passwordHelp" class="form-text text-muted mt-2">Enter your new password to reset.</small>
                    </div>

                    <div class="form-group mt-5">
                      <label for="password" class="h4">Confirm Password:</label>
                      <input type="password" class="form-control" id="passwordc" name="passwordc" required  tabindex="2">
                      <small id="passwordHelp" class="form-text text-muted mt-2">Confirm your new password</small>
                    </div>
                    <hr class="my-5">
                    <button type="submit" class="btn btn-primary btn-lg btn-block" onclick="sendTweet()" tabindex="4" >Save Password</button>
                  </form>
                  <%
                }else if (username != null && username.trim().length() > 0) {
                  Random random = new Random();
                  int num = random.nextInt(900000) + 100000;
                  String prc = String.format("%06d", num);
                  UserDao dao = new UserDao();
                  dao.updateUserPasswordReset(username, prc);
                  User user = dao.getUserByUsername(username);

                  UUID uuid = UUID.randomUUID();
                  String rm = "";
                  APIConfig ac = new APIConfig();

                  try{
                        File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
                        FileWriter fw = new FileWriter(file);
                        BufferedWriter bw = new BufferedWriter(fw);
                        String firstName = user.getFirstName();
                        String email  = user.getEmail();

                        String emailMessage =  "Dear " + firstName + ",\n"
                                                + "\n"
                                                + "We received a request to reset the password for your Home Renovation Nation account. If you did not request a password reset, please ignore this email.\n"
                                                + "\n"
                                                + "To reset your password, please click the link below:\n"
                                                + "\n"
                                                + "<a href=\"https://homerenovationnation.com/signin.password.forgot.jsp?prc=" + prc + "&username=" + username + "&email=" + email +"\" >Reset password</a> \n"
                                                + "If you are unable to click the link, you can also copy and paste it into your web browser.\n"
                                                + "\n"
                                                + "If you have any issues or concerns, please don't hesitate to contact us at info@homerenovationnation.com.\n"
                                                + "\n"
                                                + "Best regards,\n"
                                                + "Home Renovation Nation Team";

                        bw.write(email + "<CONTENT>Password Reset for Home Renovation Nation<CONTENT>" + emailMessage + "<CONTENT>info@homerenovationnation.com");
                        bw.close();

                        Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/sendmail.py", uuid.toString(), uuid.toString()).start();
                        String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                        String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                        rm = stdout + stderr + " TEST ";
                        %>
                          We have sent a password reset link to your email address. Please check your email and follow the instructions to reset your password.
                          <%=rm%>
                        <%
                    }catch(IOException ex){
                        rm = ex.getMessage();
                    }

                }else{

                // Validate other fields as necessary

                // Create User object and set its fields


        %>
        <form action="signin.password.forgot.jsp" method="POST" class="mx-5">
          <div class="form-group mt-5">
            <label for="username" class="h4">Username:</label>
            <input type="text" class="form-control" id="username" name="username" required tabindex="1">
            <small id="usernameHelp" class="form-text text-muted mt-2">Enter your username to change password.</small>
          </div>
          <hr class="my-5">
          <button type="submit" class="btn btn-primary btn-lg btn-block" onclick="sendTweet()" tabindex="4" >Reset Password</button>
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
