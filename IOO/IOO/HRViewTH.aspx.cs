using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class HRViewTH : System.Web.UI.Page
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

    protected void viewth(object sender, EventArgs e)
    {

        

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Total_Hours", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string userId = Session["Username"].ToString();
        
        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));

        SqlParameter good = cmd.Parameters.Add("@good", SqlDbType.Int);
        good.Direction = ParameterDirection.Output;


        string user = txt_username.Text;
        int year = int.Parse(txt_year.Text);




        cmd.Parameters.Add(new SqlParameter("@Staff_username", user));
        cmd.Parameters.Add(new SqlParameter("@year", year));


        //SqlParameter pass = cmd.Parameters.Add("@password", SqlDbType.VarChar, 50);
        //pass.Value = password;

        // output parm



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
            Response.Write("This Staff is not in your department !!");
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