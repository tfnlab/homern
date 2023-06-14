<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
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
            <h2><a href="<%=rootUpdate%>user.menu.sec.jsp" tabindex="1" >Home Renovation Nation</a></h2>
            <HR>
        <h2>Product</h2>
        <HR>

        <%

                int id = Integer.parseInt(request.getParameter("productId"));
                ProductDao dao = new ProductDao();

                long currentTimeMillis = System.currentTimeMillis();
                Timestamp currentTime = new Timestamp(currentTimeMillis);


                  // Get the form data from the request
                  String sku = request.getParameter("sku");
                  String name = request.getParameter("name");

                if (name != null && name.trim().length() > 0) {

                  BigDecimal price = new BigDecimal(request.getParameter("price"));
                  int inventory = Integer.parseInt(request.getParameter("inventory"));
                  int reorderLevel = 0;
                  int leadTime = 0;
                  boolean featured = Boolean.parseBoolean(request.getParameter("featured"));
                  BigDecimal rating = new BigDecimal(request.getParameter("rating"));

                  String description = request.getParameter("description");
                  String imageUrl = request.getParameter("image_url");
                  Timestamp createdAt = currentTime;
                  Timestamp updatedAt = currentTime;
                  int categoryId = 0;
                  int manufacturerId = 0;
                  boolean availability = Boolean.parseBoolean(request.getParameter("availability"));
                  BigDecimal weight = new BigDecimal(request.getParameter("weight"));
                  String dimensions = request.getParameter("dimensions");

                  String customerId = username;

                  // Create a new Product object
                 Product product = new Product(id, sku, name, price, inventory, reorderLevel, leadTime, featured, rating, description, imageUrl, createdAt, updatedAt, categoryId, manufacturerId, availability, weight, dimensions, customerId);

                  // Create a new ProductDao object

                  // Insert the Product object into the database
                  dao.updateProductById(product);
                %>
                <p>Product successfully Saved to the database.</p>
                <%

              }


                  Product product = dao.getProductById(id, username);

        %>
            		<form action="<%=rootUpdate%>product.edit.sec.jsp/" method="post" class="form">
            			<div class="form-group">
            				<label for="sku">ID:</label>
            				<input type="text" class="form-control" name="productId" id="productId" value="<%= product.getId() %>">
            			</div>
            			<div class="form-group">
            				<label for="sku">SKU:</label>
            				<input type="text" class="form-control" name="sku" id="sku" value="<%= product.getSku() %>">
            			</div>
            			<div class="form-group">
            				<label for="name">Name:</label>
            				<input type="text" class="form-control" name="name" id="name" value="<%= product.getName() %>">
            			</div>
            			<div class="form-group">
            				<label for="price">Price:</label>
            				<input type="text" class="form-control" name="price" id="price" value="<%= product.getPrice() %>">
            			</div>
            			<div class="form-group">
            				<label for="inventory">Inventory:</label>
            				<input type="text" class="form-control" name="inventory" id="inventory" value="<%= product.getInventory() %>">
            			</div>
            			<div class="form-group">
            				<label for="reorderLevel">Reorder Level:</label>
            				<input type="text" class="form-control" name="reorderLevel" id="reorderLevel" value="<%= product.getReorderLevel() %>">
            			</div>
            			<div class="form-group">
            				<label for="leadTime">Lead Time:</label>
            				<input type="text" class="form-control" name="leadTime" id="leadTime" value="<%= product.getLeadTime() %>">
            			</div>

                  <div class="form-group form-check">
            				<input type="checkbox" class="form-check-input" name="featured" id="featured" value="true" <%= product.isFeatured() ? "checked" : "" %>>
            				<label class="form-check-label" for="featured">Featured</label>
            			</div>
            			<div class="form-group">
            				<label for="rating">Rating:</label>
            				<input type="text" class="form-control" name="rating" id="rating" value="<%= product.getRating() %>">
            			</div>
            			<div class="form-group">
            				<label for="description">Description:</label>
                    <textarea class="form-control" id="description" name="description"><%= product.getDescription() %></textarea><br>
            			</div>
            			<div class="form-group">
            				<label for="imageUrl">Image URL:</label>
            				<input type="text" class="form-control" name="imageUrl" id="imageUrl" value="<%= product.getImageUrl() %>">
            			</div>
            			<div class="form-group">
            				<label for="createdAt">Created At:</label>
            				<input type="text" class="form-control" name="createdAt" id="createdAt" value="<%= product.getCreatedAt() %>">
            			</div>
            			<div class="form-group">
            				<label for="updatedAt">Updated At:</label>
            				<input type="text" class="form-control" name="updatedAt" id="updatedAt" value="<%= product.getUpdatedAt() %>">
            			</div>
            			<div class="form-group">
            				<label for="categoryId">Category ID:</label>
            				<input type="text" class="form-control" name="categoryId" id="categoryId" value="<%= product.getCategoryId() %>">
            			</div>
            			<div class="form-group">
            				<label for="manufacturerId">Manufacturer ID:</label>
            				<input type="text" class="form-control" name="manufacturerId" id="manufacturerId" value="<%= product.getManufacturerId() %>">
            			</div>
            			<div class="form-group form-check">
            				<input type="checkbox" class="form-check-input" name="availability" id="availability" value="true" <%= product.isAvailability() ? "checked" : "" %>>
            				<label class="form-check-label" for="availability">Availability</label>
            			</div>
                  <div class="form-group">
            				<label for="weight">Weight:</label>
            				<input type="text" class="form-control" name="weight" id="weight" value="<%= product.getWeight() %>">
            			</div>
            			<div class="form-group">
            				<label for="dimensions">Dimensions:</label>
            				<input type="text" class="form-control" name="dimensions" id="dimensions" value="<%= product.getDimensions() %>">
            			</div>
            			<div class="form-group">
            				<label for="customerId">Customer ID:</label>
            				<input type="text" class="form-control" name="customerId" id="customerId" value="<%= product.getCustomerId() %>">
            			</div>
            			<button type="submit" class="btn btn-primary">Save</button>
            		</form>


                                                </div>
                                            </div>

                                          </section><!-- End Blog Section -->

                                        </main><!-- End #main -->

</body>

</html>
