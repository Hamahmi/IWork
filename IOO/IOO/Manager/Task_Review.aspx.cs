using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Manager_Task_Review : System.Web.UI.Page
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
    protected void AcceptClicked(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        conn.Open();

        SqlCommand cmd1 = new SqlCommand("Task_Review", conn);
        cmd1.CommandType = CommandType.StoredProcedure;

        cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
        cmd1.Parameters.Add(new SqlParameter("@name", Session["TaskReview"]));
        cmd1.Parameters.Add(new SqlParameter("@project_name", Session["ProjectReview"]));
        cmd1.Parameters.Add(new SqlParameter("@status", "Closed"));


        cmd1.ExecuteNonQuery();
        conn.Close();
        string script = "alert('" + "The Task has been closed successfully. " + "');";
        ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        Response.Redirect("Tasks");

    }
    protected void RejectClicked(object sender, EventArgs e)
    {

        if (newDeadline.Text == "")
        {
            string script = "alert('" + "You have to specify the new deadline" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Task_Review", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@name", Session["TaskReview"]));
            cmd1.Parameters.Add(new SqlParameter("@project_name", Session["ProjectReview"]));
            cmd1.Parameters.Add(new SqlParameter("@status", "Assigned"));


            cmd1.ExecuteNonQuery();
            conn.Close();
            string script = "alert('" + "The Task has been closed successfully. " + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
            Response.Redirect("Tasks");
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