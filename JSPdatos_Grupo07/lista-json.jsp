<%@page contentType="text/html" %>
<%@page pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>

<% String nombreJSON = "ARCHIVO.json"; 
   response.setHeader("Content-Disposition", "attachment;filename="+ nombreJSON); 
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
      out.println("[ ");
      while (rs.next())
      {
         out.println("\n { \n  \"id\": \""+i+"\",");
         out.println("  \"isbn\": \""+rs.getString("isbn")+"\",");
         out.println("  \"titulo\": \""+rs.getString("titulo")+"\"");
         out.println("},");
         i++;
      }
      out.println("]");

      // cierre de la conexion
      conexion.close();
}
%>