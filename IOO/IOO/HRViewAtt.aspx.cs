using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HRViewAtt : System.Web.UI.Page
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

    protected void back(object sender, EventArgs e)
    {
        Response.Redirect("HR", true);
    }

    protected void viewAtt(object sender, EventArgs e)
    {

        

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Staff_Attendance", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string userId = Session["Username"].ToString();
        
        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));

        SqlParameter good = cmd.Parameters.Add("@good", SqlDbType.Int);
        good.Direction = ParameterDirection.Output;


        string user = txt_username.Text;
        string sd = txt_sd.Text;
        string ed = txt_ed.Text;




        cmd.Parameters.Add(new SqlParameter("@Staff_username", user));
        cmd.Parameters.Add(new SqlParameter("@start_date", sd));
        cmd.Parameters.Add(new SqlParameter("@end_date", ed));
        

        



        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (good.Value.ToString().Equals("0"))
        {

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grid1.DataSource = dt;
            grid1.DataBind();
        }
        else
        {

            Label lbl = new Label();
            lbl.Text = "This Staff is not in your department !!";
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