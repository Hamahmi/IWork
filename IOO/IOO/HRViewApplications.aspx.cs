using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HRViewApplications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (!Session["type"].Equals("hr"))
            Response.Redirect("HomePage");
        if (Session["title"] == null)
            Response.Redirect("HRViewJob", true);
        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Applications", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        
        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));
        cmd.Parameters.Add(new SqlParameter("@job_title", Session["title"].ToString()));

       

        
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
        string js = (grid1.Rows[row].Cells[5]).Text;
        Session["js"] = js;
        
        if (e.CommandName == "viewjs")
        {
            
            Response.Redirect("HRViewJS", true);
        }
        if (e.CommandName == "viewj")
        {
            Response.Redirect("HRViewAJob", true);
        }
        if (e.CommandName == "acc")
        {

            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Accept_App", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@hrusername", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@Jtitle", Session["title"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@JS_username", js));

            SqlParameter good = cmd.Parameters.Add("@out", SqlDbType.Int);
            good.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            if (good.Value.ToString().Equals("0"))
            {


                Label lbl2 = new Label();
                lbl2.Text = "This job has no vacancies available";
                form1.Controls.Add(lbl2);


            }
            else
            {
                Response.Redirect("HRViewApplications", true);
            }

        }
        if (e.CommandName == "rej")
        {

            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("Reject_App", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@hrusername", Session["Username"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@Jtitle", Session["title"].ToString()));
            cmd.Parameters.Add(new SqlParameter("@JS_username", js));

           

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Redirect("HRViewApplications", true);
        }
    }

    protected void cancel(object sender, EventArgs e)
    {
        Response.Redirect("HRViewJob", true);
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