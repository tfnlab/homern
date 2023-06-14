<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tfnlab.mysql.User"%>
<%@ page import="com.tfnlab.mysql.UserDao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.tfnlab.mysql.Product" %>
<%@ page import="com.tfnlab.mysql.ProductDao" %>
<%@ include file="auth.sec.jsp" %>
<%

                int id = Integer.parseInt(request.getParameter("productId"));
                ProductDao dao = new ProductDao();
                Product product = dao.getProductById(id, username);
        %>
            				<%= product.getName() %><HRNITEM>
                    <%= product.getDescription() %><HRNITEM>
            		    <%= product.getPrice() %>
