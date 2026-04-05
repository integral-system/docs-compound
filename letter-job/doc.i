class CMyDocument extends CDTDocumentBasic
{
	LastPage = 1;

	TitlePrimary = "INTEGRAL";
	TitleSecondary = "Job Recommendation Letter";
	TitleIssue = "January 12, 2019";

	ContentUnits =
	[
		//[true, -1, "doc-common.i"],
		[true,  0, "doc-article_1.i"],
		[true,  1, "doc-pagenum.i"]
	];
}
