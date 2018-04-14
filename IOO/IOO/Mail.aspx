<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Mail.aspx.cs" Inherits="Mail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mail</title>
</head>
<body>
    <form id="form1" runat="server">
       <div style="background-color: #9999FF; border: thin solid #000066;  width: 1348px;"">
             <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/>
        <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        <asp:Button ID="logOut" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
        <div style="background-color: #9999FF; border: thin solid #000066">
             <asp:Button ID="SendB" runat="server" Text="Send an Email" onclick="Send"  Height="38px" Width="197px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>

        </div>
    </form>
</body>
</html>
