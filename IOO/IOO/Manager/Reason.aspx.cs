using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Manager_Reason : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["Username"] == null)
            Response.Redirect("~/Login", true);
        if (!Session["type"].Equals("m"))
            Response.Redirect("~/HomePage");


       
    }


    protected void Sub(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        conn.Open();

        SqlCommand cmd1 = new SqlCommand("Manager_Respond_To_Request", conn);
        cmd1.CommandType = CommandType.StoredProcedure;

        cmd1.Parameters.Add(new SqlParameter("@m_username", Session["Username"]));
        cmd1.Parameters.Add(new SqlParameter("@applicant_username", Session["Applicant"]));
        cmd1.Parameters.Add(new SqlParameter("@start_date", Session["start_date"]));
        cmd1.Parameters.Add(new SqlParameter("@manager_response", "rejected"));

        cmd1.Parameters.Add(new SqlParameter("@reason", reason.Text));
        cmd1.ExecuteNonQuery();
        Response.Redirect("Requets");
        conn.Close();

    }


    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("~/HomePage");
    }
    protected void MyProfile(object sender, EventArgs e)
    {
        Response.Redirect("~/My_Profile");
    }
    protected void LogOut(object sender, EventArgs e)
    {
        Session["type"] = null;
        Session["username"] = null;
        Response.Redirect("~/HomePage");
    }
}