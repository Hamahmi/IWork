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

public partial class Staff_Member : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(Session["type"] as string) || Session["type"].ToString().Equals("j"))
            Response.Redirect("HomePage");
    }
    protected void check_in(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("check_in", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        SqlParameter msg = cmd.Parameters.Add("@msg", SqlDbType.VarChar);
        msg.Direction = ParameterDirection.Output;
        msg.Size = 300;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Write(msg.Value.ToString());
    }
    protected void check_out(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("check_out", conn); 
        cmd.CommandType = CommandType.StoredProcedure;
        string username = Session["username"].ToString();
        cmd.Parameters.Add(new SqlParameter("@username", username));
        SqlParameter msg = cmd.Parameters.Add("@msg", SqlDbType.VarChar);
        msg.Direction = ParameterDirection.Output;
        msg.Size = 300;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Write(msg.Value.ToString());
    }

    protected void view_attendance(object sender, EventArgs e)
    {
        DateTime d;
        Boolean isValid = (DateTime.TryParseExact(txt_from.Text, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d) || DateTime.TryParseExact(txt_from.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d)) & ( DateTime.TryParseExact(txt_to.Text, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d) || DateTime.TryParseExact(txt_to.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d));
        if (isValid)
        {
            String connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("View_My_Attendance", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string username = Session["username"].ToString();
            cmd.Parameters.Add(new SqlParameter("@username", username));
            DateTime from = DateTime.Parse(txt_from.Text);
            DateTime to = DateTime.Parse(txt_to.Text);
            cmd.Parameters.Add(new SqlParameter("@Startdate", from));
            cmd.Parameters.Add(new SqlParameter("@Enddate", to));
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                string day = SafeString(rdr, "date");
                string Start = SafeString(rdr,"start_time");
                string end = SafeString(rdr,"end_time");
                string duration = SafeString(rdr,"duration");
                string missing = SafeString(rdr,"missing hours");
                if (end.Length == 0)
                    end = "haven't checked out";
                else
                    end = end.Substring(0, 5);
                Label lbl_attendance = new Label();
                lbl_attendance.Text = day.Substring(0,10) + ", check-in: " + Start.Substring(0,5) + ", check-out: " + end + ", duration: " + duration + " hours, missing hours: " + missing + " hours.  <br /> <br />";
                att.Controls.Add(lbl_attendance);
                
            }

        }
        else
            Response.Write("write the date in the correct format"+ txt_from.Text);
    }
    protected void businessTrip(object sender, EventArgs e)
    {
        string username = Session["username"].ToString();
        string start = start_dateL.Text;
        string end = end_dateL.Text;
        string des = txt_destination.Text;
        string pur = txt_purpose.Text;
        string rep = Replacement.Text;
        DateTime d;
        Boolean isValid =( DateTime.TryParseExact(start, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d) || DateTime.TryParseExact(start, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d)) & (DateTime.TryParseExact(end, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d) || DateTime.TryParseExact(end, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d));
        if (isValid)
        {
            DateTime from = DateTime.Parse(start);
            DateTime to = DateTime.Parse(end);
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("Apply_For_Business_Trip_Request", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@start_date", from));
            cmd.Parameters.Add(new SqlParameter("@end_date", to));
            cmd.Parameters.Add(new SqlParameter("@destination", des));
            cmd.Parameters.Add(new SqlParameter("@purpose", pur));
            cmd.Parameters.Add(new SqlParameter("@replacement_username", rep));
            SqlParameter msg = cmd.Parameters.Add("@msg", SqlDbType.VarChar);
            msg.Direction = ParameterDirection.Output;
            msg.Size = 300;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Write(msg.Value.ToString());
        }
        else
            Response.Write("please write the date in the correct form");
    }
    protected void leaveRequest(object sender, EventArgs e)
    {
        string username = Session["username"].ToString();
        string start = start_date.Text;
        string end = end_date.Text;
        string t = Request.Form["type"];
        string rep = Replacement.Text;
        DateTime d;
        Boolean isValid = (DateTime.TryParseExact(start, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d) || DateTime.TryParseExact(start, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d)) & (DateTime.TryParseExact(end, "yyyy-mm-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out d) || DateTime.TryParseExact(end, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out d));
        if (isValid)
        {
            DateTime from = DateTime.Parse(start);
            DateTime to = DateTime.Parse(end);
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("Apply_For_Leave_Request", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@start_date", from));
            cmd.Parameters.Add(new SqlParameter("@end_date", to));
            cmd.Parameters.Add(new SqlParameter("@type", t));
            cmd.Parameters.Add(new SqlParameter("@replacement_username", rep));
            SqlParameter msg = cmd.Parameters.Add("@msg", SqlDbType.VarChar);
            msg.Direction = ParameterDirection.Output;
            msg.Size = 300;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Write(msg.Value.ToString());
        }
        else
            Response.Write("please write the date in correct form ex:01/30/2001");
    }
    protected void ViewRequests(object sender, EventArgs e)
    {
        Response.Redirect("Requests");
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
        Session["username"] = null;
        Session["type"] = null;
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