using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Manager_Requets : System.Web.UI.Page
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

            SqlCommand cmd1 = new SqlCommand("Manager_View_Trip_Requests", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("m_username", Session["Username"]));
            cmd1.ExecuteNonQuery();
            SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);
            Trip_Requests.DataSource = dt1;
            Trip_Requests.DataBind();

            SqlCommand cmd2 = new SqlCommand("Manager_View_Leave_Requests", conn);
            cmd2.CommandType = CommandType.StoredProcedure;

            cmd2.Parameters.Add(new SqlParameter("m_username", Session["Username"]));
            cmd2.ExecuteNonQuery();
            SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
            DataTable dt2 = new DataTable();
            sda2.Fill(dt2);
            Leave_Requests.DataSource = dt2;
            Leave_Requests.DataBind();
            conn.Close();
        }
    }
    protected void Trip_Commands(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "accept")
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Manager_Respond_To_Request", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            string applicant_username = Trip_Requests.Rows[Convert.ToInt32((e.CommandArgument).ToString())].Cells[0].Text;
            string start_date = Trip_Requests.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;

            cmd1.Parameters.Add(new SqlParameter("@m_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@applicant_username", applicant_username));
            cmd1.Parameters.Add(new SqlParameter("@start_date", start_date));
            cmd1.Parameters.Add(new SqlParameter("@manager_response", "accepted"));
            cmd1.ExecuteNonQuery();
            Response.Redirect("Requets");
            conn.Close();
        }
        if (e.CommandName == "reject")
        {
            string applicant_username = Trip_Requests.Rows[Convert.ToInt32((e.CommandArgument).ToString())].Cells[0].Text;
            string start_date = Trip_Requests.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
            Session["Applicant"] = applicant_username;
            Session["start_date"] = start_date;
            Response.Redirect("Reason",true);
        }
    }
    protected void Leave_Commands(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "accept")
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Manager_Respond_To_Request", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            string applicant_username = Leave_Requests.Rows[Convert.ToInt32((e.CommandArgument).ToString())].Cells[0].Text;
            string start_date = Leave_Requests.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;

            cmd1.Parameters.Add(new SqlParameter("@m_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@applicant_username", applicant_username));
            cmd1.Parameters.Add(new SqlParameter("@start_date", start_date));
            cmd1.Parameters.Add(new SqlParameter("@manager_response", "accepted"));
            cmd1.ExecuteNonQuery();
            Response.Redirect("Requets");
            conn.Close();
        }
        if (e.CommandName == "reject")
        {
            string applicant_username = Leave_Requests.Rows[Convert.ToInt32((e.CommandArgument).ToString())].Cells[0].Text;
            string start_date = Leave_Requests.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
            Session["Applicant"] = applicant_username;
            Session["start_date"] = start_date;
            Response.Redirect("Reason", true);
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