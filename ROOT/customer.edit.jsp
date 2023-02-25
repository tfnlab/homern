<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
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

  <title>Home Renovation Nation - Customer</title>
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
      int eId = 0;
      if (request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty()) {
        eId = Integer.parseInt(request.getParameter("customerId"));
      }
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
    function getPayments(){
        var eId = <%=eId%>;
        var url = "customer.edit.payments.jsp?customerId=" + eId ;
        window.open(url, "_self");
    }
    function getCom() {
      var select = document.getElementById("touchPoints");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.value;
      var eId = <%=eId%>;
      var url = "customer.edit.com.jsp?customerId=" + eId +  "&comType=" + com;
      window.open(url, "_self");
    }
    function getOrders() {
      var eId = <%=eId%>;
      var url = "customer.edit.orders.jsp?customerId=" + eId;
      window.open(url, "_self");
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
          <li>Customer</li>
        </ol>
        <h2>Customer</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Customer</h2>
        <%@ include file="user.menu.nav.jsp" %>
        <HR>
          <div class="form-group">
            <label for="touchPoints">Choose a touch point:</label>
            <select class="form-control" id="touchPoints">
              <option value="initialConsultation">Initial consultation</option>
              <option value="needsAssessment" >Needs Assessment</option>
              <option value="contractSigning">Contract signing</option>
              <option value="preConstructionMeeting">Pre-construction meeting</option>
              <option value="onSiteVisits">On-site visits</option>
              <option value="maintenanceduereminder" >Maintenance Due Reminder</option>
              <option value="progressUpdates">Progress updates</option>
              <option value="finalWalkThrough">Final walk-through</option>
              <option value="warrantyAndMaintenance">Warranty and maintenance</option>
            </select>
          </div>
        <HR>
        <button class="btn btn-primary" onclick="getCom()">Correspondence</button>
        <button class="btn btn-primary" onclick="getPayments()">Payments</button>
        <button class="btn btn-primary" onclick="getOrders()">Orders</button>
        <HR>
        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);
                String first_name = request.getParameter("firstName");

                // Validate form data
                Entity entity = new Entity();
                EntityDao ed = new EntityDao();

                if (first_name != null && first_name.trim().length() > 0) {

                      entity = entity.generateSampleEntity();
//                      entity.setId(Integer.parseInt(request.getParameter("id")));
                      entity.setUsername(username);
                      entity.setFirstName(request.getParameter("firstName"));
                      entity.setLastName(request.getParameter("lastName"));
                      entity.setEmail(request.getParameter("email"));
                      entity.setPhone(request.getParameter("phone"));
                      entity.setAddress(request.getParameter("address"));
                      entity.setAddress2(request.getParameter("address2"));
                      entity.setCity(request.getParameter("city"));
                      entity.setState(request.getParameter("state"));
                      entity.setZipcode(request.getParameter("zipcode"));
                      entity.setCountry(request.getParameter("country"));
                      // parse birthday as a Date object

                      String dateString = request.getParameter("birthday");
                      Date date = null;
                      if (dateString != null) {
                          try {
                              SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                              date = dateFormat.parse(dateString);
                              entity.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("birthday")));
                              // date is a valid date
                          } catch (ParseException e) {
                              // dateString is not a valid date
                              dateString = "1980-24-10";
                              entity.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
//                              date = dateFormat.parse(dateString);
                          }
                      }
