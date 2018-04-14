<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HR.aspx.cs" Inherits="HR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style ="text-align: center; left:50%; right: 50%; justify-content: center">

            <div style="text-align: center; left:50%; right: 50%; justify-content: center; background-color: #9999FF; border: thin solid #000066;  width: 1348px;"">
                 <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/> 
                 <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
               <asp:Button ID="logOut" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>

            

             

             <br />
            <asp:Button ID="btn_addJob" runat="server" Text="Add Job" onclick="addJob" Width="200px" BackColor="#0000CC"/>
            <br />
            <br />
            <asp:Button ID="btn_viewJob" runat="server" Text="View and edit jobs" onclick="viewJob"  Width="200px" BackColor="Red"/>
            <br />
            <br />
            <asp:Button ID="btn_post" runat="server" Text="Post Announcement" onclick="postAnnouncement" Width="200px" BackColor="Lime"/>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="View Leave Requests" onclick="viewLReq" Width="200px" BackColor="#6600CC"/>
            <br />
            <br />
            <asp:Button ID="Button2" runat="server" Text="View business trip Requests" onclick="viewBReq"  Width="200px" BackColor="Yellow"/>
            <br />
            <br />
            <asp:Button ID="Button3" runat="server" Text="View Staff Attendence" onclick="viewAtt" Width="200px" BackColor="#FF0066"/>
            <br />
            <br />
            <asp:Button ID="Button4" runat="server" Text="View Staff total hours" onclick="viewtotalh" Width="200px" BackColor="Aqua"/>
            <br />
            <br />
            <asp:Button ID="Button5" runat="server" Text="Top 3 Employees" onclick="top" Width="200px" BackColor="#FF6600"/>
            <br />
            <br />
        </div>
        </form>
   
</body>
</html>
