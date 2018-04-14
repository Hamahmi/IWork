using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Manager_Tasks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("~/Login", true);
        if (!Session["type"].Equals("m"))
            Response.Redirect("~/HomePage");

        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);

        if (!Page.IsPostBack)
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("View_Project_Tasks_With_Status", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@project_name", Session["ProjectSearch"]));
            cmd1.Parameters.Add(new SqlParameter("@status", Session["status"]));

            cmd1.ExecuteNonQuery();

            SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);
            Tasks.DataSource = dt1;
            Tasks.DataBind();

            conn.Close();
        }
    }

    protected void TaskReview(object sender, GridViewCommandEventArgs e)
    {

        if(e.CommandName == "Review")
        {
            string project = Tasks.Rows[Convert.ToInt32((e.CommandArgument).ToString())].Cells[1].Text;
            string task = Tasks.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
            Session["ProjectReview"] = project;
            Session["TaskReview"] = task;
            Response.Redirect("Task_Review");
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