//                      entity.setBirthday(dateString);

                      entity.setGender(request.getParameter("gender"));
                      entity.setMaritalStatus(request.getParameter("maritalStatus"));
                      entity.setNationality(request.getParameter("nationality"));
                      entity.setOccupation(request.getParameter("occupation"));
                      entity.setIncomeRange(request.getParameter("incomeRange"));
                      entity.setEducationLevel(request.getParameter("educationLevel"));
                      entity.setPreferences(request.getParameter("preferences"));
                      entity.setInterests(request.getParameter("interests"));
                      entity.setEmergencyContactName(request.getParameter("emergencyContactName"));
                      entity.setEmergencyContactRelationship(request.getParameter("emergencyContactRelationship"));
                      entity.setEmergencyContactPhone(request.getParameter("emergencyContactPhone"));
                      entity.setReferralSource(request.getParameter("referralSource"));
                      entity.setLoyaltyProgram(request.getParameter("loyaltyProgram"));
                      int loyaltyPoints = 0;
                      String loyaltyPointsString = request.getParameter("loyaltyPoints");
                      if (loyaltyPointsString != null) {
                          try {
                              loyaltyPoints = Integer.parseInt(loyaltyPointsString);
                              // loyaltyPoints is a valid integer
                          } catch (NumberFormatException e) {
                              // loyaltyPointsString is not a valid integer
                          }
                      }
                      entity.setLoyaltyPoints(loyaltyPoints);
                      entity.setFacebookUsername(request.getParameter("facebookUsername"));
                      entity.setTwitterHandle(request.getParameter("twitterHandle"));
                      entity.setInstagramUsername(request.getParameter("instagramUsername"));
                      entity.setLinkedinUrl(request.getParameter("linkedinUrl"));
                      entity.setYoutubeChannel(request.getParameter("youtubeChannel"));
                      // parse createdAt as a Timestamp object
                      entity.setCreatedAt(currentTime);
                      entity.setCreatedBy(username);
                      // parse createdDate as a Date object
