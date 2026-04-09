function CMyDocument::Article_Sidebar(title, params)
{
	UpdateBaseFormat({FontUniqueID = "F0010_CMBRGH_SS0", FontSize = 78, MarginLeft = 0, Align = DE_ALIGN_CENTER, Hyphenation = 1});

	/* text */

	local t = Run()

	+ {Bold = 1, Text = "DEMO DOCUMENT"}

	+ Gap({SpacingFactor = 1024})
	+ {Bold = 1, Text = "Journal of Neural Networks\rAnd Applications"}

	+ Gap({SpacingFactor = 1024})
	+ {Bold = 1, Text = TitleIssue}

	+ Gap({SpacingFactor = 1024})
	+ {Bold = 1, Color = "508EFA00", Text = "EDITORIAL\r"}
	+ "Editorial Director: " + {Bold = 1, Text = "Jim Olsen\r"}
	+ "Managing Director: " + {Bold = 1, Text = "Jaden Black\r"}
	+ "Design Director: " + {Bold = 1, Text = "Dejan Kovacevic"}

	+ Gap({SpacingFactor = 1024})
	+ {Bold = 1, Color = "508EFA00", Text = "INTEGRAL MEDIA\r"}
	+ "Vice President: " + {Bold = 1, Text = "Diana Victoriano\r"}
	+ "Senior Director: " + {Bold = 1, Text = "Jessy Santos\r"}
	+ "Director of Content: " + {Bold = 1, Text = "Raul Payette\r"}
	+ "Media Operations: " + {Bold = 1, Text = "Sammy Gonzalez"}

	+ Gap({SpacingFactor = 1024})
	+ {Bold = 1, Color = "508EFA00", Text = "INTEGRAL PUBLISHING\r"}
	+ "Research Editor: " + {Bold = 1, Text = "Zare Black\r"}
	+ "Senior Designer: " + {Bold = 1, Text = "Lucas Alexanderson\r"}
	+ "Art Production: " + {Bold = 1, Text = "Mira Cutie\r"}
	+ "Staff Writer: " + {Bold = 1, Text = "Ned Smith\r"}
	+ "Copy Editor: " + {Bold = 1, Text = "Alex Jovan\r"}
	+ "Photo Editor: " + {Bold = 1, Text = "Ella Love"}

	+ Gap({SpacingFactor = 1024})
	+ {Bold = 1, Color = "508EFA00", Text = "ADVERTISING SALES\r"}
	+ "Sales Account Executive: " + {Bold = 1, Text = "Dejan Kovacevic\r"}
	+ "dejan@integralsystems-magazine.com\r416-225-1212"

	+ Gap({SpacingFactor = 1024})
	+ {Bold = 1, Color = "508EFA00", Text = "Corporate Offices\r"}
	+ "Integral Systems Inc.\r810 Albert Lane\rToronto, Ontario, M3G 1T2\rCanada"

	+ Gap({SpacingFactor = 1024});

	UpdateBaseFormat({FontSize = 55, MarginLeft = 0, Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + "INTEGRAL (ISSN 12345-54321) is a sample magazine that demonstrates the capabilities of the INTEGRAL e-textbook publishing system. The INTEGRAL system is particularly suitable for scientific, technical and educational publications, even with hundreds of pages or complex objects. All articles in this sample magazine have been published with the permission of their respective authors. All rights reserved. Reproduction of any material from this issue in whole or part is prohibited without the prior written consent of Integral Systems Inc."

	+ Gap()
	+ "Views and opinions authors express are their own and do not necessarily represent the views and opinions of INTEGRAL magazine."

	+ Gap()
	+ "Subscription inquiries: Please write to INTEGRAL magazine, P.O. Box 12345, Toronto, Ontario, M3G 1T2; call toll free 800-123-4567; send e-mail to subscriptions@integralsystems-magazine.com. Return undeliverable Canadian addresses to: Integral Systems Inc., 810 Albert Lane, Toronto, Ontario, M3G 1T2, Canada."

	+ Gap()
	+ "Registration No. R123341134\rPublication Mail Agreement No. 341233123\rDocument generated on " + date().year + "/" + (date().month + 1) + "/" + date().day + " at " + date().hour + ":" + date().min + ":" + date().sec;

	TextArea(params.Page, params.X, params.Y + 400, 1500, params.H - 400, t, {VAlign = DE_VALIGN_JUSTIFIED, VAlignEnd = DE_VALIGN_JUSTIFIED});
}


function CMyDocument::Article_MainContent(title, params)
{
	/* fontmap */
	//SetFontmap("fontmaps/stix-1.inf");

	UpdateBaseFormat({FontSize = 78, MarginLeft = 0, Hyphenation = 1, Align = DE_ALIGN_JUSTIFY_A_LEFT});

	/* H1 and H2 */
	AddToIndex(Index, 0, 1, "Letter From The Editor");
	AddToIndex(Index, 0, 2, "Announcing a unique publishing system");

	/* text */

	local t = Run();

	t + "ne of the key questions of Vision Science (natural and artificial) is how to produce good internal representations of the visual world. What sort of internal representation would allow an artificial vision system to detect and classify objects into categories, independently of pose, scale, illumination, conformation, and clutter? More interestingly, how could an artificial vision system " + {Italic = 1, Text = "learn"} + " appropriate internal representations automatically, the way animals and human seem to learn by simply looking at the world? In the time-honored approach to computer vision (and to pattern recognition in general), the question is avoided: internal representations are produced by a hand-crafted feature extractor, whose output is fed to a trainable classifier. While the issue of learning features has been a topic of interest for many years, considerable progress has been achieved in the last few years with the development of so-called " + {Italic = 1, Text = "deep learning"} + " methods." + Endnote("Here is the first endnote");

	t + Gap()
	+ "One of the key questions of Vision Science (natural and artificial) is how to produce good internal representations of the visual world. What sort of internal representation would allow an artificial vision system to detect and classify objects into categories, independently of pose, scale, illumination, conformation, and clutter? More interestingly, how could an artificial vision system " + {Italic = 1, Text = "learn"} + " appropriate internal representations automatically, the way animals and human seem to learn by simply looking at the world? In the time-honored approach to computer vision (and to pattern recognition in general), the question is avoided: internal representations are produced by a hand-crafted feature extractor, whose output is fed to a trainable classifier. While the issue of learning features has been a topic of interest for many years, considerable progress has been achieved in the last few years with the development of so-called " + {Italic = 1, Text = "deep learning"} + " methods." + Endnote("Here is the second endnote");

	t + Gap()
	+ "One of the key questions of Vision Science (natural and artificial) is how to produce good internal representations of the visual world. What sort of internal representation would allow an artificial vision system to detect and classify objects into categories, independently of pose, scale, illumination, whose output is fed to a trainable classifier. While the issue of learning features has been a topic of interest for many years, considerable progress has been achieved in the last few years with the development of so-called " + {Italic = 1, Text = "deep learning"} + " methods." + Endnote("Here is the third endnote");

	t + Gap()
	+ "In closing, I'd like to restate my strong support for Raul's application to the role of software sales professional with Pixel Solutions. I'm confident that he will surpass your expectations in this new role. Raul is driven, self-confident, proactively helpful, and resourceful. I know he will continue to find success in sales. Please feel free to contact me with any other questions.";

	t + Gap({SpacingFactor = 748});

	UpdateBaseFormat({MarginLeft = 1700});

	t + {Bold = 1, Text = "Jim Olsen\r"} + Pict({SizeScale = 1560, Src = GetAssetDir() + "signature-jo.png"});

	UpdateBaseFormat({MarginLeft = 0});

	TextArea(params.Page, params.X + 1650, params.Y + 800, params.W - 1650, params.H - 800, t, {AreaType = DE_AREA_CUSTOM, VAlign = DE_VALIGN_JUSTIFIED, VAlignEnd = DE_VALIGN_JUSTIFIED, EdgeLeft = "20, 32, 0, 20, 32, 14, 20, 0, 14", EdgeRight = "20, 68, 0, 20, 68, 43, 20, 0, 43"}, [] /* must be an empty array in order for the index to work */);

	TextArea(params.Page, params.X + 1650, params.Y + 800, 0, 0, {Text = "O", FontSize = 455, Dx = -20, Dy = -35, Color = "508EFA00", Bold = 1}, {RowType = DE_ROW_TYPO});
}


function CMyDocument::ExecUnit(params)
{
	local p = params.Page;
	local x = params.X;
	local y = params.Y;
	local w = params.W;
	local h = params.H;

	local o_color = O("Color") + S(pdRGBT, "508EFA00");
	local o_style = O("Line Style") + L(pdStylePtr, o_color) + I(pdLineThickness, 800);
	local o_rect = O("Rect") + L(pdBodyPtr, o_color) + I(pdDw, 1500) + I(pdDh, 270);
	local o_line = O("Line") + L(pdLinePtr, o_style) + I(pdDw, w - 1650) + I(pdDh, 0);

	o_rect.Pin(p, x, y + 60, pdDrawRect);
	o_line.Pin(p, x + 1650, y + 330, pdDrawLine);

	TextArea(p, x, y + 60, 1500, 0, {Text = TitlePrimary, Align = DE_ALIGN_CENTER, Dy = 20, FontWidth = 170, FontHeight = 201, FontUniqueID = "F0010_CMBRGH_cS0", Color = "FFFFFF00"}, {RowType = DE_ROW_WIN});

	MakeArticle(Article_Sidebar, "Sidebar", params);

	TextArea(p, x + 1650, y + 100, w - 1650, 0, {Text = "Letter From The Editor", Align = DE_ALIGN_RIGHT, FontWidth = 133, FontHeight = 158, FontUniqueID = "F0010_CMBRGH_cS0", Color = "508EFA00"});

	TextArea(p, x + 1650, y + 450, w - 1650, 0, {Text = "Announcing a unique publishing system", FontSize = 170, FontUniqueID = "F0011_STIX1__cS4"}, {RowType = DE_ROW_TYPO});

	Pict({Page = p, X = w - 400, Y = y + 800, SizeScale = 1325, Quality = DE_QUALITY_HIGH, Src = GetAssetDir() + "profile-dk.png"}, true);

	MakeArticle(Article_MainContent, "Letter From The Editor", params);
}
