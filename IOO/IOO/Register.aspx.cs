using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void reg(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("Register", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string user = txt_un.Text;
        string passw = txt_pass.Text;
        string pe = txt_mail.Text;
        string B_D = txt_bd.Text;
        string y_o_e = txt_ye.Text;
        string fname = txt_fn.Text;
        string mname = txt_mn.Text;
        string lname = txt_ln.Text;
        string pj = ","+txt_PJ.Text+",";
        DateTime BD;
        int yoe = 0;
        Boolean isValid = (DateTime.TryParseExact(B_D, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out BD) || DateTime.TryParseExact(B_D, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out BD))  && Int32.TryParse(y_o_e,out yoe);
        if (fname == null || fname.Length == 0 || lname == null || lname.Length == 0 || passw == null || passw.Length == 0 || B_D == null || B_D.Length == 0)
            Response.Write("First name, Last name, password and birthdate can't be empty");
        else
        if (isValid)
        {
            cmd.Parameters.Add(new SqlParameter("@username", user));
            cmd.Parameters.Add(new SqlParameter("@password", passw));
            cmd.Parameters.Add(new SqlParameter("@pemail", pe));
            cmd.Parameters.Add(new SqlParameter("@bdate", BD));
            cmd.Parameters.Add(new SqlParameter("@yearsOfExp", yoe));
            cmd.Parameters.Add(new SqlParameter("@fname", fname));
            cmd.Parameters.Add(new SqlParameter("@mname", mname));
            cmd.Parameters.Add(new SqlParameter("@lname", lname));
            cmd.Parameters.Add(new SqlParameter("@previousJobs", pj));
            SqlParameter outP = cmd.Parameters.Add("@msg", SqlDbType.VarChar);
            outP.Direction = ParameterDirection.Output;
            outP.Size = 100;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Write(outP.Value.ToString());
            if(outP.Value.ToString().Equals("successfully registered"))
            {
                Session["username"] = user;
                Session["type"] = "j";
                Response.Redirect("My_Profile");
            }
        }
        else
            Response.Write("Please write the data in the correct format");
    }
    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("HomePage");
    }
    protected void register(object sender, EventArgs e)
    {
        Response.Redirect("Register");
    }
    protected void Login(object sender, EventArgs e)
    {
        Response.Redirect("Login");
    }
}