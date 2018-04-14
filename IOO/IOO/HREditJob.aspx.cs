using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HREditJob : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("Login", true);
        if (Session["title"] == null)
            Response.Redirect("HRViewJob", true);
        
        Response.Write("Logged-in User: " + Session["Username"].ToString() );
    }


    protected void Edit (object sender, EventArgs e)
    {

        

        String title = Session["title"].ToString();

        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Edit_Job", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string userId = Session["Username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@hrusername", userId));
        cmd.Parameters.Add(new SqlParameter("@Oldtitle", title));

        SqlParameter good = cmd.Parameters.Add("@done", SqlDbType.Int);
        good.Direction = ParameterDirection.Output;


        string newtitle = txt_newTitle.Text;
        string sd = txt_sd.Text;
        string ld = txt_ld.Text;
        int me = int.Parse(txt_me.Text);
        int salary = int.Parse(txt_salary.Text);
        string deadline = txt_deadline.Text;
        int nov = int.Parse(txt_nov.Text);
        int wh = int.Parse(txt_wh.Text);
        
        



        cmd.Parameters.Add(new SqlParameter("@Newtitle", newtitle));
        cmd.Parameters.Add(new SqlParameter("@short_description", sd));
        cmd.Parameters.Add(new SqlParameter("@detailed_description", ld));
        cmd.Parameters.Add(new SqlParameter("@min_experience", me));
        cmd.Parameters.Add(new SqlParameter("@salary", salary));
        cmd.Parameters.Add(new SqlParameter("@deadline", deadline));
        cmd.Parameters.Add(new SqlParameter("@no_of_vacancies", nov));
        cmd.Parameters.Add(new SqlParameter("@working_hours", wh));
        
        
       

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (!good.Value.ToString().Equals("3"))
        {
            //this is how you store data to session variable.
            Session["title"] = newtitle;
            Response.Redirect("HRAddQ", true);
            
        }
        
        else 
        {
            Label lbl2 = new Label();
            lbl2.Text = "this job title already exists in the database ";
            form1.Controls.Add(lbl2);
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