<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="com.tfnlab.mysql.EventDao" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.math.BigDecimal" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.ProductDashBoard" %>
<%@ page import="com.tfnlab.mysql.EmployeeTimeSheet" %>
<%@ page import="com.tfnlab.mysql.EmployeeTimeSheetDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.util.HRNDate" %>
<%@ include file="auth.jsp" %>
<%
          User user = (User)session.getAttribute("usernameOBJ");
          String username = (String) session.getAttribute("username");

%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="assets/css/style.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
    <%@ include file="include.header.jsp" %>
  <main id="main">
    <section class="breadcrumbs">
      <div class="container">
        <ol>
          <li><a href="user.menu.jsp">Home</a></li>
          <li>Service Operations Center</li>
        </ol>
      </div>
    </section>
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Template</h2>
        <HR>
        <%@ include file="user.menu.nav.jsp" %>



          <div class="container mt-5">
<%
                    SimpleDateFormat formatterHH = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                 %>
                   <%
                    int id = Integer.parseInt(request.getParameter("technicianId"));
                    EmployeeTimeSheetDAO etsDao = new EmployeeTimeSheetDAO();
                        if (request.getParameter("action") != null && !request.getParameter("action").isEmpty()) {
                            int tsid = Integer.parseInt(request.getParameter("timesheetid"));
                            if(request.getParameter("action").equals("remove")){
                                    etsDao.deleteEmployeeTimeSheet(tsid, username);
                             }
                             if(request.getParameter("action").equals("edit")){
                                    Date startDate = dateFormat.parse(request.getParameter("start_time"));
                                    Date endDate = dateFormat.parse(request.getParameter("end_time"));
                                    EmployeeTimeSheet etc = new EmployeeTimeSheet();
                                    etc.setStartTime(startDate);
                                    etc.setEndTime(endDate);
                                    etc.setTimeSheetID(tsid);
                                    etc.setUsername(username);
                                    %>UPDATE COUNT <%=etsDao.updateEmployeeTimeSheet(etc)%><%
                             }
                        }

                       List<EmployeeTimeSheet> etsList = etsDao.getTimesheetEntryByTechnicianId(id);

                       %><a href="timesheet.list.jsp" tabindex="12" >Time Sheet
                       <i class="fa fa-clock"></i></a>
                        <BR><BR>
                                 <HR>
                       <div class="container-fluid">
                       <%
                       for (EmployeeTimeSheet etc : etsList) {
                                %>
                                <form action="timesheet.list.technician.jsp" method="post">
                                  <div class="row">
                                <div class="col-md-1">
                                    <%=etc.getTimeSheetID()%>
                                    <HR>
                                    <small>
                                    <a href="timesheet.list.technician.jsp?action=remove&technicianId=<%=id%>&timesheetid=<%=etc.getTimeSheetID()%>" ><i class="fas fa-trash"></i></a>
                                    </small>
                                </div>
                                <div class="col-md-1">
                                   <div class="form-group">
                                    <label for="end_time"><%=HRNDate.getDay_of_week(etc.getStartTime())%></label>
                                    </div>
                                </div>
                                <div class="col-md-1">
                                   <div class="form-group">
                                    <label for="end_time">Start</label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                   <div class="form-group">
                                    <input type="datetime-local" class="form-control" id="start_time" name="start_time" required datepicker value="<%=formatterHH.format(etc.getStartTime())%>" >
                                    </div>
                                </div>
                                <div class="col-md-1">
                                  <div class="form-group">
                                    <label for="end_time">End</label>
                                  </div>
                                </div>
                                <div class="col-md-3">
                                  <div class="form-group">
                                    <input type="datetime-local" class="form-control" id="end_time" name="end_time" required datepicker value="<%=formatterHH.format(etc.getEndTime())%>" >
                                  </div>
                                </div>
                                <div class="col-md-1">
                                    &nbsp;
                                </div>
                                <div class="col-md-1">

                                    <button type="submit" class="btn btn-primary">Save&nbsp;</button>
                                    <input type="hidden" name="action" id="action" value="edit" />

                                    <input type="hidden" name="technicianId" id="technicianId" value="<%=id%>" />
                                    <input type="hidden" name="timesheetid" id="timesheetid" value="<%=etc.getTimeSheetID()%>" />
                                </div>
                                </div>
                                </form>
                                 <HR>
                                <%
                       }
                   %>
                        </div>
          </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
  <%@ include file="include.footer.jsp" %>
  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/js/main.js"></script>
</body>
</html>
