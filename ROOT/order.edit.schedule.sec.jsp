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
<%@ page import="com.tfnlab.util.Translate" %>
<%@ include file="auth.sec.jsp" %>
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
  <%
    OrderDao dao = new OrderDao();
    OrderTechniciansDAO otD = new OrderTechniciansDAO();
    EventDao evd = new EventDao();
    TechnicianDao technicianDao = new TechnicianDao();
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }

    String comType = request.getParameter("comType");

  %>
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
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
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
          <h2>Event</h2>
          <HR>
                    <div class="form-group">
                      Order:
                        <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a><br>
                    </div>
        <HR>

        <!--
          <p>Order Dates: <%= order.getOrderDate() %> - <%= order.getShipDate() %></p><br>
          <p>Order Description: <%= order.getOrderDescription() %></p>
        -->
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


         <form action="<%=rootUpdate%>order.edit.schedule.sec.jsp/" method="POST" >
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
                Event ID: <a href="<%=rootUpdate%>event.edit.sec.jsp/?eventid=<%= technician.getEventId() %>" ><%= technician.getEventId() %></a><br>
                Tech ID: <%= technician.getTechnicianId() %><br>
                <%=tMap.get(Integer.valueOf(technician.getTechnicianId())).getTechnicianName() %>
                -- <BR>
                <%=eMap.get(Integer.valueOf(technician.getEventId())).getTitle() %>
                -- <a href="<%=rootUpdate%>order.edit.schedule.sec.jsp/?orderId=<%=orderId%>&tlid=<%= technician.getId() %>" >remove<a><br>
                <hr>

         <%
             }
         %>

    </div>
    </div>

    </section><!-- End Blog Section -->

    </main><!-- End #main -->

</body>

</html>
