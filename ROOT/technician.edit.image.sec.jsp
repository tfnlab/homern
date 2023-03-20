<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.servlet.*, org.apache.commons.fileupload.disk.*" %>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tfnlab.mysql.Technician" %>
<%@ page import="com.tfnlab.mysql.TechnicianDao" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.Collection" %>
<%@ page import="javax.servlet.http.Part" %>
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

  <title>Home Renovation Nation - Technician</title>
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
</head>

<body>

  <main id="main">
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
          <div class="container mt-5">
        <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
        <HR>

<%
                String technicianId = "technicianId";

%>
        <img src="<%=rootUpdate%>technician.edit.image.view.sec.jsp/?technicianId=<%=technicianId%>" class="img-fluid" style="max-width: 50%;"/>

        <%
          boolean isMultipart = ServletFileUpload.isMultipartContent(request);
          if (isMultipart) {
              APIConfig conf = new APIConfig();

              String filepath = conf.getPdfloc();
              DiskFileItemFactory factory = new DiskFileItemFactory();
              factory.setSizeThreshold(1024 * 1024); // Set the size threshold for storing files in memory
              factory.setRepository(new File(filepath)); // Set the repository location for temporarily storing files
              ServletFileUpload upload = new ServletFileUpload(factory);
              List<FileItem> items = upload.parseRequest(request);
              for (FileItem item : items) {
                if (!item.isFormField()) { // Check if the item is an uploaded file

                }else{
                    String inputFieldName = item.getFieldName();
                    String inputFieldValue = item.getString();
                    if (inputFieldName.equals("technicianId")) {
                        technicianId = inputFieldValue;
                    }
                }
              }
              String  filename = technicianId + "." + username + ".png";
              for (FileItem item : items) {
                if (!item.isFormField()) { // Check if the item is an uploaded file
                  InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
                  // Save the file to a local directory or database, or process the contents in some other way
                  //String fileName = item.getName(); // Get the original file name
                  FileOutputStream fos = new FileOutputStream(filepath  +  "technician." + filename);
                  byte[] buffer = new byte[1024];
                  int length;
                  while ((length = fileContent.read(buffer)) > 0) {
                    fos.write(buffer, 0, length);
                  }
                  fos.close();
                  fileContent.close();
                }
              }
            %>

            <p>File uploaded successfully!</p>
            <%
          } else {
            // Request is not a multipart form
                int id = Integer.parseInt(request.getParameter("technicianId"));
                TechnicianDao td = new TechnicianDao();
                Technician technician = new Technician();
                technician = td.getTechnicianById(id);
            %>
            <form method="post" action="<%=rootUpdate%>technician.edit.image.sec.jsp/?technicianId=<%= technician.getTechnicianId() %>" enctype="multipart/form-data">
               <input type="hidden" name="technicianId" value="<%= technician.getTechnicianId() %>">
              <input type="file" name="file" />
              <input type="submit" value="Upload" />
            </form>
            <%
          }
        %>


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
