<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCompany.aspx.cs" Inherits="ViewCompany" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="background-color: #9999FF; color: #000066">
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
        <asp:Label ID="lb_c" runat="server" Text="Company's Information" Font-Size="32pt" Font-Bold="True" Font-Italic="True" Font-Overline="True" Font-Strikeout="False" Font-Underline="True"></asp:Label>
        <br />
         <br />
         <br />
    <div>
        <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="false" Width="810px" style="margin-left: 130px" Font-Bold="True" Font-Italic="False" Font-Size="Large" Font-Strikeout="False">    
             <Columns>    
                 <asp:BoundField DataField="email" HeaderText="Email" ItemStyle-Width="150" />    
                 <asp:BoundField DataField="name" HeaderText="Name" ItemStyle-Width="150" />
                 <asp:BoundField DataField="address" HeaderText="Address" ItemStyle-Width="150" />
                 <asp:BoundField DataField="domain" HeaderText="Domain" ItemStyle-Width="150" />
                 <asp:BoundField DataField="type" HeaderText="Type" ItemStyle-Width="150" />
                 <asp:BoundField DataField="vision" HeaderText="Vision" ItemStyle-Width="150" />
                 <asp:BoundField DataField="specialization" HeaderText="Specialization" ItemStyle-Width="150" />
                  </Columns>    
         </asp:GridView>
        <br />

        <asp:GridView ID="grid3" runat="server" AutoGenerateColumns="false" Width="542px" style="margin-left: 131px">    
             <Columns>  
                <asp:BoundField DataField="phone" HeaderText="Phone Numbers" ItemStyle-Width="150" />
                  </Columns>    
         </asp:GridView>
 
        <asp:Label ID="Llb_d" runat="server" Text="Company's Departments" Font-Size="32pt" Font-Bold="True" Font-Italic="True" Font-Overline="True" Font-Underline="True"></asp:Label>
        <br />  


        <asp:GridView ID="grid2" runat="server" AutoGenerateColumns="false" Width="542px" style="margin-left: 131px">    
             <Columns>  
                <asp:BoundField DataField="code" HeaderText="Code" ItemStyle-Width="150" />
                 <asp:BoundField DataField="name" HeaderText="Name" ItemStyle-Width="150" />
                  </Columns>    
         </asp:GridView>
    
      
    
    </div>
    </form>
    
</body>
</html>
