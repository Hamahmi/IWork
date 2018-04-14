<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApplyForJob.aspx.cs" Inherits="Apply_For_A_Job" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="background-color: #9999FF; color: #000066; font-size: 20px">
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
        <asp:Label ID="lbl_Job_Title" runat="server" Text="Job Title: " Font-Bold="True" Font-Italic="False" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_Job_Title" runat="server" style="margin-left: 103px" Width="310px" BackColor="#9999FF" BorderColor="#000066" BorderStyle="Dashed" ForeColor="#000066"></asp:TextBox>
    
        <br />
        <br />
    
        <br />

        <asp:Label ID="lbl_Years_Of_Experience" runat="server" Text="Department_Code: " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_dep_code" runat="server" style="margin-left: 5px" Width="310px" BackColor="#9999FF" BorderColor="#000066" BorderStyle="Dashed"></asp:TextBox>
    
        <br />
        <br />
    
        <br />
        <asp:Label ID="Label1" runat="server" Text="Company_Email: " Font-Bold="True" Font-Overline="True" Font-Size="Larger" Font-Underline="True"></asp:Label>
    
        <asp:TextBox ID="txt_comp_email" runat="server" style="margin-left: 22px" Width="310px" BackColor="#9999FF" BorderColor="#000066" BorderStyle="Dashed"></asp:TextBox>
    
        <br />
        <asp:Button ID="btn_View_Interview_questions" runat="server" Text="View_Interview_questions"
             onclick="viewQuestions" style="margin-top: 45px; margin-left: 526px;" BackColor="#9999FF" BorderColor="#000066" BorderStyle="Dashed" Font-Bold="True" Font-Italic="True" Font-Strikeout="False" ForeColor="#000066" Width="178px" />
        
    </div>
    </form>
</body>
</html>
