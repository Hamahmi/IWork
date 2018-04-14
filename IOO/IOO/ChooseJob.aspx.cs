using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Choose_A_Job : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["username"] as string))
        {
            myProfileB.Text = "Register";
            logOut.Text = "Login";
        }
        else
        {
            myProfileB.Text = "Profile";
            logOut.Text = "Logout";
        }
    }
    protected void chooseJob(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("Choose_Job", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string dayoff = txt_dayoff.Text;
        string jTitle = txt_Job_Title.Text;
        int jdCode = int.Parse(txt_jdCode.Text);
        string jcMail = txt_jcMail.Text;
        while (int.TryParse(txt_jdCode.Text, out jdCode) == false)
            Response.Write("<script> alert('You have to enter the department code in the right format')</script>");
        jdCode = int.Parse(txt_jdCode.Text);
        if (string.IsNullOrEmpty((Session["username"] as string)))
        {

            Response.Write("<script> alert('You are not logged in')</script>");
            Response.Redirect("HomePage", true);
        }
        cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@dayoff", dayoff));
        cmd.Parameters.Add(new SqlParameter("@jTitle", jTitle));
        cmd.Parameters.Add(new SqlParameter("@jdCode",jdCode));
        cmd.Parameters.Add(new SqlParameter("@jcMail", jcMail));
        SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.Int);
        output.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Session["cjjt"] = jTitle;
        Session["cjdc"] =""+ jdCode;
        Session["cjce"] = jcMail;


        if (output.Value.ToString().Equals("1"))
            Response.Write("<script> alert('You accepted this job successfully')</script>");
        else
            Response.Write("<script> alert('Your application is pending or !')</script>");

    }
    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("HomePage");
    }
    protected void MyProfile(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["username"] as string))
            Response.Redirect("Register");
        else
            Response.Redirect("My_Profile");
    }
    protected void LogOut(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["username"] as string))
            Response.Redirect("Login");
        else
        {
            Session["type"] = null;
            Session["username"] = null;
            Response.Redirect("HomePage");

        }
    }
}