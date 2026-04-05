function CMyDocument::Index_Addendum(title, params, entries, extras)
{
	local j = 0, n = entries.len();
	local markers = ArrayOfMarkers(n);

	UpdateBaseFormat({FontSize = 68, MarginLeft = 200});

	local t = Run() + H1(title + "\r", 1);

	for (local i = 0; i < n; i++)
	{
		local entry = entries[i];
		j++;

		if (entry.Level == 0) { t + {MarginLeft = 0, Text = entry.Title + "\r"}; j = 0; }
		else t + Bullet({Text = "" + j + ")", Type = DE_BULLET_CUSTOMTEXT}) + markers[i] + " (Page " + entry.DestPage + ", Textflow " + entry.DestImg + ", Pos " + entry.DestPos + ")\r";
	}

	local img = TextArea(params.Page, params.X, params.Y, params.W, params.H, t);

	InsertEntries(img, markers, entries, [{FontSize = 68, Bold = 0, Effect = 0}]);
}


function CMyDocument::ExecUnit(params)
{
	params.W = (params.W - 100) / 2;

	MakeIndex(Index_Addendum, "Index of Acronyms", params, {Kind = 1, LevelShift = 0});

	params.X += params.W + 100;

	MakeIndex(Index_Addendum, "Index of Endnotes", params, {Kind = 2, LevelShift = 0});
}
