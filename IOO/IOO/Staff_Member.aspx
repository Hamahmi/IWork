<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Staff_Member.aspx.cs" Inherits="Staff_Member" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance and Requests</title>
    <style type="text/css">
        .btn-default {
            width: 47px;
        }
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color: #9999FF; border: thin solid #000066;  width: 1348px;">
             <asp:Button ID="homeB" runat="server" Text="Home" onclick="Home" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" CssClass="btn-default" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="myProfileB" runat="server" Text="My Profile" onclick="MyProfile" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
            <asp:Button ID="logOut" runat="server" Text="Logout" onclick="LogOut" Height="90px" Width="446px" BackColor="#000066" BorderColor="Black" BorderStyle="Outset" Font-Bold="True" Font-Size="Large" ForeColor="#9999FF"/>
        </div>
         
        <div style="background-color: #9999FF; border: thin solid #000066">
             <asp:Panel ID ="att" runat ="server" Font-Size="Large" Font-Bold="True"> 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
                 &nbsp;Attendance:&nbsp; <asp:Button ID="checkinB" runat="server" Text="check-in" onclick="check_in"/>
                 &nbsp;&nbsp;
        <asp:Button ID="checkoutB" runat="server" Text="check-out" onclick="check_out"/>
                 <br />
                 <br />
                 &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Size="medium" Text="From: "></asp:Label>
                 <asp:TextBox ID="txt_from" runat="server" Height="18px" TextMode="Date" Width="105px"></asp:TextBox>
&nbsp;&nbsp;<asp:Label ID="Label5" runat="server" Font-Bold="False" Font-Size="x-small" Text="(mm/dd/yyyy)"></asp:Label>
                 &nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Font-Bold="False" Font-Size="medium" Text="To: "></asp:Label>
                 &nbsp;&nbsp;
                 <asp:TextBox ID="txt_to" runat="server" Height="18px" TextMode="Date" Width="105px"></asp:TextBox>
                 <asp:Label ID="Label4" runat="server" Font-Bold="False" Font-Size="x-small" Text="(mm/dd/yyyy)"></asp:Label>
                 &nbsp;&nbsp;
        <asp:Button ID="attendance" runat="server" Text="View my attendance" onclick="view_attendance"/>
            <br />
            <br />
            </asp:Panel>
        </div>
        <div style="border: thin solid #000066; background-color: #9999FF; padding: inherit">
             <br />
&nbsp; <asp:Label ID="Label1" runat="server" Text="Requests: " Font-Bold="True" Font-Size="Large"></asp:Label>&nbsp;&nbsp;&nbsp;
        <asp:Button ID="requests" runat="server" Text="View my requests" onclick ="ViewRequests" />
            <br />
             <br />
        &nbsp;
              <asp:Label ID="lb_StartDate" runat="server" Text="Start Date: " Font-Bold="False" Font-Size="Medium"></asp:Label>
    
        &nbsp;<asp:TextBox ID="start_date" runat="server" Height="18px" TextMode ="Date"></asp:TextBox>
             &nbsp;<asp:Label ID="format" runat="server" Text="(mm/dd/yyyy)" Font-Size="X-Small"></asp:Label>
    &nbsp;
             <asp:Label ID="lb_endDate" runat="server" Text="End Date: " Font-Size="Medium"></asp:Label>
    
        <asp:TextBox ID="end_date" runat="server" Height="18px" TextMode ="Date"></asp:TextBox>
            <asp:Label ID ="format1" runat ="server" Text ="(mm/dd/yyyy)" Font-Size="X-Small"></asp:Label>
            <br />
            &nbsp;
            <asp:Label ID="lb_type" runat="server" Text="Type : " Font-Size="Medium"></asp:Label>
    
            &nbsp;&nbsp;
            <select name ="type" style="height: 20px; width: 156px">
                <option value ="sick">sick</option>
                <option value ="accidental">accidental</option>
                <option value ="annual">annual</option>
            </select>&nbsp;&nbsp;
              <asp:Label ID="lb_Replacement" runat="server" Text="Replacement Username: " Font-Size="Medium"></asp:Label>
    
        <asp:TextBox ID="Replacement" runat="server" Height="18px"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;  
        <asp:Button ID="leave" runat="server" Text="Apply for leave request" onclick="leaveRequest"/>
        &nbsp;
                <br />
                <br />
&nbsp;
                <asp:Label ID="Label6" runat="server" Text="Start Date: " Font-Size="Medium"></asp:Label>
    
        <asp:TextBox ID="start_dateL" runat="server" Height="18px" TextMode ="Date"></asp:TextBox>
             <asp:Label ID="Label7" runat="server" Text="(mm/dd/yyyy)" Font-Size ="x-small"></asp:Label>
    &nbsp;
             <asp:Label ID="Label8" runat="server" Text="End Date: " Font-Size ="Medium"></asp:Label>
    
       
    
        <asp:TextBox ID="end_dateL" runat="server" Height ="18px" TextMode ="Date"></asp:TextBox>
            <asp:Label ID ="Label9" runat ="server" Text ="(mm/dd/yyyy)" Font-Size ="x-small"></asp:Label>
            <br />
            &nbsp;
            <asp:Label ID="lb_destination" runat="server" Text="Destination: " Font-Size ="Medium"></asp:Label>
    
            &nbsp;<asp:TextBox ID="txt_destination" runat="server" Height="18px"></asp:TextBox>
            &nbsp;
            <asp:Label ID="Label10" runat="server" Text="Purpose: " Font-Size ="Medium"></asp:Label>
    
            &nbsp;<asp:TextBox ID="txt_purpose" runat="server" Height="18px"></asp:TextBox>
           
            &nbsp;

            <asp:Label ID="Label11" runat="server" Text="Replacement Username: " Font-Size ="Medium"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" Height="18px"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="business" runat="server" Text="Apply for business trip request" onclick ="businessTrip"/>
        &nbsp;
            <br />
             &nbsp;<br />
        </div>
    </form>
</body>
</html>

