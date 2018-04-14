using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SearchJobResults : System.Web.UI.Page
{
     List<Button> btns;
     List<string> Cemail;
     List<string> Dcode;
     List<string> Jtitle;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (string.IsNullOrEmpty(Session["v"] as string))
            Response.Redirect("HomePage");
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
        btns = new List<Button>();
        Cemail = new List<string>();
        Dcode = new List<string>();
        Jtitle =  new List<string>();
        String v = Session["v"].ToString();
        if (v.Equals("1"))
            searchC();
        else
            if (v.Equals("2"))
            type();
        else
            if (v.Equals("3"))
            avg();
        else
            searchJ();
    }
    protected void searchJ()
    {
        string keys = Session["KW"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Search_For_Job", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@jname", keys));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            Panel p1 = new Panel();
            p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
            p1.BorderStyle = BorderStyle.Solid;
            p1.BorderWidth = 2;
            p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
            string Cname = SafeString(rdr, "name");
            string dname = SafeString(rdr, "dname");
            string title = SafeString(rdr, "title");
            string email = SafeString(rdr, "company_email");
            string code = SafeString(rdr, "department_code");
            Label cn = new Label();
            cn.Text = "&nbsp;" + title;
            cn.Font.Size = 22;
            cn.Font.Bold = true;
            cn.Width = 1100;
            Label ea = new Label();
            ea.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + Cname + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dname;
            ea.Font.Size = 12;
            ea.Width = 1000;
            Label lb = new Label();
            lb.Text = "<br />";
            Button view = new Button();
            view.Text = "View job";
            view.Click += new EventHandler(this.view_info);
            view.Width = 100;
            btns.Add(view);
            Cemail.Add(email);
            Jtitle.Add(title);
            Dcode.Add(code);
            p1.Controls.Add(cn);
            p1.Controls.Add(view);
            p1.Controls.Add(lb);
            p1.Controls.Add(ea);
            form1.Controls.Add(p1);

        }
        conn.Close();
    }
    protected void searchC()
    {
        string name = Session["name"].ToString();
        string addr = Session["addr"].ToString();
        string type = Session["typeC"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Search_For_Companies", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@name", name));
        cmd.Parameters.Add(new SqlParameter("@address", addr));
        cmd.Parameters.Add(new SqlParameter("@type", type));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            Panel p1 = new Panel();
            p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
            p1.BorderStyle = BorderStyle.Solid;
            p1.BorderWidth = 2;
            p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
            string Cname = SafeString(rdr, "name");
            string email = SafeString(rdr, "email");
            string address = SafeString(rdr, "address");
            Label cn = new Label();
            cn.Text = "&nbsp;" + Cname;
            cn.Font.Size = 22;
            cn.Font.Bold = true;
            cn.Width = 1100;
            Label ea = new Label();
            ea.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + email + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + address;
            ea.Font.Size = 12;
            ea.Width = 1000;
            Label lb = new Label();
            lb.Text = "<br />";
            Button view = new Button();
            view.Text = "View company information";
            view.Click += new EventHandler(view_info);
            view.OnClientClick = "validate(); return false";
            btns.Add(view);
            Cemail.Add(email);
            p1.Controls.Add(cn);
            p1.Controls.Add(view);
            p1.Controls.Add(lb);
            p1.Controls.Add(ea);
            form1.Controls.Add(p1);

        }
        conn.Close();
    }

    protected void type()
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        Panel main = new Panel();
        SqlCommand cmd;
            Panel nat = new Panel();
            Panel Inter = new Panel();
            cmd = new SqlCommand("View_Available_Companies", conn);
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            main.BackColor = Color.FromArgb(Convert.ToInt32("9996FF", 16));

            while (rdr.Read())
            {
                Panel p1 = new Panel();
                p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
                p1.BorderStyle = BorderStyle.Solid;
                p1.BorderWidth = 2;
                p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
                string Cname = SafeString(rdr, "name");
                string email = SafeString(rdr, "email");
                string address = SafeString(rdr, "address");
                string tt = SafeString(rdr, "type");
                Label cn = new Label();
                cn.Text = "&nbsp;" + Cname;
                cn.Font.Size = 22;
                cn.Font.Bold = true;
                cn.Width = 1100;
                Label ea = new Label();
                ea.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + email + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + address;
                ea.Font.Size = 12;
                ea.Width = 1000;
                Label lb = new Label();
                lb.Text = "<br />";
                Button view = new Button();
                view.Text = "View company information";
                view.Click += new EventHandler(view_info);
                btns.Add(view);
                Cemail.Add(email);
                p1.Controls.Add(cn);
                p1.Controls.Add(view);
                p1.Controls.Add(lb);
                p1.Controls.Add(ea);

                if (tt.Equals("national"))
                    nat.Controls.Add(p1);
                else
                    Inter.Controls.Add(p1);

            }
            Label i = new Label();
            i.Text = "&nbsp;International Companies";
            i.Font.Size = 28;
            Label n = new Label();
            n.Text = "&nbsp;National Companies";
            n.Font.Size = 28;
            main.Controls.Add(i);
            main.Controls.Add(Inter);
            main.Controls.Add(n);
            main.Controls.Add(nat);
            form1.Controls.Add(main);
        conn.Close();
    }
    protected void avg()
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd;
        cmd = new SqlCommand("View_Companies_HiAvSalary", conn);
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            Panel p1 = new Panel();
            p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
            p1.BorderStyle = BorderStyle.Solid;
            p1.BorderWidth = 2;
            p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
            string Cname = SafeString(rdr, "name");
            string email = SafeString(rdr, "email");
            string address = SafeString(rdr, "address");
            string avg = SafeString(rdr, "avg");
            Label cn = new Label();
            cn.Text = "&nbsp;" + Cname;
            cn.Font.Size = 22;
            cn.Font.Bold = true;
            cn.Width = 1100;
            Label ea = new Label();
            ea.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + "average salary: " + avg + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + email + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + address;
            ea.Font.Size = 12;
            ea.Width = 1000;
            Label lb = new Label();
            lb.Text = "<br />";
            Button view = new Button();
            view.Text = "View company information";
            view.Click += new EventHandler(view_info);
            btns.Add(view);
            Cemail.Add(email);
            p1.Controls.Add(cn);
            p1.Controls.Add(view);
            p1.Controls.Add(lb);
            p1.Controls.Add(ea);

            form1.Controls.Add(p1);

        }
        conn.Close();
    }
    protected void view_info(object sender, EventArgs e)
    {
        Button b = sender as Button;
        int i = btns.IndexOf(b);
        if (Jtitle.Count == 0)
        {
            Session["email"] = Cemail.ElementAt(i);
            Response.Redirect("ViewCompany");
        }
        else
        {
            Session["email"] = Cemail.ElementAt(i);
            Session["code"] = Dcode.ElementAt(i);
            Session["jTitle"] = Jtitle.ElementAt(i);
            Response.Redirect("viewJobs");
        }

    }
    public static string SafeString(SqlDataReader rdr, string col)
    {
        if (!rdr.IsDBNull(rdr.GetOrdinal(col)))
            return rdr.GetSqlValue(rdr.GetOrdinal(col)).ToString();
        else
            return "";
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