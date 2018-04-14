<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewJobs.aspx.cs" Inherits="viewJobs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="color: #000066; background-color: #9999FF">
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
    <div id="div1" style=" width: 1214px;">
                <asp:Label ID="lb_c" runat="server" Text="Job's Information" Font-Size="32pt" Font-Bold="True" Font-Italic="True" Font-Overline="True" Font-Strikeout="False" Font-Underline="True"></asp:Label>
        <br />
         <br />
         <br />
    
        <asp:GridView ID="grid1" runat="server" AutoGenerateColumns="False" Width="402px" style=" margin-top: 19px; margin-left: 101px;" Font-Bold="True" Font-Italic="True" Font-Size="Large" Font-Strikeout="False" BorderColor="#000066" BorderStyle="Dashed" BorderWidth="3px">    
             <Columns>    
                     <asp:BoundField DataField="department_code" HeaderText="Code" ItemStyle-Width="150" >
                 <ControlStyle Width="100px" />
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="company_email" HeaderText="Comapny Email" ItemStyle-Width="150" >
                 <ControlStyle Width="100px" />
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="short_description" HeaderText="Short Description" ItemStyle-Width="150" >
                 <ControlStyle Width="150px" />
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="detailed_description" HeaderText="Detailed Description" ItemStyle-Width="350" >
                 <ControlStyle Width="300px" />
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="min_experience" HeaderText="Min Experience" ItemStyle-Width="150" >
                 <ControlStyle Width="100px" />
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="salary" HeaderText="Salary" ItemStyle-Width="150" >
                 <ControlStyle Width="100px" />
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="deadline" HeaderText="Deadline" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="no_of_vacancies" HeaderText="Number of Vacancies" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="working_hours" HeaderText="Working Hours" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField> </Columns>    
             <HeaderStyle BorderStyle="Groove" />
             <RowStyle BorderStyle="Double" />
         </asp:GridView>
        <br />
                <asp:Button ID="btn_apply" runat="server" Text="Apply For Job"
             onclick="ApplyForJob" style="margin-left: 921px; margin-top: 0px" Width="117px" BackColor="#9999FF" BorderColor="#000066" ForeColor="#000066" BorderStyle="Dashed" Font-Bold="True" Font-Italic="True" />
    
        <br />

        </div>
    </form>
</body>
</html>
