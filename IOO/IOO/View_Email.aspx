<%@ Page Language="C#" AutoEventWireup="true" CodeFile="View_Email.aspx.cs" Inherits="View_Email" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mail</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div style="background-color: #9999FF; border: thin solid #000066;  width: 1348px;"">
                <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/>
                <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
                <asp:Button ID="logOut" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
            </div>
            <div style="background-color: #9999FF; border: thin solid #000066">
            <asp:Label ID="lbl_Sender" runat="server" Text=""></asp:Label>
            </div>
            <div style="background-color: #9999FF; border: thin solid #000066">
            <asp:Label ID="lbl_Subject" runat="server" Text=""></asp:Label>
            </div>
            <div style="background-color: #9999FF; border: thin solid #000066">          
            <asp:Label ID="lbl_Time" runat="server" Text=""></asp:Label>
            </div>
            <div style="background-color: #9999FF; border: thin solid #000066">          
             <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;          
            <asp:Label ID="lbl_body" runat="server" Text="    "></asp:Label>
                  <br />
                <asp:TextBox ID="txt_body"  TextMode ="multiline" runat="server" Height="84px" Width="1060px"></asp:TextBox>
                  <br />
                  <asp:Button ID="btn_Reply" runat="server"   Text="Reply" onclick="Reply"/>
            </div>
        </div>
    </form>
</body>
</html>
