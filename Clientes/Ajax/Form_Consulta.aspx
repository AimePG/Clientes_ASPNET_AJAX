<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Form_Consulta.aspx.cs" Inherits="Ajax_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../css/Estilos.css" rel="stylesheet" />
    <link href="../Componentes/Bootstrap/css/bootstrap.css" rel="stylesheet" />
    <link href="../Componentes/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../Componentes/DataTables/datatables.css" rel="stylesheet" />
    <link href="../Componentes/DataTables/datatables.min.css" rel="stylesheet" />
</head>

<body>
            <h>Atención a Clientes</h>
            <form id="Form_Consulta" runat="server">
                <div class="bottons">
                    <br/>
                     <button type="button" id="btn_Nuevo" class="btn btn-primary" onclick="ft_NuevoCliente()"> Nuevo </button>   
                     <button type="button" id="btn_Buscar" class="btn btn-primary" onclick="ft_BuscarCliente()"> Buscar </button>   
                </div>
                <div class="input-group">
                    <br/>
                    <label class="label">Buscar por nombre completo:</label> 
                    <input type="text" id="txt_Buscar" class="form-control" placeholder="val_Buscar"/>
                </div>
            <div>
                <br/>
                <table id="tbl_Clientes" class="table table-active" cellspacing="0" whith="100%">
                    <thead>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                    </thead>
                </table>
            </div>
            </form>

    <div class="modal fade" id="Form_Actualiza" tabindex="-1" role="dialog" aria-labelledby="Form_ActualizaLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="Form_ActualizaLabel">Actualizar Datos de Clientes</h5>
                </div>
                <div class="modal-body">
                    <form id="nuevoForm">
                      <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" class="form-control" id="nombre" placeholder="Nombre"/>
                      </div>
                      <div class="form-group">
                            <label for="primerApellido">Primer Apellido</label>
                            <input type="text" class="form-control" id="primerApellido" placeholder="Primer Apellido"/>
                      </div>
                      <div class="form-group">
                            <label for="segundoApellido">Segundo Apellido</label>
                            <input type="text" class="form-control" id="segundoApellido" placeholder="Segundo Apellido"/>
                      </div>
                      <div class="form-group">
                        <label for="identificacion">Identificación</label>
                        <input type="text" class="form-control" id="identificacion" placeholder="Identificación"/>
                      </div>
                      <div class="form-group">
                            <label for="telefono">Teléfono</label>
                            <input type="text" class="form-control" id="telefono" placeholder="Teléfono"/>
                      </div>
                      <div class="form-group">
                        <label for="direccion">Dirección</label>
                        <input type="text" class="form-control" id="direccion" placeholder="Dirección"/>
                      </div>
                      <input type="hidden" id="Id" value="0"/>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="ft_Cerrar()">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="ft_GuardarCliente()">Guardar</button>
                </div>
            </div>
        </div>
    </div>


    <script src="../Componentes/JQuery/jquery.min.js"></script>
    <script src="../Componentes/Bootstrap/js/bootstrap.js"></script>
    <script src="../Componentes/Bootstrap/js/bootstrap.min.js"></script>
    <script src="../Componentes/DataTables/datatables.js"></script>
    <script src="../Componentes/DataTables/datatables.min.js"></script>
    <script src="../Componentes/JQuery-confirm/js/jquery-confirm.js"></script>

    <script>

        ft_MostrarClientes("todos");

        function ft_MostrarClientes(nombre) {
            $(document).ready(function () {
                $.ajax({
                    type: "POST",
                    url: "Form_Consulta.aspx/Mostrar_Clientes",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ N: nombre }),
                    success: function (response) {
                        var data = JSON.parse(response.d); // obtengo los datos devueltos por el WebMethod Mostrar_Clientes
                        var table = $("#tbl_Clientes");
                        table.empty(); // Limpio la tabla para refrescarla
                        var headerRow = $("<tr></tr>");
                        headerRow.append($("<th style='display: none;'>ID</th>")); // Columna oculta para el ID
                        headerRow.append($("<th>Seleccionar</th>"));
                        headerRow.append($("<th>Nombre</th>"));
                        headerRow.append($("<th>Primer Apellido</th>"));
                        headerRow.append($("<th>Segundo Apellido</th>"));
                        headerRow.append($("<th>Identificación</th>"));
                        headerRow.append($("<th>Acciones</th>"));
                        table.append(headerRow); 
                        $.each(data, function (index, item) {
                            var row = $("<tr></tr>");
                            row.append($("<td style='display: none;'>" + item.Id + "</td>")); // Celda oculta con el ID
                            row.append($("<td><button type='button' class='btn btn-primary btn-sm' onclick='ft_EditarClientes(this)'>Sel</button></td>"));
                            row.append($("<td>" + item.Nombre + "</td>"));
                            row.append($("<td>" + item.PrimerApellido + "</td>"));
                            row.append($("<td>" + item.SegundoApellido + "</td>"));
                            row.append($("<td>" + item.Identificacion + "</td>"));
                            row.append($("<td><button class='btn btn-danger btn-sm' onclick='ft_EliminarClientes(this)'>Eliminar</button></td>"));
                            table.append(row);
                        });
                    },
                    error: function (response) {
                        alert("Error al recuperar los datos.");
                    }
                });
            });
        }


        //$('#txt_Buscar').on('keyup', function () {
        //    var table = $('#tbl_Clientes').DataTable();
        //    table.search(this.value).draw();
        //});
        function ft_EliminarClientes(btn) {
            var row = $(btn).closest('tr');
            var IdC = row.find('td:eq(0)').text(); // Asume que el ID está en la primera columna
            console.log(IdC);

            $.ajax({
                type: "POST",
                url: "Form_Consulta.aspx/Eliminar_Cliente",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ IdCliente: IdC }),
                success: function (response) {
                    var mensaje = response.d;
                    alert(mensaje);
                    ft_MostrarClientes('todos');
                },
                error: function (response) {
                    alert("Error al eliminar el cliente.");
                }
            });
        }

        function ft_EditarClientes(btn) {
            var row = $(btn).closest('tr');
            var IdC = row.find('td:eq(0)').text(); 

            $.ajax({
                type: "POST",
                url: "Form_Consulta.aspx/Editar_Cliente",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ IdCliente: IdC }),
                success: function (response) {
                    var values = JSON.parse(response.d);
                    $('#Form_Actualiza').modal('show');
                    $('#Id').val(values[0].ID);
                    $('#nombre').val(values[0].Nombre);
                    $('#primerApellido').val(values[0].PrimerApellido);
                    $('#segundoApellido').val(values[0].SegundoApellido);
                    $('#identificacion').val(values[0].Identificacion);
                    $('#telefono').val(values[0].Telefono);
                    $('#direccion').val(values[0].Direccion);
                    console.log(values);
                },
                error: function (response) {
                    alert("Error al recuperar el cliente.");
                }
            });
        }

        function ft_GuardarCliente() {
            var IdC = $('#Id').val();
            var n = $('#nombre').val();
            var pa = $('#primerApellido').val();
            var sa = $('#segundoApellido').val();
            var i = $('#identificacion').val();
            var t = $('#telefono').val();
            var d = $('#direccion').val();

            $.ajax({
                type: "POST",
                url: "Form_Consulta.aspx/Guardar_Cliente",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({
                    IdCliente: IdC,
                    nombre: n,
                    apellido1: pa,
                    apellido2: sa,
                    identificacion: i,
                    telefono: t,
                    direccion: d,
                }),
                success: function (response) {
                    var mensaje = response.d;
                    alert(mensaje);
                    ft_MostrarClientes('todos');
                },
                error: function (response) {
                    alert("Error al insertar el cliente.");
                }
            });
            ft_Cerrar();

        }

        function ft_BuscarCliente() {
            ft_MostrarClientes($('#txt_Buscar').val());
        }

        function ft_NuevoCliente() {
            $('#Id').val(0);
            $('#nombre').val("");
            $('#primerApellido').val("");
            $('#segundoApellido').val("");
            $('#identificacion').val("");
            $('#telefono').val("");
            $('#direccion').val("");

            $('#Form_Actualiza').modal('show');
        }

        function ft_Cerrar() {
            $('#Form_Actualiza').modal('hide');
        }


    </script> 


</body>
</html>
