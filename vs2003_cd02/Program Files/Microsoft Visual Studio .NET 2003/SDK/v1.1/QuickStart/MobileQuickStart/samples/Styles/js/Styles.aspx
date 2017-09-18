<%@ Page Inherits="System.Web.UI.MobileControls.MobilePage" Language="JScript" %>

<script runat="server" language="JScript">

var greetingText : String;

protected function GoCommand_OnClick(sender:Object , e:EventArgs )
{
    greetingText = String.Format("Hello, {0}!", NameEdit.Text);
    ActiveForm = SecondForm;
}

protected function SecondForm_OnActivate(sender:Object , e:EventArgs )
{
    Greeting.Text = greetingText;
}

</script>

<mobile:Form runat="server" id="FirstForm" BackColor="#336699" ForeColor="#ffffff">
    <mobile:Label runat="server" Font-Name="Arial" Font-Size="Large">What is your name?</mobile:Label>
    <mobile:TextBox runat="server" id="NameEdit" ForeColor="#000000" />
    <mobile:Command runat="server" OnClick="GoCommand_OnClick" Text="Go!" />
</mobile:Form>

<mobile:Form runat="server" id="SecondForm" OnActivate="SecondForm_OnActivate" Font-Name="Arial">
    <mobile:Label runat="server" id="Greeting" Font-Size="Large" />
    <mobile:Link runat="server" Font-Size="Small" NavigateURL="#FirstForm" Text="Return to Start" />
</mobile:Form>
