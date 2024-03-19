using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;

public partial class Ajax_Datos_Clientes : System.Web.UI.Page
{
    public class Class_Clientes 
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string PApellido { get; set; }
        public string SApellido { get; set; }
        public string Identificacion { get; set; }
    }

    //public string Mostrar_Clientes() 
    //{
    //    SqlConnection con = null;
    // Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True;Connect Timeout=30;Encrypt=False;Trust Server Certificate=False;Application Intent=ReadWrite;Multi Subnet Failover=False
    //}

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}