<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DataGrid14.aspx.vb" Inherits="Data.Vb.DataGrid14"%>

 <html>
  <head>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.0">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET">
  </head>
  <body>

    <form id="DataGrid14" method="post" runat="server">

	<h3><font face="Verdana">Simple Stored Proc Select to a DataGrid Control</font></h3>

	<ASP:DataGrid id="MyDataGrid" runat="server"
	  Width="360"
	  BackColor="#ccccff" 
	  BorderColor="black"
	  ShowFooter="false" 
	  CellPadding=3 
	  CellSpacing="0"
	  Font-Name="Verdana"
	  Font-Size="8pt"
	  HeaderStyle-BackColor="#aaaadd"
	  EnableViewState="false"
	/>

    </form>

  </body>
 </html>