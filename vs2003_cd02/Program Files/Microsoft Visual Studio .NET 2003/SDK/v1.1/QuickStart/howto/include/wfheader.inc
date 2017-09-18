<!--BEGIN HEADER-->
<%@ Register TagPrefix="Code" Namespace="Microsoft.Samples.Utils.CodeShow" %>
<%@ Register TagPrefix="Acme" TagName="SourceRef" Src="/quickstart/howto/util/SrcRef.ascx"%>
<%@ Register TagPrefix="AcmeInclude" Namespace="Acme" Assembly="TocSwitch" %>

<html>
<head>
 <title>Microsoft HowTo QuickStarts Tutorial</title>
<link rel="stylesheet" href="/quickstart/include/qsstyle.css">
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" >

<table class="outer" cellpadding=0 cellspacing=0>
<tr>
<AcmeInclude:TocSwitch runat="server"><TocTemplate>
<td class="toc" valign="top" width="210">
  <!-- #include virtual="/quickstart/howto/include/toc.inc" -->
</td>
 </TocTemplate></AcmeInclude:TocSwitch>
<td valign="top">
<div class="body">
<!--END HEADER-->

<!-- #include virtual="/quickstart/winforms/include/winformsheader.inc" -->