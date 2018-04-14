<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color: #9999FF; border: thin solid #000066; white-space: normal; width: 1348px;">
            <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="registerB" runat="server" Text="Register" onclick="register" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="loginB" runat="server" Text="Login" onclick="Login" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
        <div style="background-color: #9999FF; border: thin solid #000066">
            <asp:Panel ID ="Info" runat ="server">
                <br />&nbsp;
                <asp:Label ID="PI" runat="server" Text="Register" Font-Bold="True" Font-Overline="False" Font-Size="X-Large" Font-Underline="True"></asp:Label>
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_un" runat="server" Text="Username: " Font-Size="Large"></asp:Label>
                 <br />
                &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_un" runat="server"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_pass" runat="server" Text="Password: " Font-Size="Large"></asp:Label>
                 <br />
                &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                <asp:TextBox ID="txt_pass" runat="server" TextMode="Password"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_fn" runat="server" Text="First name: " Font-Size="Large"></asp:Label>
                 <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_fn" runat="server"></asp:TextBox>
                <br />
                &nbsp; &nbsp;
                <asp:Label ID="lbl_mn" runat="server" Text="Middle name: " Font-Size="Large"></asp:Label>
                 <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_mn" runat="server"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_ln" runat="server" Text="Last name: " Font-Size="Large"></asp:Label>
                 <br />
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                <asp:TextBox ID="txt_ln" runat="server"></asp:TextBox>
                <br />
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_mail" runat="server" Text="Personal Email: " Font-Size="Large"></asp:Label>
                 <br />
                &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_mail" runat="server"></asp:TextBox>
                (name@domain.com)<br />&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_bd" runat="server" Font-Size="Large" Text="Birth date: "></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_bd" runat="server" TextMode ="Date"></asp:TextBox>
                 <asp:Label ID ="format1" runat ="server" Text ="(mm/dd/yyyy)" Font-Size="X-Small"></asp:Label><br />&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_PJ" runat="server" Font-Size="Large" Text="Prevoius Jobs: "></asp:Label>
                &nbsp;<br /> &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txt_PJ" runat="server"></asp:TextBox>
                (ex: job1, job2, job3...)<br />&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lbl_ye" runat="server" Text="Years of experience: " Font-Size="Large"></asp:Label>
                 <br />
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                <asp:TextBox ID="txt_ye" runat="server"></asp:TextBox>
                <br />
                &nbsp;&nbsp;<br /> &nbsp;&nbsp;&nbsp; &nbsp;
        <asp:Button ID="btn_register" runat="server" Text="Register" onclick="reg" Height="38px" Width="80px"/>
                <br /><br />
    
            </asp:Panel> 
        </div>
    </form>
</body>
</html>
