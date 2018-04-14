using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Manager_Manager_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
            Response.Redirect("~/Login", true);
        if (!Session["type"].Equals("m"))
            Response.Redirect("~/HomePage");

        string userId = Session["Username"].ToString();
        Response.Write("Logged-in User: " + userId);
    }

    protected void ViewRequestsClicked(object sender, EventArgs e)
    {
        Response.Redirect("Requets");

      
    }
    protected void ViewApplicationsClicked(object sender, EventArgs e)
    {
        if (job_title.Text == "")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {
            Session["JobTitle"] = job_title.Text;
            Response.Redirect("Applications");
        }
    }

    protected void ViewTasksClicked(object sender, EventArgs e)
    {
        if (status.Text == "" || status.Text=="Project" || ProjectSearch.Text == "" || ProjectSearch.Text=="Project")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {
            Session["status"] = status.Text;
            Session["ProjectSearch"] = ProjectSearch.Text;
            Response.Redirect("Tasks");
        }
    }
    
    protected void CreateProjectClicked(object sender, EventArgs e)
    {
        Response.Redirect("New_Project");

    }
    protected void NewTaskClicked(object sender, EventArgs e)
    {
        if (name.Text == "" || project.Text == "" || deadline.Text == "" || description.Text=="" ||
            name.Text == "Task name" || project.Text == "Project" || deadline.Text == "deadline" || description.Text == "description")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Define_New_Task", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@deadline", System.DateTime.Parse(deadline.Text)));
            cmd1.Parameters.Add(new SqlParameter("@description", description.Text));
            cmd1.Parameters.Add(new SqlParameter("@name", name.Text));
            cmd1.Parameters.Add(new SqlParameter("@project_name", project.Text));


            cmd1.ExecuteNonQuery();
            conn.Close();
            string script = "alert('" + "Task has been defined successfully " + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
    }
    protected void Assign_to_Project_Clicked(object sender, EventArgs e)
    {
        if(ProjectAssigned.Text == "Project" || Employee.Text == "Employee" || ProjectAssigned.Text=="" || Employee.Text == "")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {

            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Assign_Employee_Project", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@regular_employee_username", Employee.Text));
            cmd1.Parameters.Add(new SqlParameter("@project_name", ProjectAssigned.Text));


            cmd1.ExecuteNonQuery();
            conn.Close();
            string script = "alert('" + "The Employee you selected has been assigned to the project successfully " + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);


        }
    }

    protected void Remove_from_Project_Clicked(object sender, EventArgs e)
    {
        if (ProjectRemoved.Text == "Project" || EmployeeRemoved.Text == "Employee" || ProjectRemoved.Text == "" || EmployeeRemoved.Text == "")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {

            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Remove_Regular_From_Project", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@regular_employee_username", EmployeeRemoved.Text));
            cmd1.Parameters.Add(new SqlParameter("@project_name", ProjectRemoved.Text));


            cmd1.ExecuteNonQuery();
            conn.Close();
            string script = "alert('" + "The Employee you selected has been removed from the project successfully " + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);


        }
    }
    protected void AssignTaskClicked(object sender, EventArgs e)
    {
        if (AssignedTask.Text == "" || project_task.Text == "" ||  TaskEmployee.Text == "" || AssignedTask.Text == "Task name" || project_task.Text == "Project" || TaskEmployee.Text == "Employee")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Manager_Assign_Employee_Task", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@regular_employee_username", TaskEmployee.Text));
            cmd1.Parameters.Add(new SqlParameter("@name", AssignedTask.Text));
            cmd1.Parameters.Add(new SqlParameter("@project_name", project_task.Text));


            cmd1.ExecuteNonQuery();
            conn.Close();
            string script = "alert('" + "Task has been assigned successfully " + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
    }

    protected void ChangeTaskClicked(object sender, EventArgs e)
    {
        if (changed_task.Text == "" || project_task_changed.Text == "" || newEmployee.Text == "" || changed_task.Text == "Task name" || project_task_changed.Text == "Project" || newEmployee.Text == "New Employee")
        {
            string script = "alert('" + "Some required data is missing" + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["I_WORK_CONN"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            conn.Open();

            SqlCommand cmd1 = new SqlCommand("Change_Assigned_Employee", conn);
            cmd1.CommandType = CommandType.StoredProcedure;

            cmd1.Parameters.Add(new SqlParameter("@manager_username", Session["Username"]));
            cmd1.Parameters.Add(new SqlParameter("@regular_employee_username", newEmployee.Text));
            cmd1.Parameters.Add(new SqlParameter("@name", changed_task.Text));
            cmd1.Parameters.Add(new SqlParameter("@project_name", project_task_changed.Text));


            cmd1.ExecuteNonQuery();
            conn.Close();
            string script = "alert('" + "Employee has been chnaged successfully " + "');";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "Alert", script, true);
        }
    }

   

    // put this in the end of your code for the .aspx.cs file
    protected void Home(object sender, EventArgs e)
    {
        Response.Redirect("~/HomePage");
    }
    protected void MyProfile(object sender, EventArgs e)
    {
        Response.Redirect("~/My_Profile");
    }
    protected void LogOut(object sender, EventArgs e)
    {
        Session["type"] = null;
        Session["username"] = null;
        Response.Redirect("~/HomePage");
    }
}