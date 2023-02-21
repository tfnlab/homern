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


    <%@ include file="include.header.jsp" %>

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">Home</a></li>
          <li>Sign-up</li>
        </ol>
        <h2>Terms of Service</h2>
        </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h4>Terms of Service</h4>
<p>
  Welcome to Home Renovation Nation! Our platform provides software as a service (SaaS) for homeowners and contractors. By using our platform, you are agreeing to the following terms and conditions:

Eligibility: You must be 18 years or older to use our services. By using our platform, you represent and warrant that you are of legal age to form a binding contract and that you comply with all of the terms and conditions of this Agreement.

Account: In order to use certain features of our platform, you will need to create an account. You are responsible for maintaining the confidentiality of your account credentials and for any activity that occurs on your account. You agree to notify us immediately of any unauthorized use of your account.

User Content: You are solely responsible for any User Content that you upload, post, or otherwise make available on or through our platform. You represent and warrant that you have all necessary rights to the User Content and that such content does not infringe on any third party's intellectual property rights.

Use of our Platform: You agree to use our platform only for lawful purposes and in accordance with these terms. You may not use our platform in any way that is fraudulent, illegal, or in violation of any third-party rights. Additionally, you may not use our platform in any way that could damage, disable, overburden, or impair the operation of the platform or interfere with any other party's use and enjoyment of the platform.

Termination: We reserve the right to terminate your use of our platform at any time and for any reason, including but not limited to your violation of these terms.

Disclaimer of Warranties: Our platform is provided on an "as is" and "as available" basis. We make no representations or warranties of any kind, express or implied, as to the operation of our platform, the information, content, materials or products included on our platform. You expressly agree that your use of our platform is at your sole risk.

Limitation of Liability: In no event shall we be liable for any damages whatsoever, including but not limited to any direct, indirect, special, incidental, or consequential damages, arising out of or in connection with the use or inability to use our platform.

Indemnification: You agree to indemnify and hold us, our officers, employees, agents, and assigns harmless from any and all claims, damages, expenses, and costs, including reasonable attorneys' fees, arising from your use of our platform or your violation of these terms.

Changes to our Platform and these terms: We reserve the right to make changes to our platform and these terms at any time. Any changes to these terms will be effective immediately upon posting on our platform. Your continued use of our platform after any such changes constitutes your acceptance of the new terms.

Governing Law: These terms and conditions shall be governed by and construed in accordance with the laws of the country in which the company is incorporated without giving effect to any principles of conflicts of law.

Contact Us: If you have any questions or comments about our platform or these terms, please contact us.

By using our platform, you confirm that you have read, understood, and agree to be bound by these terms and conditions. If you do not agree to these terms, you are not authorized to use our platform.
</p>
      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->


  <%@ include file="include.footer.jsp" %>

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
