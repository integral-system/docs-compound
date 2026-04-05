function CMyDocument::Index_TOCShort(title, params, entries, extras)
{
	local n = entries.len();
	local markers = ArrayOfMarkers(n);

	UpdateBaseFormat({FontSize = 118, Align = DE_ALIGN_CENTER, FontUniqueID = "F0010_CMBRGH_cS0"});

	local t = Run() + {Text = title, Bold = 1, FontSize = 154} + Gap();

	for (local i = 0; i < n; i++)
	{
	 	t + {Text = entries[i].DestPage, Bold = 1, FontWidth = 240, FontHeight = 162, Color = "508EFA00"} + "\r" + markers[i] + Gap();
	}

	local img = TextArea(params.Page, params.X + 200, params.Y + 1400, params.W - 400, 2800, t, {VAlign = DE_VALIGN_MIDDLE, VAlignEnd = DE_VALIGN_MIDDLE});

	local entry_format = {FontSize = 118, Align = DE_ALIGN_CENTER, FontUniqueID = "F0010_CMBRGH_SS0", MarginLeft = 1150, MarginRight = 1150, Hyphenation = 0};

	InsertEntries(img, markers, entries, [entry_format]);
}


function CMyDocument::Index_TOCLong(title, params, entries, extras)
{
	local n = entries.len();
	local markers = ArrayOfMarkers(n);

	local base_format = {FontSize = 88, FontUniqueID = "F0010_CMBRGH_SS0", Align = DE_ALIGN_LEFT, Effect = 0, TabstopPositions = "65535", TabstopFlags = "2"};
	local entry_formats =
	[
		{MarginLeft = 0, Bold = 1, Color = "white", RowboundColor = "508EFA00", RowboundMarginLeft = -20, RowboundMarginRight = -20, RowboundMarginTop = -10, RowboundMarginBottom = -10},
		{MarginLeft = 100, Bold = 1, Color = "black"},
		{MarginLeft = 280, Bold = 0, Color = "black"}
	];

	UpdateFormat(entry_formats[0], base_format);
	UpdateFormat(entry_formats[1], base_format);
	UpdateFormat(entry_formats[2], base_format);

	UpdateBaseFormat(base_format);

	local t = Run() + {Text = title, Align = DE_ALIGN_CENTER, FontSize = 114, FontUniqueID = "F0011_STIX1__cS4"} + Gap();

	for (local i = 0; i < n; i++)
	{
		local level = entries[i].Level; if (level > 2) level = 2;

		ReplaceBaseFormat(entry_formats[level]);

		if (level > 1) t + Bullet({Type = DE_BULLET_CIRCSOLID});
		t + markers[i] + "\tp." + entries[i].DestPage + Gap({SpacingFactor = 460});
	}

	local img = TextArea(params.Page + 1, 950, params.Y, params.W - 1300, params.H, t, {VAlign = DE_VALIGN_MIDDLE, VAlignEnd = DE_VALIGN_MIDDLE, RowType = DE_ROW_WIN});

	InsertEntries(img, markers, entries, entry_formats);
}


function CMyDocument::ExecUnit(params)
{
	local p = params.Page;
	local x = params.X;
	local y = params.Y;
	local w = params.W;
	local h = params.H;

	local o_color = O("Color") + S(pdRGBT, "F5EDC688");
	local o_rect = O("Rect") + L(pdBodyPtr, o_color) + I(pdDw, w - 400) + I(pdDh, 2800);

	o_rect.Pin(p, x + 200, y + 1400, pdDrawRect);

	MakeIndex(Index_TOCShort, "In This Issue", params, {Depth = 1});

	Pict({Page = p + 1, W = 900, H = 6600, Quality = DE_QUALITY_HIGH, Src = GetAssetDir() + "neural-side-1.jpg"}, true);
	Pict({Page = p + 1, W = 900, H = 6600, Quality = DE_QUALITY_HIGH, Src = GetAssetDir() + "neural-side-2.jpg", X = w - 300}, true);

	MakeIndex(Index_TOCLong, "Detailed Table of Contents", params, {Depth = 3});
}
