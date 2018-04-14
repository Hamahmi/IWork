<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HREditJob.aspx.cs" Inherits="HREditJob" %>

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
            <asp:Label Width="200" ID="lbl_newTitle" runat="server" Text="New Title: "></asp:Label>
            <asp:TextBox ID="txt_newTitle" runat="server"></asp:TextBox>

            <br />

            <asp:Label Width="200" ID="lbl_sd" runat="server" Text="Short description: "></asp:Label>
            <asp:TextBox ID="txt_sd" runat="server"></asp:TextBox>
            
            <br />

            <asp:Label Width="200" ID="lbl_ld" runat="server" Text="Long description: "></asp:Label>
            <asp:TextBox ID="txt_ld" runat="server" TextMode="MultiLine"></asp:TextBox>

            <br />

            <asp:Label Width="200" ID="lbl_me" runat="server" Text="Minimum experience: "></asp:Label>
            <asp:TextBox ID="txt_me" runat="server" TextMode="Number"></asp:TextBox>

            <br />

            <asp:Label Width="200" ID="lbl_salary" runat="server" Text="Salary: "></asp:Label>
            <asp:TextBox ID="txt_salary" runat="server" TextMode="Number"></asp:TextBox>

            <br />

            <asp:Label Width="200" ID="lbl_deadline" runat="server" Text="Deadline: "></asp:Label>
            <asp:TextBox ID="txt_deadline" runat="server" TextMode ="Date"></asp:TextBox>

            <br />

            <asp:Label Width="200" ID="lbl_nov" runat="server" Text="Number of vacancies: "></asp:Label>
            <asp:TextBox ID="txt_nov" runat="server" TextMode="Number"></asp:TextBox>

            <br />

            <asp:Label Width="200" ID="lbl_wh" runat="server" Text="Working Hours: "></asp:Label>
            <asp:TextBox ID="txt_wh" runat="server" TextMode="Number"></asp:TextBox>
            
            <br />

            

            <br /> <br />
             <asp:Button ID="btn_edit" runat="server" Text="Save edit and add questions" onclick="Edit" Width="217px"/>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Cancel" onclick="cancel" Width="217px"/>


            <br />
            <br />
            <asp:CompareValidator runat="server" ControlToValidate= "txt_me" ErrorMessage= "Minimum experience: Must be a number!" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
            <br />
            
            <asp:CompareValidator runat="server" ControlToValidate= "txt_salary" ErrorMessage= "Salary: Must be a number!" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
            
            <br />
            <asp:CompareValidator runat="server" ControlToValidate= "txt_deadline" ErrorMessage= "Deadline: Must have the form mm/dd/yyyy" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
            <br />
            <asp:CompareValidator runat="server" ControlToValidate= "txt_nov" ErrorMessage= "Number of vacancies: Must be a number!" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
            <br />
            <asp:CompareValidator runat="server" ControlToValidate= "txt_wh" ErrorMessage= "Working Hours: Must be a number!" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
            <br />


        </div>
    </form>
</body>
</html>
