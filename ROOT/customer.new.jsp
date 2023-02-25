<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Order" %>
<%@ page import="com.tfnlab.mysql.OrderDao" %>
<%@ page import="com.tfnlab.mysql.Entity" %>
<%@ page import="com.tfnlab.mysql.EntityDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.UUID" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.http.*" %>
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

  <title>Home Renovation Nation - Customer</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" crossorigin="anonymous" />

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

    function dsiplayName() {
      document.getElementById("display_name").value = document.getElementById("firstName").value + " " + document.getElementById("lastName").value;
    }
  </script>
</head>

<body>

          <%@ include file="include.header.jsp" %>

  <main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
      <div class="container">

        <ol>
          <li><a href="index.html">Home</a></li>
          <li>Customer</li>
        </ol>
        <h2>Customer</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2>Customer</h2>
        <%@ include file="user.menu.nav.jsp" %>

        <HR>


        <%
                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);
                String first_name = request.getParameter("firstName");
                int orderId = 0;
                String mfer_uuid = java.util.UUID.randomUUID().toString();
                if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
                  orderId = Integer.parseInt(request.getParameter("orderId"));
                }

                // Validate form data
                if (first_name != null && first_name.trim().length() > 0) {
                      Entity entity = new Entity();
                      entity = entity.generateSampleEntity();
//                      entity.setId(Integer.parseInt(request.getParameter("id")));
                      entity.setUsername(username);
                      entity.setFirstName(request.getParameter("firstName"));
                      entity.setLastName(request.getParameter("lastName"));
                      entity.setEmail(request.getParameter("email"));
                      entity.setPhone(request.getParameter("phone"));
                      entity.setAddress(request.getParameter("address"));
                      entity.setAddress2(request.getParameter("address2"));
                      entity.setCity(request.getParameter("city"));
                      entity.setState(request.getParameter("state"));
                      entity.setZipcode(request.getParameter("zipcode"));
                      entity.setCountry(request.getParameter("country"));
                      // parse birthday as a Date object

                      String dateString = request.getParameter("birthday");
                      Date date = null;
                      if (dateString != null) {
                          try {
                              SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                              date = dateFormat.parse(dateString);
                              entity.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("birthday")));
                              // date is a valid date
                          } catch (ParseException e) {
                              // dateString is not a valid date
                              dateString = "1980-24-10";
                              entity.setBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(dateString));
//                              date = dateFormat.parse(dateString);
                          }
                      }
//                      entity.setBirthday(dateString);

                      entity.setGender(request.getParameter("gender"));
                      entity.setMaritalStatus(request.getParameter("maritalStatus"));
                      entity.setNationality(request.getParameter("nationality"));
                      entity.setOccupation(request.getParameter("occupation"));
                      entity.setIncomeRange(request.getParameter("incomeRange"));
                      entity.setEducationLevel(request.getParameter("educationLevel"));
                      entity.setPreferences(request.getParameter("preferences"));
                      entity.setInterests(request.getParameter("interests"));
                      entity.setEmergencyContactName(request.getParameter("emergencyContactName"));
                      entity.setEmergencyContactRelationship(request.getParameter("emergencyContactRelationship"));
                      entity.setEmergencyContactPhone(request.getParameter("emergencyContactPhone"));
                      entity.setReferralSource(request.getParameter("referralSource"));
                      entity.setLoyaltyProgram(request.getParameter("loyaltyProgram"));
                      int loyaltyPoints = 0;
                      String loyaltyPointsString = request.getParameter("loyaltyPoints");
                      if (loyaltyPointsString != null) {
                          try {
                              loyaltyPoints = Integer.parseInt(loyaltyPointsString);
                              // loyaltyPoints is a valid integer
                          } catch (NumberFormatException e) {
                              // loyaltyPointsString is not a valid integer
                          }
                      }
                      entity.setLoyaltyPoints(loyaltyPoints);
                      entity.setFacebookUsername(request.getParameter("facebookUsername"));
                      entity.setTwitterHandle(request.getParameter("twitterHandle"));
                      entity.setInstagramUsername(request.getParameter("instagramUsername"));
                      entity.setLinkedinUrl(request.getParameter("linkedinUrl"));
                      entity.setYoutubeChannel(request.getParameter("youtubeChannel"));
                      // parse createdAt as a Timestamp object
                      entity.setCreatedAt(currentTime);
                      entity.setCreatedBy(username);
                      entity.setLocation_pointlat("0");
                      entity.setLocation_pointlng("0");
                      entity.setMfer_uuid(mfer_uuid);
                      entity.setCompany_name(request.getParameter("company_name"));
                      entity.setDisplay_name(request.getParameter("display_name"));
                      // parse createdDate as a Date object
