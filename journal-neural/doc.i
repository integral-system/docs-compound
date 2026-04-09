class CMyPageSize extends CDTPageSize
{
	//function GetWidth() { return 5100; /* 612 pts x factor 8.3333 = 5100 */ }
	//function GetHeight() { return 6600; /* 792 pts x factor 8.3333 = 6600 */ }

	// For splash screen (export at 12.07%)
	//function GetWidth() { return 5100; /* 612 pts x factor 8.3333 = 5100 */ }
	//function GetHeight() { return 7153; /* 792 pts x factor 8.3333 = 6600 */ }

	function GetBleedL() { return 80; }
	function GetBleedR() { return 80; }
	function GetBleedT() { return 80; }
	function GetBleedB() { return 80; }

	function GetMarginL() { return 220; }
	function GetMarginR() { return 220; }
	function GetMarginT() { return 220; }
	function GetMarginB() { return 220; }
}


class CMyDocument extends CDTDocumentBasic
{
	PageSize = CMyPageSize();

	LastPage = 18;

	TitlePrimary = "INTEGRAL";
	TitleSecondary = "Journal of Neural Networks And Applications";
	TitleIssue = "APRIL 2019 VOL 2 NO 1";

	ContentUnits =
	[
		//[true, -1, "doc-common.i"],
		[true,  3, "doc-editorial.i"],
		[true,  4, "doc-article_1.i"],
		[true,  9, "doc-article_2.i"],
		[true, 12, "doc-article_3.i"],
		[true,  0, "doc-title.i"],
		[true,  1, "doc-toc.i"],
		[true,  2, "doc-pagenum.i"],
		[true, 19, "doc-addendum.i"]
	];

	constructor()
	{
		//base.constructor(fontmap, construct_flags, internal_flags, index_mask, auto_reflow, final_cleanup);
		base.constructor("fontmaps/stix-1.inf");

		/*Index_Acronyms*/ Index.Dictionary =
		{
			"ConvNet"  : "Convolutional Network",
			"ConvNets" : "Convolutional Networks",
			"LASER"    : "Light Amplification by Stimulated Emission of Radiation",
			"E.T."     : "Extra Terrestrial",
			"TS"       : "Top Secret"
		};

		SetMathParams({Autoformat = 1, Placeholders = 0});
	}
}


function CMyDocument::H1ToIndex(s, cpos = 0, bold = 0)
{
	local run = Run(s); run * {Align = DE_ALIGN_CENTER, FontSize = 120, Bold = bold};
	//local run = Run(s);
	/*if (typeof s == "string")*/
	AddToIndex(Index, 0, 1, run, cpos);
	return run;

	//if (typeof s == "string") AddToIndex(Index_Contents, 1, s);
	//return s;
}

function CMyDocument::H2ToIndex(s, cpos = 0, unused = 0)
{
	local run = Run(s); run * {Underline = 1, Align = DE_ALIGN_CENTER, FontSize = 100};
	/*if (typeof s == "string")*/
	AddToIndex(Index, 0, 2, run, cpos);
	return run

	//if (typeof s == "string") { AddToIndex(Index_Contents, 2, s); /*return {Text = s, Underline = 1, Align = DE_ALIGN_CENTER, FontSize = 100};*/ }
	//return s;
	//run.SetMarker(2, ArticleCounter);
	//return run * {Underline = 1, Align = DE_ALIGN_CENTER, FontSize = 100};
}

function CMyDocument::H3ToIndex(s, cpos = 0, unused = 0)
{
	local run = Run(s); run * {BoldItalic = 1, FontSize = 84};
	/*if (typeof s == "string")*/ 
	AddToIndex(Index, 0, 3, run, cpos);
	return run;

	//if (typeof s == "string") { AddToIndex(Index_Contents, 3, s); /*return {Text = s, BoldItalic = 1, FontSize = 84};*/ }
	//return s;
	//run.SetMarker(3, ArticleCounter);
	//return run * {BoldItalic = 1, FontSize = 84};
}

function CMyDocument::AbbrToIndex(abbr, cpos = 0, style_id = 0)
{
	local def = null; if (abbr in Index.Dictionary) def = Index.Dictionary[abbr];
	local s = abbr, s_index = abbr;

	if (def != null)
	{
		s_index = abbr + " = " + def;
		if (style_id > 2) s = def + " (" + abbr + ")"; else if (style_id > 1) s = abbr + " (" + def + ")"; else if (style_id > 0) s = def;
	}

	AddToIndex(Index, 1, 1, s_index, cpos);

	local run = Run(s); run * {Underline = 1};
	return run;
}

function CMyDocument::EndnoteToIndex(s, cpos = 0, unused = 0)
{
	AddToIndex(Index, 2, 1, s, cpos);
	return RunSup("[" + Index.KindCounter[2] + "]");
	//return RunSup("[" + Index.RefCounter + "]");
	//local run = Run(Index.RefCounter); run * {FontSize = 55};
	//return run;
	//return "" + Index.RefCounter;
}


function CMyDocument::H1(s, bold = 0) { return CDTDocMarker(this, H1ToIndex, s, bold); }
function CMyDocument::H2(s, unused = 0) { return CDTDocMarker(this, H2ToIndex, s, unused); }
function CMyDocument::H3(s, unused = 0) { return CDTDocMarker(this, H3ToIndex, s, unused); }
function CMyDocument::Abbr(s, style_id = 0) { return CDTDocMarker(this, AbbrToIndex, s, style_id); }
function CMyDocument::Endnote(s, unused = 0) { return CDTDocMarker(this, EndnoteToIndex, s, unused); }
function CMyDocument::Stress(s) { return {Text = s, BoldItalic = 1}; }
function CMyDocument::URL(s) { return {Text = s, Underline = 1}; }
function CMyDocument::Code(s) { return {Text = s, FontUniqueID = "F0013_CMTYPW_NS0"}; }
function CMyDocument::Math(s) { return {Text = s, Italic = 1}; }
function CMyDocument::M1(s) { return s; }
function CMyDocument::M2(s) { return s; }
function CMyDocument::M3(s) { return s; }
//function CMyDocument::Comment(s) { return ""; }

function CMyDocument::Figure(filename, scale, caption = null)
{
	local img = Pict({RunFormat = {Align = DE_ALIGN_CENTER}, NewlineFlag = 2, SizeScale = scale * 0.78, Src = DocRoot + "assets/" + filename, BaseAlign = DE_BASEALIGN_MIDDLE});

	if (typeof caption == "CDTDocTextRun") { return img + caption * {Align = DE_ALIGN_CENTER, Italic = 1, FontSize = 60}; }
	else if (caption != null && caption != "") { return img + {Text = caption, Align = DE_ALIGN_CENTER, Italic = 1, FontSize = 60}; }

	return img;
}
