<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="Graphics">
	<cfinvokeargument name="ThisPath" value="utilities">
	<cfinvokeargument name="ThisFileName" value="graphics">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllPhotos">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="Photos">
	<cfinvokeargument name="orderbystatement" value=" order by PhotoPageName">
</cfinvoke>
<cfinvoke component="#Application.WebSitePath#.utilities.XMLHandler" 
	method="GetXMLRecords" returnvariable="AllGalleries">
	<cfinvokeargument name="ThisPath" value="files">
	<cfinvokeargument name="ThisFileName" value="photoCategories">
</cfinvoke>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Image Properties</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="robots" content="noindex, nofollow" />
	<script src="common/fck_dialog_common.js" type="text/javascript"></script>
	<script src="fck_image/fck_image.js" type="text/javascript"></script>
	<link href="common/fck_dialog_common.css" rel="stylesheet" type="text/css" />
</head>
<body scroll="no" style="overflow: hidden">
	<div id="divInfo">
		<table cellspacing="1" cellpadding="1" border="0" width="100%" height="100%">
			<tr>
				<td>
					<table cellspacing="0" cellpadding="0" width="100%" border="0">
						<tr>
							<td width="100%">
								<span fcklang="DlgImgURL">Enter URL or select from the list</span>
							</td>
							<td id="tdBrowse" style="display: none" nowrap="nowrap" rowspan="2">
								&nbsp;
								<input id="btnBrowse" onClick="BrowseServer();" type="button" value="Browse Server"
									fcklang="DlgBtnBrowseServer" />
							</td>
						</tr>
						<tr>
							<td valign="top">
								<input id="txtUrl" style="width: 100%" type="text" onBlur="UpdatePreview();" />
							</td>
						</tr>
						<tr>
							<td valign="top">
								<select id="cboURL" name="cboURL" onChange="UpdatePreview2(this.value);">
									<option value="#application.returnpath#/images/b.gif">---Select---</option>
									<cfoutput query="graphics">
										<option value="#application.returnpath#/#filename#">#Description#
									</cfoutput>
									<Cfset thecategory=0>
									<option>------- Gallery Photos <cfoutput>#allphotos.recordcount#</cfoutput>-------</option>
									<cfoutput query="AllPhotos">
										<cfif thecategory neq #photopagename#>
											<cfquery name="getCategory" dbtype="query">
												select categoryid,CatDescription from AllGalleries where categoryid='#PhotoPageName#'
											</cfquery>
											<Cfif #getCategory.recordcount# gt 0>
												<cfset thecategory=#getcategory.categoryid#>
												<option value="0">---- #Getcategory.catdescription# ---</option>
											</Cfif>
										</cfif>
										<option value="#application.returnpath#/#ThePhoto#">#PhotoDescription#
									</cfoutput>
								</select>
								
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<span fcklang="DlgImgAlt">Short Description</span><br />
					<input id="txtAlt" style="width: 100%" type="text" /><br />
				</td>
			</tr>
			<tr height="100%">
				<td valign="top">
					<table cellspacing="0" cellpadding="0" width="100%" border="0" height="100%">
						<tr>
							<td valign="top">
								<br />
								<table cellspacing="0" cellpadding="0" border="0">
									<tr>
										<td nowrap="nowrap">
											<span fcklang="DlgImgWidth">Width</span>&nbsp;</td>
										<td>
											<input type="text" size="3" id="txtWidth" onKeyUp="OnSizeChanged('Width',this.value);" /></td>
										<td rowspan="2">
											<div id="btnLockSizes" class="BtnLocked" onMouseOver="this.className = (bLockRatio ? 'BtnLocked' : 'BtnUnlocked' ) + ' BtnOver';"
												onmouseout="this.className = (bLockRatio ? 'BtnLocked' : 'BtnUnlocked' );" title="Lock Sizes"
												onclick="SwitchLock(this);">
											</div>
										</td>
										<td rowspan="2">
											<div id="btnResetSize" class="BtnReset" onMouseOver="this.className='BtnReset BtnOver';"
												onmouseout="this.className='BtnReset';" title="Reset Size" onClick="ResetSizes();">
											</div>
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap">
											<span fcklang="DlgImgHeight">Height</span>&nbsp;</td>
										<td>
											<input type="text" size="3" id="txtHeight" onKeyUp="OnSizeChanged('Height',this.value);" /></td>
									</tr>
								</table>
								<br />
								<table cellspacing="0" cellpadding="0" border="0">
									<tr>
										<td nowrap="nowrap">
											<span fcklang="DlgImgBorder">Border</span>&nbsp;</td>
										<td>
											<input type="text" size="2" value="" id="txtBorder" onKeyUp="UpdatePreview();" /></td>
									</tr>
									<tr>
										<td nowrap="nowrap">
											<span fcklang="DlgImgHSpace">HSpace</span>&nbsp;</td>
										<td>
											<input type="text" size="2" id="txtHSpace" onKeyUp="UpdatePreview();" /></td>
									</tr>
									<tr>
										<td nowrap="nowrap">
											<span fcklang="DlgImgVSpace">VSpace</span>&nbsp;</td>
										<td>
											<input type="text" size="2" id="txtVSpace" onKeyUp="UpdatePreview();" /></td>
									</tr>
									<tr>
										<td nowrap="nowrap">
											<span fcklang="DlgImgAlign">Align</span>&nbsp;</td>
										<td>
											<select id="cmbAlign" onChange="UpdatePreview();">
												<option value="" selected="selected"></option>
												<option fcklang="DlgImgAlignLeft" value="left">Left</option>
												<option fcklang="DlgImgAlignAbsBottom" value="absBottom">Abs Bottom</option>
												<option fcklang="DlgImgAlignAbsMiddle" value="absMiddle">Abs Middle</option>
												<option fcklang="DlgImgAlignBaseline" value="baseline">Baseline</option>
												<option fcklang="DlgImgAlignBottom" value="bottom">Bottom</option>
												<option fcklang="DlgImgAlignMiddle" value="middle">Middle</option>
												<option fcklang="DlgImgAlignRight" value="right">Right</option>
												<option fcklang="DlgImgAlignTextTop" value="textTop">Text Top</option>
												<option fcklang="DlgImgAlignTop" value="top">Top</option>
											</select>
										</td>
									</tr>
								</table>
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;</td>
							<td width="100%" valign="top">
								<table cellpadding="0" cellspacing="0" width="100%" style="table-layout: fixed">
									<tr>
										<td>
											<span fcklang="DlgImgPreview">Preview</span></td>
									</tr>
									<tr>
										<td valign="top">
											<iframe class="ImagePreviewArea" src="fck_image/fck_image_preview.html" frameborder="0"
												marginheight="0" marginwidth="0"></iframe>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<div id="divUpload" style="display: none">
		<form id="frmUpload" method="post" target="UploadWindow" enctype="multipart/form-data"
			action="" onSubmit="return CheckUpload();">
			<span fcklang="DlgLnkUpload">Upload</span><br />
			<input id="txtUploadFile" style="width: 100%" type="file" size="40" name="NewFile" /><br />
			<br />
			<input id="btnUpload" type="submit" value="Send it to the Server" fcklang="DlgLnkBtnUpload" />
			<iframe name="UploadWindow" style="display: none" src="../fckblank.html"></iframe>
		</form>
	</div>
	<div id="divLink" style="display: none">
		<table cellspacing="1" cellpadding="1" border="0" width="100%">
			<tr>
				<td>
					<div>
						<span fcklang="DlgLnkURL">Enter URL or select from the list</span><br />
						<input id="txtLnkUrl" style="width: 100%" type="text" onBlur="UpdatePreview();" />
					</div>
					<div id="divLnkBrowseServer" align="right">
						<input type="button" value="Browse Server" fcklang="DlgBtnBrowseServer" onClick="LnkBrowseServer();" />
					</div>
					<div>
						<span fcklang="DlgLnkTarget">Target</span><br />
						<select id="cmbLnkTarget">
							<option value="" fcklang="DlgGenNotSet" selected="selected">&lt;not set&gt;</option>
							<option value="_blank" fcklang="DlgLnkTargetBlank">New Window (_blank)</option>
							<option value="_top" fcklang="DlgLnkTargetTop">Topmost Window (_top)</option>
							<option value="_self" fcklang="DlgLnkTargetSelf">Same Window (_self)</option>
							<option value="_parent" fcklang="DlgLnkTargetParent">Parent Window (_parent)</option>
						</select>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<div id="divAdvanced" style="display: none">
		<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
			<tr>
				<td valign="top" width="50%">
					<span fcklang="DlgGenId">Id</span><br />
					<input id="txtAttId" style="width: 100%" type="text" />
				</td>
				<td width="1">
					&nbsp;&nbsp;</td>
				<td valign="top">
					<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
						<tr>
							<td width="60%">
								<span fcklang="DlgGenLangDir">Language Direction</span><br />
								<select id="cmbAttLangDir" style="width: 100%">
									<option value="" fcklang="DlgGenNotSet" selected="selected">&lt;not set&gt;</option>
									<option value="ltr" fcklang="DlgGenLangDirLtr">Left to Right (LTR)</option>
									<option value="rtl" fcklang="DlgGenLangDirRtl">Right to Left (RTL)</option>
								</select>
							</td>
							<td width="1%">
								&nbsp;&nbsp;</td>
							<td nowrap="nowrap">
								<span fcklang="DlgGenLangCode">Language Code</span><br />
								<input id="txtAttLangCode" style="width: 100%" type="text" />&nbsp;
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;
					</td>
			</tr>
			<tr>
				<td colspan="3">
					<span fcklang="DlgGenLongDescr">Long Description URL</span><br />
					<input id="txtLongDesc" style="width: 100%" type="text" />
				</td>
			</tr>
			<tr>
				<td colspan="3">&nbsp;
					</td>
			</tr>
			<tr>
				<td valign="top">
					<span fcklang="DlgGenClass">Stylesheet Classes</span><br />
					<input id="txtAttClasses" style="width: 100%" type="text" />
				</td>
				<td>
				</td>
				<td valign="top">
					&nbsp;<span fcklang="DlgGenTitle">Advisory Title</span><br />
					<input id="txtAttTitle" style="width: 100%" type="text" />
				</td>
			</tr>
		</table>
		<span fcklang="DlgGenStyle">Style</span><br />
		<input id="txtAttStyle" style="width: 100%" type="text" />
	</div>
</body>
</html>
