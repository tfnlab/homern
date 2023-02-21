<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.OrderTechnicians" %>
<%@ page import="com.tfnlab.mysql.OrderTechniciansDAO" %>
<!DOCTYPE html>
<html>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
<style>
.order-state-box {
  width: 70px;
  height: 50px;
  text-align: center;
  padding-top: 5px;
  font-weight: bold;
  font-size: 14px;
  color: black;
}
</style>

  </head>
  <body>


    <%@ include file="include.header.jsp" %>
        <!-- ======= Blog Section ======= -->
    <div >
    <div style="margin: 20px;">
            <HR> <HR> <HR> <HR> <HR>
            <%@ include file="user.menu.nav.jsp" %>
            <HR>
      <table>
        <tr>
          <%
            String[] orderStates = {"Open", "Closed", "Cancelled", "On Hold", "Pending", "Shipped", "Delivered", "Refunded", "Returned", "Need Attention", "In Progress"};
            String[] orderColors = {"green", "red", "orange", "blue", "purple", "pink", "yellow", "brown", "gray", "black", "teal"};
            for (int i = 0; i < orderStates.length; i++) {
          %>
          <td style="background-color: <%=orderColors[i%orderColors.length]%>">
               <hr>
              <div class="order-state-box" style="background-color: white; color: black;">
                <%=orderStates[i]%>
              </div>

          </td>
          <%
            }
          %>
          <td >
            <div class="order-state-box" >
                <a href="event.new.jsp" >
                <i class="fas fa-plus"></i>
                </a>
            </div>
          </td>
        </tr>
      </table>

      <HR>
            <%

                    String username = (String) session.getAttribute("username");
                    TechnicianDao technicianDao = new TechnicianDao();
                    List<Technician> technicians = technicianDao.getTechniciansByUsernameActive(username);
            %>
                       <select class="form-group" id="technicianId" name="technicianId" onchange="renderCalendar()" tabindex="2">
                             <option value="all" >All Technicians</option>
                           <% for (Technician technician : technicians) { %>
                             <option value="<%= technician.getTechnicianId() %>" ><%= technician.getTechnicianName() %></option>
                           <% } %>
                       </select>

            <HR>
    </div>
        <HR>
    </div>
    <div style="margin: 20px;">
    <div id='calendar' ></div>
    </div>

      <%@ include file="include.footer.jsp" %>
  </body>
      <script>
        $(document).ready(function() {
                renderCalendar();
        });

        function renderCalendar() {
            var technicianIdSelect = document.getElementById("technicianId");
            var technicianId = technicianIdSelect.options[technicianIdSelect.selectedIndex].value;
              $.ajax({
                type: "GET",
                url: "event.list.calendar.event.jsp?technicianId=" + technicianId ,
                dataType: "json",
                success: function(events) {
                  $('#calendar').fullCalendar('destroy');
                  $('#calendar').fullCalendar({ events: events });
                }
              });

              $('#calendar').fullCalendar('refetchEvents');
        }
    </script>

</html>
