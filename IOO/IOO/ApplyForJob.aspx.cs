using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Apply_For_A_Job : System.Web.UI.Page
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

    }
    protected void viewQuestions(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Job_Seeker_apply", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"] as string;
        string job_title =  txt_Job_Title.Text;
        string comp_email = txt_comp_email.Text;
        int dep_code = 0;
        while(int.TryParse(txt_dep_code.Text,out dep_code) == false )
            Response.Write("<script> alert('You have to enter the department code in the right format')</script>");
        dep_code = int.Parse(txt_dep_code.Text);
        if(string.IsNullOrEmpty((Session["username"] as string)))
        {

            Response.Write("<script> alert('You are not logged in')</script>");
            Response.Redirect("HomePage", true);
        }

        cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@jTitle", job_title));
        cmd.Parameters.Add(new SqlParameter("@jdCode", dep_code));
        cmd.Parameters.Add(new SqlParameter("@jcMail", comp_email));
        SqlParameter count = cmd.Parameters.Add("@count", SqlDbType.Int);
        count.Direction = ParameterDirection.Output;
      
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (count.Value.ToString().Equals("1"))
        {

            Response.Write("<script> alert('Your application is now in process')</script>");

            Session["job_title"] = job_title;
            Session["dep_code"] = dep_code+"";
            Session["comp_email"] = comp_email;
            Response.Redirect("JobQuestions", true);
        }
        else
        {
            Response.Write("<script> alert('You do not have the required experience to apply to this job or you already applied and your application is still pending')</script> ");
        }

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
