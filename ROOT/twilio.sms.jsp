<%@ page language="java" import="java.util.UUID, java.io.File, java.io.FileWriter, java.io.BufferedWriter, com.tfnlab.api.con.APIConfig, java.io.FileOutputStream, com.tfnlab.mysql.User, com.tfnlab.mysql.UserDao, java.lang.Thread, org.apache.commons.io.IOUtils, org.apache.commons.io.output.*, java.nio.charset.Charset, java.io.*, java.util.*, java.awt.image.BufferedImage, javax.imageio.ImageIO, java.io.OutputStream, java.io.FileInputStream, java.io.File" %>
<%
UserDao dao = new UserDao();
String username = request.getParameter("username");
User user = dao.getUserByUsername(username);
UUID uuid = UUID.randomUUID();
String rm = "";
APIConfig ac = new APIConfig();
try {
    File file = new File(ac.getPdfloc() + uuid.toString() + ".txt");
    FileWriter fw = new FileWriter(file);
    BufferedWriter bw = new BufferedWriter(fw);
    bw.write(user.getTwilio_voice_forward_phone() + "<CONTENT>" + request.getParameter("From") + "<CONTENT>call for " + request.getParameter("username") + " From " + request.getParameter("From"));

    // Append all parameters in the request to the content
    Enumeration<String> paramNames = request.getParameterNames();
    while (paramNames.hasMoreElements()) {
        String paramName = paramNames.nextElement();
        String paramValue = request.getParameter(paramName);
        bw.write("<PARAMETER>" + paramName + "=" + paramValue + "<PARAMETER>");
    }

    bw.close();
} catch (IOException ex) {
    rm = ex.getMessage();
}
%>Thank You
