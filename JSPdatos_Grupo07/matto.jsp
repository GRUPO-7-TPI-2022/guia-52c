<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
 
<%
    /* Paso 1) Obtener los datos del formulario */
    String ls_isbn = request.getParameter("isbn");
    String ls_titulo = request.getParameter("titulo");
	String ls_action = request.getParameter("autor");
    String ls_action = request.getParameter("Action");
    
    /* Paso 2) Inicializar variables */
    String ls_result = "Base de datos actualizada...";
    String ls_query = "";
    ServletContext context = request.getServletContext();
    String path = context.getRealPath("/data");
    String filePath = path +"\\datos.mdb";
    String ls_dburl = "jdbc:odbc:Driver={MicroSoft Access Driver (*.mdb)};DBQ="+filePath;
    String ls_usuario = "";
    String ls_password = "";
    String ls_dbdriver = "sun.jdbc.odbc.JdbcOdbcDriver";
    
    /* Paso 3) Crear query&nbsp; */
    if (ls_action.equals("Crear")) 
    {
        ls_query = " insert into libros (isbn, titulo, autor)";
        ls_query += " values (";
        ls_query += "'" + ls_isbn + "',";
        ls_query += "'" + ls_titulo + "')";
		ls_query += "'" + ls_autor + "')";
    }
    
    if (ls_action.equals("Eliminar")) 
    {
        ls_query = " delete from libros where isbn = ";
        ls_query += "'" + ls_isbn + "'";
    }
    
    if (ls_action.equals("Actualizar")) 
    {
        ls_query = " update libros";
        ls_query += " set titulo= " + "'" + ls_titulo + "'";
		ls_query += " set autor= " + "'" + ls_autor + "'";
        ls_query += " where isbn = " + "'" + ls_isbn + "'";
    }
    
    /* Paso4) Conexi�n a la base de datos */
    Connection l_dbconn = null;
    
    try 
    {
        Class.forName(ls_dbdriver);
        /*&nbsp; getConnection(URL,User,Pw) */
        l_dbconn = DriverManager.getConnection(ls_dburl,ls_usuario,ls_password);
        
        /*Creación de SQL Statement */
        Statement l_statement = l_dbconn.createStatement();
        /* Ejecución de SQL Statement */
        l_statement.execute(ls_query);
    } catch (ClassNotFoundException e) {
        ls_result = " Error creando el driver!";
        ls_result += " <br/>" + e.toString();
    } catch (SQLException e) {
        ls_result = " Error procesando el SQL!";
        ls_result += " <br/>" + e.toString();
    } finally {
        /* Cerramos */
        try {
            if (l_dbconn != null) 
            {
                l_dbconn.close();
            }
        } catch (SQLException e) {
            ls_result = "Error al cerrar la conexi�n.";
            ls_result += " <br/>" + e.toString();
        }
    }
%>
<html>
    <head><title>Updating a Database</title></head>
    <body>
        La siguiente instrucci&oacute;n fue ejecutada:
        <br/><br/>
        <%=ls_query%>
        <br/><br/>
        
        El resultado fue:
        <br/><br/>
        <%=ls_result%>
        <br/><br/>
        
        <a href="libros.jsp">Entre otro valor</a>
    </body>
</html>