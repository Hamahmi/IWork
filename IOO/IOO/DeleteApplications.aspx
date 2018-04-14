<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DeleteApplications.aspx.cs" Inherits="Delete_Applications" %>

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
    <asp:Label ID="lbl_Job_Title" runat="server" Text="Job Title: " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_Job_Title" runat="server" BackColor="#9999FF" BorderColor="#000066" style="margin-left: 96px" Width="300px" BorderStyle="Dashed"></asp:TextBox>
    
        <br />

        <asp:Label ID="Label1" runat="server" Text="Department Code: " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_dep_code" runat="server" BackColor="#9999FF" BorderColor="#000066" style="margin-left: 5px; margin-top: 17px" Width="300px" BorderStyle="Dashed"></asp:TextBox>
    
        <br />

        <asp:Label ID="Label2" runat="server" Text="Company Email: " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_comp_email" runat="server" BackColor="#9999FF" BorderColor="#000066" style="margin-left: 22px; margin-top: 27px" Width="300px" BorderStyle="Dashed"></asp:TextBox>
    
        <br />



    
        <asp:Button ID="btn_View_Interview_questions" runat="server" Text="Delete Application"
             onclick="dlt" BackColor="#9999FF" BorderColor="#000066" Height="29px" style="margin-top: 37px; margin-left: 510px;" BorderStyle="Dashed" Font-Bold="True" Font-Italic="True" Width="147px" />
        <br />
    </div>
    </form>
</body>
</html>