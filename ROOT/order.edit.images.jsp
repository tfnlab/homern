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
    int orderId = 0;
    if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
      orderId = Integer.parseInt(request.getParameter("orderId"));
    }
    OrderDao dao = new OrderDao();
    Order order = dao.getOrderByOrderId(orderId, username);
     String uuid = java.util.UUID.randomUUID().toString();
%>
                <div class="form-group">
                  Order:
                    <a href="order.edit.jsp?orderId=<%= order.getOrderId() %>" ><%= order.getOrderId() %> - <%= order.getOrderName() %></a>
                    &nbsp;
                    (<a href="order.edit.images.jsp?orderId=<%= order.getOrderId() %>" >new</a>)
                </div>
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
                                <a href="order.edit.images.view.jsp?filename=<%=image.getFilename()%>&orderId=<%=orderId%>" >
                                <img src="order.edit.images.view.jsp?filename=<%=image.getFilename()%>&orderId=<%=orderId%>" class="img-fluid" alt="Responsive Image" style="width: 100px; height: 100px;" />
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

    <script>
      var fileInput = document.getElementById('fileInput');
      var canvas = document.getElementById('canvas');
      var ctx = canvas.getContext('2d');
      var submitButton = document.getElementById('submitButton');
      var orderId = document.getElementById('orderId').value;
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
              formData.append('orderId', orderId);
              formData.append('client_request_key', client_request_key);



              submitButton.addEventListener('click', function(e) {
                e.preventDefault();

                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'order.edit.images.upload.jsp');
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
