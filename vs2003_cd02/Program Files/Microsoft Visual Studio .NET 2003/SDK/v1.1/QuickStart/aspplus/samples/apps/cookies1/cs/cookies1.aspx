<html>

  <script language="C#" runat="server">

      void Page_Load(Object sender, EventArgs E) {
      
        if (Request.Cookies["preferences1"] == null) {
        
          HttpCookie cookie = new HttpCookie("preferences1");
          cookie.Values.Add("ForeColor","black");
          cookie.Values.Add("BackColor","beige");
          cookie.Values.Add("LinkColor","blue");
          cookie.Values.Add("FontSize","8pt");
          cookie.Values.Add("FontName","Verdana");
          Response.Cookies.Add(cookie);
        }
      }

      protected String GetStyle(String key) {
      
        HttpCookie cookie = Request.Cookies["preferences1"];
     
        if (cookie != null) {
        
          switch (key) {
          
            case "ForeColor" : 
              return cookie.Values["ForeColor"]; 
              break;
              
            case "BackColor" : 
              return cookie.Values["BackColor"]; 
              break;
              
            case "LinkColor" : 
              return cookie.Values["LinkColor"]; 
              break;
              
            case "FontSize" : 
              return cookie.Values["FontSize"]; 
              break;
              
            case "FontName" : 
              return cookie.Values["FontName"]; 
              break;
          }
        }
        
        return "";
      }

  </script>

  <style>

    body {
      font: <%=GetStyle("FontSize")%> <%=GetStyle("FontName")%>;
      background-color: <%=GetStyle("BackColor")%>;
    }

    a { color: <%=GetStyle("LinkColor")%> }

  </style>

  <body style="color:<%=GetStyle("ForeColor")%>">

    <h3><font face="Verdana">Storing Volatile Data with Client-Side Cookies</font></h3>

    <b><a href="customize.aspx">Customize This Page</a></b><p>

    Imagine some content here ...<br>
    Imagine some content here ...<br>
    Imagine some content here ...<br>
    Imagine some content here ...<br>
    Imagine some content here ...<br>
    Imagine some content here ...<br>
    Imagine some content here ...<br>
    Imagine some content here ...<br>

  </body>
  
</html>
