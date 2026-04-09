function CMyDocument::Article_MainContent(title, params)
{
	SetFontmap("fontmaps/stix-1.inf");

	UpdateBaseFormat({FontSize = 100, Align = DE_ALIGN_JUSTIFY_A_LEFT});

	local t = Run();

	t + Pict({Src = "assets/integral-hor.png", SizeScale = 1000, RunFormat = {Align = DE_ALIGN_CENTER}, NewlineFlag = 2, BaseAlign = DE_BASEALIGN_MIDDLE})

	+ "Jim Olsen\rIntegral Systems Inc.\r810 Albert Lane\rToronto, Ontario, M3G 1T2"

	+ Gap({SpacingFactor = 1024})

	+ "January 12, 2019"

	+ Gap({SpacingFactor = 1024})

	+ "Patricia Smith\rPixel Solutions Ltd.\r128 Sheppard Street West, Suite 301\rVancouver, British Columbia, V5K 2C1"

	+ Gap({SpacingFactor = 1024})

	+ "Dear Patricia,"

	+ Gap()

	+ "It’s my pleasure to provide this letter of recommendation for Raul Payette as he seeks employment in software sales with your company. As Raul’s direct supervisor at Integral Systems, I’ve worked closely with him over the past four years. Raul showed excellent communication skills and consistently exceeded company quotas. On a personal level, Raul is charismatic and well-spoken. Both of these qualities have served him well in his role as software sales professional."

	+ Gap()

	+ "Due to his wife’s cross-country transfer, Raul is seeking employment in Vancouver. All of us at Integral Systems will be sad to see such a valuable and energetic individual go. Allow me to point out three examples of Raul’s strengths:"

	+ Gap()

	+ Bullet({Type = DE_BULLET_CIRC}) + {MarginLeft = 200, Text = "First, Raul brought great value to Integral Systems by consistently exceeding quotas and selling in the top 15% of his peers. Raul has an understanding of market trends and instincts for identifying and pursuing qualified leads. Not only does he provide stellar service to existing clients, but he’s established a number of new business-to-business and business-to-customer accounts during his time at Integral Systems."}

	+ Gap()

	+ Bullet({Type = DE_BULLET_CIRC}) + {MarginLeft = 200, Text = "Second, Raul has a very strong grasp of technology. He knows software inside and out and helps relay technical information to customers in an accessible way. He explains our products clearly to customers and makes the most of technological avenues to gain new leads and customize his sales pitch to clients. During his first year at Integral Systems, I observed him discuss in detail with a prospective client the specific ways that our software could boost the sales of their print business. By monitoring clients’ presence across our website and blog, he provides each one with personalized service to meet their needs. Raul makes the most of technology to find new prospects, provide modern solutions, and drive results."}

	+ Gap()

	+ Bullet({Type = DE_BULLET_CIRC}) + {MarginLeft = 200, Text = "Finally, Raul has proven himself to be a strong cultural fit here at Integral Systems. He’s always ready to lend a helping hand to his teammates and contributes during brainstorming sessions and meetings between the sales and product development teams. Last month, Raul co-led an enlightening meeting on content marketing and account management. Outside of official events, Raul also takes turns leading weekly cycling classes at our in-house gym. Raul is an active member of the Integral Systems team and supports his colleagues professionally and personally."}

	+ Gap()

	+ "In closing, I’d like to restate my strong support for Raul’s application to the role of software sales professional with Pixel Solutions. I’m confident that he will surpass your expectations in this new role. Raul is driven, self-confident, proactively helpful, and resourceful. I know he will continue to find success in sales. Please feel free to contact me with any other questions."

	+ Gap({SpacingFactor = 748})

	+ "Sincerely Yours,"

	+ Gap({SpacingFactor = 480})

	+ Pict({Src = "assets/signature-jo.png", SizeScale = 1500, NewlineFlag = 2, BaseAlign = DE_BASEALIGN_MIDDLE}) + "Jim Olsen\rIntegral Systems Inc.";

	TextFlow(params.Page, 2, 1, 0, params.X, params.Y, params.W, params.H, t);
}


function CMyDocument::ExecUnit(params)
{
	MakeArticle(Article_MainContent, "ARTICLE 1 - Recommendation Letter", params);
}
