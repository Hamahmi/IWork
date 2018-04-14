using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Mail : System.Web.UI.Page
{
    List<int> serial;
    List<Button> btns;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string) || Session["type"].ToString() == "j")
            Response.Redirect("HomePage");

        serial = new List<int>();
        btns = new List<Button>();
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Emails", conn);
        cmd.CommandType = CommandType.StoredProcedure;
         string username = Session["username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            string Susername ="Sender: "+ rdr.GetString(rdr.GetOrdinal("sender_username"));
            string subject = "Subject: "+rdr.GetString(rdr.GetOrdinal("subject"));
            string date = "Date: " + (rdr.GetValue(rdr.GetOrdinal("date"))).ToString();
            int no = (int)rdr.GetSqlInt32(rdr.GetOrdinal("serial_number"));
            serial.Add(no);
            Label lbl_date = new Label();
            lbl_date.Text =date;
            Label lbl_sbjct= new Label();
            lbl_sbjct.Text = subject;
            Label lbl_sender = new Label();
            lbl_sender.Text = Susername;
            lbl_sender.Width = 400;
            lbl_sbjct.Width = 550;
            lbl_date.Width = 300;

            Button b = new Button();
            b.Text = "View Email";
            b.Click+= new EventHandler(Reply) ;
            btns.Add(b);
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
            p1.Controls.Add(lbl_sender);
            p1.Controls.Add(lbl_sbjct);
            p1.Controls.Add(lbl_date);
            p1.Controls.Add(b);
            p1.Controls.Add(lb1);
            form1.Controls.Add(p1);
        }
        if(btns.Count ==0)
        {
            Panel p1 = new Panel();
            p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
            p1.BorderStyle = BorderStyle.Solid;
            p1.BorderWidth = 2;
            p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
            Label lb = new Label();
            lb.Text = "<br />";
            Label lb0 = new Label();
            lb0.Text = "No Emails to Show";
            Label lb1 = new Label();
            lb1.Text = "<br /> <br />";
            p1.Controls.Add(lb);
            p1.Controls.Add(lb0);
            p1.Controls.Add(lb1);
            form1.Controls.Add(p1);
        }
        conn.Close();
        
    }
    protected void Return(object sender, EventArgs e)
    {
        Response.Redirect("staff_member");
    }
    protected void Send(object sender, EventArgs e)
    {
        Response.Redirect("SendEmail");
    }
    protected void Reply(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        int s = serial.ElementAt(btns.IndexOf(btn));
        Session["serial"] = s;
        Response.Redirect("View_Email");

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

}