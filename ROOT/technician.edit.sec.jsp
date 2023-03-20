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
    function verifyOwner() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
            let items = this.responseText.split('<ITEM>');
            document.getElementById('wallet_id_public').value = items[2];
          }
        };
        let search = document.getElementById('wallet_id_active_nft_id').value;
        var urlString = "technician.edit.getowner.jsp?token_id=" + search;
        xhttp.open("GET", urlString, true);
        xhttp.send();
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

                int id = Integer.parseInt(request.getParameter("technicianId"));
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);

                TechnicianDao td = new TechnicianDao();



                String technicianName = request.getParameter("technicianName");



                // Validate form data
                Technician technician = new Technician();
                if (technicianName != null && technicianName.trim().length() > 0) {


                      //Order order = new Order(orderId, username, orderDate, shippingDate, shippingAddress, billingAddress, paymentMethod, orderTotal, createdAt, updatedAt, deletedAt, orderName, orderDescription, shippingAddressaclat, shippingAddressaclng, billingAddressaclat, billingAddressaclng);
                      //OrderDao dao = new OrderDao();
                      //ao.insertOrder(order);

                        try{
                        technician = technician.generateSampleTechnician();
                        technician.setTechnicianId(id);
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
                        technician.setWallet_id_private(request.getParameter("wallet_id_private"));
                        technician.setWallet_id_public(request.getParameter("wallet_id_public"));
                        technician.setWallet_id_active_nft_id(request.getParameter("wallet_id_active_nft_id"));


                        Timestamp createdAt = currentTime;
                        Timestamp updatedAt = currentTime;
                        technician.setDateCreated(new java.util.Date(createdAt.getTime()));
                        technician.setDateLastModified(new java.util.Date(updatedAt.getTime()));
                        technician.setUsername(username);

                        td.updateRecord(technician);
                      }catch(Exception ex){
                        %><%=ex.getMessage()%><%
                      }
                      %>

                        Order Saved
                      <%
                }
                technician = td.getTechnicianById(id);
        %>
        <form action="<%=rootUpdate%>technician.edit.sec.jsp/" method="post">
          <input type="hidden" name="technicianId" value="<%= technician.getTechnicianId() %>">
          <div class="form-group">
              <label for="technicianName"><%= (new Translate()).translate("Name", usernameOBJ.getLanguage())%></label>
              <input type="text" class="form-control" id="technicianName" name="technicianName" value="<%= technician.getTechnicianName() %>">
          </div>
          <div class="form-group">
              <label for="technicianEmail"><%= (new Translate()).translate("Email", usernameOBJ.getLanguage())%></label>
              <input type="email" class="form-control" id="technicianEmail" name="technicianEmail" value="<%= technician.getTechnicianEmail() %>">
          </div>
          <div class="form-group">
              <label for="technicianPhone"><%= (new Translate()).translate("Phone", usernameOBJ.getLanguage())%></label>
              <input type="text" class="form-control" id="technicianPhone" name="technicianPhone" value="<%= technician.getTechnicianPhone() %>">
          </div>
          <div class="form-group">
              <label for="technicianSkills"><%= (new Translate()).translate("Skills", usernameOBJ.getLanguage())%></label>
              <input type="text" class="form-control" id="technicianSkills" name="technicianSkills" value="<%= technician.getTechnicianSkills() %>">
          </div>
          <div class="form-group">
              <label for="isTechnicianActive"><%= (new Translate()).translate("Active", usernameOBJ.getLanguage())%></label>
              <input type="checkbox" class="form-control" id="isTechnicianActive" name="isTechnicianActive" value="true" <%= technician.isTechnicianActive() ? "checked" : "" %>>
          </div>
          <div class="form-group">
            <label for="technicianInterviewed"><%= (new Translate()).translate("Technician Interviewed", usernameOBJ.getLanguage())%></label>
            <input type="checkbox" class="form-control" id="technicianInterviewed" name="technicianInterviewed" value="true" <%= technician.isTechnicianInterviewed() ? "checked" : "" %>>
          </div>
          <div class="form-group">
              <label for="technicianPassedBackgroundCheck"><%= (new Translate()).translate("Passed Background Check", usernameOBJ.getLanguage())%></label>
              <input type="checkbox" class="form-control" id="technicianPassedBackgroundCheck" name="technicianPassedBackgroundCheck" value="true" <%= technician.isTechnicianPassedBackgroundCheck() ? "checked" : "" %>>
          </div>
          <div class="form-group">
              <label for="technicianPayrate"><%= (new Translate()).translate("Payrate", usernameOBJ.getLanguage())%></label>
              <input type="number" step="0.01" class="form-control" id="technicianPayrate" name="technicianPayrate" value="<%= technician.getTechnicianPayrate() %>">
          </div>
          <div class="form-group">
              <label for="technicianLocation"><%= (new Translate()).translate("Location", usernameOBJ.getLanguage())%></label>
              <input type="text" class="form-control" id="technicianLocation" name="technicianLocation" value="<%= technician.getTechnicianLocation() %>">
          </div>
          <div class="form-group">
              <label for="technicianCertifications"><%= (new Translate()).translate("Certifications", usernameOBJ.getLanguage())%></label>
              <input type="text" class="form-control" id="technicianCertifications" name="technicianCertifications" value="<%= technician.getTechnicianCertifications() %>">
          </div>
          <div class="form-group">
              <label for="technicianAvailability"><%= (new Translate()).translate("Availability", usernameOBJ.getLanguage())%></label>
              <input type="text" class="form-control" id="technicianAvailability" name="technicianAvailability" value="<%= technician.getTechnicianAvailability() %>">
          </div>
          <div class="form-group">
              <label for="wallet_id_private"><%= (new Translate()).translate("Wallet Private Key", usernameOBJ.getLanguage())%></label>
              <input type="text" class="form-control" id="wallet_id_private" name="wallet_id_private" value="<%= technician.getWallet_id_private() %>">
          </div>
          <div class="form-group">
              <label for="wallet_id_public"><%= (new Translate()).translate("Wallet Public", usernameOBJ.getLanguage())%></label> <a href="https://opensea.io/<%= technician.getWallet_id_public() %>" >OpenSea.io</a>
              <input type="text" class="form-control" id="wallet_id_public" name="wallet_id_public" value="<%= technician.getWallet_id_public() %>">
          </div>
          <div class="form-group">
              <label for="wallet_id_public"><%= (new Translate()).translate("Active", usernameOBJ.getLanguage())%> <a href="https://opensea.io/collection/liquid-crystal-display" >Liquid Crystal Display</a> Token Identification Number <a href="https://opensea.io/assets/ethereum/0xcfe9f30cb7c339039782dc5e4a1a24632caf0d83/<%= technician.getWallet_id_active_nft_id() %>" ><%= technician.getWallet_id_active_nft_id() %></a></label>
              <input type="text" class="form-control" id="wallet_id_active_nft_id" name="wallet_id_active_nft_id" value="<%= technician.getWallet_id_active_nft_id() %>" onkeyup="verifyOwner()">
              <HR>
              <img src="technician.edit.getowner.view.jsp?contract_id=0xcFE9f30CB7C339039782DC5E4a1a24632CaF0D83&token_id=<%= technician.getWallet_id_active_nft_id() %>" class="img-fluid" style="max-width: 50%;"/>
          </div>
          <div class="form-group">
              <label for="technicianNotes"><%= (new Translate()).translate("Notes", usernameOBJ.getLanguage())%></label>
              <textarea class="form-control" id="technicianNotes" name="technicianNotes"><%= technician.getTechnicianNotes() %></textarea>
          </div>
          <div class="form-group">
              <%= (new Translate()).translate("Technician", usernameOBJ.getLanguage())%> <%= (new Translate()).translate("Photo", usernameOBJ.getLanguage())%>
              <HR>
              <a href="technician.edit.image.jsp?technicianId=<%= technician.getTechnicianId() %>" >
              <img src="technician.edit.image.view.jsp?technicianId=<%=technician.getTechnicianId()%>" class="img-fluid" style="max-width: 50%;"/>
              </a>
          </div>
          <div class="form-group">
              <label for="technicianPassword"><%= (new Translate()).translate("Password", usernameOBJ.getLanguage())%></label>
              <input type="password" class="form-control" id="technicianPassword" name="technicianPassword" value="<%= technician.getTechnicianPassword() %>">
          </div>
 <button type="submit" class="btn btn-primary"><%= (new Translate()).translate("Submit", usernameOBJ.getLanguage())%></button>
 </form>
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
