<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="com.tfnlab.mysql.Event" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.UUID" %>
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
  <script>
function formatDate(date, time) {
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, "0");
    var day = date.getDate().toString().padStart(2, "0");
    return year + "-" + month + "-" + day + "T" + time;
}
function tomorrowM(inputField , end_time, reminder_time) {
    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById(inputField).value = formatDate(tomorrow, "09:00");
    document.getElementById(end_time).value = formatDate(tomorrow, "10:00");
    document.getElementById(reminder_time).value = formatDate(tomorrow, "08:00");
}
function tomorrowE(inputField , end_time, reminder_time) {
    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    document.getElementById(inputField).value = formatDate(tomorrow, "14:00");
    document.getElementById(end_time).value = formatDate(tomorrow, "15:00");
    document.getElementById(reminder_time).value = formatDate(tomorrow, "13:00");
}
function nextWeek(inputField , end_time, reminder_time) {
    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 7);
    document.getElementById(inputField).value = formatDate(tomorrow, "09:00");
    document.getElementById(end_time).value = formatDate(tomorrow, "10:00");
    document.getElementById(reminder_time).value = formatDate(tomorrow, "08:00");
}
function nextMonth(inputField , end_time, reminder_time) {
    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 30);
    document.getElementById(inputField).value = formatDate(tomorrow, "09:00");
    document.getElementById(end_time).value = formatDate(tomorrow, "10:00");
    document.getElementById(reminder_time).value = formatDate(tomorrow, "08:00");
}
function nextQ(inputField , end_time, reminder_time) {
    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 90);
    document.getElementById(inputField).value = formatDate(tomorrow, "09:00");
    document.getElementById(end_time).value = formatDate(tomorrow, "10:00");
    document.getElementById(reminder_time).value = formatDate(tomorrow, "08:00");
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

        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);


                  // Get the form data from the request
                  String title = request.getParameter("title");

                if (title != null && title.trim().length() > 0) {
                  int id = 0;

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
                  if (request.getParameter("locationaclat") == null || request.getParameter("locationaclat").isEmpty()) {
                    locationaclat = "0.0";
                  }
                  if (request.getParameter("locationaclng") == null || request.getParameter("locationaclng").isEmpty()) {
                    locationaclng = "0.0";
                  }

                  //2022-12-30T17:35
//                  SimpleDateFormat dateFormat = new SimpleDateFormat("MM/DD/YYYY, HH:MM AM");
//                  SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy, HH:mm a");
                  //SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy',' HH':'mm a");
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

                  String event_status = request.getParameter("event_status");
                  Event event = new Event(0, title, startTimeDate, endTimeDate, location, description, reminderTimeDate, invitees, username, groupId, locationaclat, locationaclng, uuid, null, null);
                  event.setEvent_status(event_status);
                  EventDao evd = new EventDao();

                  evd.addEvent(event);
                  // Create a new Product object

                  // Insert the Product object into the database
                %>
                <%=request.getParameter("end_time")%>
                <p>Event successfully added to the database.</p>
                <%

                }else{

        %>
                         <%
                    SimpleDateFormat formatterHH = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                 %>
        <form method="post" action="event.new.jsp">
          <div class="form-group">
            <label for="title">Title</label>
            <input type="text" class="form-control" id="title" name="title" required>
          </div>
          <div class="form-group">
              <label for="start_time">Start Time</label>

                           <a href="#"><i class="fas fa-sun" onclick="event.preventDefault();tomorrowM('start_time', 'end_time', 'reminder_time')"></i></a>
                           &nbsp;&nbsp;
                           <a href="#"><i class="fas fa-moon" onclick="event.preventDefault();tomorrowE('start_time', 'end_time', 'reminder_time')"></i></a>
                           &nbsp;&nbsp;
                           <a href="#"><i class="fas fa-angle-right" onclick="event.preventDefault();nextWeek('start_time', 'end_time', 'reminder_time')"></i></a>
                           &nbsp;&nbsp;
                           <a href="#"><i class="fas fa-angle-double-right" onclick="event.preventDefault();nextMonth('start_time', 'end_time', 'reminder_time')"></i></a>
                           &nbsp;&nbsp;
                           <a href="#"><i class="fas fa-step-forward" onclick="event.preventDefault();nextQ('start_time', 'end_time', 'reminder_time')"></i></a>
              <input type="datetime-local" class="form-control" id="start_time" name="start_time" required datepicker value="<%=formatterHH.format(new Date())%>" >
          </div>
          <div class="form-group">
            <label for="end_time">End Time</label>
            <input type="datetime-local" class="form-control" id="end_time" name="end_time" required datepicker value="<%=formatterHH.format(new Date())%>" >
          </div>
          <div class="form-group">
            <label for="location">Location</label>
            <input type="text" class="form-control" id="location" name="location" onkeypress="callAC(this)">
            <input type="hidden" id="locationaclat" name="locationaclat" >
            <input type="hidden" id="locationaclng" name="locationaclng" >
            <ul id="locationac" name="locationac"></ul>
            <hr>
          </div>
          <div class="form-group">
            <label for="description">Description</label>
            <textarea class="form-control" id="description" name="description"></textarea>
          </div>
          <div class="form-group">
            <label for="reminder_time">Reminder Time</label>
            <input type="datetime-local" class="form-control" id="reminder_time" name="reminder_time" datepicker value="<%=formatterHH.format(new Date())%>">
          </div>
          <div class="form-group">
            <label for="invitees">Invitees</label>
            <input type="email" class="form-control" id="invitees" name="invitees" placeholder="Enter email addresses separated by commas">
          </div>
          <div class="form-group">
            <label for="group_id">Group ID</label>
            <input type="text" class="form-control" id="group_id" name="group_id">
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
          <button type="submit" class="btn btn-primary">Create Event</button>
          </form>





                 <%}%>
     </div>
     </div>

     </section><!-- End Blog Section -->

     </main><!-- End #main -->

  <!-- Initialize the datepicker on the text input field -->
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
