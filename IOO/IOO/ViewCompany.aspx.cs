using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class ViewCompany : System.Web.UI.Page
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

        SqlCommand cmd = new SqlCommand("view_Company", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if(string.IsNullOrEmpty(Session["email"]as string))
        {
            Response.Redirect("HomePage", true);

        }
       
        cmd.Parameters.Add(new SqlParameter("@email", Session["email"] as string));

        SqlCommand cmd2 = new SqlCommand("view_Company_Departments", conn);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.Add(new SqlParameter("@email", Session["email"] as string));


        SqlCommand cmd3 = new SqlCommand("view_Company_Phones", conn);
        cmd3.CommandType = CommandType.StoredProcedure;
        cmd3.Parameters.Add(new SqlParameter("@email", Session["email"] as string));

        conn.Open();
        cmd.ExecuteNonQuery();
        cmd2.ExecuteNonQuery();
        cmd3.ExecuteNonQuery();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        grid1.DataSource = dt;
        grid1.DataBind();
        List<int> s = new List<int>();
        List<Button> b = new List<Button>();
        SqlDataAdapter sda2 = new SqlDataAdapter(cmd3);
        DataTable dt2 = new DataTable();
        sda2.Fill(dt2);
        grid3.DataSource = dt2;
        grid3.DataBind();
        SqlDataReader rdr = cmd2.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
           
            string x = rdr.GetString(rdr.GetOrdinal("company_email"));
            Session["email"] = x;
            string name = rdr.GetString(rdr.GetOrdinal("name"));
            int code = rdr.GetInt32(rdr.GetOrdinal("code"));
            Panel p = new Panel();
            Label l1 = new Label();
            l1.Text = "<br> </br>" + "Department's name: "+ name + "<br> </br>";
            l1.Font.Size = 22;
            l1.Font.Bold = true;
            l1.Font.Italic = true;
            p.Controls.Add(l1);
            Button b1 = new Button();
            b1.Text = "View Department's Information" ;
            b1.ForeColor = System.Drawing.Color.FromArgb(0x000066);
            b1.Font.Italic = true;
            b1.Font.Bold = true;
            
            b1.BackColor = System.Drawing.Color.FromArgb(0x9999FF);
            b1.Click += new EventHandler(this.jobs);
            b1.BorderColor = System.Drawing.Color.FromArgb(0x000066);
            b1.BorderStyle = BorderStyle.Double;

            p.Controls.Add(b1);
            p.BorderColor = System.Drawing.Color.FromArgb(0x000066);
            s.Add(code);
            b.Add(b1);
            form1.Controls.Add(p);
            Session["s"] = s;
            Session["b"] = b; 
        }

        }
        protected void jobs(object sender , EventArgs e)
    {
        List<Button> b = Session["b"] as List<Button>;
        List<int> s = Session["s"] as List<int>;
        int code = s.ElementAt(b.IndexOf((Button)sender));
        Session["code"] = code+"";
        Response.Redirect("ViewDepJobs", true); 
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