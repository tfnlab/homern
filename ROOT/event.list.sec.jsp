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
      <main id="main">
        <section id="blog" class="blog">
          <div class="container px-4 px-lg-5">
              <div class="container mt-5">
                <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
        <HR>
          <a href="<%=rootUpdate%>event.new.sec.jsp/"><i class="fas fa-plus"></i> Event</a>
        <HR>
        <a href="<%=rootUpdate%>event.list.calendar.sec.jsp/" >Calendar</a> |
        <a href="<%=rootUpdate%>event.list.sec.jsp/?sortBy=eventDate">Latest</a> |
        <a href="<%=rootUpdate%>event.list.sec.jsp/?sortBy=eventDateDESC">Oldest</a>
        <HR>

        <%
                EventDao eDao = new EventDao();
                String remove = request.getParameter("remove");

                TechnicianDao technicianDao = new TechnicianDao();
                List<Technician> technicians = technicianDao.getTechniciansByUsernameActive(username);
                int eId = 0;
                if (request.getParameter("eventid") != null && !request.getParameter("eventid").isEmpty()) {
                  eId = Integer.parseInt(request.getParameter("eventid"));
                }
                if (remove != null && remove.trim().length() > 0) {
                    OrderTechniciansDAO otDao = new OrderTechniciansDAO();
                    otDao.deleteOrderTechniciansByEventId(eId, username);
                    eDao.deleteEventById(eId, username);
                }

                List<Event> events = null;

                String startTime = request.getParameter("start_time");
                String endTime = request.getParameter("end_time");
                String tIdstr = request.getParameter("technicianId");
                if (startTime != null && startTime.trim().length() > 0) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    Date startTimeDate = null;
                    Date endTimeDate = null;
                      try{
                         startTimeDate = dateFormat.parse(startTime);
                         endTimeDate = dateFormat.parse(endTime);
                         events = eDao.searchEventsByDateRange(startTimeDate , endTimeDate);
                      } catch (Exception e) {
              		      %><%="Error parsing date and time string: " + e.getMessage()%><%
              		    }
                }else{
                  if(request.getParameter("sortBy")!=null){
                    if(request.getParameter("sortBy").equals("eventDate")){
                      events = eDao.getEventsByUsername(username, 1);
                    }
                    if(request.getParameter("sortBy").equals("eventDateDESC")){
                      events = eDao.getEventsByUsername(username, 2);
                    }
                  }else{
                    events = eDao.getEventsByUsername(username, 0);
                  }
                }
                %>
                <%
                  if (startTime == null) {
                    startTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(new Date());
                  }
                  if (endTime == null) {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(startTime));
                    calendar.add(Calendar.DATE, 1);
                    calendar.set(Calendar.HOUR_OF_DAY, 19);
                    calendar.set(Calendar.MINUTE, 0);
                    calendar.set(Calendar.SECOND, 0);
                    calendar.set(Calendar.MILLISECOND, 0);
                    endTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(calendar.getTime());
                  }
                %>

                <%
                  // Get the value of the "technicianId" parameter
                  String technicianId = request.getParameter("technicianId");

                  // Set the value to "all" if it is null or empty
                  if (technicianId == null || technicianId.trim().length() == 0) {
                    technicianId = "all";
                  }
                %>

                <form method="post" action="<%=rootUpdate%>event.list.sec.jsp/">
                  <div class="form-group">
                   <label for="technicianId">Technician:</label>
                   <select class="form-group" id="technicianId" name="technicianId" >
                         <option value="all" <%if(technicianId.equals("all")){%>selected<%}%> >All Technicians</option>
                       <% for (Technician technician : technicians) { %>
                         <option value="<%= technician.getTechnicianId() %>" <%if(technicianId.equals(String.valueOf(technician.getTechnicianId()))){%>selected<%}%>  ><%= technician.getTechnicianName() %></option>
                       <% } %>
                   </select>
                 </div>
                 <HR>
                  <div class="form-group">
                      <label for="start_time">Start Time</label>
                      <input type="datetime-local" class="form-control" id="start_time" name="start_time" required datepicker value="<%= startTime %>">
                  </div>
                  <BR>
                  <div class="form-group">
                    <label for="end_time">End Time</label>
                    <input type="datetime-local" class="form-control" id="end_time" name="end_time" required datepicker value="<%= endTime %>">
                  </div>
                  <HR>
                  <button type="submit" class="btn btn-primary">Filter</button>
                </form>


              <hr>
              <% if(events !=null) {%>
              <% for (Event event : events) { %>
                  <%
                    boolean showItem = true;
                    if (request.getParameter("technicianId") != null && !request.getParameter("technicianId").isEmpty()) {
                      if (!request.getParameter("technicianId").equals("all")) {
                        int tId = 0;
                        tId = Integer.parseInt(request.getParameter("technicianId"));
                        if(event.getTechnician().getTechnicianId() != tId){
                          showItem = false;
                        }
                      }
                    }
                  %>
                  <%if(showItem){%>
                Event Name: <%= event.getTitle() %><br>
                Event ID: <a href="<%=rootUpdate%>event.edit.sec.jsp?eventid=<%= event.getId() %>" ><%= event.getId() %></a><br>
                Event Description: <%= event.getDescription() %><br>
                Event Date: <%= event.getStartTime() %> - <%= event.getEndTime() %> <BR>
                <a href="<%=rootUpdate%>event.list.sec.jsp?eventid=<%= event.getId() %>&remove=yes" >REMOVE</a><br>
                <hr>
                  <%}%>
              <% } %>
              <% }%>


            </div>
            </div>

            </section><!-- End Blog Section -->

            </main><!-- End #main -->
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
</body>

</html>
