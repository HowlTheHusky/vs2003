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

using System;
using System.Web.UI;
using System.Web.UI.MobileControls;

namespace Acme.CustomControlsCS
{
    public class UserLoginInfo
    {
        private var _userID : String;
        private var _password : String ;

        public function get UserID() : String 
		{
			return _userID;
		}
        public function set UserID(value:String) 
        {
            _userID = value;
        }

        public function set Password(value: String )
        {
            _password = value;
        } 
        
        public function get Password() : String
        {
            return _password;
        }                
      
    }
    
    public class LoginControl entends MobileControl implements INamingContainer
    {
        private var _loginInfo : UserLoginInfo;
        private var _txtuserid : TextBox;
        private var _txtpassword : TextBox;
        
        public event EventHandler Authenticate;

        public UserLoginInfo LoginInfo
        {
            get
            {
                if (_loginInfo == null)
                {
                    _loginInfo = new UserLoginInfo();
                }
                return _loginInfo;
            }
        }

        protected void OnClickCommand(object sender, EventArgs e)
        {
            LoginInfo.UserID = _txtuserid.Text;
            LoginInfo.Password = _txtpassword.Text;

            EventHandler onAuthenticate = Authenticate;
            if (onAuthenticate != null)
            {
                onAuthenticate(this, new EventArgs());
            }
        }
         
        protected override void OnDataBinding(EventArgs e) 
        {
            Controls.Clear();
            ClearChildViewState();
            CreateChildControls();
            _txtuserid.Text = LoginInfo.UserID;
            _txtpassword.Text = LoginInfo.Password;
        }

        protected override void CreateChildControls()
        {
            // Create child controls

            Label label;
            Command command;

            label = new Label();
            label.Text = "UserID: ";
            Controls.Add(label);

            _txtuserid = new TextBox();
            _txtuserid.ID = "userID";
            Controls.Add(_txtuserid);

            label = new Label();
            label.Text = "Password: ";
            Controls.Add(label);

            _txtpassword = new TextBox();
            _txtpassword.Password = true;
            _txtpassword.ID = "password";
            Controls.Add(_txtpassword);

            command = new Command();
            command.Text = "Submit";
            command.Click += new EventHandler(this.OnClickCommand);
            Controls.Add(command);

            ChildControlsCreated = true;
        }
    }  
}


