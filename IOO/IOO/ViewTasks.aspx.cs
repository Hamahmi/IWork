using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class ViewTasks : System.Web.UI.Page
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
        SqlCommand cmd = new SqlCommand("view_Project_Tasks", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (string.IsNullOrEmpty(Session["pname"] as string) )
        {
            Response.Redirect("HomePage", true);
        }
        if (!(Session["type"] as string).Equals("r"))
        {

            Response.Write("<script> alert('You are not a regular employee')</script>");
            Response.Redirect("HomePage", true);
        }
        if (string.IsNullOrEmpty((Session["username"] as string)))
        {

            Response.Write("<script> alert('You are not logged in')</script>");
            Response.Redirect("HomePage", true);
        }
        cmd.Parameters.Add(new SqlParameter("@pname", Session["pname"] as string));
        cmd.Parameters.Add(new SqlParameter("@e_username", Session["username"] as string));
        conn.Open();
        cmd.ExecuteNonQuery();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Session["rdr"] = rdr;
        List<string> tn = new List<string>();
        List<string> pn = new List<string>();
        List<string> cn = new List<string>();
        List<string> ru = new List<string>();
        List<Button> t2 = new List<Button>();
        List<Button> t3 = new List<Button>();
        while (rdr.Read())
        {
            string name = rdr.GetString(rdr.GetOrdinal("name"));
            string pname = rdr.GetString(rdr.GetOrdinal("project_name"));
            string cmail = rdr.GetString(rdr.GetOrdinal("company_email"));
            DateTime deadline = rdr.GetDateTime(rdr.GetOrdinal("deadline"));
            string des = rdr.GetString(rdr.GetOrdinal("description"));
            string reu = rdr.GetString(rdr.GetOrdinal("regular_employee_username"));
            string mu = rdr.GetString(rdr.GetOrdinal("manager_username"));
            Label project = new Label();
            project.Text = "Task Name : "+name + "  <br /> <br />" + "Project Name : " + pname + "  <br /> <br />" + "Company Email : " + cmail + "  <br /> <br />"
                + "Deadline : " + deadline + "  <br /> <br />" + "des : " + des + "  <br /> <br />" + " Regular Employee Username : " + reu + "  <br /> <br />"
                 + " Manager Username : " + mu + "  <br /> <br />";
            form1.Controls.Add(project);
            Button b1 = new Button();
            b1.Text = "Finalize";
            b1.Click += new EventHandler(this.finalize);

            Button b2 = new Button();
            b2.Text = "Resume";
            b2.Click += new EventHandler(this.work);
            form1.Controls.Add(b1);
            form1.Controls.Add(b2);
            tn.Add(name);
            pn.Add(pname);
            cn.Add(cmail);
            ru.Add(reu);
            t2.Add(b1);
            t3.Add(b2);
        }
        Session["tn"] = tn;
        Session["pn"] = pn;
        Session["cn"] = cn;
        Session["t2"] = t2;
        Session["t3"] = t3;

    }
    protected void finalize(object sender , EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("Set_Fixed", conn);
        Button b = sender as Button;
        string name = (Session["tn"] as List<string>).ElementAt((Session["t2"] as List<Button>).IndexOf(b));
        string pn = (Session["pn"] as List<string>).ElementAt((Session["t2"] as List<Button>).IndexOf(b));
        string cn = (Session["cn"] as List<string>).ElementAt((Session["t2"] as List<Button>).IndexOf(b));
        string ru = (Session["username"] as string);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@name", name ));
        cmd.Parameters.Add(new SqlParameter("@project_name", pn));
        cmd.Parameters.Add(new SqlParameter("@company_email", cn));
        cmd.Parameters.Add(new SqlParameter("@regular_employee_username", ru));
        SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.Int);
        output.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        if (output.Value.ToString().Equals("0"))
            Response.Write("<script> alert('The deadline of this task has already passed or it is already closed')</script>");
        else
            Response.Write("<script> alert('The task status has been fixed')</script>");
    }
    protected void work(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("Set_Assigned", conn);
        Button b = sender as Button;
        string name = (Session["tn"] as List<string>).ElementAt((Session["t3"] as List<Button>).IndexOf(b));
        string pn = (Session["pn"] as List<string>).ElementAt((Session["t3"] as List<Button>).IndexOf(b));
        string cn = (Session["cn"] as List<string>).ElementAt((Session["t3"] as List<Button>).IndexOf(b));
        string ru = (Session["username"] as string);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@name", name));
        cmd.Parameters.Add(new SqlParameter("@project_name", pn));
        cmd.Parameters.Add(new SqlParameter("@company_email", cn));
        cmd.Parameters.Add(new SqlParameter("@regular_employee_username", ru));
        cmd.CommandType = CommandType.StoredProcedure;
        SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.VarChar);
        output.Direction = ParameterDirection.Output;
        output.Size = 50;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        if (output.Value.ToString().Equals("Assigned"))
                Response.Write("The status of this task has been set to Assigned");
        else
            if (output.Value.ToString().Equals("passed"))
                Response.Write("The deadline of this task has already passed");
            else
            Response.Write("This task has already been closed");
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