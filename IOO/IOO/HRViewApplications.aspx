<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HRViewApplications.aspx.cs" Inherits="HRViewApplications" %>

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

            <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="true" OnRowCommand ="rowcom" HorizontalAlign ="Center">    
               <Columns>
                   
                     <asp:ButtonField ButtonType="Button" Commandname ="viewjs" Text="View Info about the job seeker" />
                   <asp:ButtonField ButtonType="Button" Commandname ="viewj" Text="View Info about the job" />
                   <asp:ButtonField ButtonType="Button" Commandname ="acc" Text="Accept" />
                   <asp:ButtonField ButtonType="Button" Commandname ="rej" Text="Reject" />
                   
               </Columns>

             </asp:GridView>
                <asp:Button ID="Button1" runat="server" Text="Cancel" onclick="cancel"/>

        </div>
    </form>
</body>
</html>
