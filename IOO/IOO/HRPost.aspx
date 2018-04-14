<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HRPost.aspx.cs" Inherits="HRPost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center; left:50%; right: 50%; justify-content: center; background-color: #9999FF; border: thin solid #000066;  width: 1348px;"">
                 <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/> 
                 <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
               <asp:Button ID="logOut" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
        <div style ="text-align: center; left:50%; right: 50%; justify-content: center">
            <asp:Label Width="200" ID="lbl_Title" runat="server" Text="Title: "></asp:Label>
            <asp:TextBox ID="txt_Title" runat="server"></asp:TextBox>

            <br />
            <asp:Label Width="200" ID="Label1" runat="server" Text="Type: "></asp:Label>
            <asp:TextBox ID="txt_type" runat="server"></asp:TextBox>

            <br />
            <asp:Label Width="200" ID="Label2" runat="server" Text="Description: "></asp:Label>
            <asp:TextBox ID="txt_description" runat="server" TextMode="MultiLine"></asp:TextBox>

            <br /> <br />
            <asp:Button ID="btn_edit" runat="server" Text="Post" onclick="post" Width="60px"/>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Cancel" onclick="cancel"/>
            
            <br />
            
        </div>
    </form>
</body>
</html>
