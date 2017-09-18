'-----------------------------------------------------------------------
'  This file is part of the Microsoft .NET SDK Code Samples.
' 
'  Copyright (C) Microsoft Corporation.  All rights reserved.
' 
'This source code is intended only as a supplement to Microsoft
'Development Tools and/or on-line documentation.  See these other
'materials for detailed information regarding Microsoft code samples.
' 
'THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
'KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
'IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
'PARTICULAR PURPOSE.
'-----------------------------------------------------------------------

Imports System
Imports System.Net
Imports System.IO
Imports System.Text

Namespace Client
    Public class ClientGETssl

        Public Shared bShow As Boolean
        Public Shared Sub Main()

            Dim args As String ()
            args = Environment.GetCommandLineArgs()

            If (args.Length < 2)
                showusage()
            Else
                If (args.Length > 2)
                    bShow = false
                Else
                    bShow = true
                End If
                getPage(args(1))
            End If

            Console.WriteLine()
            Console.WriteLine("Press Enter to continue...")
            Console.ReadLine()
        End Sub

        public Shared Sub showusage()
            Console.WriteLine("Attempts to GET a URL")
            Console.WriteLine()
            Console.WriteLine("Usage:")
            Console.WriteLine("ClientGETwithssl URL")
            Console.WriteLine()
            Console.WriteLine("Examples:")
            Console.WriteLine("ClientGETwithssl https://www.microsoft.com/net/")
        End Sub

        public Shared Sub getPage(url As String)
            Try
                Dim req As WebRequest
                Dim result As WebResponse
                Dim ReceiveStream As Stream
                Dim encode As Encoding
                Dim sr As StreamReader

                req = WebRequest.Create(url)
                result = req.GetResponse()
                ReceiveStream = result.GetResponseStream()
            	encode = System.Text.Encoding.GetEncoding("utf-8")
            	sr = new StreamReader( ReceiveStream, encode )

            	Console.WriteLine()
                Console.WriteLine("Response stream received")
                If bShow
                    Dim read(256) As Char
            	    Dim count As Integer = sr.Read( read, 0, 256 )

                    Console.WriteLine("HTML...")
                    Console.WriteLine()
                    Do While count > 0
        		        Dim str As String = new String(read, 0, count)
                        Console.Write(str)
                        count = sr.Read(read, 0, 256)
                    Loop
                    Console.WriteLine("")
                End If
            Catch Exc As Exception
                Console.WriteLine()
                Console.WriteLine("The request URI could not be found or was malformed")
            End Try
        End Sub
    End Class
End Namespace
