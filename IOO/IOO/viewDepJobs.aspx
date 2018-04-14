<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewDepJobs.aspx.cs" Inherits="viewJobs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="color: #000066; background-color: #9999FF; border-color: #000066">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color: #9999FF; border: thin solid #000066; width: 1348px;">
            <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="myProfileB" runat="server" Text="Register" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="logOut" runat="server" Text="Login" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
    <div>
        <asp:Label ID="lb_c" runat="server" Text="Department's Jobs" Font-Size="32pt" Font-Bold="True" Font-Italic="True" Font-Overline="True" Font-Strikeout="False" Font-Underline="True"></asp:Label>
        <br />
         <br />
         <br />
    
    </div>
    </form>
</body>
</html>
