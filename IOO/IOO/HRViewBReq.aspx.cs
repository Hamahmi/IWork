using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HRViewBReq : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (!Session["type"].Equals("hr"))
            Response.Redirect("HomePage");

        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_BRequests", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));


        

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        grid1.DataSource = dt;
        grid1.DataBind();

        conn.Close();

    }


    protected void rowcom(object sender, GridViewCommandEventArgs e)
    {
        int row = Convert.ToInt32(e.CommandArgument.ToString());
        string sd = (grid1.Rows[row].Cells[2]).Text;
        string au = (grid1.Rows[row].Cells[3]).Text;



        if (e.CommandName == "acc")
        {

            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Accept_Req", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@hrusername", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@Rstart_date", sd));
            cmd.Parameters.Add(new SqlParameter("@Ausername", au));



            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            Response.Redirect("HRViewBReq", true);


        }
        if (e.CommandName == "rej")
        {

            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Reject_Req", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@hrusername", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@Rstart_date", sd));
            cmd.Parameters.Add(new SqlParameter("@Ausername", au));


            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            Response.Redirect("HRViewBReq", true);


        }
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