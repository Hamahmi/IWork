using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class Manager_New_Project : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("~/Login", true);
        if (!Session["type"].Equals("m"))
            Response.Redirect("~/HomePage");

        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);
    }

    

    protected void Create_Project(object sender, EventArgs e)
    {
        if(name.Text=="" || start_date.Text=="" ||end_date.Text == "")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Create_Project", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@start_date", System.DateTime.Parse(start_date.Text)));
            cmd1.Parameters.Add(new SqlParameter("@end_date", System.DateTime.Parse(end_date.Text)));
            cmd1.Parameters.Add(new SqlParameter("@name", name.Text));

            cmd1.ExecuteNonQuery();
            conn.Close();
            string script = "alert('" + "Project has been created successfully " + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            Response.Redirect("Manager_Profile");
        }
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