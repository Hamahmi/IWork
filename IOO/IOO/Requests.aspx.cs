using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Requests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string) || Session["type"].ToString().Equals("j"))
            Response.Redirect("HomePage");
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Request_Status", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        grid1.DataSource = dt;
        grid1.DataBind();
    }
    protected void delete(object sender, EventArgs e)
    {
        DateTime d;
        Boolean isValid = DateTime.TryParseExact(txt_start_date.Text, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d) || DateTime.TryParseExact(txt_start_date.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d);
        if (isValid) {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("Delete_Request", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            string user = Session["username"].ToString();
            cmd.Parameters.Add(new SqlParameter("@username", user));
            cmd.Parameters.Add(new SqlParameter("@start_date", d));
            SqlParameter msg = cmd.Parameters.Add("@msg", SqlDbType.VarChar);
            msg.Direction = ParameterDirection.Output;
            msg.Size = 100;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Write(msg.Value.ToString());

        }
        else
            Response.Write("write the date in the correct format");
    }
    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("HomePage");
    }
    protected void MyProfile(object sender, EventArgs e)
    {
        Response.Redirect("My_Profile");
    }
    protected void LogOut(object sender, EventArgs e)
    {
        Session["username"] = null;
        Session["type"] = null;
        Response.Redirect("HomePage");
    }

}