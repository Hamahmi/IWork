using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HRViewJob : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (!Session["type"].Equals("hr"))
            Response.Redirect("HomePage");
        
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Jobs", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);
        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));

        

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        grid1.DataSource = dt;
        grid1.DataBind();

        conn.Close();
    }


    protected void rowcom(object sender, GridViewCommandEventArgs e)
    {
        int row = Convert.ToInt32(e.CommandArgument.ToString());
        string title = (grid1.Rows[row].Cells[0]).Text;
        Session["title"] = title;
        
        if (e.CommandName == "viewjob")
        {
            Response.Redirect("HRViewAJob", true);
        }
        if (e.CommandName == "edit")
        {
            Response.Redirect("HREditJob", true);
        }
        if (e.CommandName == "viewapp")
        {
            Response.Redirect("HRViewApplications", true);
        }
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
    protected void cancel(object sender, EventArgs e)
    {
        Session["title"] = null;
        Response.Redirect("HR", true);
    }

  
}