function CMyDocument::ExecUnit(params)
{
	local p = params.Page, p2 = p + 1;
	local x = params.X;
	local y = params.Y;
	local w = params.W;
	local h = params.H;

	local x2 = x + 200;
	local w2 = w - 400;
	local y2 = y + h - 500;

	local pw = PageSize.GetWidth();
	local ph = PageSize.GetHeight();

	/* Cover page - black background rectangle */

	local o_color = O("Color") + S(pdRGBT, "00000000");
	local o_rect = O("Rect") + L(pdBodyPtr, o_color) + I(pdDw, pw) + I(pdDh, ph);

	o_rect.Pin(p, 0, 0, pdDrawRect);

	/* Cover page - main image and text elements */

	UpdateBaseFormat({FontUniqueID = "F0010_CMBRGH_cS0"});

	Pict({Page = p, X = x2, Y = 1580, W = w2, H = 4100, Src = GetAssetDir() + "cover.jpg"}, true);

	local img_0 = TextArea(p, x2, 200, w2, 0, {Text = "DEMO DOCUMENT", FontSize = 100, Color = "AAAAAA00"});

	TextArea(p, x2, 200, w2, 0, {Text = TitleIssue, FontSize = 100, Align = DE_ALIGN_RIGHT, Color = "F5EDC600"});

	local img_1 = TextArea(p, x2, 349, w2, 0, {Text = TitlePrimary, FontWidth = 760, FontHeight = 900, Align = DE_ALIGN_CENTER, Color = "FFFFFF00", OutlineColor = "78B6FA00", OutlineThickness = 1500}, {RowType = DE_ROW_TYPO});

	TextArea(p, x2, 1320, w2, 0, {Text = TitleSecondary, FontSize = 190, Align = DE_ALIGN_CENTER, Color = "FFFFFF00", RowboundMarginTop = -20, RowboundMarginBottom = -20, RowboundColor = "508EFA00"}, {RowType = DE_ROW_WIN});

	local style_item_a = {Color = "F5EDC600", FontSize = 125, FontUniqueID = "F0011_CMCONC_SS0"};
	local style_item_b = {Color = "FFFFFF00", FontSize = 125, FontUniqueID = "F0011_CMCONC_SS0"};
	local style_pg_num = {Color = "78B6FA00", FontSize = 120, FontUniqueID = "F0011_CMCONC_SS0"};

	local featured_items =
	[
		Run("Convolutional Networks and Applications in Vision") * style_item_a + Run(" p.4") * style_pg_num,
		Run("Deep Taylor Decomposition of Neural Network") * style_item_b + Run(" p.9") * style_pg_num,
		Run("Image Denoising: Can Plain Neural Networks Compete With BM3D?") * style_item_a + Run(" p.12") * style_pg_num
	];

	foreach (item in featured_items)
	{
		TextArea(p, x2, y2, w2, 0, item);
		y2 += 150;
	}

	/* Inside page (p2) */

	VirtualCopy(img_0, p2, x2, 200);
	VirtualCopy(img_1, p2, x2, 349);

	TextArea(p2, x2, 200, w2, 0, {Text = TitleIssue, FontSize = 100, Align = DE_ALIGN_RIGHT});

	TextArea(p2, x2, 1360, w2, 0, {Text = TitleSecondary, FontSize = 130, Align = DE_ALIGN_CENTER, Color = "FFFFFF00", RowboundMarginTop = -20, RowboundMarginBottom = -20, RowboundColor = "508EFA00"}, {RowType = DE_ROW_WIN});

	Pict({Page = p2, X = x2, Y = 4700, W = w2, H = 1500, Src = GetAssetDir() + "neural-main.png"}, true);
}
