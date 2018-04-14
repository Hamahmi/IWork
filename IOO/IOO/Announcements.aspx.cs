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

public partial class Announcements : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string) || Session["type"].ToString().Equals("j"))
            Response.Redirect("HomePage");
        
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Announcements", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        int i = 0;
        while (rdr.Read())
        {
            i++;
            string title = rdr.GetString(rdr.GetOrdinal("title"));
            string type = "#"+rdr.GetString(rdr.GetOrdinal("type"))+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            string date = (rdr.GetValue(rdr.GetOrdinal("date"))).ToString() +"<br />";
            string desc = SafeString(rdr, "description");
            int s = title.Length;
            for (int j = s; j < 200; j++)
                title += "&nbsp;";
            Label lbl_date = new Label();
            lbl_date.Text = type+date;
            Label lbl_desc = new Label();
            lbl_desc.Text = desc;
            Label lbl_title = new Label();
            lbl_title.Text = title;
            Panel p1 = new Panel();
            p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
            p1.BorderStyle = BorderStyle.Solid;
            p1.BorderWidth = 2;
            p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
            Label lb = new Label();
            lb.Text = "<br />";
            Label lb1 = new Label();
            lb1.Text = "<br /> <br />";
            p1.Controls.Add(lb);
            p1.Controls.Add(lbl_title);
            p1.Controls.Add(lbl_date);
            p1.Controls.Add(lbl_desc);
            p1.Controls.Add(lb1);
            form1.Controls.Add(p1);
        }
        if (i == 0)
        {
            Label lbl_title = new Label();
            lbl_title.Text = "No announcements in the past 20 days";
            Panel p1 = new Panel();
            p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
            p1.BorderStyle = BorderStyle.Solid;
            p1.BorderWidth = 2;
            p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
            Label lb = new Label();
            lb.Text = "<br />";
            Label lb1 = new Label();
            lb1.Text = "<br /> <br />";
            p1.Controls.Add(lb);
            p1.Controls.Add(lbl_title);
            p1.Controls.Add(lb1);
            form1.Controls.Add(p1);
        }

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
        Session["username"] = null;
        Session["type"] = null;
        Response.Redirect("HomePage");
     }
    public static string SafeString(SqlDataReader rdr, string col)
    {
        if (!rdr.IsDBNull(rdr.GetOrdinal(col)))
            return rdr.GetSqlValue(rdr.GetOrdinal(col)).ToString();
        else
            return "";
    }

}