<%@ page language="java" import="java.lang.Thread,org.apache.commons.io.IOUtils,org.apache.commons.io.output.*,java.nio.charset.Charset,java.io.*,java.util.*,java.awt.image.BufferedImage,javax.imageio.ImageIO,java.io.OutputStream,java.io.FileInputStream,java.io.File"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.util.Random" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="com.tfnlab.api.con.APIConfig" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.tfnlab.util.Translate" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Home Renovation Nation - Sign-up</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

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
    function callTFNLab() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          document.getElementById("status").innerHTML = this.responseText;
          const el = document.createElement('textarea');
          el.value =  this.responseText;
          el.setAttribute('readonly', '');
          el.style.position = 'absolute';
          el.style.left = '-9999px';
          document.body.appendChild(el);
          el.select();
          document.execCommand('copy');
          document.body.removeChild(el);

        }
      };
      var urlString = "gennft.jsp?walletid=" + document.getElementById("walletid").value
      document.getElementById("start").style.display="none";
      document.getElementById("status").innerHTML = "Started Avatar Generation, give it a minute. <img src=\"assets/img/wait.gif\" />";
      xhttp.open("GET", urlString, true);
      xhttp.send();
    }

    function callCopy() {
      const el = document.createElement('textarea');
      el.value =  document.getElementById("status").innerHTML;
      el.setAttribute('readonly', '');
      el.style.position = 'absolute';
      el.style.left = '-9999px';
      document.body.appendChild(el);
      el.select();
      document.execCommand('copy');
      document.body.removeChild(el);
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
          <li>Sign-up</li>
        </ol>
        <h2>Sign-up</h2>
      </div>
    </section><!-- End Breadcrumbs -->

    <!-- ======= Blog Section ======= -->
    <section id="blog" class="blog">
      <div class="container px-4 px-lg-5">
        <h2><%= (new Translate()).translate("Sign-up", request.getParameter("language")) %></h2>
        <%
                String firstName = request.getParameter("firstName");
                String middleInitial = request.getParameter("middleInitial");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String ogId = "odId";
                String address = "";
                String city = "";
                String state = "";
                String zipcode = "";
                String addressaclat = "0";
                String addressaclng = "0";
                String business_type = request.getParameter("business_type");

                String url_website = request.getParameter("url_website");
                String url_yelp = request.getParameter("url_yelp");
                String url_google = request.getParameter("url_google");
                String url_twitter = request.getParameter("url_twitter");
                String url_tiktok = request.getParameter("url_tiktok");
                String url_snap = request.getParameter("url_snap");
                String url_instagram = request.getParameter("url_instagram");
                String url_facebook = request.getParameter("url_facebook");
                String referred_by = request.getParameter("referred_by");

                Random random = new Random();
                int num = random.nextInt(900000) + 100000;
                String is_email_confirmed_code = String.format("%06d", num);
                int nump = random.nextInt(900000) + 100000;
                String is_phone_confirmed_code = String.format("%06d", nump);

                // Validate form data
                if (firstName != null && firstName.trim().length() > 0) {
                  username = username.toLowerCase();
                  email = email.toLowerCase();
                  User user = new User(firstName, middleInitial, lastName, email, phone, username, password, ogId, address, city, state, zipcode, "0", "0", business_type, "", "", "url_website", "url_yelp", "url_google", "url_twitter", "url_tiktok", "url_snap", "url_instagram", "url_facebook", referred_by, "url_linkedin", "token_linkedin", "token_twitter_c_key", "token_twitter_c_secret", "token_twitter_a", "token_twitter_a_secret", "api_key");
                  user.setIs_phone_confirmed_code(is_phone_confirmed_code);
                  user.setIs_email_confirmed_code(is_email_confirmed_code);
                  UserDao dao = new UserDao();
                  try {
                      boolean pv = true;
                      String um = "Thank you for joining";
                      if (email == null || email.isEmpty()) {
                        pv = false;
                        um  = "Email can't be Empty";
                      }
                      if (username == null || username.isEmpty()) {
                        pv = false;
                        um  = "Username can't be Empty";
                      }
                      if (password == null || password.isEmpty()) {
                        pv = false;
                        um  = "Password can't be Empty";
                      }
                      if(dao.isUsernameTaken(username)){
                        pv = false;
                        um  = "Username is taken";
                      }else if(dao.isEmailTaken(email)){
                        pv = false;
                        um  = "Email is already a user";
                      }

                      if(username.equals(referred_by)){
                        pv = false;
                        um  = "Username can not equal to referred by";
                      }

                      if(pv){
                        dao.insertUser(user);
                        user = dao.getUserByUsername(username);
                        session.setAttribute("username", username);
                        session.setAttribute("usernameOBJ", user);
                        um  = "Thank you for joining";
                      }
                        %>
                        <p>
                          <%=um%>
                          <%if(pv){


                            UUID uuid = UUID.randomUUID();
                            String rm = "";
                            APIConfig ac = new APIConfig();

                            try{
                                  File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
                                  FileWriter fw = new FileWriter(file);
                                  BufferedWriter bw = new BufferedWriter(fw);

                                  String emailMessage = "Dear " + firstName + ",\n" +
                                                       "\n" +
                                                       "Thank you for registering with Home Renovation Nation! We're excited to have you as a member of our community.\n" +
                                                       "\n" +
                                                       "To complete your registration, please confirm your email by clicking the link below or visiting Home Renovation Nation and adding the following code under the \"User Profile\" section:\n" +
                                                       "\n" +
                                                       "<a href=\"https://homerenovationnation.com/signup.confirm.email.jsp?is_email_confirmed_code=" + is_email_confirmed_code + "&username=" + username + "&email=" + email +"\" >Confirm Email</a> " +
                                                       " " + is_email_confirmed_code + "\n" +
                                                       "\n" +
                                                       "Thank you for your cooperation, and we look forward to seeing you on the site!\n" +
                                                       "\n" +
                                                       "Sincerely,\n" +
                                                       "The Home Renovation Nation Team";


                                  bw.write(email + "<CONTENT>Home Renovation Nation Confirm Email<CONTENT>" + emailMessage);
                                  bw.close();

                                  Process pweb3 = new ProcessBuilder("python3", "/var/lib/tomcat9/webapps/py/sendmail.py", uuid.toString(), uuid.toString()).start();
                                  String stderr = IOUtils.toString(pweb3.getErrorStream(), Charset.defaultCharset());
                                  String stdout = IOUtils.toString(pweb3.getInputStream(), Charset.defaultCharset());
                                  rm = stdout + stderr + " TEST ";
                              }catch(IOException ex){
                                  rm = ex.getMessage();
                              }

                            %>
                              <hr>
                              Dear new customer,<BR><BR>

                              Welcome to Home Renovation Nation! Whether you're a homeowner looking to renovate your home or a contractor looking to grow your business, our platform has everything you need to get started. Sign up for free to access expert advice, connect with a community of homeowners, use our project planner tool, and receive discounts on products and services. Our system, built with advanced artificial intelligence, offers a wealth of functionality and capabilities to help you succeed in your home renovation journey. Join today and start exploring all that Home Renovation Nation has to offer. If you have any questions or need assistance, don't hesitate to reach out to us.
                              <BR><BR>
                              To start, let's finish setting up your user account so you can start using 'Home Renovation Nation' right away. Once that's done, you'll have full access to all the tools and resources available on Home Renovation Nation. We hope you find this system useful and helpful in your home renovation journey. If you have any questions or need assistance, don't hesitate to reach out to us.
                              <BR><BR>
                              Sincerely,
                              <BR><BR>
                              Home Renovation Nation
                              <%if(business_type.equals("home-owner")){%>
                                <a href="https://homerenovationnation.com/customer/user.edit.jsp">Finish User Profile</a>
                              <%}else{%>
                                <a href="https://homerenovationnation.com/user.edit.jsp">Finish User Profile</a>
                              <%}%>
                          <%}%>
                        </p>
                        <%
                  } catch (Exception e) {
                      %><%="An error occurred: " + e.getMessage()%><%
                  }


                }else{

                // Validate other fields as necessary

                // Create User object and set its fields


        %>
            <!-- ======= Contact Section ======= -->
                <p>
                <%= (new Translate()).translate("Are you a field service professional looking to simplify your business operations? Look no further than Home Renovation Nation! Our platform provides a one-stop-shop for all your business needs, from order to cash. Join now and access our advanced tools for free as a homeowner. Field service professionals can upgrade to our premium service for just $1 a day and unlock even more possibilities. Don't miss out on this opportunity to take your business to the next level. Sign up today and experience the difference Home Renovation Nation can make.", request.getParameter("language")) %>

                </p>
                <%
                const values = ["general-contractor", "carpenter", "plumber", "electrician", "hers-rating-company", "hvac-technician", "landscaper", "roofing-contractor", "painter", "flooring-contractor"];

                const names = ["General contractor","Carpenter", "Plumber", "Electrician", "HERS rating company", "HVAC technician", "Landscaper", "Roofing contractor", "Painter", "Flooring contractor"];

                %>

                <form action="signup.jsp" method="POST">
                  <div class="form-group  mt-3">
                    <label for="business-type">Select Your Role:</label>
                    <select class="form-control  mt-1" id="business_type" name="business_type">
                    <%for(int j=0;j<names.length();j++){%>
                      <option value="<%=values[j]%>"><%= (new Translate()).translate(names[j],  request.getParameter("language"))%></option>
                    <%}%>
                    </select>
                  </div>
                  <HR>

                    <div class="form-group mt-3">
                  <div class="row">
                    <div class="col">
              		<label for="firstName"><%= (new Translate()).translate("First Name", request.getParameter("language"))%>:</label><br>
              		<input type="text"  class="form-control mt-1" id="firstName" name="firstName"  required><br>
                    </div>
                    <div class="col">
              		<label for="middleInitial"><%= (new Translate()).translate("Middle Initial", request.getParameter("language"))%>:</label><br>
              		<input type="text"  class="form-control mt-1" id="middleInitial" name="middleInitial"><br>
                    </div>
                    <div class="col">
              		<label for="lastName"><%= (new Translate()).translate("Last Name", request.getParameter("language"))%>:</label><br>
              		<input type="text"  class="form-control mt-1" id="lastName" name="lastName" required><br>
                    </div>
                  </div>
                    </div>

                  <div class="form-group mt-3">
              		<label for="email"><%= (new Translate()).translate("Email", request.getParameter("language"))%>:</label><br>
              		<input type="email"  class="form-control" id="email" name="email" required><br>
                  </div>
                  <div class="form-group mt-3">
              		<label for="phone"><%= (new Translate()).translate("Phone", request.getParameter("language"))%>:</label><br>
              		<input type="text"  class="form-control" id="phone" name="phone" required><br>
                  </div>
                  <div class="form-group mt-3">
              		<label for="username"><%= (new Translate()).translate("Username", request.getParameter("language"))%>:</label><br>
              		<input type="text"  class="form-control" id="username" name="username" required><br>
                  </div>
                  <div class="form-group mt-3">
              		<label for="password"><%= (new Translate()).translate("Password", request.getParameter("language"))%>:</label><br>
              		<input type="password"  class="form-control" id="password" name="password" required><br>
                  </div>


                  <div class="form-group mt-3">

                  <div class="form-group  mt-3">
                    <label for="url_facebook"><%= (new Translate()).translate("Referred By", request.getParameter("language"))%></label>
                    <input type="text" class="form-control" id="referred_by" name="referred_by" <% if (request.getParameter("referred_by") !=null) { %>value="<%=request.getParameter("referred_by")%>" <% } %> >
                  </div>
                  <hr class="mt-3">
                    <a href="signup.tos.jsp" ><%= (new Translate()).translate("Terms Of Service", request.getParameter("language"))%></a>
                  <hr class="mt-3">

                      <button type="submit" class="btn btn-primary"><%= (new Translate()).translate("Sign-up", request.getParameter("language"))%></button>
                  	</form>

                 <%}%>
      </div>

    </section><!-- End Blog Section -->

  </main><!-- End #main -->


  <%@ include file="include.footer.jsp" %>

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
