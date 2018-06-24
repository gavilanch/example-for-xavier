using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webformapp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [WebMethod]
        public static string ObtenerInformacionDolares(DateTime fecha)
        {
            return BuscarInformacionDolares(fecha).ToString();
        }

        public static decimal BuscarInformacionDolares(DateTime fecha)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_GetTasaCambio", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@fecha", fecha));
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            throw new ApplicationException("No existe información de tasa de cambio para la fecha " + fecha.ToShortDateString());
                        }

                        decimal resultado = decimal.Parse(dt.Rows[0]["cordoba_x_dolar"].ToString());
                        return resultado;
                    }
                }
            }
        }
    }
}