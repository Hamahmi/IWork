using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HRAddQ : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (!Session["type"].Equals("hr"))
            Response.Redirect("HomePage");
        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);

        if (Session["title"] == null)
            Response.Redirect("HR", true);

        Label lbl = new Label();
        lbl.Text = "You're adding questions to the job : " + Session["title"].ToString();
        form1.Controls.Add(lbl);
    }


    protected void addq(object sender, EventArgs e)
    {

        

        

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("add_Ques", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string userId = Session["Username"].ToString();
        string ti = Session["title"].ToString();

        

        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));
        cmd.Parameters.Add(new SqlParameter("@title",ti));




        string q = txt_q.Text;
        
        int ans = dd.SelectedIndex;
        
        cmd.Parameters.Add(new SqlParameter("@Q", q));
        cmd.Parameters.Add(new SqlParameter("@A", ans));
        




        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        Response.Redirect("HRAddQ",true);




    }

    protected void cancel(object sender, EventArgs e)
    {
        Session["title"] = null;
        Response.Redirect("HR", true);
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