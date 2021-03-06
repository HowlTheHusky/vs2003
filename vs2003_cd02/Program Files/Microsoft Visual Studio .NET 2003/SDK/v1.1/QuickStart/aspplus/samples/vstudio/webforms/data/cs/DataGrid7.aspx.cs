//-----------------------------------------------------------------------
//  This file is part of the Microsoft .NET SDK Code Samples.
// 
//  Copyright (C) Microsoft Corporation.  All rights reserved.
// 
//This source code is intended only as a supplement to Microsoft
//Development Tools and/or on-line documentation.  See these other
//materials for detailed information regarding Microsoft code samples.
// 
//THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
//KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
//PARTICULAR PURPOSE.
//-----------------------------------------------------------------------

namespace Data.Cs
{
	using Acme;
    using System;
    using System.Collections;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;
    using System.Drawing;
    using System.Globalization;
    using System.Web;
    using System.Web.SessionState;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;

    /// <summary>
    ///    Summary description for DataGrid7.
    /// </summary>
    public class DataGrid7 : System.Web.UI.Page
    {
		protected System.Web.UI.WebControls.DataGrid MyDataGrid;
		protected System.Web.UI.HtmlControls.HtmlGenericControl Message;
		protected System.Web.UI.HtmlControls.HtmlGenericControl P1;
		private System.ComponentModel.IContainer components;
		protected SqlConnection myConnection;

	
	public DataGrid7()
	{
	    Page.Init += new System.EventHandler(Page_Init);
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Windows Form Designer.
            //
            InitializeComponent();
        }

        /// <summary>
        ///    Required method for Designer support - do not modify
        ///    the contents of this method with the code editor.
        /// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.Load += new System.EventHandler(this.Page_Load);

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

			String[] cols = {"@Id","@LName","@FName","@Phone","@Address","@City","@State","@Zip","@Contract"};
			Message.InnerHtml = "";

			int numCols = E.Item.Cells.Count;
			for (int i=2; i<numCols-1; i++) //skip first, second and last column
			{
				String colvalue =((System.Web.UI.WebControls.TextBox)
					E.Item.Cells[i].Controls[0]).Text;

				// check for invalid values
				switch (cols[i-1])
				{
					case "@LName":
						if ( !InputValidator.IsValidAnsiName(colvalue) )
						{
							Message.InnerHtml += "ERROR: Last Name - " + InputValidator.AnsiNameErrorString + "<br>";
						}
						break;
					case "@FName":
						if ( !InputValidator.IsValidAnsiName(colvalue) )
						{
							Message.InnerHtml += "ERROR: First Name - " + InputValidator.AnsiNameErrorString + "<br>";
						}
						break;
					case "@Phone":
						if ( !InputValidator.IsValidAnsiPhoneNumber(colvalue) )
						{
							Message.InnerHtml += "ERROR: Phone - " + InputValidator.AnsiPhoneErrorString + "<br>";
						}
						break;
					case "@Address":
						if ( !InputValidator.IsValidAnsiAddress(colvalue) )
						{
							Message.InnerHtml += "ERROR: Address - " + InputValidator.AnsiAddressErrorString + "<br>";
						}
						break;
					case "@City":
						if ( !InputValidator.IsValidAnsiCityOrState(colvalue) )
						{
							Message.InnerHtml += "ERROR: City - " + InputValidator.AnsiCityStateErrorString + "<br>";
						}
						break;
					case "@State":
						if ( !InputValidator.IsValidAnsiTwoCharacterState(colvalue) )
						{
							Message.InnerHtml += "ERROR: State - " + InputValidator.AnsiTwoCharacterStateErrorString + "<br>";
						}
						break;
					case "@Zip":
						if ( !InputValidator.IsValidFiveDigitZipCode(colvalue) )
						{
							Message.InnerHtml += "ERROR: Zip Code - " + InputValidator.AnsiBasicZipCodeErrorString + "<br>";
						}
						break;
				}

				// check for null values in required fields
				if (i<6 && colvalue == "")
				{
					Message.InnerHtml += "ERROR: Null values not allowed for " + cols[i-1] + "<br>";
				}

				myCommand.Parameters[cols[i-1]].Value = colvalue;
			}

			if ( Message.InnerHtml != "" )
			{
				Message.Style["color"] = "red";
				return;
			}

			//append last row, converting true/false values to 0/1
			if (String.Compare(((TextBox)E.Item.Cells[numCols-1].Controls[0]).Text, "true", true, CultureInfo.InvariantCulture)==0)
				myCommand.Parameters["@Contract"].Value =  "1"; 
			else
				myCommand.Parameters["@Contract"].Value =  "0"; 

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

		public void BindGrid() 
		{
			SqlDataAdapter myCommand = new SqlDataAdapter("select * from Authors", myConnection);

			DataSet ds = new DataSet();
			myCommand.Fill(ds, "Authors");

			MyDataGrid.DataSource=ds.Tables["Authors"].DefaultView;
			MyDataGrid.DataBind();
		}

		private void Page_Load(object sender, System.EventArgs e)
		{
			myConnection = new SqlConnection("server=(local)\\NetSDK;database=pubs;Integrated Security=SSPI");

			if (!IsPostBack)
				BindGrid();
		}
		private void Page_UnLoad(object sender, System.EventArgs e)
		{
			myConnection.Close();
		}
    }
}
