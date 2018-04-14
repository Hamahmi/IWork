using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class View_Status : System.Web.UI.Page
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
        SqlCommand cmd = new SqlCommand("view_Status", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        
        if (string.IsNullOrEmpty((Session["username"] as string)))
        {

            Response.Write("<script> alert('You are not logged in')</script>");
            Response.Redirect("HomePage", true);
        }
        cmd.Parameters.Add(new SqlParameter("@username", Session["username"] as string));
        conn.Open();
        cmd.ExecuteNonQuery();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Session["rdr"] = rdr;
        while (rdr.Read())
        {
            string job_t = rdr.GetString(rdr.GetOrdinal("job_title"));
            string manager_r = rdr.GetString(rdr.GetOrdinal("manager_response"));
            int scor = rdr.GetInt32(rdr.GetOrdinal("score"));
            Label job_title = new Label();
            job_title.Text = "Job Title : " + job_t + "  <br /> <br />";
            form1.Controls.Add(job_title);
                Label manager_response = new Label();
                manager_response.Text = "Status : " + manager_r + "  ";
                form1.Controls.Add(manager_response);

                Label score = new Label();
                score.Text = "Score : " + scor + "  <br /> <br />";
                form1.Controls.Add(score);

                Button delete = new Button();
                delete.Text = "Delete Application";
                delete.Click += new EventHandler(this.delete);

                Button accept = new Button();
                accept.Text = "Accept Job";
                accept.Click += new EventHandler(this.accept);

                if (manager_r == "accepted")
                {
                    form1.Controls.Add(accept);

                }
                else
                {
                    form1.Controls.Add(delete);

                }
            
        }
    }
    protected void delete(object sender , EventArgs e)
    {
        Response.Redirect("DeleteApplications", true);
    }

    protected void accept(object sender, EventArgs e)
    {
        Response.Redirect("ChooseJob", true);
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
    public static string SafeString(SqlDataReader rdr, string col)
    {
        if (!rdr.IsDBNull(rdr.GetOrdinal(col)))
            return rdr.GetSqlValue(rdr.GetOrdinal(col)).ToString();
        else
            return "";
    }
}