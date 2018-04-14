<%@ Page Language="C#" AutoEventWireup="true" CodeFile="My_Profile.aspx.cs" Inherits="My_Profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile</title>
    <style type="text/css">
        .btn-default {}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <div style="background-color: #9999FF; border: thin solid #000066;  width: 1348px;"">
                 <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/> 
                 <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
                 <asp:Button ID="logout" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
             </div>
            <div style="background-color: #9999FF; border: thin solid #000066">
                <asp:Panel ID ="Info" runat ="server">
                    <br />&nbsp;
                    <asp:Label ID="PI" runat="server" Text="Personal Information" Font-Bold="True" Font-Overline="False" Font-Size="X-Large" Font-Underline="True"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_un" runat="server" Text="Username: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_pass" runat="server" Text="Password: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_fn" runat="server" Text="First name: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_mn" runat="server" Text="Middle name: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_ln" runat="server" Text="Last name: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_mail" runat="server" Text="Personal Email: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_bd" runat="server" Text="Birth date: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_age" runat="server" Text="Age: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_PJ" runat="server" Text="Prevoius Jobs: " Font-Size="Large"></asp:Label>
                    <br />&nbsp;&nbsp;
                    <asp:Label ID="lbl_ye" runat="server" Text="Years of experience: " Font-Size="Large"></asp:Label>
                    <br />
                    <br />
                </asp:Panel> 
                <asp:Button ID="Edit_info" runat="server" Text="Edit Info" onclick="edit_info" Height="90px" Width="111px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/>
                <asp:Button ID="J_hunt" runat="server" Text="Job Hunt" onclick="job_hunt" Height="90px" Width="119px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
                <asp:Button ID="Mail" runat="server" Text="Mail" onclick="mail" Height="90px" Width="124px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
                <asp:Button ID="Announcements" runat="server" Text="Announcements" onclick="announ" Height="90px" Width="167px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
                <asp:Button ID="AR" runat="server" Text="Attendance&Requests" onclick="attReq" Height="90px" Width="217px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
                <asp:Button ID="MW" runat="server" Text="Manage Work" onclick="Manage" Height="90px" Width="160px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
            </div>
        </div>
    </form>
</body>
</html>
