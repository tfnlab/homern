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
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.ContactDAO" %>
<%@ page import="com.tfnlab.mysql.Contact" %>
<%@ page import="com.tfnlab.util.Translate" %>
<%@ page import="com.tfnlab.mysql.LeadDAO" %>
<%@ page import="com.tfnlab.mysql.Lead" %>
<%@ page import="com.tfnlab.mysql.LeadCorrespondenceDAO" %>
<%@ page import="com.tfnlab.mysql.LeadCorrespondence" %>
<%@ page import="com.tfnlab.mysql.ImageRepository" %>
<%@ page import="com.tfnlab.mysql.ImageRepositoryDAO" %>
<%@ include file="auth.sec.jsp" %>
<!DOCTYPE html>
<html lang="en">
  <%
     int recordId = Integer.parseInt(request.getParameter("lead_id"));
  %>
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

  </head>
<body>
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>
        <h2>Lead <a href="<%=rootUpdate%>lead.edit.sec.jsp/?lead_id=<%=recordId%>" tabindex="2"><%=recordId%></a></h2>
        <HR>
          <%
              LeadDAO leadDAO = new LeadDAO();
              Lead lead = new Lead();


              String uuid = java.util.UUID.randomUUID().toString();
              lead = leadDAO.getLead(username, recordId);

          %>
          <a href="<%=rootUpdate%>lead.new.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-plus"></i></a>
          <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/" class="btn btn-primary" tabindex="2"><i class="fas fa-cubes"></i></a>
          <a href="<%=rootUpdate%>lead.list.sec.jsp/" class="btn btn-primary" tabindex="3"><i class="fas fa-list"></i></a>
          <a href="<%=rootUpdate%>lead.list.table.sec.jsp/" class="btn btn-primary" tabindex="4"><i class="fas fa-table"></i></a>
          <a href="<%=rootUpdate%>lead.list.dash.sec.jsp/" class="btn btn-primary" tabindex="5"><i class="fas fa-tachometer-alt"></i></a>
          <a href="<%=rootUpdate%>lead.list.csv.sec.jsp/?csv=true" class="btn btn-primary" tabindex="6"><i class="fas fa-download"></i></a>
          <a href="<%=rootUpdate%>lead.new.bulk.sec.jsp/?csv=true" class="btn btn-primary" tabindex="7"><i class="fas fa-upload"></i></a>
          <a href="<%=rootUpdate%>lead.edit.image.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-success" tabindex="8"><i class="fas fa-image"></i></a>
          <a href="<%=rootUpdate%>lead.edit.com.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-primary" tabindex="8"><i class="fas fa-envelope"></i></a>
          <a href="<%=rootUpdate%>lead.edit.map.sec.jsp/?lead_id=<%=lead.getRecordId()%>" class="btn btn-primary" tabindex="9"><i class="fas fa-map"></a>
          <a href="https://sunroof.withgoogle.com/building/<%= lead.getLocation_pointlat() %>/<%= lead.getLocation_pointlng() %>/#?f=buy" tabindex="2" class="btn btn-primary" target="_blank" ><i class="fas fa-sun"></a>
        <HR>
          <div class="container mt-5">
            <div class="container">
                <div class="form-group">
                    <label>First Name:</label>
                    <input type="text" class="form-control" name="name" value="<%=lead.getName()%>">
                </div>
                <div class="form-group">
                    <label>Last Name:</label>
                    <input type="text" class="form-control" name="lname" value="<%=lead.getLname()%>">
                </div>
                <div class="form-group">
                  <label>Phone:</label>
                  <input type="text" class="form-control" name="phone" value="<%= lead.getPhone() %>">
                </div>
                <div class="form-group">
                  <label>Email Address:</label>
                  <input type="text" class="form-control" name="emailAddress" value="<%= lead.getEmailAddress() %>">
                </div>



                    <input type="hidden" class="form-control" name="lead_id" id="lead_id" value="<%=lead.getRecordId()%>">
                    <input type="hidden" class="form-control" id="location_pointlat" name="location_pointlat" value="<%= lead.getLocation_pointlat() %>">
                    <input type="hidden" class="form-control" id="location_pointlng" name="location_pointlng" value="<%= lead.getLocation_pointlng() %>">

                      <HR>
                    <form>
                      <label for="orderId">Select Image Type:</label><br>
                    <select id="image_type" class="form-control" >
                      <option value="before">Before</option>
                      <option value="during">During</option>
                      <option value="after">After</option>
                      <option value="damage">Damage</option>
                      <option value="progress">Progress</option>
                      <option value="special_note">Special Note</option>
                      <option value="completed_work">Completed Work</option>
                      <option value="materials">Materials</option>
                      <option value="equipment">Equipment</option>
                      <option value="other">Other</option>
                    </select>
                      <BR>
                      <label for="orderId">Add Image Description:</label><br>
                      <input class="form-control" id="description" name="description" />
                      <HR>
                      <input type="file" id="fileInput" accept="image/*" multiple>
                      <HR>
                      <button type="submit" id="submitButton" name="submitButton" class="btn btn-primary" >Upload</button>
                      <input type="hidden" id="lead_id" name="lead_id" value="<%=lead.getRecordId()%>" >
                      <input type="hidden" id="client_request_key" name="client_request_key" value="<%=uuid%>" >

                    </form>
                     <HR>
                             <div id="image_div" name="image_div">
                                        <div class="d-flex flex-wrap">

                        <%

                         ImageRepositoryDAO iDao = new ImageRepositoryDAO();
                         List<ImageRepository> images = iDao.selectByUsernameAndLeadId(username, lead.getRecordId());

                            for (ImageRepository image : images) {
                                    %>
                                                <div class="col-sm-6 col-md-4">
                                                  <div class="thumbnail">
                                                    <a href="order.edit.images.view.jsp?filename=<%=image.getFilename()%>&orderId=<%=lead.getRecordId()%>" >
                                                    <img src="order.edit.images.view.jsp?filename=<%=image.getFilename()%>&orderId=<%=lead.getRecordId()%>" class="img-fluid" alt="Responsive Image" style="width: 100px; height: 100px;" />
                                                    <a>
                                                    <div class="caption">
                                                      <h3>Title <%=image.getType()%></h3>
                                                      <p>ID: <%=image.getId()%></p>
                                                      <p><%=image.getDescription()%></p>
                                                    </div>
                                                  </div>
                                                </div>
                                    <%
                            }
                        %>
                                        </div>
                              </div>

                      <HR>

                <BR>
            </div>
          </div>
        </div>
      </div>
    </section><!-- End Blog Section -->
  </main>
  <div id="image_div_canvas" name="image_div_canvas">
    <canvas id="canvas" style="display: none;" ></canvas>
  <div>
  <script>
    var fileInput = document.getElementById('fileInput');
    var canvas = document.getElementById('canvas');
    var ctx = canvas.getContext('2d');
    var submitButton = document.getElementById('submitButton');
    var lead_id = document.getElementById('lead_id').value;
    var client_request_key = document.getElementById('client_request_key').value;


    fileInput.addEventListener('change', function(e) {
      for (var i = 0; i < fileInput.files.length; i++) {
        var image = new Image();
        image.src = URL.createObjectURL(fileInput.files[i]);

        image.onload = function() {
          canvas.width = image.width * 0.5;
          canvas.height = image.height * 0.5;

          ctx.drawImage(image, 0, 0, canvas.width, canvas.height);

          canvas.toBlob(function(blob) {
            var formData = new FormData();
            formData.append('file', blob);
            formData.append('lead_id', lead_id);
            formData.append('client_request_key', client_request_key);



            submitButton.addEventListener('click', function(e) {
              e.preventDefault();

              var xhr = new XMLHttpRequest();
              xhr.open('POST', '<%=rootUpdate%>order.edit.images.upload.sec.jsp/');
              xhr.onload = function() {
                if (xhr.status === 200) {
                  alert(this.responseText);
                  document.getElementById("submitButton").classList.remove("btn-warning");
                  document.getElementById("submitButton").classList.add("btn-success");
                  document.getElementById("image_div").innerHTML = this.responseText.trim();
                } else {
                  // Handle error
                  alert(this.responseText);
                  alert("Error");
                }
              };
              var description = document.getElementById('description').value;
              formData.append('description', description);
              var selectBox = document.getElementById("image_type");
              var selectedValue = selectBox.options[selectBox.selectedIndex].value;
              formData.append('image_type', selectedValue);

              document.getElementById("submitButton").classList.remove("btn-primary");
              document.getElementById("submitButton").classList.add("btn-warning");

              xhr.send(formData);
            });
          }, 'image/jpeg');
        };
      }
    });
  </script>
</body>
</html>
