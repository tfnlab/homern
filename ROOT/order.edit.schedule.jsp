<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.OrderTechnicians" %>
<%@ page import="com.tfnlab.mysql.OrderTechniciansDAO" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.text.SimpleDateFormat" %>


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
  <%
    OrderDao dao = new OrderDao();
    OrderTechniciansDAO otD = new OrderTechniciansDAO();
    EventDao evd = new EventDao();
    TechnicianDao technicianDao = new TechnicianDao();
    int orderId = 0;
    String username = (String) session.getAttribute("username");
    User usernameOBJ = (User) session.getAttribute("usernameOBJ");
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }

    String comType = request.getParameter("comType");

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
    function getMessage() {
      //genmessage.jsp?comType=latepaymentrequest
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {

          document.getElementById("orderCom").innerHTML = this.responseText.trim();
        }
      };
      var select = document.getElementById("customer-touch-points");
      var selectedOption = select.options[select.selectedIndex];
      var text = selectedOption.text;
      const encodedString = encodeURIComponent(text);
      var urlString = "genmessage.jsp?orderId=" + document.getElementById("orderId").value + "&comType=" + encodedString ;
      xhttp.open("GET", urlString, true);
      xhttp.send();
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
    function getCom() {
      var select = document.getElementById("customer-touch-points");
      var selectedOption = select.options[select.selectedIndex];
      var com = selectedOption.value;
      var orderId = <%=orderId%>;
      var url = "order.edit.com.jsp?orderId=" + orderId +  "&comType=" + com;
      window.open(url, "_self");
    }
  </script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>


  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
          <li>Order</li>
        </ol>
        <h2>Order</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Order - Schedule </h2>
        <%@ include file="user.menu.nav.jsp" %>
                <%
                Order order = dao.getOrderByOrderId(orderId, username);
                %>
        <%

              String shippingAddress = request.getParameter("shippingAddress");
              String technicianId = request.getParameter("technicianId");
              String title = request.getParameter("title");


              // Validate form data
              String tlidstr = request.getParameter("tlid");
              if (tlidstr != null && tlidstr.trim().length() > 0) {
                int tlid = 0;
                if (!request.getParameter("tlid").isEmpty()) {
                  tlid = Integer.parseInt(request.getParameter("tlid"));
                }
                OrderTechnicians ot = otD.getOrderTechniciansById(tlid);
                otD.deleteOrderTechnicians(tlid, username);
                evd.deleteEventById(ot.getEventId(),username);
              }

              if (technicianId != null && technicianId.trim().length() > 0) {

                    String uuid = java.util.UUID.randomUUID().toString();
                    String startTime = request.getParameter("start_time");
                    String endTime = request.getParameter("end_time");
                    String location = request.getParameter("location");
                    String description = request.getParameter("description");
                    String reminderTime = request.getParameter("reminder_time");
                    String invitees = request.getParameter("invitees");
                    String groupId = request.getParameter("group_id");
                    String locationaclat = request.getParameter("locationaclat");
                    String locationaclng = request.getParameter("locationaclng");
                    String event_type = request.getParameter("event_type");
                    String event_status = request.getParameter("event_status");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                      Date startTimeDate = new Date();
                      Date endTimeDate = new Date();
                      Date reminderTimeDate = new Date();
                        try{
                           startTimeDate = dateFormat.parse(startTime);
                        } catch (Exception e) {
                           startTimeDate = new Date();
                        }
                       try{
                           endTimeDate = dateFormat.parse(endTime);
                        } catch (Exception e) {
                            endTimeDate = new Date();
                        }
                       try{
                           reminderTimeDate = dateFormat.parse(reminderTime);
                        } catch (Exception e) {
                           reminderTimeDate = new Date();
                        }
                        String[] events;
                        if (event_type.equals("installation")) {
                            String[] new_events = {
                                "Site assessment and measurement",
                                "Equipment selection and ordering",
                                "Permit acquisition",
                                "Preparation of the installation area",
                                "Disconnection and removal of old equipment",
                                "Installation of new equipment",
                                "Electrical and ductwork connections",
                                "Testing and commissioning of the new system",
                                "Clean up of the installation area",
                                "Handover and training to the customer",
                                "Follow-up inspection and maintenance."
                            };
                            events = new_events;
                        }else if (event_type.equals("maintenance")) {
                            String[] new_events  = {
                              "Inspect Vacuum Cleaner",
                              "Replace Dust Bag",
                              "Check Hose and Attachments",
                              "Lubricate Moving Parts",
                              "Clean Air Filter",
                              "Test Vacuum Cleaner"
                            };
                            events = new_events;
                        }else if (event_type.equals("replacement")) {
                            String[] new_events  = {
                              "Remove Old HVAC System",
                              "Install New HVAC System",
                              "Test New HVAC System",
                              "Explain Operation and Maintenance",
                              "Dispose of Old HVAC System",
                              "Clean Up Installation Site"
                            };
                            events = new_events;
                        } else {
                            String[] new_events = {""};
                            events = new_events;
                        }
                        for (int i = 0; i < events.length; i++) {
                                uuid = java.util.UUID.randomUUID().toString();
                                Event event = new Event(0, title  + "-" + events[i] , startTimeDate, endTimeDate, location, description, reminderTimeDate, invitees, username, groupId, locationaclat, locationaclng, uuid, null, null);
                                event.setEvent_status(event_status);
                                evd.addEvent(event);
                                event = evd.getEventByUuid(uuid);

                              int tId = 0;
                              if (request.getParameter("technicianId") != null && !request.getParameter("technicianId").isEmpty()) {
                                tId = Integer.parseInt(request.getParameter("technicianId"));
                              }
                              OrderTechnicians ot = OrderTechnicians.createSampleOrderTechnicians();
                              ot.setTechnicianId(tId);
                              ot.setOrderId(orderId);
                              ot.setEventId(event.getId());
                              ot.setUsername(username);
                              otD.insertOrderTechnicians(ot);
                       }

              }
        %>

        <HR>

                    <div class="form-group">
                      Order:
                        <a href="order.edit.jsp?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
                    </div>
        <HR>
        <form action="order.edit.schedule.jsp" method="POST" >
          <p>Order Dates: <%= order.getOrderDate() %> - <%= order.getShipDate() %></p><br>
          <p>Order Description: <%= order.getOrderDescription() %></p>
        </form>
        <%
             List<OrderTechnicians> lI = otD.getOrderTechniciansByOrderId(order.getOrderId());
             List<Technician> technicians = technicianDao.getTechniciansByUsernameActive(username);
         %>
              <%
                HashMap<Integer, Event> eMap = new HashMap<>();
                HashMap<Integer, Technician> tMap = new HashMap<>();
                if(lI.size()>0){
                    eMap = evd.getEventsByUsernameMap(username);
                    tMap = technicianDao.getTechniciansByUsernameMap(username);
                }
              %>


         <form action="order.edit.schedule.jsp" method="POST" >
         <p>



              <div class="form-group">
               <label for="technicianId">Technician:</label>
               <select class="form-group" id="technicianId" name="technicianId" >
                   <% for (Technician technician : technicians) { %>
                     <option value="<%= technician.getTechnicianId() %>"><%= technician.getTechnicianName() %></option>
                   <% } %>
               </select>
               </div>
                <HR>
             <div class="form-group">
               <label for="title">Title</label>
               <input type="text" class="form-control" id="title" name="title" required  value="<%= order.getOrderName() %>" >
             </div>
             <div class="form-group">
                 <%
                    SimpleDateFormat formatterHH = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                 %>
                 <label for="start_time">Start Time </label>
                 <input type="datetime-local" class="form-control" id="start_time" name="start_time" required  value="<%= formatterHH.format(order.getOrderDate()) %>">
             </div>
             <div class="form-group">
               <label for="end_time">End Time</label>
               <input type="datetime-local"  class="form-control"  id="end_time" name="end_time" required  value="<%= formatterHH.format(order.getShipDate()) %>">
             </div>
             <div class="form-group">
               <label for="location">Location</label>
               <input type="text" class="form-control" id="location" name="location" onkeypress="callAC(this)" value="<%= order.getShippingAddress() %>">
               <input type="hidden" id="locationaclat" name="locationaclat" value="<%= order.getShippingAddresslat() %>" >
               <input type="hidden" id="locationaclng" name="locationaclng" value="<%= order.getShippingAddresslng() %>" >
               <ul id="locationac" name="locationac"></ul>
               <hr>
             </div>
             <div class="form-group">
               <label for="description">Description</label>
               <textarea class="form-control" id="description" name="description" ><%= order.getOrderDescription() %></textarea>
             </div>
             <div class="form-group">
               <label for="reminder_time">Reminder Time</label>
               <input type="datetime-local" class="form-control" id="reminder_time" name="reminder_time" datepicker>
             </div>
             <div class="form-group">
               <label for="invitees">Invitees</label>
               <input type="email" class="form-control" id="invitees" name="invitees" placeholder="Enter email addresses separated by commas">
             </div>
               <div class="form-group mt-3">
                 <label for="business-type">Event Status</label>
                 <% String[] orderStates = {"Open", "Closed", "Cancelled", "On Hold", "Pending", "Shipped", "Delivered", "Refunded", "Returned", "Need Attention", "In Progress"}; %>
                <select class="form-control" id="event_status" name="event_status" tabindex="16">
                    <% for (int i = 0; i < orderStates.length; i++) { %>
                        <option value="<%= orderStates[i].toLowerCase() %>" >
                            <%= orderStates[i] %>
                        </option>
                    <% } %>
                </select>
               </div>
               <HR>
                <div class="form-group">
                  <label for="event_type">Add Multiple Events:</label>
                        <select name="event_type" id="event_type" >
                          <option value="none">None</option>
                          <option value="installation">Installation of new heating and cooling systems</option>
                          <option value="maintenance">Maintenance and repair services</option>
                          <option value="replacement">Replacement of old or worn out equipment</option>
                          <option value="air-quality">Indoor air quality assessment and improvement</option>
                          <option value="duct-cleaning">Duct cleaning and sealing</option>
                          <option value="efficiency">Energy efficiency upgrades</option>
                          <option value="emergency">Emergency repair services</option>
                          <option value="preventive">Preventive maintenance contracts</option>
                        </select>
                </div>
             <input type="hidden" id="orderId" name="orderId" value="<%= order.getOrderId() %>" >
             <HR>
             <input type="submit" value="Add Event">
         </p>
         </form>

  <HR>
         <%
             for (OrderTechnicians technician : lI) {
         %>
                ID: <%= technician.getId() %><br>
                Event ID: <a href="event.edit.jsp?eventid=<%= technician.getEventId() %>" ><%= technician.getEventId() %></a><br>
                Tech ID: <%= technician.getTechnicianId() %><br>
                <%=tMap.get(Integer.valueOf(technician.getTechnicianId())).getTechnicianName() %>
                -- <BR>
                <%=eMap.get(Integer.valueOf(technician.getEventId())).getTitle() %>
                -- <a href="order.edit.schedule.jsp?orderId=<%=orderId%>&tlid=<%= technician.getId() %>" >remove<a><br>
                <hr>

         <%
             }
         %>

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
