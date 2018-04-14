<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Requets.aspx.cs" Inherits="Manager_Requets" %>

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
    
    <div style="height: 174px; width: 841px">
            <asp:GridView ID="Trip_Requests" runat="server" AutoGenerateColumns="False" OnRowCommand ="Trip_Commands" HorizontalAlign ="Center" EmptyDataText="You don't have any new trip requests" Width="1286px">    
             <Columns>    
                 <asp:BoundField DataField="applicant_username" HeaderText="Applicant" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="start_date" HeaderText="Start date" ItemStyle-Width="150" >    
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="end_date" HeaderText="End date" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="request_date" HeaderText="Request date" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="total_days" HeaderText="Duration" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="hr_response" HeaderText="HR response" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="destination" HeaderText="Destination" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="purpose" HeaderText="Purpose" ItemStyle-Width="150" >
<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:BoundField DataField="replacement_username" HeaderText="Replacement" ItemStyle-Width="150" >
                 

<ItemStyle Width="150px"></ItemStyle>
                 </asp:BoundField>
                 <asp:ButtonField ButtonType="Button" CommandName="accept" HeaderText="Accept" ShowHeader="True" Text="Accept" />
                 <asp:ButtonField ButtonType="Button" CommandName="reject" HeaderText="Reject" ShowHeader="True" Text="Reject" />
                 

             </Columns>   
         </asp:GridView> 
     

        </div>

   
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
       
        <asp:GridView ID="Leave_Requests" runat="server" AutoGenerateColumns="false" OnRowCommand ="Leave_Commands" HorizontalAlign ="Center" EmptyDataText="You don't have any new leave requests." Width="1286px" >
            <Columns>
                <asp:BoundField DataField="applicant_username" HeaderText="Applicant" ItemStyle-Width="150" />
                <asp:BoundField DataField="start_date" HeaderText="Start date" ItemStyle-Width="150" />
                <asp:BoundField DataField="end_date" HeaderText="End date" ItemStyle-Width="150" />
                <asp:BoundField DataField="request_date" HeaderText="Request date" ItemStyle-Width="150" />
                <asp:BoundField DataField="total_days" HeaderText="Duration" ItemStyle-Width="150" />
                <asp:BoundField DataField="hr_response" HeaderText="HR response" ItemStyle-Width="150" />
                <asp:BoundField DataField="type" HeaderText="Type" ItemStyle-Width="150" />
                <asp:BoundField DataField="replacement_username" HeaderText="Replacement" ItemStyle-Width="150" />
                <asp:ButtonField ButtonType="Button" CommandName="accept" HeaderText="Accept" ShowHeader="True" Text="Accept" />
                <asp:ButtonField ButtonType="Button" CommandName="reject" HeaderText="Reject" ShowHeader="True" Text="Reject" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
