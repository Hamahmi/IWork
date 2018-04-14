using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HRViewJS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (!Session["type"].Equals("hr"))
            Response.Redirect("HomePage");
        if (Session["title"] == null)
            Response.Redirect("HRViewJob", true);
        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);

        string js = Session["js"].ToString();
        

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Job_Seeker", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", js));
        
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        grid1.DataSource = dt;
        grid1.DataBind();

        SqlCommand cmd1 = new SqlCommand("View_Job_Seeker_Jobs", conn);
        cmd1.CommandType = CommandType.StoredProcedure;

        cmd1.Parameters.Add(new SqlParameter("@username", js));

        SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
        DataTable dt1 = new DataTable();
        sda1.Fill(dt1);
        grid2.DataSource = dt1;
        grid2.DataBind();

        conn.Close();

    }

    protected void cancel(object sender, EventArgs e)
    {
        Response.Redirect("HRViewApplications", true);
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
        Session["type"] = null;
        Session["username"] = null;
        Response.Redirect("HomePage");
    }
}