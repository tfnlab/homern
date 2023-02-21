<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.api.con.LinkedinPost"%>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
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
    function getMessage() {
      //genmessage.jsp?comType=latepaymentrequest
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("working").src = "assets/img/hrn/mw.png";
          document.getElementById("orderCom").innerHTML = this.responseText.trim();
        }
      };

      document.getElementById("working").src = "assets/img/hrn/mw.gif";

      var select = document.getElementById("post-type");
      var selectedOption = select.options[select.selectedIndex];
      var text = selectedOption.text;
      const encodedString = encodeURIComponent(text);
      const moreInfo = encodeURIComponent(document.getElementById("moreInfo").value);
      var urlString = "genmessage.jsp?comType=" + encodedString + "&moreInfo=" + moreInfo + "&twitter=" + document.getElementById('twitter').checked;
      //alert(urlString);
      xhttp.open("GET", urlString, true);
      xhttp.send();
    }
    function sendTweet() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          alert(this.responseText);
          //          document.getElementById("orderCom").innerHTML = this.responseText.trim();
        }
      };
      var text = document.getElementById("orderCom").innerHTML;
      if(text.length>140){
        alert('Make the message less than 140 characters')
        return;
      }
      const encodedString = encodeURIComponent(text);
      var select = document.getElementById("post-type");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.text;
      const encodedStringsub = encodeURIComponent(com);
      var urlString = "user.edit.twitter.jsp?com=" + encodedString + "&sub=" + encodedStringsub ;
      alert(urlString);
      xhttp.open("GET", urlString, true);
      xhttp.send();
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
          <li>Home</li>
        </ol>
        <h2>User</h2>
      </div>
    </section><!-- End Breadcrumbs -->
    <%
    UUID uuid = UUID.randomUUID();
    UserDao dao = new UserDao();
    String username = (String) session.getAttribute("username");
    User user = new User();
    User usernameOBJ = (User) session.getAttribute("usernameOBJ");
    String rm = "";

       String orderCom = request.getParameter("orderCom");

      if (orderCom != null && orderCom.trim().length() > 0) {
              boolean sendLinkedin = Boolean.parseBoolean(request.getParameter("linkedin"));
              boolean sendTwitter = Boolean.parseBoolean(request.getParameter("twitter"));
              if(sendLinkedin){
                LinkedinPost.sendPost(orderCom, usernameOBJ.getToken_linkedin());
              }
              if(sendTwitter){
                try{
                      APIConfig ac = new APIConfig();
                      File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
                      FileWriter fw = new FileWriter(file);
                      BufferedWriter bw = new BufferedWriter(fw);
                      bw.write("NA<CONTENT>NA<CONTENT>" +orderCom);
                      bw.close();
                      String argument =  usernameOBJ.getToken_twitter_c_key() + "HELGAMERIKYAN" + usernameOBJ.getToken_twitter_c_secret() + "HELGAMERIKYAN" + usernameOBJ.getToken_twitter_a() + "HELGAMERIKYAN" + usernameOBJ.getToken_twitter_a_secret() + "HELGAMERIKYAN" + uuid.toString();
                      Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/tweet.py", argument, argument).start();
                      String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                      String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                      rm = stdout + stderr + " TEST ";
                }catch(IOException ex){
                      rm = ex.getMessage();
                }
              }
      }

    %>
    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>User Social Management Page</h2>
        <%@ include file="user.menu.nav.jsp" %>

        <HR>
        <div class="form-group">
          <label for="post-type">Select a post type:</label>
          <select class="form-control" id="post-type" name="post-type" tabindex="2" >
            <option value="industry-updates">Industry updates</option>
            <option value="personal-updates">Personal updates</option>
            <option value="inspirational-quotes">Inspirational quotes</option>
            <option value="questions">Questions</option>
            <option value="advice">Advice</option>
            <option value="opinions">Opinions</option>
            <option value="announcements">Announcements</option>
            <option value="fun-facts">Fun facts</option>
          </select>
        </div>
        <HR>
        <div class="form-group">
          <label for="url_facebook">More Info</label>
          <input type="text" class="form-control" id="moreInfo" name="moreInfo" tabindex="3">
        </div>
        <HR>
        <form action="user.edit.social.jsp" method="POST" >
          <HR>
            <div class="form-group form-check">
              <input type="checkbox" class="form-check-input" name="twitter" id="twitter" value="true" checked tabindex="4" >
              <label class="form-check-label" for="twitter">Tweet</label>
            </div>
            <div class="form-group form-check">
              <input type="checkbox" class="form-check-input" name="linkedin" id="linkedin" value="true" checked tabindex="5" >
              <label class="form-check-label" for="linkedin">LinkedIn</label>
            </div>
          <HR>
          <a href="javascript:void(0)" onclick="getMessage()"  tabindex="6" >Generate Message <img src="assets/img/hrn/mw.png" width="50px" id="working" name="working"/></a>
          <HR>
          <div class="form-group">
            <label for="orderId">Touch Point</label><br>
            <textarea class="form-control" id="orderCom" name="orderCom" rows="10" tabindex="7" ></textarea>
          </div>

          <HR>
          <button type="submit" class="btn btn-primary" tabindex="8" >Post Message</button>
        </form>

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
