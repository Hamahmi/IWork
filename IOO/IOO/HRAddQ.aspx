<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HRAddQ.aspx.cs" Inherits="HRAddQ" %>

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


            &nbsp;&nbsp;


            <asp:Label Width="200" ID="lbl_nov" runat="server" Text="Question: "></asp:Label>
            <asp:TextBox Width ="193px" ID="txt_q" runat="server"></asp:TextBox>
            
           <br />

            <asp:Label Width="211px" ID="lbl_wh" runat="server" Text="Answer: "></asp:Label>
            <asp:DropDownList Width ="200" runat="server" ID ="dd" AutoPostBack ="true">
                <asp:ListItem Text ="False"></asp:ListItem>
                <asp:ListItem Text ="True"></asp:ListItem>

            </asp:DropDownList>
            
            <br />


            <asp:Button ID="btn_addq" runat="server" Text="Add Question" onclick="addq" Width="112px"/>

            <br />
            
            <asp:Button ID="Button1" runat="server" Text="Cancel" onclick="cancel" Width="113px"/>
            <br />
        </div>
    </form>
</body>
</html>
