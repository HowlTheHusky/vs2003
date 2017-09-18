<html>
<head>
    <script language="JScript" runat=server>

        function ValidateBtn_Click(sender:Object, e:EventArgs) : void {

           if (Page.IsValid) {
              lblOutput.Text = "Page is Valid!";
           }
           else {
              lblOutput.Text = "Page is InValid! :-(";
           }
        }

   </script>

</head>
<body>

<h3><font face="Verdana">Simple RegularExpressionValidator Sample</font></h3>

<form runat="server">

    <table bgcolor="#eeeeee" cellpadding=10>
    
      <tr valign="top">
        <td colspan=3>
          <asp:Label ID="lblOutput" Text="Enter a 5 digit zip code" Font-Name="Verdana" Font-Size="10pt" runat="server"/>
        </td>
      </tr>

      <tr>
        <td colspan=3>
          <font face=Verdana size=2><b>Personal Information</b></font>
        </td>
      </tr>
      
      <tr>
        <td align=right>
          <font face=Verdana size=2>Zip Code:</font>
        </td>
        <td>
          <ASP:TextBox id=TextBox1 runat=server />
        </td>
        <td>
          <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server"
              ControlToValidate="TextBox1"
              ValidationExpression="^\d{5}$"
              Display="Static"
              Font-Name="verdana" 
              Font-Size="10pt">
                 Zip code must be 5 numeric digits
          </asp:RegularExpressionValidator>
        </td>
      </tr>
      
      <tr>
        <td></td>
        <td>
          <ASP:Button text="Validate" OnClick="ValidateBtn_Click" runat=server />
        </td>
        <td></td>
      </tr>
      
    </table>

</form>

</body>
</html>