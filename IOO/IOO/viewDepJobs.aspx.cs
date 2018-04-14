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

        SqlCommand cmd = new SqlCommand("Department_In_Company", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        int c = 0;
        string email="";
        if(string.IsNullOrEmpty(Session["code"] as string) || string.IsNullOrEmpty(Session["email"] as string) || int.TryParse(Session["code"] as string , out c) == false)
        {
            Response.Redirect("HomePage", true);
        }
       
        cmd.Parameters.Add(new SqlParameter("@dcode", int.Parse(Session["code"] as string)));
        cmd.Parameters.Add(new SqlParameter("@email", Session["email"] as string));
        conn.Open();
        cmd.ExecuteNonQuery();
        List<int> cod = new List<int>();
        List<string> compe = new List<string>();
        List<string> jtitle = new List<string>();
        List<Button> b = new List<Button>();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            int nv = rdr.GetInt32(rdr.GetOrdinal("no_of_vacancies"));
            if (nv > 0)
            {
                string title = rdr.GetString(rdr.GetOrdinal("title"));
                int code = rdr.GetInt32(rdr.GetOrdinal("department_code"));
                string comp = rdr.GetString(rdr.GetOrdinal("company_email"));
                Panel p = new Panel();
                Label l1 = new Label();
                l1.Text = "<br> </br>" + "Job's Title: " + title + "<br> </br>";
                l1.Font.Size = 22;
                l1.Font.Bold = true;
                l1.Font.Italic = true;
                p.Controls.Add(l1);
                
                Button b1 = new Button();
                b1.Text = "View Job's Information";
                b1.ForeColor = System.Drawing.Color.FromArgb(0x000066);
                b1.Font.Italic = true;
                b1.Font.Bold = true;

                b1.BackColor = System.Drawing.Color.FromArgb(0x9999FF);
                b1.Click += new EventHandler(this.jobs);
                b1.BorderColor = System.Drawing.Color.FromArgb(0x000066);
                b1.BorderStyle = BorderStyle.Double;

                p.Controls.Add(b1);
                p.BorderColor = System.Drawing.Color.FromArgb(0x000066);
                form1.Controls.Add(p);
                b.Add(b1);
                jtitle.Add(title);
                compe.Add(comp);
                cod.Add(code);
                Session["b"] = b;
                Session["titles"] = jtitle;
                Session["compe"] = compe;
                Session["cod"] = cod;
            }
        }
    }
    protected void jobs(object sender, EventArgs e)
    {

        List<Button> b = Session["b"] as List<Button>;
        List<int> cod = Session["cod"] as List<int>;
        List<string> compe= Session["compe"] as List<string>;
        List<string> jtitle = Session["titles"] as List<string>;
        int code = cod.ElementAt(b.IndexOf((Button)sender));
        string jTitle = jtitle.ElementAt(b.IndexOf((Button)sender));
        string email = compe.ElementAt(b.IndexOf((Button)sender));

        Session["code"] = code + "";
        Session["jTitle"] = jTitle;
        Session["email"] = email; 
        Response.Redirect("viewJobs", true);
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