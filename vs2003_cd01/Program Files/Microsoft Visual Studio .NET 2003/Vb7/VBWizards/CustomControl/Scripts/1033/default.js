//
// Copyright (c) Microsoft Corporation 2001-2002. All rights reserved.
//

function OnFinish(selProj, selObj)
{
    var oldSuppressUIValue = true;
    try
    {
        oldSuppressUIValue = dte.SuppressUI;
        var bSilent = wizard.FindSymbol("SILENT_WIZARD");
        dte.SuppressUI = bSilent;

        var strItemName = wizard.FindSymbol("ITEM_NAME");
        var strTemplatePath = wizard.FindSymbol("TEMPLATES_PATH");
        var strTemplateFile = strTemplatePath + "\\CustomControl.vb"; 

        var VSProject = selProj.Object;
        var refs = VSProject.References;
        var ref;
        ref = refs.Add("System");
        ref = refs.Add("System.Data");
        ref = refs.Add("System.Drawing");
        ref = refs.Add("System.Windows.Forms");

        var item = AddFileToVSProject(strItemName, selProj, selObj, strTemplateFile, true);
        if( item )
        {
            item.Properties("SubType").Value = "UserControl";
            var editor = item.Open(vsViewKindPrimary);
            editor.Visible = true;
        }
        
        return 0;
    }
    catch(e)
    {   
        switch(e.number)
        {
        case -2147221492 /* OLE_E_PROMPTSAVECANCELLED */ :
            return -2147221492;

        case -2147024816 /* FILE_ALREADY_EXISTS */ :
        case -2147213313 /* VS_E_WIZARDBACKBUTTONPRESS */ :
            return -2147213313;

        default:
            ReportError(e.description);
            return -2147213313;
        }
    }
    finally
    {
        dte.SuppressUI = oldSuppressUIValue;
    }
}