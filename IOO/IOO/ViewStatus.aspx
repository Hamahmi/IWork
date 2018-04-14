<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewStatus.aspx.cs" Inherits="View_Status" %>

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
    <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="false" Width="810px" BorderColor="#000066" BorderStyle="Dashed" BorderWidth="3px" Font-Bold="True" Font-Italic="True" Font-Size="Large">    
             <Columns>    
                 <asp:BoundField DataField="job_title" HeaderText="Job Title" ItemStyle-Width="150" />    
                 <asp:BoundField DataField="manager_response" HeaderText="Status" ItemStyle-Width="150" />
                 <asp:BoundField DataField="score" HeaderText="Score" ItemStyle-Width="150" />
            
                  </Columns>    
         </asp:GridView>
    </div>
    </form>
</body>
</html>
