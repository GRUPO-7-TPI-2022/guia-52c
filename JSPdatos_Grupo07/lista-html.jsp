<%@page contentType="text/html" %>
<%@page pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>

<% String nombreHTML = "ARCHIVO.html"; 
   response.setHeader("Content-Disposition", "attachment;filename="+ nombreHTML); 
%>

<%!

public Connection getConnection(String path) throws SQLException {
   String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
   String filePath= path+"/datos.mdb";
   String userName="",password="";
   String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
    String rutaRelativa = path + "\\datos.mdb";
   try
   {
      Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
      conn = DriverManager.getConnection(fullConnectionString,userName,password);

   }
   catch (Exception e) {
   System.out.println("Error: " + e);
   }
      return conn;
   }
%>
<%
ServletContext context = request.getServletContext();

String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
//out.write("OK");
 
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros" );
      int i=1;
      out.println("<!DOCTYPE html>\n<html lang=\"en\"><head>\n<meta charset=\"UTF-8\">\n<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">"+
            "\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n<title>Document</title>\n</head>\n<body>"
        );
      while (rs.next())
      {
         out.println(" <div key=\"" +i+"\">\n  <h1>Libro"+i+"</h1>");
         out.println("  <h2>ISBN:"+rs.getString("isbn")+"</h2>");
         out.println("  <h2>Titulo:"+rs.getString("titulo")+"</h2>\n  </div>");
         i++;
      }
      out.println("</body>\n</html>");

      // cierre de la conexion
      conexion.close();
}
%>