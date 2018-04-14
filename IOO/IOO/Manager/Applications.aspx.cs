using System; 
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Manager_Applications : System.Web.UI.Page
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

            SqlCommand cmd1 = new SqlCommand("Manager_View_Job_Applications", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("m_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("job_title", Session["JobTitle"]));
        
            cmd1.ExecuteNonQuery();

            SqlDataAdapter sda1 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            sda1.Fill(dt1);
            Apps.DataSource = dt1;
            Apps.DataBind();

            conn.Close();
        }
    }
    protected void App_Respond(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "accept")
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Manager_Respond_Job_Applications", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            string applicant_username = Apps.Rows[Convert.ToInt32((e.CommandArgument).ToString())].Cells[1].Text;
            string job_title = Apps.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@job_seeker_username", applicant_username));
            cmd1.Parameters.Add(new SqlParameter("@job_title", job_title));
            cmd1.Parameters.Add(new SqlParameter("@response", "accepted"));
            cmd1.ExecuteNonQuery();
            
            conn.Close();
            Response.Redirect("Applications");
        }
        if (e.CommandName == "reject")
        {

            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Manager_Respond_Job_Applications", conn);
            cmd1.CommandType = CommandType.StoredProcedure;
            string applicant_username = Apps.Rows[Convert.ToInt32((e.CommandArgument).ToString())].Cells[1].Text;
            string job_title = Apps.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@job_seeker_username", applicant_username));
            cmd1.Parameters.Add(new SqlParameter("@job_title", job_title));
            cmd1.Parameters.Add(new SqlParameter("@response", "rejected"));
            cmd1.ExecuteNonQuery();
            
            conn.Close();
            Response.Redirect("Applications");
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