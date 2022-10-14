<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
      <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <title>Actualizar, Eliminar, Crear registros.</title>
      </head>
   <body style="font-family:'Lucida Sans';">
      <h1>MANTENIMIENTO DE LIBROS</h1>
      <form action="matto.jsp" method="post" name="Actualizar">
         <table>
            <tr>
               <td>ISBN:<input type="text" name="isbn" value="" size="40"/></td>
            </tr>
            <tr>
               <td>T&iacutetulo:<input type="text" name="titulo" value="" size="50"/></td>
            </tr>
            <tr>
               <td>Acti&oacuten:
                  <input type="radio" name="Action" value="Actualizar"/> Actualizar
                  <input type="radio" name="Action" value="Eliminar" /> Eliminar
                  <input type="radio" name="Action" value="Crear" checked /> Crear
               </td>
               <td>
                  <input type="SUBMIT" value="ACEPTAR"/>
               </td>
         </table>
      </form>
      <br>
      <br>
      <%!
         public Connection getConnection(String path) throws SQLException 
         {
            String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
            String filePath= path + "\\datos.mdb";
            String userName="",password="";
            String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

               Connection conn = null;
            try
            {
                  Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                  conn = DriverManager.getConnection(fullConnectionString,userName,password);

            }
            catch (Exception e) 
            {
               System.out.println("Error: " + e);
            }
               return conn;
         }
      %>
      <%
         ServletContext context = request.getServletContext();
         String path = context.getRealPath("/data");
         Connection conexion = getConnection(path);
         if (!conexion.isClosed())
         {
            
            Statement st = conexion.createStatement();
            ResultSet rs = st.executeQuery("select * from libros" );

            // Ponemos los resultados en un table de html -------
                                
            out.println("<table border = \"2\"><thead><tr><th>Num.</th><th>ISBN</th><th>T&iacute;tulo</th><th>Acci&oacute;n</th></tr></thead><tbody>");
            int i=1;
            String prueba = "";
            while (rs.next())
            {
               prueba = rs.getString("isbn");
               out.println("<tr>");
               out.println("<td>"+ i +"</td>");
               out.println("<td>"+prueba+"</td>");
               out.println("<td>"+rs.getString("titulo")+"</td>");
               out.println("<td>"+"Actualizar<br><a href=\"matto.jsp?isbn="+prueba+"&Action=Eliminar\">Eliminar</a>"+"</td>");
               out.println("</tr>");
               i++;
            }
            out.println("</tbody></table>");

            // cierre de la conexion
            conexion.close();   
         }

      %>
   </body>
<html>
