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
                     <button type="button" id="btn_Nuevo" class="btn btn-primary" onclick="btnNuevo()"> Nuevo </button>   
                     <button type="button" id="btn_Buscar" class="btn btn-primary" onclick="btnBuscar()"> Buscar </button>   
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
                            <td>
                                <button class="btn btn-primary btn-sm" onclick="editarFila(this)">Sel</button>
                            </td>
                            <td>Nombre</td>
                            <td>Primer Apellido</td>
                            <td>Segundo Apellido</td>
                            <td>Identificación</td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="eliminarFila(this)">Eliminar</button>
                            </td>
                          </tr>
                    </thead>
                    

                </table>
            </div>
            </form>

    <script src="../Componentes/JQuery/jquery-3.7.1.min.js"></script>
    <script src="../Componentes/Bootstrap/js/bootstrap.js"></script>
    <script src="../Componentes/Bootstrap/js/bootstrap.min.js"></script>
    <script src="../Componentes/DataTables/datatables.js"></script>
    <script src="../Componentes/DataTables/datatables.min.js"></script>
    <script src="../Componentes/JQuery-confirm/js/jquery-confirm.js"></script>

    <script>

        function ft_MostrarClientes()
        {
            $('#tbl_Clientes').dataTable().fnDestroy();

            $.ajax({
                url: 'DatosClientes.aspx',
                datatype: 'JSON',
                type: 'GET',
                datatype: 'JSON',
                contentType: 'application/json; charset=utf-8',
                data: data,

                success: function (data)
                {
                    $('#tbl_Clientes').dataTable({
                        "aaData": data,
                        "scrollX": true,
                        "aoColumns": [
                            {"sTitle": "Nombre", "mData": "p_Nombre" },
                            {"sTitle": "Primer Apellido", "mData": "p_Apellido1" },
                            {"sTitle": "Segundo Apellido", "mData": "p_Apellido2" },
                            {"sTitle": "Identificación", "mData": "p_Identificación" },

                        ] 
                        

                    })
                }

            })
        }

        //$('#txt_Buscar').on('keyup', function () {
        //    var table = $('#tbl_Clientes').DataTable();
        //    table.search(this.value).draw();
        //});
        function eliminarFila(btn) {
            var row = $(btn).closest('tr');
            var id = row.find('td:eq(0)').text(); // Asume que el ID está en la primera columna

            $.ajax({
                url: 'ruta/a/tu/servidor/para/eliminar',
                type: 'POST',
                data: { id: id },
                success: function (response) {
                    if (response.success) {
                        row.remove();
                        $('#tbl_Clientes').DataTable().draw();
                    } else {
                        alert('Error al eliminar el registro');
                    }
                }
            });
        }
        function btnNuevo() {
            $('#nuevoModal').modal('show');
        }
        function cerrarModal() {
            $('#nuevoModal').modal('hide');
        }

        // Función para guardar el nuevo objeto
        function guardarNuevo() {
            var nombre = $('#nombre').val();
            var primerApellido = $('#primerApellido').val();
            var segundoApellido = $('#segundoApellido').val();
            var identificacion = $('#identificacion').val();

            $.ajax({
                url: 'ruta/a/tu/servidor/para/guardar', // Reemplaza con la ruta correcta
                type: 'POST',
                data: {
                    nombre: nombre,
                    primerApellido: primerApellido,
                    segundoApellido: segundoApellido,
                    identificacion: identificacion
                },
                success: function (response) {
                    if (response.success) {
                        // Recargar la tabla o actualizarla con el nuevo objeto
                        $('#nuevoModal').modal('hide');
                        alert('Objeto guardado exitosamente');
                    } else {
                        alert('Error al guardar el objeto');
                    }
                }
            });
        }

    </script> 

    <%-- ESTOP ES LO ULOTIMO --%>
    <div class="modal fade" id="nuevoModal" tabindex="-1" role="dialog" aria-labelledby="nuevoModalLabel" aria-hidden="true">
 <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="nuevoModalLabel">Agregar Nuevo Objeto</h5>
        <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>--%>
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
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="cerrarModal()">Cancelar</button>
        <button type="button" class="btn btn-primary" onclick="guardarNuevo()">Guardar</button>
      </div>
    </div>
 </div>
</div>

</body>
</html>
