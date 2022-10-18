/* Scripts de Libro.jsp*/ 
function cambiarLink(src) {

    if(src.value == "desc") {
        document.querySelector('#th-isbn').setAttribute('href','libros.jsp?ordenar_por=ISBN&orden=' + src.value)
        document.querySelector('#th-titulo').setAttribute('href','libros.jsp?ordenar_por=titulo&orden='+ src.value)
        document.querySelector('#th-autor').setAttribute('href','libros.jsp?ordenar_por=autor&orden='+ src.value)
        document.querySelector('#th-editorial').setAttribute('href','libros.jsp?ordenar_por=editorial&orden='+ src.value)
        document.querySelector('#th-anio').setAttribute('href','libros.jsp?ordenar_por=anio&orden='+ src.value)
    }
    else {
        document.querySelector('#th-isbn').setAttribute('href','libros.jsp?ordenar_por=ISBN&orden=' + src.value)
        document.querySelector('#th-titulo').setAttribute('href','libros.jsp?ordenar_por=titulo&orden='+ src.value)
        document.querySelector('#th-autor').setAttribute('href','libros.jsp?ordenar_por=autor&orden='+ src.value)
        document.querySelector('#th-editorial').setAttribute('href','libros.jsp?ordenar_por=editorial&orden='+ src.value)
        document.querySelector('#th-anio').setAttribute('href','libros.jsp?ordenar_por=anio&orden='+ src.value)
    }
}

function busqueda(src) {
    document.querySelector('#form-buscar').setAttribute('action', 'libros.jsp?buscar_isbn=' + src.value)
}

function evaluarCampos() {

    const isbn = document.querySelector('#input-isbn')
    const titulo = document.querySelector('#input-titulo')
    const autor = document.querySelector('#input-autor')
    const anio = document.querySelector('#input-anio')
    const boton = document.querySelector("#btn-actualizar")

    console.log(isbn.value)
    if (!(isbn.value.trim() === "") && !(titulo.value.trim() === "") && !(autor.value.trim() === "") && !(anio.value.trim() === "")) {
        boton.removeAttribute('disabled')
    }
    else {
        boton.setAttribute('disabled', 'true')
    }
}

function cambiarEstado() {
    const componente_1 = document.querySelector("#buscar-isbn")
    const componente_2 = document.querySelector("#buscar-titulo")
    const boton = document.querySelector("#btn-buscar")

    if (!(componente_1.value.trim() === "")) {
        boton.removeAttribute('disabled')
    }
    else if(componente_2.value.trim() === "") {
        boton.setAttribute('disabled', 'true')
  }
}