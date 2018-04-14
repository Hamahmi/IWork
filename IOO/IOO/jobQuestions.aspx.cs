using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
public partial class jobQuestions : System.Web.UI.Page
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
        Session["score"] = "0";
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("view_Job_Questions", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if (string.IsNullOrEmpty((Session["username"] as string)) ||
                string.IsNullOrEmpty((Session["job_title"] as string)) ||
                string.IsNullOrEmpty((Session["dep_code"] as string)) ||
                string.IsNullOrEmpty((Session["comp_email"] as string)))
        {

            Response.Write("<script> alert('You are not logged in')</script>");
            Response.Redirect("HomePage", true);
        }
        cmd.Parameters.Add(new SqlParameter("@username", Session["username"] as string));
        cmd.Parameters.Add(new SqlParameter("@jTitle", Session["job_title"] as string));
        cmd.Parameters.Add(new SqlParameter("@jdCode",int.Parse(Session["dep_code"] as string)));
        cmd.Parameters.Add(new SqlParameter("@cEmail", Session["comp_email"] as string));
        conn.Open();
        //SqlDataAdapter sda = new SqlDataAdapter(cmd);
        // DataTable dt = new DataTable();
        //sda.Fill(dt);
        //grid1.DataSource = dt;
        //grid1.DataBind();

        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Session["rdr"] = rdr;
        List<int> qn = new List<int>();
        List<RadioButtonList> bn = new List<RadioButtonList>();
        while (rdr.Read())
        {
            string question = rdr.GetString(rdr.GetOrdinal("question"));
            Label quest = new Label();
            quest.Text = question + "  <br /> <br />";
            form2.Controls.Add(quest);
            RadioButtonList g = new RadioButtonList();
            g.Items.Add("Yes");
            g.Items.Add("No");
           // g.SelectedIndexChanged += new EventHandler(this.gh);
            g.TextChanged += new EventHandler(this.gh);
            qn.Add(rdr.GetInt32(rdr.GetOrdinal("number")));
            bn.Add(g);
            form2.Controls.Add(g);
            Session["qn"] = qn;
            Session["bn"] = bn;
        }
        Button b = new Button();
            b.Text = "Submit";
            b.Click += new EventHandler(this.submit);
            form2.Controls.Add(b);


        conn.Close();
    }
    protected void submit(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("update_score", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@job_title", Session["job_title"] as string));
        cmd.Parameters.Add(new SqlParameter("@dCode", int.Parse(Session["dep_code"] as string)));
        cmd.Parameters.Add(new SqlParameter("@cEmail", Session["comp_email"] as string));
        cmd.Parameters.Add(new SqlParameter("@score", Session["score"]));
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        string x = Session["score"] as string;
        Response.Write("<script> alert('Your application is now in process')</script>");
        form2.Visible = false;
        Response.Write("Your Score Is : " + x);
        Response.Redirect("Main-JobSeeker",true);
    }
    protected void gh(object sender, EventArgs e)
        
    {
        string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("Save_Score", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@job_title", Session["job_title"] as string));
        cmd.Parameters.Add(new SqlParameter("@dCode", int.Parse(Session["dep_code"] as string)));
        cmd.Parameters.Add(new SqlParameter("@cEmail", Session["comp_email"] as string));
        RadioButtonList g = sender as RadioButtonList;
        List<int> q = Session["qn"] as List<int>;
        List<RadioButtonList> b = Session["bn"] as List<RadioButtonList>;
        int qn = q.ElementAt(b.IndexOf(g));
        int ans = 2;

        if (g.SelectedValue.ToString().Equals("Yes"))
            ans = 1;
        else
            ans = 0;
        cmd.Parameters.Add(new SqlParameter("@answer", ans));
        cmd.Parameters.Add(new SqlParameter("@qn", qn));
        SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.Int);
        output.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        string x = Session["score"] as string ;
        int score = int.Parse(x);
        if (output.Value.ToString().Equals("1"))
            score++;
        x = "" + score;
        Session["score"] = x;
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
//Save_Score
