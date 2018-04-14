<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Applications.aspx.cs" Inherits="Manager_Applications" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
        <form id="form1" runat="server">
            <div style="background-color: #9999FF; border: thin solid #000066;  width: 1348px;"">
                 <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/> 
                 <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
               <asp:Button ID="logOut" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
      <asp:GridView ID="Apps" runat="server" AutoGenerateColumns="false" OnRowCommand ="App_Respond" HorizontalAlign ="Center" EmptyDataText="There are no new applications for this job" Width="1286px" >
            <Columns>
                <asp:BoundField DataField="job_title" HeaderText="Applicant" ItemStyle-Width="150" />
                <asp:BoundField DataField="job_seeker_username" HeaderText="Job" ItemStyle-Width="150" />
                <asp:BoundField DataField="score" HeaderText="Score" ItemStyle-Width="150" />
                 <asp:ButtonField ButtonType="Button" CommandName="accept" HeaderText="Accept" ShowHeader="True" Text="Accept" />
                <asp:ButtonField ButtonType="Button" CommandName="reject" HeaderText="Reject" ShowHeader="True" Text="Reject" />
            </Columns>
        </asp:GridView>

            </form>




    </body>
</html>
