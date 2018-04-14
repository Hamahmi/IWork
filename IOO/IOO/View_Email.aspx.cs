using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class View_Email : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string) || Session["type"].ToString().Equals("j"))
            Response.Redirect("HomePage");
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Get_Email", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        int serial;
        Int32.TryParse(Session["serial"].ToString(), out serial);
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@Email_id", serial));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            string email = rdr.GetString(rdr.GetOrdinal("company_email"));
            string subject = rdr.GetString(rdr.GetOrdinal("subject"));
            string date = (rdr.GetValue(rdr.GetOrdinal("date"))).ToString();
            string body = rdr.GetString(rdr.GetOrdinal("body"));
            lbl_body.Text = body;
            lbl_Sender.Text = "Sender: "+email;
            lbl_Subject.Text = "Subject: "+subject;
            lbl_Time.Text = "Time: "+ date;
        }
    }
    protected void Reply(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("Reply_to_Email", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        int serial;
     
        Int32.TryParse(Session["serial"].ToString(), out serial);
        string body = txt_body.Text;
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@Email_id", serial));
        cmd.Parameters.Add(new SqlParameter("@body", body));
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Write("Your Reply was sent");
        txt_body.Text = "";
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