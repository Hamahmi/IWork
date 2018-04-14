<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tasks.aspx.cs" Inherits="Manager_Tasks" %>

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
    <div>
        <asp:GridView ID="Tasks" runat="server" AutoGenerateColumns="False" OnRowCommand ="TaskReview" HorizontalAlign ="Center" EmptyDataText="There are no tasks that meets the specified data" Width="1286px" >
            <Columns>
                <asp:BoundField DataField="name" HeaderText="Task name" ItemStyle-Width="150" />
                <asp:BoundField DataField="project_name" HeaderText="Project" ItemStyle-Width="150" />
                <asp:BoundField DataField="deadline" HeaderText="Deadline" ItemStyle-Width="150" />
                <asp:BoundField DataField="status" HeaderText="Status" ItemStyle-Width="150" />
                <asp:BoundField DataField="description" HeaderText="Description" ItemStyle-Width="150" />
                <asp:BoundField DataField="regular_employee_username" HeaderText="Employee" ItemStyle-Width="150" />

                 <asp:ButtonField ButtonType="Button" CommandName="Review" HeaderText="Review" ShowHeader="True" Text="Review" />
            </Columns>
        </asp:GridView>
    
    </div>
    </form>
</body>
</html>
