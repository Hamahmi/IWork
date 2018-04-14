using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HomePage : System.Web.UI.Page
{
   static  List<Button> btns;
   static  List<string> Cemail;
    static List<string> Dcode;
    static List<string> Jtitle;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(string.IsNullOrEmpty(Session["username"] as string))
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

    protected void Search(object sender, EventArgs e)
    {
        Session["v"] = "1";
        Session["name"] = txt_name.Text;
        Session["addr"] = txt_address.Text;
        Session["typeC"] = Request.Form["ddl_type"];
        Response.Redirect("SearchjobResults");
    }
    protected void View(object sender, EventArgs e)
    {


        if (Request.Form["ddl_Base"] =="Type")
        {
            Session["v"] = 2+"";
        }
        else
        {
            Session["v"] = 3+"";
        }
        Response.Redirect("SearchJobResults");


    }
    protected void SearchJ(object sender, EventArgs e)
    {
        Session["v"] = 4+"";
        Session["KW"] = txt_KW.Text;
        Response.Redirect("SearchJobResults");
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
    public static string SafeString(SqlDataReader rdr, string col)
    {
        if (!rdr.IsDBNull(rdr.GetOrdinal(col)))
            return rdr.GetSqlValue(rdr.GetOrdinal(col)).ToString();
        else
            return "";
    }
}