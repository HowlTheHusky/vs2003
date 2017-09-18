<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<html>

<script language="JScript" runat="server">

    function PopulateList() : void {

        var myConnection : SqlConnection = new SqlConnection("server=(local)\\NetSDK;database=pubs;Integrated Security=SSPI");
        var myCommand : SqlDataAdapter = new SqlDataAdapter("select * from Titles where type='business'", myConnection);

        var ds : DataSet = new DataSet();
        myCommand.Fill(ds, "Titles");

        MyDataList.DataSource = ds.Tables("Titles").DefaultView;
        MyDataList.DataBind();
    }

    function Page_Load(sender : Object , e : EventArgs ) : void  {

        if (!Page.IsPostBack) {
          PopulateList();
        }
    }

    function MyDataList_Edit(sender : Object, e : DataListCommandEventArgs) : void {

        MyDataList.EditItemIndex = int(e.Item.ItemIndex);
        PopulateList();
    }

    function MyDataList_Update(sender : Object, e : DataListCommandEventArgs ) : void {

        // database update left out for simplicity's sake...

        var price : String = (HtmlInputText(e.Item.FindControl("edit_price"))).Value;
        Message.InnerHtml = "Price Updated: " + price;
        MyDataList.EditItemIndex = -1;
        PopulateList();
    }

    function MyDataList_Cancel(sender : Object, e : DataListCommandEventArgs) : void {

        MyDataList.EditItemIndex = -1;
        PopulateList();
    }

</script>

<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">

  <form runat="server">

  <!-- #include virtual="/quickstart/aspplus/samples/webforms/customize/header.inc" -->

  <ASP:DataList id="MyDataList" RepeatColumns="2" OnEditCommand="MyDataList_Edit" OnUpdateCommand="MyDataList_Update" OnCancelCommand="MyDataList_Cancel" runat="server">

      <ItemTemplate>

        <table cellpadding=10 style="font: 10pt verdana">
          <tr>
            <td width=1 bgcolor="BD8672"/>
            <td valign="top">
              <img align="top" src='<%# DataBinder.Eval(Container.DataItem, "title_id", "/quickstart/aspplus/images/title-{0}.gif") %>' >
            </td>
            <td valign="top">
              <b>Title: </b><%# DataBinder.Eval(Container.DataItem, "title") %><br>
              <b>Category: </b><%# DataBinder.Eval(Container.DataItem, "type") %><br>
              <b>Publisher ID: </b><%# DataBinder.Eval(Container.DataItem, "pub_id") %><br>
              <b>Price: </b><%# DataBinder.Eval(Container.DataItem, "price", "$ {0}") %>
              <p>
              <asp:linkbutton CommandName="Edit" runat="server">
                <img border="0" src="/quickstart/aspplus/images/edit_book.gif" >
              </asp:linkbutton>
            </td>
          </tr>
        </table>

      </ItemTemplate>

      <EditItemTemplate>

        <table cellpadding=10 style="font: 10pt verdana">
          <tr>
            <td width=1 bgcolor="BD8672"/>
            <td valign="top">
              <img align="top" src='<%# DataBinder.Eval(Container.DataItem, "title_id", "/quickstart/aspplus/images/title-{0}.gif") %>' >
            </td>
            <td valign="top">
              <b>Title: </b><%# DataBinder.Eval(Container.DataItem, "title") %><br>
              <b>Category: </b><%# DataBinder.Eval(Container.DataItem, "type") %><br>
              <b>Publisher ID: </b><%# DataBinder.Eval(Container.DataItem, "pub_id") %><br>
              <b>Price: </b><input id="edit_price" type="text" value='<%# DataBinder.Eval(Container.DataItem, "price", "$ {0}") %>' runat="server"/>
              <p>
              <asp:linkbutton CommandName="Update" runat="server"><img border="0" src="/quickstart/aspplus/images/update_book.gif" ></asp:linkbutton>
              <asp:linkbutton CommandName="Cancel" runat="server"><img border="0" src="/quickstart/aspplus/images/cancel_book.gif" ></asp:linkbutton>
            </td>
          </tr>
        </table>

      </EditItemTemplate>

  </ASP:DataList>

  <!-- #include virtual="/quickstart/aspplus/samples/webforms/customize/footer.inc" -->

  </form>

  <div style="font: 10pt verdana;padding:0,15,15,15" id="Message" runat="server"/>

</body>
</html>