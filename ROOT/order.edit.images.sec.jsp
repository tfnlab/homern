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
<%@ page import="com.tfnlab.mysql.ImageRepository" %>
<%@ page import="com.tfnlab.mysql.ImageRepositoryDAO" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductLineItemDao" %>
<%@ page import="com.tfnlab.mysql.ProductDashBoard" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
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
</head>
<body>
  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
<%
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }
    OrderDao dao = new OrderDao();
    Order order = dao.getOrderByOrderId(orderId, username);
     String uuid = java.util.UUID.randomUUID().toString();
%>
                <HR>
                  Order:
                    <a href="<%=rootUpdate%>order.edit.sec.jsp/?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a>
                    &nbsp;
                    (<a href="<%=rootUpdate%>order.edit.images.sec.jsp/?orderId=<%= order.getOrderId() %>" >new</a>)
  <HR>
<form>
  <label for="orderId">Select Image Type:</label><br>
<select id="image_type">
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
  <HR>

  <label for="orderId">Add Image Description:</label><br>
  <input class="form-control" id="description" name="description" />
  <HR>
  <input type="file" id="fileInput" accept="image/*" multiple>
  <HR>
  <button type="submit" id="submitButton" name="submitButton" class="btn btn-primary" >Upload</button>
  <input type="hidden" id="orderId" name="orderId" value="<%=orderId%>" >
  <input type="hidden" id="client_request_key" name="client_request_key" value="<%=uuid%>" >

</form>
 <HR>
         <div id="image_div" name="image_div">
                    <div class="d-flex flex-wrap">

    <%
            ImageRepositoryDAO iDao = new ImageRepositoryDAO();
      List<ImageRepository> images = iDao.selectByUsernameAndOrderId(username, order.getOrderId());

        for (ImageRepository image : images) {
                %>
                            <div class="col-sm-6 col-md-4">
                              <div class="thumbnail">
                                <a href="<%=rootUpdate%>order.edit.images.view.sec.jsp?filename=<%=image.getFilename()%>&orderId=<%=orderId%>" >
                                <img src="<%=rootUpdate%>order.edit.images.view.sec.jsp?filename=<%=image.getFilename()%>&orderId=<%=orderId%>" class="img-fluid" alt="Responsive Image" style="width: 100px; height: 100px;" />
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
  <div id="image_div_canvas" name="image_div_canvas">
    <canvas id="canvas" style="display: none;" ></canvas>
  <div>
  <HR>

  </div>
  </div>

  </section><!-- End Blog Section -->

  </main><!-- End #main -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>


    <script>
      var fileInput = document.getElementById('fileInput');
      var canvas = document.getElementById('canvas');
      var ctx = canvas.getContext('2d');
      var submitButton = document.getElementById('submitButton');
      var orderId = document.getElementById('orderId').value;
      var client_request_key = document.getElementById('client_request_key').value;
      var csrfmiddlewaretoken = document.querySelector('input[name="csrfmiddlewaretoken"]').value;


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
              formData.append('orderId', orderId);
              formData.append('client_request_key', client_request_key);
              formData.append('csrfmiddlewaretoken', csrfmiddlewaretoken);



              submitButton.addEventListener('click', function(e) {
                e.preventDefault();

                var xhr = new XMLHttpRequest();
                xhr.open('POST', '<%=rootUpdate%>order.edit.images.upload.sec.jsp/');
                xhr.onload = function() {
                  if (xhr.status === 200) {
                    document.getElementById("submitButton").classList.remove("btn-warning");
                    document.getElementById("submitButton").classList.add("btn-success");
                    document.getElementById("image_div").innerHTML = this.responseText.trim();
                  } else {
                    // Handle error
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
