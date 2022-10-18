<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*" %>

<%
	String ls_isbn = request.getParameter("isbn");
	String ls_titulo = request.getParameter("titulo");
	String ls_autor = request.getParameter("autor");
	String ls_anio = request.getParameter("anio");
	String ls_editorial = request.getParameter("editorial");
	String ls_action = request.getParameter("action");
	String ls_result = "Base de datos actualizada...";
	String ls_query = "";
	String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
	String userName="", password="";

	if (ls_action != null) {
		Connection conexion = null;
		ServletContext context = request.getServletContext();
		String path = context.getRealPath("/data");
		String filePath= path + "\\datos.mdb";
		String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

		if (ls_action.equals("crear")) {
			ls_query = " insert into libros (isbn, titulo, editorial, anio, autor) values ('" + ls_isbn + "', '" + ls_titulo + "', '" + ls_editorial + "', '" + ls_anio + "', '" + ls_autor + "' )";
		}

		if (ls_action.equals("eliminar")){
			ls_query = "delete from libros where isbn = '" + ls_isbn + "'";
		}

		if (ls_action.equals("actualizar")) {
			ls_query = "update libros set titulo = '" + ls_titulo + "', editorial = '" + ls_editorial + "', anio = '" + ls_anio + "', autor = '" + ls_autor + "' where isbn = '" + ls_isbn + "'";
		}

		try {
			Class.forName(driver);
			conexion = DriverManager.getConnection(fullConnectionString, userName, password);
			Statement statement = conexion.createStatement();
			Boolean result = statement.execute(ls_query);
			ls_result = "Se ha ejecutado correctamente la consulta!\nEstado de errores: " + result + "\n";
		}
		catch (ClassNotFoundException e) {
			ls_result = " Error creando el driver!";
			ls_result += " <br/>" + e.toString();
		}
		catch (SQLException e) {
			ls_result = " Error procesando el SQL!";
			ls_result += " <br/>" + e.toString();
		}
		finally {
		/* Cierra */
			try {
				if (conexion != null) {
					conexion.close();
				}
			} catch (SQLException e) {
				ls_result = "Error al cerrar la conexión.";
				ls_result += " <br/>" + e.toString();
			}
		}
	} 
	else{
		ls_query = "No se ha especificado ninguna accion!";
		ls_result = "No se ha ejecutando ninguna consulta!";
	}
%>
<html>
	<head>
		<title>Updating a Database</title>
		<meta charset="UTF-8" lang="es">
	</head>
	<body>
		<h1>
			La siguiente instrucción fue ejecutada:
		</h1>
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