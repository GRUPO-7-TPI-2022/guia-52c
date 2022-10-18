<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, net.ucanaccess.jdbc.*" %>
<%
	String query = "", orden_th = "asc", editorial_item = "";
	ServletContext context = request.getServletContext();
	String path = context.getRealPath("/data");
	Connection conexion = getConnection(path);
%>
<%!
	public Connection getConnection(String path) throws SQLException {

		String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
		String filePath= path + "\\datos.mdb";
		String userName="", password="";
		String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;
		Connection conn = null;

		try{
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			conn = DriverManager.getConnection(fullConnectionString,userName,password);
		}
		catch (Exception e) {
			System.out.println("Error: " + e);
		}
		return conn;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Actualizar, Eliminar, Crear registros.</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/libros.css"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta charset="UTF-8" lang="es"/>
		<script src="${pageContext.request.contextPath}/scripts/libros.js"></script>
	</head>
	<body>
		<di class="container-pl">
			<div class="name-form">
				<h1>Mantenimiento de Libros</h1>
			</div>
			<div id="container-li" class="container-li">
				<form id="form-actualizar" action="matto.jsp" method="post" name="actualizar">
					<table class="styled-table-form">
						<tbody>
							<td>
								<h3>Actualizar Datos</h3>
							</td>
							<%
								Statement st = conexion.createStatement();
								ResultSet rs = null;

								if (request.getParameter("isbn") != null) {

									query = "select * from libros where isbn='" + request.getParameter("isbn") + "'";

									if (!conexion.isClosed()){
										rs = st.executeQuery(query);
										rs.next();
										editorial_item = rs.getString("editorial");
										out.println("<tr><td><label>ISBN:</label><input id=\"input-isbn\" name=\"isbn\" class=\"input-text\" type=\"text\" value=\""+ rs.getString("isbn") + "\" pattern=\"[0-9]+\" minlength=\"13\" maxlength=\"13\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"0000-0000-0000-0\" onkeyup=\"evaluarCampos()\"/></td></tr>");
										out.println("<tr><td><label>Título:</label><input id=\"input-titulo\" name=\"titulo\" class=\"input-text\" type=\"text\" value=\""+ rs.getString("titulo") + "\" pattern=\"[a-zA-Z ]{3,32}\" minlength=\"3\" maxlength=\"32\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"La Iliada\" onkeyup=\"evaluarCampos()\"/></td></tr>");
										out.println("<tr><td><label>Autor:</label><input id=\"input-autor\" name=\"autor\" class=\"input-text\" type=\"text\" value=\""+ rs.getString("autor") + "\" pattern=\"[a-zA-Z ]{3,32}\" minlength=\"3\" maxlength=\"32\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"Miguel\" onkeyup=\"evaluarCampos()\"/></td></tr>");
										out.println("<tr><td><label>Año:</label><input id=\"input-anio\" name=\"anio\" class=\"input-text\" type=\"number\" step=\"1\" value=\""+ rs.getString("anio") + "\" pattern=\"[0-9]+\" minlength=\"4\" maxlength=\"4\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"1941\" onkeyup=\"evaluarCampos()\"/></td></tr>");
									}
								}
								else {
									out.println("<tr><td><label>ISBN:</label><input id=\"input-isbn\" name=\"isbn\" class=\"input-text\" type=\"text\" value=\"\" pattern=\"[0-9]+\" minlength=\"13\" maxlength=\"13\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"0000-0000-0000-0\" onkeyup=\"evaluarCampos()\"/></td></tr>");
									out.println("<tr><td><label>Título:</label><input id=\"input-titulo\" name=\"titulo\" class=\"input-text\" type=\"text\" value=\"\" pattern=\"[a-zA-Z ]{3,32}\" minlength=\"3\" maxlength=\"32\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"La Iliada\" onkeyup=\"evaluarCampos()\"/></td></tr>");
									out.println("<tr><td><label>Autor:</label><input id=\"input-autor\" name=\"autor\" class=\"input-text\" type=\"text\" value=\"\" pattern=\"[a-zA-Z ]{3,32}\" minlength=\"3\" maxlength=\"32\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"Miguel\" onkeyup=\"evaluarCampos()\"/></td></tr>");
									out.println("<tr><td><label>Año:</label><input id=\"input-anio\" name=\"anio\" class=\"input-text\" type=\"number\" step=\"1\" value=\"\" pattern=\"[0-9]+\" minlength=\"4\" maxlength=\"4\" title=\"Entrada Invalida!\" required=\"true\" placeholder=\"1941\" onkeyup=\"evaluarCampos()\"/></td></tr>");
								}
							%>
							<tr>
								<td>
									<label>Editorial:</label>
									<%
										query = "select * from editorial";

										if (request.getParameter("isbn") != null) {
											out.println("<select id=\"input-editorial\" name=\"editorial\">");
											out.println("<option select=\"true\">"+ editorial_item + "</option>");
										}
										else {
											out.println("<select id=\"input-editorial\" name=\"editorial\">");
										}

										if (!conexion.isClosed()){

											rs = st.executeQuery(query);

											while(rs.next()){
												out.println("<option>"+ rs.getString("nombreEditorial") + "</option>");
											}
										}
									%>
									</select>
								</td>
							</tr>
							<tr>
								<td>
									<h4>Opciones</h4>
									<% 
										if(request.getParameter("isbn") != null) {
											out.println("<input type=\"radio\" name=\"action\" value=\"actualizar\" checked/><label>Actualizar</label>");
											out.println("<input type=\"radio\" name=\"action\" value=\"crear\"/><label>Crear</label>");
											out.println("<input type=\"radio\" name=\"action\" value=\"eliminar\"/><label>Eliminar</label>");
											out.println("<input id=\"btn-actualizar\" type=\"submit\" class=\"button\" value=\"Actualizar\"");
										}
										else {
											out.println("<input type=\"radio\" name=\"action\" value=\"actualizar\"/><label>Actualizar</label>");
											out.println("<input type=\"radio\" name=\"action\" value=\"crear\" checked/><label>Crear</label>");
											out.println("<input type=\"radio\" name=\"action\" value=\"eliminar\"/><label>Eliminar</label>");
											out.println("<input id=\"btn-actualizar\" type=\"submit\" class=\"button\" value=\"Actualizar\" disabled=\"true\"/>");
										}
									%>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<form id="form-buscar" action="libros.jsp" method="post" name="buscar">
					<table class="styled-table-form">
						<tbody>
							<td>
								<h3>Realizar Búsqueda</h3>
							</td>
							<tr>
								<td>
									<label>ISBN:</label><input type="text" id="buscar-isbn" name="buscar_isbn" value="" class="input-text" pattern="[0-9]+" minlength="3" maxlength="13" title="Entrada Invalida!" required="true" placeholder="0000-0000-0000-0" onkeyup="cambiarEstado()"/>
								</td>
							</tr>
							<tr>
								<td>
									<label>Titulo:</label><input type="text" id="buscar-titulo" name="buscar_titulo" value="" class="input-text" pattern="[a-zA-Z ]{0,32}" minlength="0" maxlength="32" title="Entrada Invalida!" placeholder="Titulo Libro" onkeyup="cambiarEstado()"/>
									<input id= "btn-buscar" class="button" type="submit" value="Buscar" disabled="true"/>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<form id="form-descarga" action="libros.jsp" method="post" name="descargar">
					<table class="styled-table-form">
						<tbody>
							<!-- Exportar-->
							<td> 
								<h3>Exportar</h3>
							</td>
							<tr>
								<td><a href="listado-csv.jsp" download="Libros.csv">Formato CSV</a></td>
								<td><a href="listado-txt.jsp" download="Libros.txt">Formato TXT</a></td>
								<td><a href="listado-xml.jsp" download="Libros.xml">Formato XML</a></td>
							</tr>
							<tr>
								<td><a href="lista-json.jsp" download="Libros.json">Formato JSON</a></td>
								<td><a href="lista-html.jsp" download="Libros.html">Formato HTML</a></td>
							</tr>
							<td>
								<h3>Ordenar Datos</h3>
							</td>
							<tr>
								<td>
									<%
										if(request.getParameter("orden") != null && request.getParameter("orden").toString().equals("desc")) {
											out.println("<input id=\"radio-asc\" type=\"radio\" name=\"ord\" value=\"asc\" onchange=\"cambiarLink(this)\"/><label>Ascendente</label>");
											out.println("<input id=\"radio-desc\" type=\"radio\" name=\"ord\" value=\"desc\" onchange=\"cambiarLink(this)\" checked/><label>Descendente</label>");
										}
										else {
											out.println("<input id=\"radio-asc\" type=\"radio\" name=\"ord\" value=\"asc\" onchange=\"cambiarLink(this)\" checked/><label>Ascendente</label>");
											out.println("<input id=\"radio-desc\" type=\"radio\" name=\"ord\" value=\"desc\" onchange=\"cambiarLink(this)\"/><label>Descendente</label>");
										}
									%>
								</td>
							</tr>
						</tbody>
					</table>
				</form>	
			</div>
			<div class="container-tb">
				<!--Scripts-->
				<%
					// Consulta para obtener todos los datos
					query = "select * from libros ";

					if (request.getParameter("ordenar_por") != null && request.getParameter("orden") != null) {

						query += "order by " + request.getParameter("ordenar_por") + " " + request.getParameter("orden");

						if(request.getParameter("orden").equals("desc")) {
							orden_th = "desc";
						}
						else {
							orden_th = "asc";
						}
					}

					if(request.getParameter("buscar_isbn") != null || request.getParameter("buscar_titulo") != null ) {
						query = "select * from libros where isbn like'" + request.getParameter("buscar_isbn") + "%' and titulo like'" + request.getParameter("buscar_titulo") + "%'";
					}

					if (!conexion.isClosed()){
						out.write("Status: OK");
						rs = st.executeQuery(query);

						// Tabla de Datos
						out.println("<table class=\"styled-table-book\"><tbody><thead><tr><th>Número</th>" +
							"<th><a id=\"th-isbn\" class=\"white\" href=\"libros.jsp?ordenar_por=ISBN&orden=" + orden_th + "\">ISBN<img class=\"order\" title=\"isbn\" src=\"resources/order_by.svg\"/></a></th>" +
							"<th><a id=\"th-titulo\" class=\"white\" href=\"libros.jsp?ordenar_por=titulo&orden=" + orden_th + "\">Título<img class=\"order\" title=\"titulo\" src=\"resources/order_by.svg\"/></a></th>" +
							"<th><a id=\"th-autor\" class=\"white\" href=\"libros.jsp?ordenar_por=autor&orden=" + orden_th + "\">Autor<img class=\"order\" title=\"autor\" src=\"resources/order_by.svg\"/></a></th>" +
							"<th><a id=\"th-editorial\" class=\"white\" href=\"libros.jsp?ordenar_por=editorial&orden=" + orden_th + "\">Editorial<img class=\"order\" title=\"autor\" src=\"resources/order_by.svg\"/></a></th>" +
							"<th><a id=\"th-anio\" class=\"white\" href=\"libros.jsp?ordenar_por=anio&orden=" + orden_th + "\">Año<img class=\"order\" title=\"autor\" src=\"resources/order_by.svg\"/></a></th>" +
							"<th>Acción</th></tr></thead>");

						String isbn = "", titulo = "", editorial = "", autor = "", anio = "";
						int i = 1;

						while (rs.next()) {

							isbn = rs.getString("isbn");
							titulo = rs.getString("titulo");
							autor = rs.getString("autor");
							editorial = rs.getString("editorial");
							anio = rs.getString("anio");
							out.println("<tr>");
							out.println("<td>"+ i +"</td>");
							out.println("<td>" + isbn + "</td>");
							out.println("<td>" + titulo + "</td>");
							out.println("<td> " + autor + " </td>");
							out.println("<td>" + editorial + "</td>");
							out.println("<td>" + anio + "</td>");
							out.println("<td><boton><a href=\"libros.jsp?isbn=" + isbn + "\">Actualizar</a><br><a href=\"matto.jsp?isbn="+ isbn +"&action=eliminar\">Eliminar</a ></td>");

							out.println("</tr>");
							i++;
						}
						out.println("</tbody></table>");

						// cierre de la conexion
						conexion.close();
					}
				%>
			</div>
		</div>
	</body>
</html>