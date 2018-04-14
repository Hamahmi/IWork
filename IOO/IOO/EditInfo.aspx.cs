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

public partial class EditInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["username"] as string))
            Response.Redirect("HomePage");
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("View_Info", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                string user = SafeString(rdr, "username");
                string passw = SafeString(rdr, "password");
                string pe = SafeString(rdr, "personal_email");
                string BD = SafeString(rdr, "birth_date");
                string yoe = SafeString(rdr, "years_of_experience");
                string fname = SafeString(rdr, "first_name");
                string mname = SafeString(rdr, "middle_name");
                string lname = SafeString(rdr, "last_name");
                string pj = SafeString(rdr, "previous");
            if(txt_bd.Text.Length==0)
                txt_bd.Text = BD.Substring(0,10);
            if (txt_fn.Text.Length ==0)
                txt_fn.Text = fname;
            if (txt_ln.Text.Length ==0)
                txt_ln.Text = lname;
            if (txt_mn.Text.Length ==0)
                txt_mn.Text = mname;
            if (txt_mail.Text.Length ==0)
                txt_mail.Text = pe;
            if (txt_pass.Text.Length ==0)
                txt_pass.Text = passw;
            if (txt_PJ.Text.Length ==0 )
                txt_PJ.Text = pj;
            if (txt_ye.Text.Length ==0)
                txt_ye.Text = yoe;
            }
        }
    protected void save(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("Edit_User_Info", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string user = Session["username"].ToString();
        string passw = txt_pass.Text;
        string pe = txt_mail.Text;
        string B_D = txt_bd.Text;
        string y_o_e = txt_ye.Text;
        string fname = txt_fn.Text;
        string mname = txt_mn.Text;
        string lname = txt_ln.Text;
        string pj = "," + txt_PJ.Text + ",";
        DateTime BD;
        int yoe = 0;
        Boolean isValid = (DateTime.TryParseExact(B_D, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out BD) || DateTime.TryParseExact(B_D,"MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out BD)) && Int32.TryParse(y_o_e, out yoe);
        if (fname == null || fname.Length == 0 || lname == null || lname.Length == 0||passw == null || passw.Length ==0 || B_D == null || B_D.Length ==0)
            Response.Write("First name, Last name, password and birthdate can't be empty");
        else
        if (isValid)
        {
            cmd.Parameters.Add(new SqlParameter("@username", user));
            cmd.Parameters.Add(new SqlParameter("@password", passw));
            cmd.Parameters.Add(new SqlParameter("@personal_email", pe));
            cmd.Parameters.Add(new SqlParameter("@birth_date", BD));
            cmd.Parameters.Add(new SqlParameter("@years_of_experience", yoe));
            cmd.Parameters.Add(new SqlParameter("@first_name", fname));
            cmd.Parameters.Add(new SqlParameter("@middle_name", mname));
            cmd.Parameters.Add(new SqlParameter("@last_name", lname));
            cmd.Parameters.Add(new SqlParameter("@previousJobs", pj));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("My_Profile");
        }
        else
            Response.Write("Please write the data in the correct format");
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
        public static string SafeString(SqlDataReader rdr, string col)
    {

        if (!rdr.IsDBNull(rdr.GetOrdinal(col)))
        {
            if (rdr.GetDataTypeName(rdr.GetOrdinal(col)).Equals("datetime") || rdr.GetDataTypeName(rdr.GetOrdinal(col)).Equals("date"))
                return (rdr.GetDateTime(rdr.GetOrdinal(col)).ToString("MM/dd/yyyy"));
            return rdr.GetSqlValue(rdr.GetOrdinal(col)).ToString();
        }
        else
            return "";
    }


}