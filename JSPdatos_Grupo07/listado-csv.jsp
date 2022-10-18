<%@page contentType="application/vnd.ms-excel" %>
<%@page pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>


<% String nombreExcel = "libros.csv"; 
   response.setHeader("Content-Disposition", "attachment;filename="+ nombreExcel); 
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
      while (rs.next())
      {
         out.println("Libro "+i);
         out.println(rs.getString("isbn"));
         out.println(rs.getString("titulo"));
         out.println("---------------------");
         i++;
      }

      // cierre de la conexion
      conexion.close();
}
%>
