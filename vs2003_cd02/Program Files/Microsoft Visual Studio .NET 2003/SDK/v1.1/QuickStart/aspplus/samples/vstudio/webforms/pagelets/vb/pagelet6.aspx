<%@ Page CodeBehind="pagelet6.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Pagelets.Vb.pagelet6" %>
<%@ Register TagPrefix="Acme" TagName="BookList" Src="pagelet6.ascx" %>

<html>
<body style="font: 10pt verdana">

  <h3>A User Control w/ an Event</h3>

  <form runat="server">

    <Acme:BookList runat="server" />

  </form>

</body>
</html>