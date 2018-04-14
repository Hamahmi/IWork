<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Manager_Profile.aspx.cs" Inherits="Manager_Manager_Profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
   
    <form id="form1" runat="server">
         <div style="background-color: #9999FF; border: thin solid #000066;  width: 1348px;"">
                 <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/> 
                 <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
               <asp:Button ID="logOut" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
    <div style="width: 1348px">
        <asp:Button ID="ViewRequests" runat="server" OnClick ="ViewRequestsClicked" Text="View Requests" Height="90px" Width="446px" />

        <asp:Button ID="Assign_to_Project" runat="server" OnClick ="Assign_to_Project_Clicked" Text="Assign Employee to a project" Height="90px" Width="446px" />

        <asp:Button ID="ViewTasks" runat="server" OnClick ="ViewTasksClicked" Text="View Tasks" Height="90px" Width="446px" />

    </div>
         <p style="width: 1507px">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

             <asp:TextBox ID="ProjectAssigned" runat="server" Text="Project" Height="85px" Width="203px"></asp:TextBox>
             <asp:TextBox ID="Employee" runat="server" Text="Employee" Height="85px" Width="233px"></asp:TextBox>

             <asp:TextBox ID="ProjectSearch" runat="server" Text="Project" Height="85px" Width="206px"></asp:TextBox>
             <asp:TextBox ID="status" runat="server" Text="Status" Height="85px" Width="225px"></asp:TextBox>

         </p>
         <p>
              

             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
        <asp:Button ID="Remove_From_Project" runat="server" OnClick ="Remove_from_Project_Clicked" Text="Remove Employee from project" Height="90px" Width="446px" />

         </p>
         <p style="width: 1371px">
        <asp:Button ID="ViewApplications" runat="server" OnClick ="ViewApplicationsClicked" Text="View Applications for : " Height="90px" Width="446px"/>

             <asp:TextBox ID="ProjectRemoved" runat="server" Text="Project" Height="85px" Width="203px"></asp:TextBox>
             <asp:TextBox ID="EmployeeRemoved" runat="server" Text="Employee" Height="85px" Width="225px"></asp:TextBox>

        <asp:Button ID="CreateProject" runat="server" OnClick ="CreateProjectClicked" Text="Create Project" Height="90px" Width="446px" />

         </p>
         <p>
             <asp:TextBox ID="job_title" runat="server" Text="Enter the job title" Height="40px" Width="439px"></asp:TextBox>
             </p>
         <p style="width: 1349px">
        <asp:Button ID="New_Task" runat="server" OnClick ="NewTaskClicked" Text="Define A New Task in : " Height="90px" Width="446px"/>
        <asp:Button ID="Assign_Task" runat="server" OnClick ="AssignTaskClicked" Text="Assign Task To Employee" Height="90px" Width="446px"/>
        <asp:Button ID="Change_Task" runat="server" OnClick ="ChangeTaskClicked" Text="Change Employee working on a task" Height="90px" Width="446px"/>
             </p>
         <p style="width: 1503px">
             <asp:TextBox ID="project" runat="server" Text="Project" Height="40px" Width="148px"></asp:TextBox>
             <asp:TextBox ID="name" runat="server" Text="Task name" Height="40px" Width="148px"></asp:TextBox>
             <asp:TextBox ID="deadline" runat="server" Text="deadline" Height="40px" Width="129px" style="direction: ltr" ToolTip="ex : &quot;4-sep-1997&quot;"></asp:TextBox>
             <asp:TextBox ID="project_task" runat="server" Text="Project" Height="40px" Width="148px"></asp:TextBox>
             <asp:TextBox ID="AssignedTask" runat="server" Text="Task name" Height="40px" Width="148px"></asp:TextBox>
             <asp:TextBox ID="TaskEmployee" runat="server" Text="Employee" Height="40px" Width="130px"></asp:TextBox>
             <asp:TextBox ID="project_task_changed" runat="server" Text="Project" Height="40px" Width="148px"></asp:TextBox>
             <asp:TextBox ID="changed_task" runat="server" Text="Task name" Height="40px" Width="148px"></asp:TextBox>
             <asp:TextBox ID="newEmployee" runat="server" Text="New Employee" Height="40px" Width="124px"></asp:TextBox>
             </p>
         <p>
             <asp:TextBox ID="description" runat="server" Text="description" TextMode = "MultiLine" Height="40px" Width="435px"></asp:TextBox>
             </p>
    </form>
</body>
</html>
