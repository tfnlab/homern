<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.tfnlab.mysql.Review" %>
<%@ page import="com.tfnlab.mysql.ReviewDAO" %>

<%
  String name = request.getParameter("name");
  String email = request.getParameter("email");
  String token_id = request.getParameter("token_id");
  int rating = Integer.parseInt(request.getParameter("rating"));
  String comment = request.getParameter("comment");
  Review review = new Review(0, name, email, rating, comment, null, token_id);
  ReviewDAO reviewDAO = new ReviewDAO();
  boolean success = reviewDAO.insert(review);
  if (success) {
%>
    <p>Review submitted successfully!</p>
<%
  } else {
%>
    <p>There was an error submitting your review.</p>
<%
  }
%>
