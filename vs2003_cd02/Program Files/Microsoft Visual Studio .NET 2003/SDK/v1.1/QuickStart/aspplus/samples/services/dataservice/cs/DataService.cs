﻿//------------------------------------------------------------------------------
// <autogenerated>
//     This code was generated by a tool.
//     Runtime Version: 1.1.4322.573
//
//     Changes to this file may cause incorrect behavior and will be lost if 
//     the code is regenerated.
// </autogenerated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by wsdl, Version=1.1.4322.573.
// 
namespace DataService {
    using System.Diagnostics;
    using System.Xml.Serialization;
    using System;
    using System.Web.Services.Protocols;
    using System.ComponentModel;
    using System.Web.Services;
    
    
    /// <remarks/>
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="DataServiceSoap", Namespace="http://tempuri.org/")]
    public class DataService : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        /// <remarks/>
        public DataService() {
            this.Url = "http://localhost/quickstart/aspplus/samples/services/dataservice/CS/dataservice.a" +
"smx";
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/GetTitleAuthors", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet GetTitleAuthors() {
            object[] results = this.Invoke("GetTitleAuthors", new object[0]);
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginGetTitleAuthors(System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("GetTitleAuthors", new object[0], callback, asyncState);
        }
        
        /// <remarks/>
        public System.Data.DataSet EndGetTitleAuthors(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/PutTitleAuthors", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public int PutTitleAuthors(System.Data.DataSet ds) {
            object[] results = this.Invoke("PutTitleAuthors", new object[] {
                        ds});
            return ((int)(results[0]));
        }
        
        /// <remarks/>
        public System.IAsyncResult BeginPutTitleAuthors(System.Data.DataSet ds, System.AsyncCallback callback, object asyncState) {
            return this.BeginInvoke("PutTitleAuthors", new object[] {
                        ds}, callback, asyncState);
        }
        
        /// <remarks/>
        public int EndPutTitleAuthors(System.IAsyncResult asyncResult) {
            object[] results = this.EndInvoke(asyncResult);
            return ((int)(results[0]));
        }
    }
}