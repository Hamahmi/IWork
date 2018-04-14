using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SendEmail : System.Web.UI.Page
{

    TextBox t;
    TextBox txt_subject;
     TextBox txt_body;
    Panel To;
    Button b;
    TextBox x;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string) || Session["type"].ToString().Equals("j"))
            Response.Redirect("HomePage");
        Panel p1 = new Panel();
        p1.BackColor = Color.FromArgb(Convert.ToInt32("9999FF", 16));
        p1.BorderStyle = BorderStyle.Solid;
        p1.BorderWidth = 2;
        p1.Width = 1343;
        p1.BorderColor = Color.FromArgb(Convert.ToInt32("000066", 16));
        To = new Panel();
        Label lb = new Label();
        lb.Text = "<br />";

        To.Controls.Add(lb);
        Label recepient = new Label();
        recepient.Text = "To:...";
        To.Controls.Add(recepient);
        t = new TextBox();
        t.Width = 598;
        t.ReadOnly = true;
        t.BackColor = Color.Gray;
        x = new TextBox();
        x.Width = 598;
        To.Controls.Add(x);
        b = new Button();
        b.Click += new EventHandler(add);
        b.Text = "add recepient";
        To.Controls.Add(b);
        Label line = new Label();
        line.Text = "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        To.Controls.Add(line);
        To.Controls.Add(t);
       Button  c = new Button();
        c.Click += new EventHandler(Clear);
        c.Text = "Clear";
        To.Controls.Add(c);
        Label sub = new Label();
        sub.Text = "Subject: ";
        txt_subject = new TextBox();
        txt_subject.Width = 598;
        txt_body = new TextBox();
        txt_body.TextMode = TextBoxMode.MultiLine;
        txt_body.Width = 1338;
        txt_body.Height = 350;
        Button sendB = new Button();
        sendB.Click += new EventHandler(sendE);
        sendB.Text = "Send";
        Label lb1 = new Label();
        lb1.Text = "<br />";
        Label lb2 = new Label();
        lb2.Text = "<br />";
        Label lb3 = new Label();
        lb3.Text = "<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
        p1.Controls.Add(To);
        p1.Controls.Add(lb1);
        p1.Controls.Add(sub);
        p1.Controls.Add(txt_subject);
        p1.Controls.Add(lb2);
        p1.Controls.Add(txt_body);
        p1.Controls.Add(lb3);
        p1.Controls.Add(sendB);
        sm.Controls.Add(p1);
    }

    private void Clear(object sender, EventArgs e)
    {
        t.Text = "";
    }

    protected void sendE(object sender, EventArgs e)
    {
        String rec = t.Text + ";" + x.Text;
        string username = Session["username"].ToString();
        string body = txt_body.Text;
        string subject = txt_subject.Text;
        if (rec.Length == 1)
        {
            Response.Write("please write the recepient email");
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("send_Email", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Susername", username));
            cmd.Parameters.Add(new SqlParameter("@Remails", rec));
            cmd.Parameters.Add(new SqlParameter("@body", body));
            cmd.Parameters.Add(new SqlParameter("@subject", subject));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            t.Text = "";
            x.Text = "";
            txt_body.Text = "";
            txt_subject.Text = "";
            Response.Write("Your Email was sent");
        }
    }
    protected void add(object sender, EventArgs e)
    {
        t.Text +=x.Text+ "; ";
        x.Text = "";

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