using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ViewProjects : System.Web.UI.Page
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
        SqlCommand cmd = new SqlCommand("view_projects", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (string.IsNullOrEmpty((Session["username"] as string)))
        {

            Response.Write("<script> alert('You are not logged in')</script>");
            Response.Redirect("HomePage", true);
        }
        if (!(Session["type"] as string).Equals("r"))
        {

            Response.Write("<script> alert('You are not a regular employee')</script>");
            Response.Redirect("HomePage", true);
        }
        cmd.Parameters.Add(new SqlParameter("@username", Session["username"] as string));
        conn.Open();
        cmd.ExecuteNonQuery();
        
        List<Button> l = new List<Button>();
        List<string> s = new List<string>();

        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Session["rdr"] = rdr;
        while (rdr.Read())
        {
            string name = rdr.GetString(rdr.GetOrdinal("name"));
            string cmail = rdr.GetString(rdr.GetOrdinal("company_email"));
            DateTime sdate = rdr.GetDateTime(rdr.GetOrdinal("start_date"));
            DateTime edate = rdr.GetDateTime(rdr.GetOrdinal("end_date"));
            string mu = rdr.GetString(rdr.GetOrdinal("manager_username"));

            Label project = new Label();
            project.Text = "Project Name : "+name + "  <br /> <br />" + "Company Email : "+cmail + "  <br /> <br />"
                + "Start Date : " +sdate + "  <br /> <br />" + "End Date : "+edate + "  <br /> <br />" + " Manager Username : "+mu+ "  <br /> <br />";
            form1.Controls.Add(project);
            Button b = new Button();
            b.Text = "View Tasks";   
            b.Click += new EventHandler(this.viewTasks);
            b.ControlStyle.BackColor =new System.Drawing.Color();
            l.Add(b);
            s.Add(name);
            form1.Controls.Add(b);
        }
        conn.Close();
        Session["l"] = l;
        Session["s"] = s;
       
    }
    protected void viewTasks(object sender,EventArgs e)
    {
        List<string> s = Session["s"] as List<string>;
        List<Button> l = Session["l"] as List<Button>;
        string pname = s.ElementAt(l.IndexOf((Button)sender));
        Session["pname"] = pname;
        Response.Redirect("ViewTasks", true);

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