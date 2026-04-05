function CMyDocument::Sequence_Header(title, params, extras)
{
	return (Run("Page ") + Run(" " + extras.Index + " ") * { Color = "FFFFFF00", TypoframeColor = "508EFA00"} + extras.Separator) * params.format;
}


function CMyDocument::Sequence_Footer(title, params, extras)
{
	local title_a = " " + TitlePrimary + " ";
	local title_b = " — " + TitleSecondary + " — " + TitleIssue + extras.Separator;

	return (Run(title_a) * {Color = "FFFFFF00", TypoframeColor = "508EFA00"} + title_b) * params.format;
}


function CMyDocument::ExecUnit(params)
{
	local p = params.Page;
	local x = params.X;
	local y = params.Y;
	local w = params.W;
	local h = params.H;
	local n = LastPage - 1;

	params.format <- {Align = DE_ALIGN_CENTER, FontWidth = 80, FontHeight = 90, FontUniqueID = "F0010_CMBRGH_cS0"};

	local run_head = MakeSequence(Sequence_Header, "HEADER", params, {Length = n, Start = 2, Step = 1});
	local run_foot = MakeSequence(Sequence_Footer, "FOOTER", params, {Length = n});

	local text_options = {RowType = DE_ROW_WIN, VAlign = DE_VALIGN_MIDDLE, VAlignEnd = DE_VALIGN_MIDDLE};

	TextFlow(p, n, 1, 0, x, PageSize.GetBleedT(), w, y - PageSize.GetBleedT(), run_head, text_options);
	TextFlow(p, n, 1, 0, x, PageSize.GetHeight() - PageSize.GetBleedB() - PageSize.GetMarginB(), w, PageSize.GetMarginB(), run_foot, text_options);
}
