<%@ Page Language="C#" AutoEventWireup="true" CodeFile="New_Project.aspx.cs" Inherits="Manager_New_Project" %>

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
        <asp:Label ID="new_proj" runat="server" Text="New Project"  HorizontalAlign ="Center"></asp:Label>
        <p>
        <asp:Label ID="new_proj0" runat="server" Text="Project Name"></asp:Label>
        &nbsp;:</p>
        <p>
            <asp:TextBox ID="name" runat="server" Height="32px" Width="305px"></asp:TextBox>
        </p>
        <p>
        <asp:Label ID="new_proj1" runat="server" Text="Start date"></asp:Label>
        &nbsp;:</p>
        <p>
            <asp:TextBox ID="start_date" runat="server" Height="31px" Width="306px"></asp:TextBox>
        </p>
        <p>
        <asp:Label ID="new_proj2" runat="server" Text="End date"></asp:Label>
        &nbsp;:</p>
        <p>
            <asp:TextBox ID="end_date" runat="server" Height="29px" Width="306px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="create_project" runat="server" OnClick="Create_Project" Text="Create"  HorizontalAlign ="Center" />
        </p>
    </form>
</body>
</html>
