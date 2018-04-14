using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HRTop : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Button2.Visible = false;
        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (!Session["type"].Equals("hr"))
            Response.Redirect("HomePage");
        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);
    }

    protected void back(object sender, EventArgs e)
    {
        Response.Redirect("HR", true);
    }

    protected void email(object sender, EventArgs e)
    {


        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        int month = int.Parse(txt_month.Text);
        int year = int.Parse(txt_year.Text);
        string userId = Session["Username"].ToString();
        SqlCommand cmd1 = new SqlCommand("Top3mails", conn);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.Add(new SqlParameter("@hrusername", userId));
        cmd1.Parameters.Add(new SqlParameter("@month", month));
        cmd1.Parameters.Add(new SqlParameter("@year", year));

        conn.Open();
        cmd1.ExecuteNonQuery();

        SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);
        string mails = "";
        while (rdr.Read())
        {
            mails = mails + rdr.GetString(rdr.GetOrdinal("company_email")) + "; ";
        }
        conn.Close();

        
        SqlCommand cmd = new SqlCommand("Send_Email", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@Susername", userId));



        cmd.Parameters.Add(new SqlParameter("@Remails", mails));
        cmd.Parameters.Add(new SqlParameter("@subject", "Congratiolations! :) "));
        cmd.Parameters.Add(new SqlParameter("@body", "You are one of the top 3 high achievers for the month " + month + " of the year " + year));

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        Label lbl = new Label();
        lbl.Text = "An Email has been sent !";
        form1.Controls.Add(lbl);

    

    }

    protected void top3(object sender, EventArgs e)
    {

       

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Top3", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string userId = Session["Username"].ToString();
        
        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));




        int month = int.Parse(txt_month.Text);
        int year = int.Parse(txt_year.Text);
        
        cmd.Parameters.Add(new SqlParameter("@month", month));
        cmd.Parameters.Add(new SqlParameter("@year", year));
       
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        grid1.DataSource = dt;
        grid1.DataBind();

        if (grid1.Rows.Count > 0)
        {
            Button2.Visible = true;
        }
        else
        {
            Label lbl = new Label();
            lbl.Text = "محدش جه معلش :'D";
            form1.Controls.Add(lbl);
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
        Session["type"] = null;
        Session["username"] = null;
        Response.Redirect("HomePage");
    }
}