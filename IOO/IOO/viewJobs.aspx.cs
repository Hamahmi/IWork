using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class viewJobs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["username"] as string))
        {
            myProfileB.Text = "Register";
            logOut.Text = "Login";
        }
        else
        {
            myProfileB.Text = "Profile";
            logOut.Text = "Logout";
        }
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Job_In_Dep", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (string.IsNullOrEmpty(Session["jTitle"] as string) || string.IsNullOrEmpty(Session["code"] as string)
            || string.IsNullOrEmpty(Session["email"] as string))
            Response.Redirect("HomePage");
        cmd.Parameters.Add(new SqlParameter("@jname", Session["jTitle"] as string));
        cmd.Parameters.Add(new SqlParameter("@depCode", int.Parse(Session["code"]as string)));
        cmd.Parameters.Add(new SqlParameter("@company_email", Session["email"] as string));
        conn.Open();
        cmd.ExecuteNonQuery();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        grid1.DataSource = dt;
        grid1.DataBind();
    }

    protected void ApplyForJob(object sender , EventArgs e)
    {
        if (!string.IsNullOrEmpty(Session["username"] as string))
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Job_Seeker_apply", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", Session["username"] as string));
            cmd.Parameters.Add(new SqlParameter("@jTitle", Session["jTitle"] as string));
            cmd.Parameters.Add(new SqlParameter("@jdCode", int.Parse(Session["code"] as string)));
            cmd.Parameters.Add(new SqlParameter("@jcMail", Session["email"] as string));
            SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
            count.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (count.Value.ToString().Equals("1"))
            {

                Response.Write("<script> alert('Your application is now in process')</script>");

                Session["job_title"] = Session["jTitle"] as string;
                Session["dep_code"] = Session["code"] as string;
                Session["comp_email"] = Session["email"] as string;
                Response.Redirect("JobQuestions", true);
            }
            else
             if (count.Value.ToString().Equals("0"))
            {
                Response.Write("<script> alert('You do not have the required experience to apply to this job or you already applied and your application is still pending')</script> ");
            }
        }
        else
            Response.Write("<script> alert('You have to login first to apply for this job')</script> ");
    }
    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("HomePage");
    }
    protected void MyProfile(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["username"] as string))
            Response.Redirect("Register");
        else
            Response.Redirect("My_Profile");
    }
    protected void LogOut(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["username"] as string))
            Response.Redirect("Login");
        else
        {
            Session["type"] = null;
            Session["username"] = null;
            Response.Redirect("HomePage");

        }
    }
}