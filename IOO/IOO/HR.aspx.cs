using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HR : System.Web.UI.Page
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

    protected void addJob(object sender, EventArgs e)
    {
        Response.Redirect("HRAddJob", true);
    }
    protected void viewJob(object sender, EventArgs e)
    {
        Response.Redirect("HRViewJob", true);
    }
    protected void postAnnouncement(object sender, EventArgs e)
    {
        Response.Redirect("HRPost", true);
    }
    protected void viewLReq(object sender, EventArgs e)
    {
        Response.Redirect("HRViewLReq", true);
    }
    protected void viewBReq(object sender, EventArgs e)
    {
        Response.Redirect("HRViewBReq", true);
    }
    protected void viewAtt(object sender, EventArgs e)
    {
        Response.Redirect("HRViewAtt", true);
    }
    protected void viewtotalh(object sender, EventArgs e)
    {
        Response.Redirect("HRViewTH", true);
    }
    protected void top(object sender, EventArgs e)
    {
        Response.Redirect("HRTop", true);
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