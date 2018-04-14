<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login
    </title>
</head>
<body>
    <form id="form2" runat="server">
        <div style="background-color: #9999FF; border: thin solid #000066; white-space: normal; width: 1348px;">
            <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="registerB" runat="server" Text="Register" onclick="register" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="loginB" runat="server" Text="Login" onclick="LoginP" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
        <div style="background-color: #9999FF; border: thin solid #000066">
            &nbsp;&nbsp;
            <br />
&nbsp;
            <asp:Label ID="PI" runat="server" Text="Login" Font-Bold="True" Font-Overline="False" Font-Size="X-Large" Font-Underline="True"></asp:Label>
            <br />
            <br />&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lbl_username" runat="server" Text="Username: " Font-Size="Large"></asp:Label>
            <asp:TextBox ID="txt_username" runat="server"></asp:TextBox>
    
            &nbsp;<br />
        &nbsp; &nbsp;
        <asp:Label ID="lbl_password" runat="server" Text="Password: " Font-Size="Large"></asp:Label>
        &nbsp;<asp:TextBox ID="txt_password" runat="server" TextMode ="Password" Width="151px"></asp:TextBox>
    
            &nbsp;<br />
    
        <br />
        &nbsp;
        <asp:Button ID="btn_login" runat="server" Text="Login" onclick="login"/>
            <br /><br />

        </div>
    </form>
</body>
    </html>