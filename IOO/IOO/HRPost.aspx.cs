using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class HRPost : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (!Session["type"].Equals("hr")) 
         Response.Redirect("HomePage");
        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);
    }

    protected void post(object sender, EventArgs e)
    {

        
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Post_Announcement", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string userId = Session["Username"].ToString();
        
        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));





        string title = txt_Title.Text;
        string type = txt_type.Text;
        string des = txt_description.Text;
        




        cmd.Parameters.Add(new SqlParameter("@title", title));
        cmd.Parameters.Add(new SqlParameter("@type", type));
        cmd.Parameters.Add(new SqlParameter("@description", des));
       

        //SqlParameter pass = cmd.Parameters.Add("@password", SqlDbType.VarChar, 50);
        //pass.Value = password;

        // output parm



        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        Label lbl = new Label();
        lbl.Text = "New Announcement has been added. Want to add new One ?";
        form1.Controls.Add(lbl);
        

        
    }
    protected void cancel(object sender, EventArgs e)
    {
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