//                      entity.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").parse(request
                      // parse createdDate as a Date object
                      //entity.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("createdDate")));
                      //entity.setLastModifiedBy(request.getParameter("lastModifiedBy"));
                      // parse lastModifiedDate as a Timestamp object
                      //entity.setLastModifiedDate(new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("lastModifiedDate")).getTime()));
                      entity.setId(eId);

                      entity.setLocation_pointlat(request.getParameter("location_pointlat"));
                      entity.setLocation_pointlng(request.getParameter("location_pointlng"));
                      entity.setCompany_name(request.getParameter("company_name"));
                      entity.setDisplay_name(request.getParameter("display_name"));



                      ed.updateEntityById(entity);
                    %>


                        Order Saved
                      <%
                }
                  entity = ed.getEntityById(eId, username);
        %>
                    <form action="customer.edit.jsp" method="post">
                      <input type="hidden" class="form-control" id="customerId" name="customerId" value="<%= entity.getId() %>" readonly>
                      <!--
                      <div class="form-group">
                         ID <%= entity.getId() %>
                      </div>
                      <HR>
                      -->

                      <input type="hidden" class="form-control" id="location_pointlat" name="location_pointlat" value="<%= entity.getLocation_pointlat() %>">
                      <input type="hidden" class="form-control" id="location_pointlng" name="location_pointlng" value="<%= entity.getLocation_pointlng() %>">
                      <div class="form-group">
                        <label for="firstName">Company Name</label>
                        <input type="text" class="form-control" id="company_name" name="company_name" value="<%= entity.getCompany_name() %>">
                      </div>
                      <div class="form-group">
                        <label for="firstName">First Name</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" value="<%= entity.getFirstName() %>">
                      </div>
                      <div class="form-group">
                        <label for="lastName">Last Name</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" value="<%= entity.getLastName() %>">
                      </div>
                      <div class="form-group">
                        <label for="lastName">Display Name</label>
                        <input type="text" class="form-control" id="display_name" name="display_name" value="<%= entity.getDisplay_name() %>">
                      </div>
                      <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= entity.getEmail() %>">
                      </div>

          <div class="form-group">
            <label for="phone">Phone</label>
            <input type="tel" class="form-control" id="phone" name="phone" value="<%= entity.getPhone() %>">
          </div>
          <div class="form-group">
            <label for="address">Address</label>
            <input type="text" class="form-control" id="address" name="address" value="<%= entity.getAddress() %>">
          </div>
          <div class="form-group">
            <label for="address">Address Line 2</label>
            <input type="text" class="form-control" id="address2" name="address2" value="<%= entity.getAddress2() %>">
          </div>
          <div class="form-group">
            <label for="city">City</label>
            <input type="text" class="form-control" id="city" name="city" value="<%= entity.getCity() %>">
          </div>
          <div class="form-group">
            <label for="state">State</label>
            <input type="text" class="form-control" id="state" name="state" value="<%= entity.getState() %>">
          </div>
          <div class="form-group">
            <label for="zipcode">Zipcode</label>
            <input type="text" class="form-control" id="zipcode" name="zipcode" value="<%= entity.getZipcode() %>">
          </div>
          <div class="form-group">
            <label for="country">Country</label>
            <input type="text" class="form-control" id="country" name="country" value="<%= entity.getCountry() %>">
          </div>
          <div class="form-group">
            <label for="birthday">Birthday</label>
            <input type="date" class="form-control" id="birthday" name="birthday" value="<%= entity.getBirthday() %>">
          </div>
          <div class="form-group">
            <label for="gender">Gender</label>
            <select class="form-control" id="gender" name="gender" >
              <option value="">Select</option>
              <option value="male">Male</option>
              <option value="female">Female</option>
              <option value="other">Other</option>
            </select>
          </div>
            <div class="form-group">
              <label for="maritalStatus">Marital Status</label>
              <select class="form-control" id="maritalStatus" name="maritalStatus" >
                <option value="">Select</option>
                <option value="single">Single</option>
                <option value="married">Married</option>
                <option value="divorced">Divorced</option>
                <option value="widowed">Widowed</option>
              </select>
            </div>
            <div class="form-group">
              <label for="nationality">Nationality</label>
              <input type="text" class="form-control" id="nationality" name="nationality" value="<%= entity.getNationality() %>">
            </div>
            <div class="form-group">
              <label for="occupation">Occupation</label>
              <input type="text" class="form-control" id="occupation" name="occupation" >
            </div>
            <div class="form-group">
              <label for="incomeRange">Income Range</label>
              <select class="form-control" id="incomeRange" name="incomeRange" >
                <option value="">Select</option>
                <option value="low">Low</option>
                <option value="medium">Medium</option>
                <option value="high">High</option>
              </select>
            </div>
            <div class="form-group">
              <label for="educationLevel">Education Level</label>
              <input type="text" class="form-control" id="educationLevel" name="educationLevel" >
            </div>
            <div class="form-group">
              <label for="preferences">Preferences</label>
              <input type="text" class="form-control" id="preferences" name="preferences" >
            </div>
            <div class="form-group">
              <label for="interests">Interests</label>
              <input type="text" class="form-control" id="interests" name="interests" >
            </div>
            <div class="form-group">
              <label for="emergencyContactName">Emergency Contact Name</label>
              <input type="text" class="form-control" id="emergencyContactName" name="emergencyContactName" >
            </div>
            <div class="form-group">
              <label for="emergencyContactRelationship">Emergency Contact Relationship</label>
              <input type="text" class="form-control" id="emergencyContactRelationship" name="emergencyContactRelationship" >
            </div>
            <div class="form-group">
              <label for="emergencyContactPhone">Emergency Contact Phone</label>
              <input type="tel" class="form-control" id="emergencyContactPhone" name="emergencyContactPhone" >
            </div>
              <div class="form-group">
                <label for="referralSource">Referral Source</label>
                <input type="text" class="form-control" id="referralSource" name="referralSource" >
              </div>
              <div class="form-group">
                <label for="loyaltyProgram">Loyalty Program</label>
                <input type="text" class="form-control" id="loyaltyProgram" name="loyaltyProgram" >
              </div>
              <div class="form-group">
                <label for="loyaltyPoints">Loyalty Points</label>
                <input type="number" class="form-control" id="loyaltyPoints" name="loyaltyPoints" >
              </div>
              <div class="form-group">
                <label for="facebookUsername">Facebook Username</label>
                <input type="text" class="form-control" id="facebookUsername" name="facebookUsername" >
              </div>
              <div class="form-group">
                <label for="twitterHandle">Twitter Handle</label>
                <input type="text" class="form-control" id="twitterHandle" name="twitterHandle" >
              </div>
              <div class="form-group">
                <label for="instagramUsername">Instagram Username</label>
                <input type="text" class="form-control" id="instagramUsername" name="instagramUsername" >
              </div>
              <div class="form-group">
                <label for="linkedinUrl">LinkedIn URL</label>
                <input type="text" class="form-control" id="linkedinUrl" name="linkedinUrl" >
              </div>
              <div class="form-group">
                <label for="youtubeChannel">YouTube Channel</label>
                <input type="text" class="form-control" id="youtubeChannel" name="youtubeChannel" >
              </div>
              <button type="submit" class="btn btn-primary">Submit</button>
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
