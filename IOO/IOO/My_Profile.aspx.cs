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

public partial class My_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string))
            Response.Redirect("HomePage");

        string type = Session["type"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Info", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        if (type.Equals("j"))
        {
            while (rdr.Read())
            {
                string user = SafeString(rdr, "username");
                string passw = SafeString(rdr, "password");
                string pe = SafeString(rdr, "personal_email");
                string BD = SafeString(rdr, "birth_date");
                string yoe = SafeString(rdr, "years_of_experience");
                string fname = SafeString(rdr, "first_name");
                string mname = SafeString(rdr, "middle_name");
                string lname = SafeString(rdr, "last_name");
                string age = SafeString(rdr, "age");
                string pj = SafeString(rdr, "previous");
                lbl_age.Text += age;
                lbl_bd.Text += BD.Substring(0,10);
                lbl_fn.Text += fname;
                lbl_ln.Text += lname;
                lbl_mn.Text += mname;
                lbl_mail.Text += pe;
                lbl_pass.Text += passw;
                lbl_un.Text += user;
                lbl_PJ.Text += pj;
                lbl_ye.Text += yoe;
            }
            AR.Visible = false;
            MW.Visible = false;
            Announcements.Visible = false;
            Mail.Visible = false;
        }
        else
        {
            while (rdr.Read())
            {
                string user = SafeString(rdr, "username");
                string passw = SafeString(rdr, "password");
                string pe = SafeString(rdr, "personal_email");
                string BD = SafeString(rdr, "birth_date");
                string yoe = SafeString(rdr, "years_of_experience");
                string fname = SafeString(rdr, "first_name");
                string mname = SafeString(rdr,"middle_name");
                string lname = SafeString(rdr, "last_name");
                string age = SafeString(rdr, "age");
                string pj = SafeString(rdr, "previous");
                lbl_age.Text += age;
                lbl_bd.Text += BD.Substring(0,10);
                lbl_fn.Text += fname;
                lbl_ln.Text += lname;
                lbl_mail.Text += pe;
                lbl_pass.Text += passw;
                lbl_mn.Text += mname;
                lbl_un.Text += user;
                lbl_PJ.Text += pj;
                lbl_ye.Text += yoe;
                string al = SafeString(rdr,"annual_leaves");
                string ce = SafeString(rdr, "company_email");
                string dof = SafeString(rdr,"day_off");
                string sal = SafeString(rdr,"salary");
                string jt = SafeString(rdr,"job_title");
                string dc = SafeString(rdr,"department_code");
                string com = SafeString(rdr, "company");
                Label lbl_al = new Label();
                lbl_al.Text = "&nbsp;&nbsp;&nbsp;Annual Leaves: " + al+"<br/> <br/>";
                Label lbl_ce = new Label();
                lbl_ce.Text = "&nbsp;&nbsp;&nbsp;Company Email: " + ce + "<br/>";
                Label lbl_dof = new Label();
                lbl_dof.Text = "&nbsp;&nbsp;&nbsp;Day off: " + dof + "<br/>";
                Label lbl_sal = new Label();
                lbl_sal.Text = "&nbsp;&nbsp;&nbsp;Salary : " + sal + "<br/>";
                Label lbl_jt = new Label();
                lbl_jt.Text = "&nbsp;&nbsp;&nbsp;Job Title: " + jt + "<br/>";
                Label lbl_dc = new Label();
                lbl_dc.Text = "&nbsp;&nbsp;&nbsp;Department Code: " + dc + "<br/>";
                Label lbl_com = new Label();
                lbl_com.Text = "&nbsp;&nbsp;&nbsp;Company: " + com + "<br/>";
                Info.Controls.Add(lbl_com);
                Info.Controls.Add(lbl_dc);
                Info.Controls.Add(lbl_jt);
                Info.Controls.Add(lbl_ce);
                Info.Controls.Add(lbl_sal);
                Info.Controls.Add(lbl_dof);
                Info.Controls.Add(lbl_al);


            }
        }
        conn.Close();
    }
    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("HomePage");
    }
    protected void MyProfile(object sender, EventArgs e)
    {
        Response.Redirect("My_Profile");
    }
    protected void LogOut(object sender, EventArgs e)
    {
        Session["type"] = null;
        Session["username"] = null;
        Response.Redirect("HomePage");
    }
    protected void edit_info(object sender, EventArgs e)
    {
        Response.Redirect("EditInfo");
    }
    protected void job_hunt(object sender, EventArgs e)
    {
        Response.Redirect("Main-JobSeeker");
    }
    protected void mail(object sender, EventArgs e)
    {
        Response.Redirect("Mail");
    }
    protected void announ(object sender, EventArgs e)
    {
        Response.Redirect("Announcements");
    }
    protected void attReq(object sender, EventArgs e)
    {
        Response.Redirect("Staff_Member");
    }
    protected void Manage(object sender, EventArgs e)
    {
        if (Session["type"].ToString().Equals("r"))
            Response.Redirect("Main-RegularEmployee");
        else
            if (Session["type"].ToString().Equals("m"))
                Response.Redirect("Manager/Manager_Profile");
        else
            Response.Redirect("HR");

    }
    public static string SafeString(SqlDataReader rdr, string col)
    {

        if (!rdr.IsDBNull(rdr.GetOrdinal(col)))
        {
            if (rdr.GetDataTypeName(rdr.GetOrdinal(col)).Equals("datetime") || rdr.GetDataTypeName(rdr.GetOrdinal(col)).Equals("date"))
                return (rdr.GetDateTime(rdr.GetOrdinal(col)).ToString("MM/dd/yyyy"));
            return rdr.GetSqlValue(rdr.GetOrdinal(col)).ToString();
        }
        else
            return "";
    }

}