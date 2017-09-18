<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<html>

<head>
<script language="C#" runat="server">

    SqlConnection myConnection;
    public Hashtable StateIndex;

    protected void Page_Load(Object Src, EventArgs E)
    {
        myConnection = new SqlConnection("server=(local)\\NetSDK;database=pubs;Integrated Security=SSPI");

        if (!IsPostBack)
            BindGrid();

        StateIndex = new Hashtable();
        StateIndex["CA"] = 0;
        StateIndex["IN"] = 1;
        StateIndex["KS"] = 2;
        StateIndex["MD"] = 3;
        StateIndex["MI"] = 4;
        StateIndex["OR"] = 5;
        StateIndex["TN"] = 6;
        StateIndex["UT"] = 7;
    }

    public void MyDataGrid_Edit(Object sender, DataGridCommandEventArgs E)
    {
        MyDataGrid.EditItemIndex = (int)E.Item.ItemIndex;
        BindGrid();
    }

    public void MyDataGrid_Cancel(Object sender, DataGridCommandEventArgs E)
    {
        MyDataGrid.EditItemIndex = -1;
        BindGrid();
    }

    public void MyDataGrid_Update(Object sender, DataGridCommandEventArgs E)
    {
        if (Page.IsValid)
        {
            String updateCmd = "UPDATE Authors SET au_id = @Id, au_lname = @LName, au_fname = @FName, phone = @Phone, "
                + "address = @Address, city = @City, state = @State, zip = @Zip, contract = @Contract where au_id = @Id";

            SqlCommand myCommand = new SqlCommand(updateCmd, myConnection);

            myCommand.Parameters.Add(new SqlParameter("@Id", SqlDbType.NVarChar, 11));
            myCommand.Parameters.Add(new SqlParameter("@LName", SqlDbType.NVarChar, 40));
            myCommand.Parameters.Add(new SqlParameter("@FName", SqlDbType.NVarChar, 20));
            myCommand.Parameters.Add(new SqlParameter("@Phone", SqlDbType.NChar, 12));
            myCommand.Parameters.Add(new SqlParameter("@Address", SqlDbType.NVarChar, 40));
            myCommand.Parameters.Add(new SqlParameter("@City", SqlDbType.NVarChar, 20));
            myCommand.Parameters.Add(new SqlParameter("@State", SqlDbType.NChar, 2));
            myCommand.Parameters.Add(new SqlParameter("@Zip", SqlDbType.NChar, 5));
            myCommand.Parameters.Add(new SqlParameter("@Contract", SqlDbType.NVarChar,1));

            myCommand.Parameters["@Id"].Value = MyDataGrid.DataKeys[(int)E.Item.ItemIndex];

            String[] cols = {"LName","FName","Phone","Address","City","Zip"};

            for (int i=0; i<6; i++)
            {
                String colvalue = ((System.Web.UI.WebControls.TextBox)
                    E.Item.FindControl("edit_" + cols[i])).Text;
                myCommand.Parameters["@" + cols[i]].Value = colvalue;
            }

            myCommand.Parameters["@State"].Value = ((DropDownList)E.Item.FindControl("edit_State")).SelectedItem.ToString();

            if (((CheckBox)E.Item.FindControl("edit_Contract")).Checked = true)
                myCommand.Parameters["@Contract"].Value = "1";
            else
                myCommand.Parameters["@Contract"].Value = "0";

            myCommand.Connection.Open();

            try
            {
                myCommand.ExecuteNonQuery();
                Message.InnerHtml = "<b>Record Updated</b><br>" + updateCmd;
                MyDataGrid.EditItemIndex = -1;
            }
            catch (SqlException e)
            {
                if (e.Number == 2627)
                    Message.InnerHtml = "ERROR: A record already exists with the same primary key";
                else
                    Message.InnerHtml = "ERROR: Could not update record, please ensure the fields are correctly filled out";
                Message.Style["color"] = "red";
            }

            myCommand.Connection.Close();

            BindGrid();
        }
        else
        {
            Message.InnerHtml = "ERROR: Please check each field for error conditions.";
            Message.Style["color"] = "red";
        }
    }

    public void BindGrid()
    {
        SqlDataAdapter myCommand = new SqlDataAdapter("select * from Authors", myConnection);

        DataSet ds = new DataSet();
        myCommand.Fill(ds, "Authors");

        MyDataGrid.DataSource=ds.Tables["Authors"].DefaultView;
        MyDataGrid.DataBind();
    }

</script>
</head>

