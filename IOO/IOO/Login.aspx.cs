using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Login : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void login(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("lgn", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = txt_username.Text;
        string password =txt_password.Text;
        cmd.Parameters.Add(new SqlParameter("@uname", username));
        cmd.Parameters.Add(new SqlParameter("@password", password));
        SqlParameter outP = cmd.Parameters.Add("@out", SqlDbType.VarChar);
        outP.Direction = ParameterDirection.Output;
        outP.Size = 1; 
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (outP.Value.ToString().Equals("n"))
        {
            Response.Write("Username does not exist or the password is wrong");
        }
        else
        {
            Session["Username"] = username;
           if(outP.Value.ToString().Equals("h"))
                Session["type"] = "hr";
           else
                Session["type"] = outP.Value.ToString();
            Response.Write("welcome " + username);
            Response.Redirect("My_Profile");
        }
    }
    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("HomePage");
    }
    protected void register(object sender, EventArgs e)
    {
        Response.Redirect("Register");
    }
    protected void LoginP(object sender, EventArgs e)
    {
        Response.Redirect("Login");
    }
}