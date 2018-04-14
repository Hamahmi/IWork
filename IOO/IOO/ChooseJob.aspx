<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChooseJob.aspx.cs" Inherits="Choose_A_Job" %>

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
        <asp:Label ID="lbl_Job_Title" runat="server" Text=" Job Title :       " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_Job_Title" runat="server" BackColor="#9999FF" BorderColor="#000066" ForeColor="#000066" style="margin-left: 128px; margin-top: 16px" Width="300px" Font-Bold="False" BorderStyle="Dashed"></asp:TextBox>
    
        <br />

        <asp:Label ID="lbl_dayoff" runat="server" Text=" Day off :         " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_dayoff" runat="server" BackColor="#9999FF" BorderColor="#000066" style="margin-left: 145px; margin-top: 26px" Width="300px" BorderStyle="Dashed"></asp:TextBox>
    
        <br />
        <asp:Label ID="lbl_jdCode" runat="server" Text=" Department Code : " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_jdCode" runat="server" BackColor="#9999FF" BorderColor="#000066" style="margin-top: 23px; margin-left: 35px;" Width="300px" BorderStyle="Dashed"></asp:TextBox>
    
        <br />

               <asp:Label ID="lbl_jcMail" runat="server" Text=" Company email :   " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_jcMail" runat="server" BackColor="#9999FF" BorderColor="#000066" style="margin-left: 57px; margin-top: 25px" Width="300px" BorderStyle="Dashed"></asp:TextBox>
    
        <br />
 
        <asp:Button ID="btn_Choose_Job" runat="server" Text="Choose Job"
             onclick="chooseJob" BackColor="#9999FF" BorderColor="#000066" Height="28px" style="margin-left: 547px; margin-top: 52px" Font-Bold="True" Font-Italic="True" Font-Names="Arial" />
        
    
    </div>
    </form>
</body>
</html>