<body style="font: 10pt verdana">

  <form runat="server">

    <h3><font face="Verdana">Updating a Row of Data w/ Validation</font></h3>

    <span id="Message" EnableViewState="false" style="font: arial 11pt;" runat="server"/><p>

    <ASP:DataGrid id="MyDataGrid" runat="server"
      Width="800"
      BackColor="#ccccff"
      BorderColor="black"
      ShowFooter="false"
      CellPadding=3
      CellSpacing="0"
      Font-Name="Verdana"
      Font-Size="8pt"
      HeaderStyle-BackColor="#aaaadd"
      OnEditCommand="MyDataGrid_Edit"
      OnCancelCommand="MyDataGrid_Cancel"
      OnUpdateCommand="MyDataGrid_Update"
      DataKeyField="au_id"
      AutoGenerateColumns="false"
    >

      <Columns>
        <asp:EditCommandColumn EditText="Edit" CancelText="Cancel" UpdateText="Update"  ItemStyle-Wrap="false"/>
        <asp:BoundColumn HeaderText="au_id" SortExpression="au_id" ReadOnly="True" DataField="au_id" ItemStyle-Wrap="false"/>
        <asp:TemplateColumn HeaderText="au_lname" SortExpression="au_lname">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "au_lname") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <nobr>
            <asp:TextBox runat="server" id="edit_LName" Text='<%# DataBinder.Eval(Container.DataItem, "au_lname") %>'/>
            <asp:RequiredFieldValidator id="au_lnameReqVal"
                ControlToValidate="edit_LName"
                Display="Dynamic"
                Font-Name="Verdana" Font-Size="12"
                runat=server>
                    &nbsp;*
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator id="au_lnameRegEx"
                ASPClass="RegularExpressionValidator" ControlToValidate="edit_LName"
                ValidationExpression="[\w\s-']+"
                Display="Dynamic"
                Font-Name="Arial" Font-Size="11"
                runat=server>
                    * names may contain only alphanumeric characters and limited punctuation <br>
            </asp:RegularExpressionValidator>
          </EditItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="au_fname" SortExpression="au_fname">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "au_fname") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <nobr>
            <asp:TextBox runat="server" id="edit_FName" Text='<%# DataBinder.Eval(Container.DataItem, "au_fname") %>'/>
            <asp:RequiredFieldValidator id="au_fnameReqVal"
                ControlToValidate="edit_FName"
                Display="Dynamic"
                Font-Name="Verdana" Font-Size="12"
                runat=server>
                    &nbsp;*
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator id="au_fnameRegEx"
                ASPClass="RegularExpressionValidator" ControlToValidate="edit_FName"
                ValidationExpression="[\w\s-']+"
                Display="Dynamic"
                Font-Name="Arial" Font-Size="11"
                runat=server>
                    * names may contain only alphanumeric characters and limited punctuation <br>
            </asp:RegularExpressionValidator>
          </EditItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="phone" SortExpression="phone">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "phone") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <nobr>
            <asp:TextBox runat="server" id="edit_Phone" Text='<%# DataBinder.Eval(Container.DataItem, "phone") %>'/>
            <asp:RequiredFieldValidator id="phoneReqVal"
                ControlToValidate="edit_Phone"
                Display="Dynamic"
                Font-Name="Verdana" Font-Size="12"
                runat=server>
                    &nbsp;*
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator id="phoneRegexVal"
                ControlToValidate="edit_Phone"
                ValidationExpression="[0-9]{3} [0-9]{3}-[0-9]{4}"
                Display="Dynamic"
                Font-Name="Arial" Font-Size="11"
                runat=server>
                    * Phone must be in form: XXX XXX-XXXX <br>
            </asp:RegularExpressionValidator>
          </EditItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="address" SortExpression="address">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "address") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <asp:TextBox runat="server" id="edit_Address" Text='<%# DataBinder.Eval(Container.DataItem, "address") %>'/>
            <asp:RegularExpressionValidator id="au_addressRegEx"
                ASPClass="RegularExpressionValidator" ControlToValidate="edit_Address"
                ValidationExpression="[\w\s-()#\.]+"
                Display="Dynamic"
                Font-Name="Arial" Font-Size="11"
                runat=server>
                    * addresses may only contain alphanumeric values and limited punctuation <br>
            </asp:RegularExpressionValidator>
          </EditItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="city" SortExpression="city">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "city") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <asp:TextBox runat="server" id="edit_City" Text='<%# DataBinder.Eval(Container.DataItem, "city") %>'/>
            <asp:RegularExpressionValidator id="au_cityRegEx"
                ASPClass="RegularExpressionValidator" ControlToValidate="edit_City"
                ValidationExpression="[\w\s]+"
                Display="Dynamic"
                Font-Name="Arial" Font-Size="11"
                runat=server>
                    * city names may only contain alphanumeric values <br>
            </asp:RegularExpressionValidator>
          </EditItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="state" SortExpression="state">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "state") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <asp:DropDownList runat="server" SelectedIndex='<%# StateIndex[(String)((DataRowView)Container.DataItem)["state"]] %>' id="edit_State">
                  <asp:ListItem>CA</asp:ListItem>
                  <asp:ListItem>IN</asp:ListItem>
                  <asp:ListItem>KS</asp:ListItem>
                  <asp:ListItem>MD</asp:ListItem>
                  <asp:ListItem>MI</asp:ListItem>
                  <asp:ListItem>OR</asp:ListItem>
                  <asp:ListItem>TN</asp:ListItem>
                  <asp:ListItem>UT</asp:ListItem>
            </asp:DropDownList>
          </EditItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="zip" SortExpression="zip">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "zip") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <asp:TextBox runat="server" id="edit_Zip" Text='<%# DataBinder.Eval(Container.DataItem, "zip") %>'/>
            <asp:RegularExpressionValidator id="RegularExpressionValidator1"
                ASPClass="RegularExpressionValidator" ControlToValidate="edit_Zip"
                ValidationExpression="[0-9]{5}"
                Display="Dynamic"
                Font-Name="Arial" Font-Size="11"
                runat=server>
                    * Zip Code must be 5 numeric digits <br>
            </asp:RegularExpressionValidator>
          </EditItemTemplate>
        </asp:TemplateColumn>
        <asp:TemplateColumn HeaderText="contract" SortExpression="contract">
          <ItemTemplate>
            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "contract", "{0}") %>'/>
          </ItemTemplate>
          <EditItemTemplate>
            <asp:CheckBox runat="server" id="edit_Contract" Checked='<%# DataBinder.Eval(Container.DataItem, "contract") %>'/>
          </EditItemTemplate>
        </asp:TemplateColumn>
      </Columns>

    </ASP:DataGrid>

  </form>

</body>
</html>