//                      entity.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").parse(request
                      // parse createdDate as a Date object
                      //entity.setCreatedDate(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("createdDate")));
                      //entity.setLastModifiedBy(request.getParameter("lastModifiedBy"));
                      // parse lastModifiedDate as a Timestamp object
                      //entity.setLastModifiedDate(new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(request.getParameter("lastModifiedDate")).getTime()));
                      EntityDao ed = new EntityDao();
                      ed.addEntity(entity);
                      entity = ed.getEntityByUuid(mfer_uuid, username);
                    %>


                        Customer Saved
                        <a href="customer.edit.jsp?customerId=<%= entity.getId() %>" ><%= entity.getId() %></a>
                        <%if(orderId!=0){%>
                          Add to Order : <a href="order.edit.customers.jsp?action=add&orderId=<%=orderId%>&customerId=<%= entity.getId() %>" ><%= orderId %></a><br>
                        <%}%>

                      <%
                }else{

        %>

        <%
          boolean isMultipart = ServletFileUpload.isMultipartContent(request);
          String ocrDescription = new String();
          if (isMultipart) {

              UUID uuid = UUID.randomUUID();
              APIConfig conf = new APIConfig();
              String filename = "customer." + username + "." + uuid + ".png";
              String filepath = conf.getPdfloc();
              DiskFileItemFactory factory = new DiskFileItemFactory();
              factory.setSizeThreshold(1024 * 1024); // Set the size threshold for storing files in memory
              factory.setRepository(new File(filepath)); // Set the repository location for temporarily storing files
              ServletFileUpload upload = new ServletFileUpload(factory);
              List<FileItem> items = upload.parseRequest(request);
              for (FileItem item : items) {
                if (!item.isFormField()) { // Check if the item is an uploaded file
                  InputStream fileContent = item.getInputStream(); // Get an InputStream for reading the file contents
                  FileOutputStream fos = new FileOutputStream(filepath   + filename);
                  byte[] buffer = new byte[1024];
                  int length;
                  while ((length = fileContent.read(buffer)) > 0) {
                    fos.write(buffer, 0, length);
                  }
                  fos.close();
                  fileContent.close();
                }
              }
               try{
                    Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/ocrimage.py", filename, filename).start();
                    String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                    String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                    ocrDescription = stdout + stderr + " TEST ";
                }catch(IOException ex){
                    ocrDescription = ex.getMessage();
                }

            %>

            <p>File uploaded successfully!</p>

            <%
              }
              %>

        <form method="post" action="customer.new.jsp" enctype="multipart/form-data">
          <input type="file" name="file" />
          <input type="submit" value="Upload" />
        </form>
        <HR>
                    <form action="customer.new.jsp" method="post">
                    <input type="hidden" name="orderId" id="orderId" value="<%=orderId%>" />
                    <div class="form-group">
                      <label for="firstName">Company Name</label>
                      <input type="text" class="form-control" id="company_name" name="company_name" >
                    </div>
          <div class="form-group">
            <label for="firstName">First Name</label>
            <input type="text" class="form-control" id="firstName" name="firstName" required onchange="dsiplayName()" onkeypress="dsiplayName()">
          </div>
          <div class="form-group">
            <label for="lastName">Last Name</label>
            <input type="text" class="form-control" id="lastName" name="lastName" required onchange="dsiplayName()" onkeypress="dsiplayName()">
          </div>
          <div class="form-group">
            <label for="lastName">Display Name</label>
            <input type="text" class="form-control" id="display_name" name="display_name" required>
          </div>
          <div class="form-group">
            <label for="lastName">Description</label>
            <textarea class="form-control" id="customerDescription" name="customerDescription" rows="5"><%= ocrDescription %></textarea>
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" class="form-control" id="email" name="email" >
          </div>
          <div class="form-group">
            <label for="phone">Phone</label>
            <input type="tel" class="form-control" id="phone" name="phone" >
          </div>
          <div class="form-group">
            <label for="address">Address</label>
            <input type="text" class="form-control" id="address" name="address" >
          </div>
          <div class="form-group">
            <label for="address">Address Line 2</label>
            <input type="text" class="form-control" id="address2" name="address2" >
          </div>
          <div class="form-group">
            <label for="city">City</label>
            <input type="text" class="form-control" id="city" name="city" >
          </div>
          <div class="form-group">
            <label for="state">State</label>
            <input type="text" class="form-control" id="state" name="state" >
          </div>
          <div class="form-group">
            <label for="zipcode">Zipcode</label>
            <input type="text" class="form-control" id="zipcode" name="zipcode" >
          </div>
          <div class="form-group">
            <label for="country">Country</label>
            <input type="text" class="form-control" id="country" name="country" >
          </div>
          <div class="form-group">
            <label for="birthday">Birthday</label>
            <input type="date" class="form-control" id="birthday" name="birthday" >
          </div>
          <div class="form-group">
            <label for="gender">Gender</label>
            <select class="form-control" id="gender" name="gender" >
              <option value="">Select</option>
              <option value="male">Male</option>
              <option value="female">Female</option>
              <option value="other">Other</option>
            </select>
          </div>
            <div class="form-group">
              <label for="maritalStatus">Marital Status</label>
              <select class="form-control" id="maritalStatus" name="maritalStatus" >
                <option value="">Select</option>
                <option value="single">Single</option>
                <option value="married">Married</option>
                <option value="divorced">Divorced</option>
                <option value="widowed">Widowed</option>
              </select>
            </div>
            <div class="form-group">
              <label for="nationality">Nationality</label>
              <input type="text" class="form-control" id="nationality" name="nationality" >
            </div>
            <div class="form-group">
              <label for="occupation">Occupation</label>
              <input type="text" class="form-control" id="occupation" name="occupation" >
            </div>
            <div class="form-group">
              <label for="incomeRange">Income Range</label>
              <select class="form-control" id="incomeRange" name="incomeRange" >
                <option value="">Select</option>
                <option value="low">Low</option>
                <option value="medium">Medium</option>
                <option value="high">High</option>
              </select>
            </div>
            <div class="form-group">
              <label for="educationLevel">Education Level</label>
              <input type="text" class="form-control" id="educationLevel" name="educationLevel" >
            </div>
            <div class="form-group">
              <label for="preferences">Preferences</label>
              <input type="text" class="form-control" id="preferences" name="preferences" >
            </div>
            <div class="form-group">
              <label for="interests">Interests</label>
              <input type="text" class="form-control" id="interests" name="interests" >
            </div>
            <div class="form-group">
              <label for="emergencyContactName">Emergency Contact Name</label>
              <input type="text" class="form-control" id="emergencyContactName" name="emergencyContactName" >
            </div>
            <div class="form-group">
              <label for="emergencyContactRelationship">Emergency Contact Relationship</label>
              <input type="text" class="form-control" id="emergencyContactRelationship" name="emergencyContactRelationship" >
            </div>
            <div class="form-group">
              <label for="emergencyContactPhone">Emergency Contact Phone</label>
              <input type="tel" class="form-control" id="emergencyContactPhone" name="emergencyContactPhone" >
            </div>
              <div class="form-group">
                <label for="referralSource">Referral Source</label>
                <input type="text" class="form-control" id="referralSource" name="referralSource" >
              </div>
              <div class="form-group">
                <label for="loyaltyProgram">Loyalty Program</label>
                <input type="text" class="form-control" id="loyaltyProgram" name="loyaltyProgram" >
              </div>
              <div class="form-group">
                <label for="loyaltyPoints">Loyalty Points</label>
                <input type="number" class="form-control" id="loyaltyPoints" name="loyaltyPoints" >
              </div>
              <div class="form-group">
                <label for="facebookUsername">Facebook Username</label>
                <input type="text" class="form-control" id="facebookUsername" name="facebookUsername" >
              </div>
              <div class="form-group">
                <label for="twitterHandle">Twitter Handle</label>
                <input type="text" class="form-control" id="twitterHandle" name="twitterHandle" >
              </div>
              <div class="form-group">
                <label for="instagramUsername">Instagram Username</label>
                <input type="text" class="form-control" id="instagramUsername" name="instagramUsername" >
              </div>
              <div class="form-group">
                <label for="linkedinUrl">LinkedIn URL</label>
                <input type="text" class="form-control" id="linkedinUrl" name="linkedinUrl" >
              </div>
              <div class="form-group">
                <label for="youtubeChannel">YouTube Channel</label>
                <input type="text" class="form-control" id="youtubeChannel" name="youtubeChannel" >
              </div>
              <button type="submit" class="btn btn-primary">Submit</button>
            </form>
              <HR>
              <a href="customer.new.bulk.jsp" >Bulk Upload</a>
              <HR>
                 <%}%>
      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer">

    <div class="footer-top">
      <div class="container">
        <div class="row">

          <div class="col-lg-3 col-md-6 footer-contact">
            <h3>Presento<span>.</span></h3>
            <p>
              A108 Adam Street <br>
              New York, NY 535022<br>
              United States <br><br>
              <strong>Phone:</strong> +1 5589 55488 55<br>
              <strong>Email:</strong> info@example.com<br>
            </p>
          </div>

          <div class="col-lg-2 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 footer-links">
            <h4>Our Services</h4>
            <ul>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
              <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
            </ul>
          </div>

          <div class="col-lg-4 col-md-6 footer-newsletter">
            <h4>Join Our Newsletter</h4>
            <p>
              Sign up to learn more about technology and information management.
            </p>
            <form action="" method="post">
              <input type="email" name="email"><input type="submit" value="Subscribe">
            </form>
          </div>

        </div>
      </div>
    </div>

    <div class="container d-md-flex py-4">

      <div class="me-md-auto text-center text-md-start">
        <div class="copyright">
          &copy; Copyright <strong><span>Presento</span></strong>. All Rights Reserved
        </div>
        <div class="credits">
          <!-- All the links in the footer should remain intact. -->
          <!-- You can delete the links only if you purchased the pro version. -->
          <!-- Licensing information: https://bootstrapmade.com/license/ -->
          <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/presento-bootstrap-corporate-template/ -->
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
      </div>
      <div class="social-links text-center text-md-end pt-3 pt-md-0">
        <a href="#" class="twitter"><i class="bx bxl-twitter"></i></a>
        <a href="#" class="facebook"><i class="bx bxl-facebook"></i></a>
        <a href="#" class="instagram"><i class="bx bxl-instagram"></i></a>
        <a href="#" class="google-plus"><i class="bx bxl-skype"></i></a>
        <a href="#" class="linkedin"><i class="bx bxl-linkedin"></i></a>
      </div>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>
