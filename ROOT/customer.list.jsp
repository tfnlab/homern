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
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <%
            User usernameOBJ = (User)session.getAttribute("usernameOBJ");
            String username = (String) session.getAttribute("username");

  %>
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Home Renovation Nation - Customer List</title>
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

  <button type="button" class="btn btn-primary" id="viewCustomerButton" data-toggle="modal" data-target="#customerModal" style="display: none;"/>
    View Customer Details
  </button>

  <!-- Modal -->
  <div class="modal fade" id="customerModal" tabindex="-1" role="dialog" aria-labelledby="customerModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="customerModalLabel">Customer Details</h5>
        </div>
        <div class="modal-body" id="customerModalBody">
          <!-- Customer details will be inserted here -->
        </div>
        <div class="modal-footer">
          <a href="#" class="btn btn-secondary" role="button" id="customerDetailButton">Detail</a>
        </div>
      </div>
    </div>
  </div>
  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">Home</a></li>
          <li>Customers</li>
        </ol>
        <h2>Customers</h2>
      </div>
    </section><!-- End Breadcrumbs -->
    <!-- Button trigger modal -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Customers</h2>
        <HR>
        <%@ include file="user.menu.nav.jsp" %>
        <HR>
          <a href="customer.new.jsp"  tabindex="2"><i class="fas fa-plus"></i> Customer</a>
          <HR>
              <%
                 String searchKey = request.getParameter("searchKey");
                EntityDao cDao = new EntityDao();
                List<Entity> es = null;

                if (searchKey != null && searchKey.trim().length() > 0) {
                    es = cDao.searchSearchKeyByUsername(username, searchKey);
                }else{
                    searchKey = "";
                    es = cDao.getEntitiesByUsername(username);
                }
                %>
                <form action="customer.list.jsp" method="post">
                  <div class="form-group mt-3">
                    <div class="row">
                      <div class="col">
                    <input type="text" class="form-control" id="searchKey" name="searchKey" value="<%= searchKey %>" tabindex="3" >
                      </div>
                      <div class="col">
                    <input type="checkbox" class="form-check-input" name="showMap" id="showMap" value="true"
                      <%
                        String showMap = request.getParameter("showMap");
                        if (showMap != null) {
                          %>checked<%
                        }
                      %>
                      tabindex="4"
                      >
                    <label class="form-check-label" for="availability">Map</label>
                      </div>
                    </div>
                  </div>

                  <HR>
                  <button type="submit" class="btn btn-primary" tabindex="5">Search</button>
                </form>
                <%if(request.getParameter("showMap")!=null){%>
                  <HR>
                  <div id="map" style="width: 100%; height: 400px;"></div>
                  <HR>
                  <!-- Include the Google Maps JavaScript API -->
                  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBicfOJqKecv8AunaLFvEC0bRBWMVUtQus"></script>
                  <script>
                    // Create a map
                    var map = new google.maps.Map(document.getElementById('map'), {
                      mapTypeId: 'roadmap',
                      center: {lat: <%=usernameOBJ.getAddresslat().trim()%>, lng: <%=usernameOBJ.getAddresslng()%>}
                    });

                    map.setOptions({
                      center: {lat: <%=usernameOBJ.getAddresslat()%>, lng: <%=usernameOBJ.getAddresslng()%>},
                      zoom: 8
                    });

                    // Update the map options to make the map responsive.
                    window.addEventListener('resize', function() {
                      map.setOptions({
                        center: {lat: <%=usernameOBJ.getAddresslat()%>, lng: <%=usernameOBJ.getAddresslng()%>},
                        zoom: 8
                      });
                    });

                    <%// Create a marker
                    int ke = 0;
                    for (Entity entity : es) { %>
                    var marker<%=ke%> = new google.maps.Marker({
                      position: {lat: <%=entity.getLocation_pointlat()%>, lng: <%=entity.getLocation_pointlng()%>},
                      map: map,
                      label: '<%=entity.getFirstName()%> <%=entity.getLastName()%>',
                      title: '<%=entity.getAddress()%>'
                    });
                    marker<%=ke%>.addListener('click', function() {
                      // Update the modal body with the customer details
                      document.getElementById('customerModalBody').innerHTML = '<p><%=entity.getFirstName()%> <%=entity.getLastName()%></p><p><%=entity.getAddress()%></p>';
                      // Update the detail button with the customer ID
                      document.getElementById('customerDetailButton').href = 'customer.edit.jsp?customerId=<%=entity.getId()%>';
                      // Show the modal
                      $('#customerModal').modal('show');

                      //alert('<%=entity.getFirstName()%> <%=entity.getLastName()%>, <%=entity.getAddress()%> <a href="customer.edit.jsp?customerId=" >Detail</a>');
                    });
                    <%
                        ke+=1;
                    } %>
                  </script>

                <%}%>
                <HR>
              <% for (Entity entity : es) { %>
                  <%try{%>
                  First Name: <%= entity.getFirstName() %><br>
                  <%if(!entity.getLastName().isEmpty()){%>
                    Last Name: <%= entity.getLastName() %><br>
                  <%}%>
                  <%if(!entity.getAddress().isEmpty()){%>
                  Address: <%= entity.getAddress() %><br>
                  <%}%>
                  <%if(entity.getAddress2()!=null && !entity.getAddress2().isEmpty()){%>
                    Address2: <%= entity.getAddress2() %><br>
                  <%}%>
                  <%if(!entity.getPhone().isEmpty()){%>
                  Phone: <%= entity.getPhone() %><br>
                  <%}%>
                  Email: <%= entity.getEmail() %><br>
                  Customer ID: <a href="customer.edit.jsp?customerId=<%= entity.getId() %>" ><%= entity.getId() %></a><br>
                  <%}catch(Exception ex){%>
                        <%=ex.getMessage()%>
                  <%}%>
                <hr>
              <% } %>


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
