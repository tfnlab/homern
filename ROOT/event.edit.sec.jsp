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
          String rootUpdate = "";
          if(rip.equals("144.202.119.205")){
              UserDao uDao = new UserDao();
              username = request.getParameter("username");
              usernameOBJ = uDao.getUserByUsername(request.getParameter("username"));
              rootUpdate = "../";
          }
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" crossorigin="anonymous" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>

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

    <main id="main">
      <section id="blog" class="blog">
        <div class="container px-4 px-lg-5">
            <div class="container mt-5">
              <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
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
                      </div>

                      </section><!-- End Blog Section -->

                      </main><!-- End #main -->
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
