<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
          <h2><a href="<%=rootUpdate%>user.menu.sec.jsp/" tabindex="1" >Home Renovation Nation</a></h2>
        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);




                String technicianName = request.getParameter("technicianName");



                // Validate form data
                if (technicianName != null && technicianName.trim().length() > 0) {


                      //Order order = new Order(orderId, username, orderDate, shippingDate, shippingAddress, billingAddress, paymentMethod, orderTotal, createdAt, updatedAt, deletedAt, orderName, orderDescription, shippingAddressaclat, shippingAddressaclng, billingAddressaclat, billingAddressaclng);
                      //OrderDao dao = new OrderDao();
                      //ao.insertOrder(order);
                      try{
                        Technician technician = new Technician();
                        technician = technician.generateSampleTechnician();
                        technician.setTechnicianName(request.getParameter("technicianName"));
                        technician.setTechnicianEmail(request.getParameter("technicianEmail"));
                        technician.setTechnicianPhone(request.getParameter("technicianPhone"));
                        technician.setTechnicianSkills(request.getParameter("technicianSkills"));
                        technician.setTechnicianActive(Boolean.parseBoolean(request.getParameter("isTechnicianActive")));
                        technician.setTechnicianInterviewed(Boolean.parseBoolean(request.getParameter("technicianInterviewed")));
                        technician.setTechnicianPassedBackgroundCheck(Boolean.parseBoolean(request.getParameter("technicianPassedBackgroundCheck")));
                        technician.setTechnicianPayrate(new BigDecimal(request.getParameter("technicianPayrate")));
                        technician.setTechnicianLocation(request.getParameter("technicianLocation"));
                        technician.setTechnicianCertifications(request.getParameter("technicianCertifications"));
                        technician.setTechnicianAvailability(request.getParameter("technicianAvailability"));
                        technician.setTechnicianNotes(request.getParameter("technicianNotes"));
                        //technician.setTechnicianPhoto(request.getParameter("technicianPhoto").getBytes());
                        technician.setTechnicianPassword(request.getParameter("technicianPassword"));
                        technician.setT_p(request.getParameter("technicianPassword"));
                        Timestamp createdAt = currentTime;
                        Timestamp updatedAt = currentTime;
                        technician.setDateCreated(new java.util.Date(createdAt.getTime()));
                        technician.setDateLastModified(new java.util.Date(updatedAt.getTime()));
                        technician.setUsername(username);

                        TechnicianDao td = new TechnicianDao();
                        td.insertRecord(technician);
                      }catch(Exception ex){
                        %><%=ex.getMessage()%><%
                      }
                      %>
                        <HR>
                        Technician Saved
                        <HR>
                      <%
                }else{

        %>
        <form action="<%=rootUpdate%>technician.new.sec.jsp/" method="post">
  <div class="form-group">
    <label for="technicianName">Technician Name</label>
    <input type="text" class="form-control" name="technicianName" id="technicianName" placeholder="Enter Technician Name" required>
  </div>
  <div class="form-group">
    <label for="technicianEmail">Technician Email</label>
    <input type="email" class="form-control" id="technicianEmail" name="technicianEmail" placeholder="Enter Technician Email" required>
  </div>
  <div class="form-group">
    <label for="technicianPhone">Technician Phone</label>
    <input type="text" class="form-control" id="technicianPhone" name="technicianPhone" placeholder="Enter Technician Phone" required>
  </div>
  <div class="form-group">
    <label for="technicianSkills">Technician Skills</label>
    <input type="text" class="form-control" id="technicianSkills" name="technicianSkills" placeholder="Enter Technician Skills">
  </div>
  <div class="form-group">
    <label for="isTechnicianActive">Is Technician Active</label>
    <input type="checkbox" class="form-control" id="isTechnicianActive" name="isTechnicianActive">
  </div>
  <div class="form-group">
    <label for="technicianInterviewed">Technician Interviewed</label>
    <input type="checkbox" class="form-control" id="technicianInterviewed" name="technicianInterviewed">
  </div>
  <div class="form-group">
    <label for="technicianPassedBackgroundCheck">Technician Passed Background Check</label>
    <input type="checkbox" class="form-control" id="technicianPassedBackgroundCheck" name="technicianPassedBackgroundCheck">
  </div>
  <div class="form-group">
    <label for="technicianPayrate">Technician Payrate</label>
    <input type="number" class="form-control" id="technicianPayrate" name="technicianPayrate" placeholder="Enter Technician Payrate" required >
  </div>
  <div class="form-group">
    <label for="technicianLocation">Technician Location</label>
    <input type="text" class="form-control" id="technicianLocation" name="technicianLocation" placeholder="Enter Technician Location">
  </div>
  <div class="form-group">
    <label for="technicianCertifications">Technician Certifications</label>
    <input type="text" class="form-control" id="technicianCertifications" name="technicianCertifications" placeholder="Enter Technician Certifications">
  </div>
  <div class="form-group">
    <label for="technicianAvailability">Technician Availability</label>
    <input type="text" class="form-control" id="technicianAvailability" name="technicianAvailability" placeholder="Enter Technician Availability">
  </div>
  <div class="form-group">
   <label for="technicianNotes">Technician Notes</label>
   <textarea class="form-control" name="technicianNotes" id="technicianNotes" rows="3"></textarea>
 </div>
 <div class="form-group">
   <label for="technicianPhoto">Technician Photo</label>
   <input type="file" class="form-control-file" name="technicianPhoto" id="technicianPhoto">
 </div>
 <div class="form-group">
   <label for="technicianPassword">Technician Password</label>
   <input type="password" class="form-control" name="technicianPassword" id="technicianPassword" placeholder="Enter Technician Password">
 </div>
 <button type="submit" class="btn btn-primary">Submit</button>
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
