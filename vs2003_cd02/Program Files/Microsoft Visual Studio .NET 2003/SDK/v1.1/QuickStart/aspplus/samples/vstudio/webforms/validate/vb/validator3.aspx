<%@ Page clienttarget="downlevel" CodeBehind="validator3.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Validate.Vb.validator3" %>

<html>
<body>

<h3><font face="Verdana">ValidationSummary Sample</font></h3>
<p>

<form runat="server">

<table cellpadding=10>
    <tr>
        <td>
            <table bgcolor="#eeeeee" cellpadding=10>

            <tr>
              <td colspan=3>
              <font face=Verdana size=2><b>Credit Card Information</b></font>
              </td>
            </tr>
            <tr>
              <td align=right>
                <font face=Verdana size=2>Card Type:</font>
              </td>
              <td>
                <ASP:RadioButtonList id=RadioButtonList1 RepeatLayout="Flow" runat=server>
                    <asp:ListItem>MasterCard</asp:ListItem>
                    <asp:ListItem>Visa</asp:ListItem>
                </ASP:RadioButtonList>
              </td>
              <td align=middle rowspan=1>
                <asp:RequiredFieldValidator id="RequiredFieldValidator1"
                    ControlToValidate="RadioButtonList1" 
                    ErrorMessage="Card Type. "
                    Display="Static"
                    InitialValue="" Width="100%" runat=server>
                    *
                </asp:RequiredFieldValidator>
              </td>
            </tr>
            <tr>
              <td align=right>
                <font face=Verdana size=2>Card Number:</font>
              </td>
              <td>
                <ASP:TextBox id=TextBox1 runat=server />
              </td>
              <td>
                <asp:RequiredFieldValidator id="RequiredFieldValidator2"
                    ControlToValidate="TextBox1" 
                    ErrorMessage="Card Number. "
                    Display="Static"
                    Width="100%" runat=server>
                    *
                </asp:RequiredFieldValidator>

              </td>
            </tr>
            <tr>
              <td align=right>
                <font face=Verdana size=2>Expiration Date:</font>
              </td>
              <td>
                <ASP:DropDownList id=DropDownList1 runat=server>
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem >06/00</asp:ListItem>
                    <asp:ListItem >07/00</asp:ListItem>
                    <asp:ListItem >08/00</asp:ListItem>
                    <asp:ListItem >09/00</asp:ListItem>
                    <asp:ListItem >10/00</asp:ListItem>
                    <asp:ListItem >11/00</asp:ListItem>
                    <asp:ListItem >01/01</asp:ListItem>
                    <asp:ListItem >02/01</asp:ListItem>
                    <asp:ListItem >03/01</asp:ListItem>
                    <asp:ListItem >04/01</asp:ListItem>
                    <asp:ListItem >05/01</asp:ListItem>
                    <asp:ListItem >06/01</asp:ListItem>
                    <asp:ListItem >07/01</asp:ListItem>
                    <asp:ListItem >08/01</asp:ListItem>
                    <asp:ListItem >09/01</asp:ListItem>
                    <asp:ListItem >10/01</asp:ListItem>
                    <asp:ListItem >11/01</asp:ListItem>
                    <asp:ListItem >12/01</asp:ListItem>
                </ASP:DropDownList>
              </td>
              <td>
                <asp:RequiredFieldValidator id="RequiredFieldValidator3"
                  ControlToValidate="DropDownList1" 
                  ErrorMessage="Expiration Date. "
                  Display="Static"
                  InitialValue="" 
                  Width="100%" 
                  runat=server>
                  *
                </asp:RequiredFieldValidator>
              </td>
              <td></td>
            <tr>
              <td></td>
              <td>
                <ASP:Button id=ValidateBtn text="Validate" runat=server />
              </td>
              <td></td>
            </tr>
            </table>
        </td>
        <td valign=top>
            <table cellpadding=20><tr><td>
            <asp:ValidationSummary ID="valSum" runat="server"
                HeaderText="You must enter a value in the following fields:"
                Font-Name="verdana" 
                Font-Size="12" 
                />
            </td></tr></table>
        </td>
    </tr>
</table>

<font face="verdana" size="-1">Select the type of validation summary display you wish: </font>

<asp:DropDownList id="ListFormat" AutoPostBack=true runat=server >
    <asp:ListItem>List</asp:ListItem>
    <asp:ListItem selected>Bulleted List</asp:ListItem>
    <asp:ListItem>Single Paragraph</asp:ListItem>
</asp:DropDownList>

</form></p>

</body>
 </html>