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
<%@ page import="com.tfnlab.mysql.OrderTechnicians" %>
<%@ page import="com.tfnlab.mysql.OrderTechniciansDAO" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="java.net.URLEncoder" %>
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

  <title>Home Renovation Nation - Event</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
  <!-- Include the Bootstrap CSS file -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <!-- Include the Bootstrap Datepicker CSS file -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" />

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
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
          <li>Event</li>
        </ol>
        <h2>Event</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Event</h2>
        <%@ include file="user.menu.nav.jsp" %>
        <HR>
        <a href="event.list.calendar.jsp" >Calendar</a> |
        <a href="event.list.jsp?sortBy=eventDate">Latest</a> |
        <a href="event.list.jsp?sortBy=eventDateDESC">Oldest</a>
        <HR>
        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);
                String title = request.getParameter("title");
                int eId = 0;
                if (request.getParameter("eventid") != null && !request.getParameter("eventid").isEmpty()) {
                  eId = Integer.parseInt(request.getParameter("eventid"));
                }
                // Validate form data
                Event event = new Event();
                EventDao ed = new EventDao();
                OrderTechniciansDAO otDao = new OrderTechniciansDAO();
                OrderTechnicians ot = otDao.getOrderTechniciansByEventIdAll(eId);

                  if (request.getParameter("action") != null && !request.getParameter("action").isEmpty()) {
                     try{
                            ed.deleteEventById(eId,username);
                            if(ot!=null){
                                otDao.deleteOrderTechnicians(ot.getId(),username);
                            }
                            RequestDispatcher dispatcherdc = request.getRequestDispatcher("event.list.calendar.jsp");
                            dispatcherdc.forward(request, response);
                     }catch(Exception Ex){
                        %><%=Ex.getMessage()%><%
                     }
                  }

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                SimpleDateFormat dateFormatApple = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                SimpleDateFormat dateFormatGoogleCal = new SimpleDateFormat("yyyyMMdd'T'hhmmss'Z'");
                if (title != null && title.trim().length() > 0) {

                      event = event.generateTestEvent();
                      String startTime = request.getParameter("startTime");
                      String endTime = request.getParameter("endTime");
                      String location = request.getParameter("location");
                      String description = request.getParameter("description");
                      String reminderTime = request.getParameter("reminderTime");
                      String invitees = request.getParameter("invitees");
                      String groupId = request.getParameter("groupId");
                      String event_status = request.getParameter("event_status");

                      Date startTimeDate = dateFormat.parse(startTime);
                      Date endTimeDate = dateFormat.parse(endTime);
                      Date reminderTimeDate = null;
                      if (reminderTime != null && !reminderTime.isEmpty()) {
                        reminderTimeDate = dateFormat.parse(reminderTime);
                      }

                      String locationaclat = request.getParameter("locationaclat");
                      String locationaclng = request.getParameter("locationaclng");

                      event = new Event(eId, title, startTimeDate, endTimeDate, location, description, reminderTimeDate, invitees, username, groupId, locationaclat, locationaclng, "", null, null);
                      event.setEvent_status(event_status);
                      ed.updateEventById(event);
                    %>


                        Event Saved
                      <%
                }
                  event = ed.getEventById(eId);
        %>
                    <HR>

                      <a href="https://calendar.google.com/calendar/r/eventedit?text=<%= URLEncoder.encode(event.getTitle()) %>&dates=<%= dateFormatGoogleCal.format(event.getStartTime()) %>/<%= dateFormatGoogleCal.format(event.getEndTime()) %>&location=<%= URLEncoder.encode(event.getLocation()) %>&details=<%= URLEncoder.encode(event.getDescription()) %>&trp=false&sprop=website:<%= URLEncoder.encode(usernameOBJ.getBusiness_name()) %>&sprop=name:<%=usernameOBJ.getUrl_website()%>" target="_blank">Add to Google</a>

                    <HR>
                        <%if(ot!=null){
                            OrderDao oDao = new OrderDao();
                            Order order = oDao.getOrderByOrderId(ot.getEvent().getOrder().getOrderId(), username);
                            ot.getEvent().setOrder(order);
                        %>
                            Order:
                           <a href="order.edit.jsp?orderId=<%= order.getOrderId() %>" >
                            <%= order.getOrderId() %> - <%=ot.getEvent().getOrder().getOrderName()%> </a>
                           <HR>
                           TEchnician:
                           <a href="technician.edit.jsp?technicianId=<%= ot.getEvent().getTechnician().getTechnicianId() %>"  >
                            <%=ot.getEvent().getTechnician().getTechnicianName()%></a>

                        <%}%>
                    <HR>
                    <form action="event.edit.jsp" method="post">
                          <input type="hidden" class="form-control" name="eventid" value="<%= eId %>">
                        <div class="form-group">
                          <label for="title">Title</label>
                          <input type="text" class="form-control" name="title" value="<%= event.getTitle() %>">
                        </div>
                        <div class="form-group">
                          <label for="startTime">Start Time</label>
                          <input type="datetime-local" class="form-control" name="startTime" value="<%= event.getStartTime() %>" datepicker >
                        </div>
                        <div class="form-group">
                          <label for="endTime">End Time</label>
                          <input type="datetime-local" class="form-control" name="endTime" value="<%= event.getEndTime() %>" datepicker >
                        </div>
                        <div class="form-group">
                          <label for="location">Location</label>
                          <input type="text" class="form-control" id="location" name="location" value="<%= event.getLocation() %>" onkeypress="callAC(this)" >
                          <input type="hidden" id="locationaclat" name="locationaclat" value="<%= event.getLocationaclat() %>" >
                          <input type="hidden" id="locationaclng" name="locationaclng" value="<%= event.getLocationaclng() %>">
                          <ul id="locationac" name="locationac"></ul>
                        </div>
                        <div class="form-group">
                          <label for="description">Description</label>
                          <input type="text" class="form-control" name="description" value="<%= event.getDescription() %>">
                        </div>
                 <%
                    SimpleDateFormat formatterHH = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                 %>
                        <div class="form-group">
                          <label for="reminderTime">Reminder Time</label>
                          <input type="datetime-local" class="form-control" name="reminderTime" value="<%= formatterHH.format(event.getReminderTime()) %>" datepicker >
                        </div>
                        <div class="form-group">
                          <label for="invitees">Invitees</label>
                          <input type="text" class="form-control" name="invitees" value="<%= event.getInvitees() %>">
                        </div>
                        <div class="form-group">
                          <label for="groupId">Group ID</label>
                          <input type="text" class="form-control" name="groupId" value="<%= event.getGroupId() %>" >
                        </div>
           <%
           String event_status = event.getEvent_status();
           if (event_status == null || event_status.isEmpty()) {
             event_status = "open";
           }
           %>
           <div class="form-group mt-3">
             <label for="business-type">Event Status</label>
             <% String[] orderStates = {"Open", "Closed", "Cancelled", "On Hold", "Pending", "Shipped", "Delivered", "Refunded", "Returned", "Need Attention", "In Progress"}; %>
            <select class="form-control" id="event_status" name="event_status" tabindex="16">
                <% for (int i = 0; i < orderStates.length; i++) { %>
                    <option value="<%= orderStates[i].toLowerCase() %>"
                            <% if (event_status.equals(orderStates[i].toLowerCase())) { %>selected<% } %>>
                        <%= orderStates[i] %>
                    </option>
                <% } %>
            </select>
           </div>

                        <button type="submit" class="btn btn-primary">Submit</button>
                      </form>
                        <hr>
                        <a href="event.edit.jsp?action=remove&eventid=<%= eId %>" >Remove Item</a>


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
  <script>
    <script>
      $(function () {
       var bindDatePicker = function() {
    		$(".date").datetimepicker({
            format:'YYYY-MM-DD',
    			icons: {
    				time: "fa fa-clock-o",
    				date: "fa fa-calendar",
    				up: "fa fa-arrow-up",
    				down: "fa fa-arrow-down"
    			}
    		}).find('input:first').on("blur",function () {
    			// check if the date is correct. We can accept dd-mm-yyyy and yyyy-mm-dd.
    			// update the format if it's yyyy-mm-dd
    			var date = parseDate($(this).val());

    			if (! isValidDate(date)) {
    				//create date based on momentjs (we have that)
    				date = moment().format('YYYY-MM-DD');
    			}

    			$(this).val(date);
    		});
    	}

       var isValidDate = function(value, format) {
    		format = format || false;
    		// lets parse the date to the best of our knowledge
    		if (format) {
    			value = parseDate(value);
    		}

    		var timestamp = Date.parse(value);

    		return isNaN(timestamp) == false;
       }

       var parseDate = function(value) {
    		var m = value.match(/^(\d{1,2})(\/|-)?(\d{1,2})(\/|-)?(\d{4})$/);
    		if (m)
    			value = m[5] + '-' + ("00" + m[3]).slice(-2) + '-' + ("00" + m[1]).slice(-2);

    		return value;
       }

       bindDatePicker();
     });


    </script>
  </script>
</body>

</html>
