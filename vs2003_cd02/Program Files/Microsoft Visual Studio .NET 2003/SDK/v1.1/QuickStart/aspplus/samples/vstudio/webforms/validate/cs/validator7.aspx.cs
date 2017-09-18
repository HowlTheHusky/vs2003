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

namespace Validate.Cs
{
    using System;
    using System.Collections;
    using System.ComponentModel;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.SessionState;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;

    /// <summary>
    ///    Summary description for validator7.
    /// </summary>
    public class validator7 : System.Web.UI.Page
    {
        protected internal System.Web.UI.WebControls.TextBox TextBox1;
        protected internal System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator1;
        protected internal System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator1;
        protected internal System.Web.UI.WebControls.TextBox TextBox2;
        protected internal System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator2;
        protected internal System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator2;
        protected internal System.Web.UI.WebControls.TextBox TextBox3;
        protected internal System.Web.UI.WebControls.RequiredFieldValidator RequiredFieldValidator3;
        protected internal System.Web.UI.WebControls.RegularExpressionValidator RegularExpressionValidator3;
        protected internal System.Web.UI.WebControls.Button ValidateBtn;
        protected internal System.Web.UI.WebControls.Label lblOutput;

	    public validator7()
	    {
    	    Page.Init += new System.EventHandler(Page_Init);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //
                // Evals true first time browser hits the page
                //
            }
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
	        this.Load += new System.EventHandler (this.Page_Load);
            ValidateBtn.Click += new System.EventHandler (this.ValidateBtn_Click);

        }

        void ValidateBtn_Click(object sender, System.EventArgs e) {
            if (Page.IsValid) {
                lblOutput.Text = "Page is Valid!";
            } else {
                lblOutput.Text = "Page is Not Valid! :-(";
            }
        }
    }
}