<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main-RegularEmployee.aspx.cs" Inherits="Main_RegularEmployee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="background-color: #9999FF; color: #000066; border-color: #000066">
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
        <asp:Button ID="btn_Apply" runat="server" Text="View Assigned Projects" onclick="vap" BackColor="#9999FF" BorderColor="#000066" Height="65px" Width="290px" ForeColor="#000066" BorderStyle="Double" BorderWidth="5px" Font-Bold="True" Font-Italic="True" Font-Size="Larger" style="margin-top: 21px"/>
        <br />

    </div>
    </form>
</body>
</html>
