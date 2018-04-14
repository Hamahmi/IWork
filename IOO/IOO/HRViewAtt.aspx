<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HRViewAtt.aspx.cs" Inherits="HRViewAtt" %>

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
        <div><div style ="text-align: center; left:50%; right: 50%; justify-content: center">
             <asp:Label Width="200" ID="lbl_username" runat="server" Text="Username Of The Staff: "></asp:Label>
            <asp:TextBox ID="txt_username" runat="server" TextMode="SingleLine"></asp:TextBox>

            <br />

            <asp:Label Width="200" ID="lbl_sd" runat="server" Text="Start Date: "></asp:Label>
            <asp:TextBox ID="txt_sd" runat="server" TextMode ="Date"></asp:TextBox>
            
            <br />

            <asp:Label Width="200" ID="lbl_ed" runat="server" Text="End Date: "></asp:Label>
            <asp:TextBox ID="txt_ed" runat="server" TextMode ="Date"></asp:TextBox>
            <br />

            <asp:Button ID="Button3" runat="server" Text="View Staff Attendence" onclick="viewAtt" Width="171px"/>
             <br />
            <asp:Button ID="Button1" runat="server" Text="Back" onclick="back" Width="171px"/>

             <br />
            <asp:CompareValidator runat="server" ControlToValidate= "txt_sd" ErrorMessage= "Start Date: Must have the form mm/dd/yyyy" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
           <br />
            <asp:CompareValidator runat="server" ControlToValidate= "txt_ed" ErrorMessage= "End Date: Must have the form mm/dd/yyyy" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>


             <br />

            <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="true" HorizontalAlign ="Center">      
            </asp:GridView>
            
        </div>
    </form>
    
</body>
</html>
