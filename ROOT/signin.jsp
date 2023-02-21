<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
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
          <li>Sign-In</li>
        </ol>
        <h2>Sign-In</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Sign-In</h2>
        <p>
        </p>
        <%
        String firstName = request.getParameter("firstName");
        String middleInitial = request.getParameter("middleInitial");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ogId = request.getParameter("ogId");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String business_type = request.getParameter("business_type");
        String url_website = request.getParameter("url_website");
        String url_yelp = request.getParameter("url_yelp");
        String url_google = request.getParameter("url_google");
        String url_twitter = request.getParameter("url_twitter");
        String url_tiktok = request.getParameter("url_tiktok");
        String url_snap = request.getParameter("url_snap");
        String url_instagram = request.getParameter("url_instagram");
        String url_facebook = request.getParameter("url_facebook");
        String referred_by = request.getParameter("referred_by");


                // Validate form data
                if (username != null && username.trim().length() > 0) {
                  username = username.toLowerCase();
                  User user = new User(firstName, middleInitial, lastName, email, phone, username, password, ogId, address, city, state, zipcode, "0", "0", business_type, "", "", url_website, url_yelp, url_google, url_twitter, url_tiktok, url_snap, url_instagram, url_facebook, referred_by, "url_linkedin", "token_linkedin", "token_twitter_c_key", "token_twitter_c_secret", "token_twitter_a", "token_twitter_a_secret", "api_key");
                  UserDao dao = new UserDao();
                  try {
                      boolean pv = true;
                      String um = "Thank you for signing in";
                      if (username == null || username.isEmpty()) {
                        pv = false;
                        um  = "Username can't be Empty";
                      }
                      if (password == null || password.isEmpty()) {
                        pv = false;
                        um  = "Password can't be Empty";
                      }

                      if(pv){
                        pv = dao.loginUser(user);
                      }
                        if(pv){
                          um  = "Thank you for signing in! You are now able to access the main menu. Simply click 'Next' to proceed.";
                          user = dao.getUserByUsername(username);
                          session.setAttribute("username", username);
                          session.setAttribute("usernameOBJ", user);
                        }else{
                          um  = "Unable to Login, you are NOT signed in";
                        }
                        %>
                        <p>
                          <%=um%>
                          <%
                          if(pv){
                          %>
                            <BR>
                            <BR>
                            <HR>
                            <%if(user.getBusiness_type().equals("home-owner")){%>
                              <a href="https://homerenovationnation.com/customer/user.menu.jsp">NEXT</a>
                            <%}else{%>
                              <a href="https://homerenovationnation.com/user.menu.jsp">NEXT</a>
                            <%}%>
                            <HR>
                          <%
                          }else{
                            %>
                               <script>
                                      localStorage.setItem('username', "");
                                      localStorage.setItem('password', "");
                                </script>
                            <%
                          }
                          %>
                        </p>
                        <%

                  } catch (Exception e) {
                      %><%="An error occurred: " + e.getMessage()%>

                                         <%
                  }


                }else{

                // Validate other fields as necessary

                // Create User object and set its fields


        %>
        <form action="signin.jsp" method="POST" class="mx-5" name="login" id="login">
          <div class="form-group mt-5">
            <label for="username" class="h4">Username:</label>
            <input type="text" class="form-control" id="username" name="username" required tabindex="1">
            <small id="usernameHelp" class="form-text text-muted mt-2">Enter your username to sign in.</small>
          </div>
          <div class="form-group mt-5">
            <label for="password" class="h4">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required  tabindex="2">
            <small id="passwordHelp" class="form-text text-muted mt-2">Enter your password to sign in. <a href="signin.password.forgot.jsp" >forgot password</a></small>
          </div>
          <div class="form-group mt-5">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" value="" id="remember-me"  name="remember-me" tabindex="3">
              <label class="form-check-label" for="remember-me">
                Remember me
              </label>
            </div>
          </div>
          <hr class="my-5">
          <button type="submit" class="btn btn-primary btn-lg btn-block" onclick="sendTweet()" tabindex="4" >Sign-In</button>

        </form>
        <script>
          // get the remember me checkbox
          const rememberMeCheckbox = document.getElementById('remember-me');

          // add an event listener to the checkbox
          rememberMeCheckbox.addEventListener('change', function(event) {
            // store the username and password in local storage if the checkbox is checked
            if (event.target.checked) {
              // get the username and password values from the form
              const username = document.getElementById('username').value;
              const password = document.getElementById('password').value;

              // store the username and password in local storage
              localStorage.setItem('username', username);
              localStorage.setItem('password', password);
            }
          });

          // get the stored username and password from local storage
          const storedUsername = localStorage.getItem('username');
          const storedPassword = localStorage.getItem('password');

          // if the stored username and password are present, set the values of the form fields and check the "Remember me" checkbox
          if (storedUsername && storedPassword) {
            // set the values of the form fields to the stored values
            document.getElementById('username').value = storedUsername;
            document.getElementById('password').value = storedPassword;

            // check the "Remember me" checkbox
            document.getElementById('remember-me').checked = true;
            document.getElementById("login").submit();
          }

        </script>

                 <%}%>
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
