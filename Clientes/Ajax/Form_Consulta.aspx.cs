using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Runtime.Remoting.Messaging;
using System.Configuration;
using System.Activities.Expressions;


public partial class Ajax_Default : System.Web.UI.Page
{
    public class Class_Clientes
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string PrimerApellido { get; set; }
        public string SegundoApellido { get; set; }
        public string Identificacion { get; set; }
    }

    [WebMethod]
    public static string Mostrar_Clientes()
    {
        string connectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=sqlclientes;";
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

                 SqlCommand command = new SqlCommand("SELECT ID, Nombre, PrimerApellido, SegundoApellido, Identificacion FROM dbo.FTN_CLIENTES_PRUEBA_LISTA_CLIENTES()", con);
                 {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                    List<Class_Clientes> clientes = new List<Class_Clientes>();
                    while (reader.Read())
                    {
                        Class_Clientes cliente = new Class_Clientes
                        {
                            Id = reader["ID"].ToString(),
                            Nombre = reader["Nombre"].ToString(),
                            PrimerApellido = reader["PrimerApellido"].ToString(),
                            SegundoApellido = reader["SegundoApellido"].ToString(),
                            Identificacion = reader["Identificacion"].ToString()
                        };
                        clientes.Add(cliente);
                    }
                    return JsonConvert.SerializeObject(clientes);
                }
            }
        }
    }

    [WebMethod]
    public static string Eliminar_Cliente(string N)
    {
        string connectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=sqlclientes;";
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            SqlCommand co = new SqlCommand("SELECT * FROM dbo.FTN_CLIENTES_PRUEBA_LISTA_CLIENTES_POR_NOMBRE(@Nombre)", con);
            co.Parameters.AddWithValue("@Nombre", N);
            SqlDataReader re = co.ExecuteReader();
            re.Read();

            using (SqlCommand command = new SqlCommand("STPR_CLIENTES_PRUEBA_MANTENIMIENTO", con))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@P_Nombre", re["Nombre"].ToString()); 
                command.Parameters.AddWithValue("@P_Apellido1", re["PrimerApellido"].ToString());
                command.Parameters.AddWithValue("@P_Apellido2", re["SegundoApellido"].ToString());
                command.Parameters.AddWithValue("@P_Identificacion", re["Identificacion"].ToString());
                command.Parameters.AddWithValue("@P_Direccion", re["Direccion"].ToString());
                command.Parameters.AddWithValue("@P_Telefono", re["Telefono"].ToString());
                command.Parameters.AddWithValue("@P_Accion", "B"); // B para Borrar
                SqlParameter outputParam = new SqlParameter("@P_Mensaje", SqlDbType.NVarChar, 50);
                outputParam.Direction = ParameterDirection.Output;
                command.Parameters.Add(outputParam);

                re.Close();
               
                command.ExecuteNonQuery();
                string mensaje = outputParam.Value.ToString();
                return mensaje;
            }
        }
    }

    [WebMethod]
    public static string Editar_Cliente(string N)
    {
        string connectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=sqlclientes;";
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();
            using (SqlCommand command = new SqlCommand("FTN_CLIENTES_PRUEBA_LISTA_CLIENTES_POR_NOMBRE", con))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Nombre", N);

                DataTable dt = new DataTable();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    dt.Load(reader);
                }
                return JsonConvert.SerializeObject(dt);
            }
        }
    }

    [WebMethod]
    public static string Insertar_Cliente(string nombre, string apellido1, string apellido2, string identificacion, string telefono, string direccion)
    {
        string connectionString = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=sqlclientes;";
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();
            using (SqlCommand command = new SqlCommand("STPR_CLIENTES_PRUEBA_MANTENIMIENTO", con))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@P_Nombre", nombre);
                command.Parameters.AddWithValue("@P_Apellido1", apellido1);
                command.Parameters.AddWithValue("@P_Apellido2", apellido2);
                command.Parameters.AddWithValue("@P_Identificacion", identificacion);
                command.Parameters.AddWithValue("@P_Telefono", telefono);
                command.Parameters.AddWithValue("@P_Direccion", direccion);
                command.Parameters.AddWithValue("@P_Accion", "I"); // I para Insertar
                SqlParameter outputParam = new SqlParameter("@P_Mensaje", SqlDbType.NVarChar, 50);
                outputParam.Direction = ParameterDirection.Output;
                command.Parameters.Add(outputParam);

                command.ExecuteNonQuery();
                string mensaje = outputParam.Value.ToString();
                return mensaje;
            }
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
    }
}
