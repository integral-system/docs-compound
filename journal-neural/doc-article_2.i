//function CMyDocument::xii_small() { return Sub(Brack(Sub(M2("x"), M3("i"))), M3("i")); }
function CMyDocument::xtildeii() { return Sub(Brack(Sub(Tilde("x"), "i")), M3("i")); }
function CMyDocument::xii() { return Sub(Brack(Sub("x", "i")), M3("i")); }
function CMyDocument::xjj() { return Sub(Brack(Sub("x", "j")), M3("j")); }
function CMyDocument::xpp() { return Sub(Brack(Sub("x", "p")), M3("p")); }
function CMyDocument::xji() { return Sub(BrackSquare(Sub("x", "j")), M3("i")); }
function CMyDocument::xfi() { return Sub(BrackSquare(Sub("x", "f")), M3("i")); }
function CMyDocument::xfj() { return Sub(BrackSquare(Sub("x", "f")), M3("j")); }
function CMyDocument::xff() { return Sub(BrackSquare(Sub("x", "f")), M3("f")); }
function CMyDocument::xfp() { return Sub(BrackSquare(Sub("x", "f")), M3("p")); }
function CMyDocument::viji() { return Sub(Brack(Sub("v", "ij")), M3("i")); }
function CMyDocument::wiji() { return Sub(Brack(Sub("w", "ij")), M3("i")); }
function CMyDocument::xfji() { return Sub(BrackSquare(Sub(BrackSquare(Sub("x", "f")), M3("j"))), M3("i")); }


function CMyDocument::Article_Authors(title, params)
{
	UpdateBaseFormat({FontSize = 78, MarginLeft = 0, RowboundMerge = 1, RowboundMarginTop = -50, RowboundMarginBottom = -50, RowboundColor = "F5EDC688", TabstopPositions = "11796, 29491"});

	/* text */

	local t = Run()
	+ {Text = "\tGreoire Montavon", Bold = 1} + RunSup("1") + "\t(GREGOIRE.MONTAVON@TU-BERLIN.DE)"

	+ Gap({SpacingFactor = 256})
	+ {Text = "\tSebastian Bach", Bold = 1} + RunSup("2") + "\t(SEBASTIAN.BACH@HHI.FRAUNHOFER.DE)"

	+ Gap({SpacingFactor = 256})
	+ {Text = "\tAlexander Binder", Bold = 1} + RunSup("3") + "\t(ALEXANDER BINDER@SUTD.EDU.SG)"

	+ Gap({SpacingFactor = 256})
	+ {Text = "\tWojciech Samek", Bold = 1} + RunSup("2,5") + "\t(WOJCIECH.SAMEK@HHI.FRAUNHOFER.DE)"

	+ Gap({SpacingFactor = 256})
	+ {Text = "\tKlaus-Robert Müller", Bold = 1} + RunSup("1,4,5") + "\t(KLAUS-ROBERT.MUELLER@TU-BERLIN.DE)";

	TextArea(params.Page, params.X, params.Y + params.h_title + 150, params.W, params.h_authors, t, {VAlign = DE_VALIGN_MIDDLE, VAlignEnd = DE_VALIGN_MIDDLE});
}


function CMyDocument::Article_Footnote(title, params)
{
	UpdateBaseFormat({FontSize = 68, MarginLeft = 40});

	/* text */

	local t = Run()
	+ Bullet({Text = RunSup("1"), Type = DE_BULLET_CUSTOMTEXT}) + "Department of Electrical Engineering and Computer Science, Technische Universitat Berlin, 10587 Berlin, Germany\r"
	+ Bullet({Text = RunSup("2"), Type = DE_BULLET_CUSTOMTEXT}) + "Department of Video Coding & Analytics, Fraunhofer Heinrich Hertz Institute, 10587 Berlin, Germany\r"
	+ Bullet({Text = RunSup("3"), Type = DE_BULLET_CUSTOMTEXT}) + "Information Systems Technology and Design, Singapore University of Technology and Design, 487372, Singapore\r"
	+ Bullet({Text = RunSup("4"), Type = DE_BULLET_CUSTOMTEXT}) + "Department of Brain and Cognitive Engineering, Korea University, Seoul 136-713, Korea\r"
	+ Bullet({Text = RunSup("5"), Type = DE_BULLET_CUSTOMTEXT}) + "Berlin Big Data Center (BBDC), Berlin, Germany\r";

	local y_footnote = params.Y + params.H - params.h_footnote;

	TextArea(params.Page, params.X, y_footnote, params.W, params.h_footnote, t, {VAlign = DE_VALIGN_MIDDLE, VAlignEnd = DE_VALIGN_MIDDLE});

	local o0 = CDTObj(this, "Color") + CDTPropStr(pdRGBT, "508EFA00");
	local o1 = CDTObj(this, "Line Style") + CDTLink(pdStylePtr, o0) + CDTPropInt(pdLineThickness, 800);
	local o2 = CDTObj(this, "Line") + CDTLink(pdLinePtr, o1) + CDTPropInt(pdDw, 1000) + CDTPropInt(pdDh, 0);

	o2.Pin(params.Page, params.X, y_footnote - 30, pdDrawLine);
}


function CMyDocument::Article_MainContent(title, params)
{
	UpdateBaseFormat({FontSize = 78, MarginLeft = 0, Bold = 1, Hyphenation = 1});

	/* H1 */
	AddToIndex(Index, 0, 1, "Shallow Taylor Decomposition of Neural Networks");

	/* text */

	local t = Run();

	t + {Italic = 1, Text = "Abstract"} + " — We summarize the main concepts behind a recently proposed method for explaining neural network predictions called " + {Italic = 1, Text = "deep Taylor decomposition"} + ". For conciseness, we only present the case of simple neural networks of ReLU neurons organized in a directed acyclic graph. More structured networks with special layers are discussed in the original paper (Montavon et al., 2015).";

	UpdateBaseFormat({Bold = 0});

	t + Gap({SpacingFactor = 1024})

	+ H2("1. Introduction");

	t + Gap()
	+ "Deep neural networks have become a tool of choice for a number of machine learning problems from automated image classification (Krizhevsky et al., 2012; Szegedy et al., 2015) to natural language processing (Collobert et al., 2011; Kim, 2014). In contrast to their very high predictive performance, deep networks are often perceived as “black-boxes”, limiting in practice their even broader applicability, in particular, for sensitive tasks where a consensus needs to be reached between the machine learning prediction and the human expert.";

	t + Gap()
	+ "Among the multiple recently proposed techniques for explaining neural network predictions (Simonyan et al., 2013; Zeiler and Fergus, 2014; Bach et al., 2015), we can identify two distinct approaches: " + {Italic = 1, Text = "sensitivity analyses"} + " (e.g. Gevrey et al., 2003), that find the input variables that causes the output to vary locally, and " + {Italic = 1, Text = "decompositions"} + " (e.g. Poulin et al., 2006) that seek to redistribute the function output on the input variables in a meaningful way.";

	t + Gap()
	+ "Techniques such as " + {Italic = 1, Text = "layer-wise relevance propagation"} + " (Bach et al., 2015) produce a decomposition for deep neural networks, by building for each neuron a redistribution rule, and applying these rules in a backward pass until the input variables (e.g. pixels) are reached. For image recognition tasks, the procedure results in a “heatmap” that indicates what pixels of the image are important for a particular neural network prediction. An example of pixel-wise decomposition is shown in Figure 1. We can observe that the classifier output is mainly redistributed on the pixels representing the actual object to detect, and not on the background.";

	t + Gap({SpacingFactor = 768})
	+ Figure("deep-taylor-1.png", 900, "Fig. 1.  Image processed by a neural network whose prediction is decomposed onto input variables. The resulting decomposition forms a heatmap indicating what pixels in the image are the most relevant for the prediction.");

	t + Gap()
	+ "Parameters of the decomposition procedure (e.g. the choice of propagation rules) can be selected such that a measure of quality of the decomposition is maximized. While some techniques such as “pixel-flipping” (Samek et al., 2015) have been proposed as a measure of quality, it is still an open question how to best measure decomposition quality, and how to do so in a fully unbiased manner.";

	t + Gap()
	+ "Here, we use a different strategy: A basic model for decomposition based on first-order Taylor expansions is considered, and is viewed as correct for a simple class of models (e.g. single neurons). Then, the model complexity is gradually increased by constraining the input domain, and adding multiple layers of neurons, while at the same time trying to deviate as little as possible from the original decomposition method. As a result of this iterative process, we obtain the deep Taylor decomposition method.";

	t + Gap({SpacingFactor = 1024})
	+ H2("2. Decomposing a ReLU Neuron");

	t + Gap()
	+ "Consider a simple neuron receiving a real-valued input vector " + xii() + " and producing the output";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + Sub("x", "j") + Eq + "max" + Brack(Run() + "0, " + Summation(Sub("x", "i") + Sub("w", "ij") + Sum + Sub("b", "j"), "i"));

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "where " + Sub("b", "j") + LTEq + "0. We would like to decompose the neuron output in terms of input variables. It can be remarked that the neuron function is linear on the subset of the input space that produces " + Sub("x", "j") + GT + "0 (we call it “active set”). On this subset, the output can be written as a first-order Taylor expansion";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + Sub("x", "j") + Eq + Summation(EvalBarB(Frac(Sub(PartialDifferential + "x", "j"), Sub(PartialDifferential + "x", "i")), M2(xii() + Eq + xtildeii())) + Mul2 + Brack(Sub("x", "i") + Diff + Sub(Tilde("x"), "i")), "i") + ",";

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "where " + xii() + " is a " + {Italic = 1, Text = "root point"} + " in the active set, with near-zero output, and at which the Taylor expansion is performed. The decomposition of " + Sub("x", "j") + " onto input variables is given directly by identification of the elements of the sum:";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + xji() + Eq + EvalBarB(Frac(Sub(PartialDifferential + "x", "j"), Sub(PartialDifferential + "x", "i")), M2(xii() + Eq + xtildeii())) + Mul2 + Brack(Sub("x", "i") + Diff + Sub(Tilde("x"), "i"));

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "Note that the property " + Summation(xji() + Eq + Sub("x", "j"), "i") + " is satisfied, and we say in that case, that the redistribution from " + Sub("x", "j") + " to " + xii() + " is " + {Italic = 1, Text = "conservative."};

	t + Gap()
	+ "One degree of freedom of the analysis is the choice of root point " + xtildeii() + " at which the Taylor expansion is performed. Montavon et al. (2015) showed that searching the root point following a direction " + viji() + " in the input space starting from the actual data point " + xii() + " gives the explicit decomposition formula";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + xji() + Eq + Frac(Sub("v", "ij") + Sub("w", "ij"), Summation(Sub("v", "i" + Prime + "j") + Sub("w", "i" + Prime + "j"), "i" + Prime)) + Mul + Sub("x", "j") + "  (1)";

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "that involves both the neuron orientation and the search direction. A graphical depiction of the root search process for two different search directions, and two different neurons is given in Figure 2. We study two specifications of the search direction motivated by constraints on the input domain, each of them leading to a different redistribution rule.";

	t + Gap({SpacingFactor = 768})
	+ H3(Run() + "2.1. Unconstrained input and the " + Sup("w", 2) + "-rule");

	t + Gap()
	+ "If the input space is unconstrained (" + xii() + Element + Sup(Reals, "d") + "), the nearest root point is obtained by searching along the gradient direction, i.e. we set " + Sub("v", "ij") + Eq + Sub("w", "ij") + ", and obtain the redistribution rule";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + xji() + Eq + Frac(SupSub("w", 2, "ij"), Summation(Sub("w", "i" + Prime + "j"), "i" + Prime)) + Mul + Sub("x", "j") + ThinSp + ".";

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "This rule is called “" + Sup("w", 2) + "-rule” and can be viewed up to a constant normalization factor as input sensitivities (" + Sup(/*Run() +*/ Brack(Sub(PartialDifferential + "x", "j") + Div + Sub(PartialDifferential + "x", "i")), "2") + Eq + SupSub("w", 2, "ij") + Mul2 + Sub(1, Sub(M2("x"), M3("j")) + M2(" ") + GT + 0) + ") multiplied by the saliency of the input pattern (as measured by the neuron activation " + Sub("x", "j") + "), that is, ";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + Math("decomposition = sensitivity × saliency.");

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap({SpacingFactor = 768})
	+ H3(Run() + "2.2. Positive input and the " + Sup("z", "+") + "-rule");

	t + Gap()
	+ "We consider the case " + xii() + Element + Sup(Reals, "d") + " occurring when the neuron receives as input the output of other ReLU neurons. Searching for a root point along the gradient direction does not guarantee that it will obey the positivity constraints. Searching for the nearest root point subject to the positivity constraints is possible, however it would require solving an optimization problem.";

	t + Gap()
	+ "Instead, we further restrict the search domain by fixing a search direction " + viji() + " which is not necessarily optimal, but for which a root point is guaranteed to be found in the input domain. One such direction is given by " + Sub("v", "ij") + Eq + Sub("x", "i") + Mul2 + Sub(1, Sub(M2("w"), M3("ij")) + M2(" ") + GT + 0) + ". That is, we move towards the origin (where " + Sub("x", "j") + " = 0) in the subspace of neurons with positive associated weights such as only negative weighted activations persist, and a root point is eventually reached. Injecting this new search direction into Equation 1 gives the redistribution rule";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + xji() + Eq + Frac(Sub("x", "i") + SupSub("w", "+", "ij"), Summation(Sub("x", "i" + Prime) + SupSub("w", "+", "i" + Prime + "j"), "i" + Prime)) + Mul + Sub("x", "j") + ThinSp + ",";

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "where the decomposition on input variables is now determined based on both the input vector and the weights. This rule is called “" + Sup("z", "+") + "-rule” and can be applied to any ReLU neuron with positive inputs and negative bias.";

	t + Gap({SpacingFactor = 1000})
	+ Figure("deep-taylor-2.png", 850 /*, 1024*/, Run() + "Fig. 2.  Illustration of a root point search in the two-dimensional input space of a ReLU neuron, for different choices of weights " + wiji() + " and bias " + Sub("b", "j") + ". The data point " + xii() + " is represented as a black dot, and the possible root points " + xtildeii() + " are depicted as circles.");

	t + Gap({SpacingFactor = 1680})
	+ H2("3. Decomposing a Neural Network");

	t + Gap()
	+ "Consider a neural network mapping an input vector " + xpp() + " to an output scalar " + Sub("x", "f") + ThinSp + ", through an interconnection of many ReLU neurons arranged in a directed acyclic graph. The output neuron " + Sub("x", "f") + " is first decomposed on its input neurons. Then, the decomposition on these neurons is redistributed on their own inputs, and the redistribution process is repeated until the input variables are reached. For this purpose, we define the messages " + xfji() + " designating how much of " + Sub("x", "f") + " is redistributed from an arbitrary neuron " + Sub("x", "j") + " to one of its input " + Sub("x", "i") + ". Redistributed terms coming from the neurons " + xjj() + " to which " + Sub("x", "i") + " contributes are summed:";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + xfi() + Eq + Summation(xfji(), "j");

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "A relevant portion of a simple neural network exhibiting both redistribution and summing in the propagation phase is shown in Figure 3.";

	t + Gap({SpacingFactor = 1000})
	+ Figure("deep-taylor-3.png", 1000 /*, 1024*/, Run() + "Fig. 3.  Portion of a neural network annotated with relevant variables, showing a neuron computation " + Sub("x", "j") + ", and a neuron " + Sub("x", "i") + " on which the neural network output is redistributed.");

	t + Gap({SpacingFactor = 1000})
	+ "We introduce an induction mechanism that allows us to redistribute for any neuron " + Sub("x", "i") + " its share " + xfi() + " on its predecessors. Assume that for all neurons " + xjj() + " to which " + Sub("x", "i") + " contributes, we can write " + xfj() + " = " + Sub("x", "j") + ThinSp + Sub("c", "j") + ", i.e. a product of the neuron activation and a constant term " + Sub("c", "j") + ". The following sequence of equations show that the same holds for " + xfi() + ":";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + xfi() + Eq + Summation(xfji(), "j") + Eq + Summation(Sub(BrackSquare(Sub("x", "j") + ThinSp + Sub("c", "j")), "i"), "j") + Eq + Summation(xji() + Sub("c", "j"), "j") + Eq + Sub("x", "i") + ThinSp + Sub("c", "i");

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "where";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	//local t2 = Summation(Sub("x", "i" + Prime) + SupSub("w", "+", "i" + Prime + "j"), "i" + Prime);
	//t2.ProcessFragments_ApplyFixedParam_Run({FontSize = 12, Align = DE_ALIGN_LEFT});
	//t + Sub("c", "i") + Eq + Summation(Frac(SupSub("w", "+", "ij") + xfj(), t2), "j") + ThinSp + ".";

	t + Sub("c", "i") + Eq + Summation(Frac(SupSub("w", "+", "ij") + xfj(), Summation(Sub("x", "i" + Prime) + SupSub("w", "+", "i" + Prime + "j"), "i" + Prime)), "j") + ThinSp + ".";

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "The variable " + Sub("c", "i") + " is indeed approximately constant under a perturbation of " + Sub("x", "i") + " due to the latter having its effect in " + Sub("c", "i") + " diluted by summing over many other neurons. As a boundary condition, the output can also be written as " + xff() + " = " + Sub("x", "f") + " " + Sub("c", "f") + " with " + Sub("c", "f") + " = 1.";

	t + Gap()
	+ "Having shown by induction that the decomposition onto any neuron in the graph has a product structure, and having made explicit the propagation rule between these neurons, the decomposition " + Sub(Brack(xfp()), M3("p")) + " onto the input variables " + xpp() + " can be easily computed by application of these propagation rules in a backward pass. Note that because the redistribution rule for each neuron is always conservative, the decomposition for the whole network is also conservative, that is, " + Summation(xfp(), "p") + " = " + Sub("x", "f") + ThinSp + ".";

	t + Gap()
	+ "An application of deep Taylor decomposition to the GoogleNet neural network (Szegedy et al., 2015) results for a selected image in the heatmap of Figure 1. Details of how specific layers are handled in such network, e.g. pooling layers, normalization layers, input layer, and linear layers with positive biases, are described in the original paper on deep Taylor decomposition."

	t + Gap({SpacingFactor = 1024})
	+ H2("REFERENCES");

	t + Gap();

	UpdateBaseFormat({FontSize = 68, MarginLeft = 120});

	t + Bullet({Text = "[1] ", Type = DE_BULLET_CUSTOMTEXT}) + "S. Bach, A. Binder, G. Montavon, F. Klauschen, K. R. Müller, and W. Samek. On pixel-wise explanations for non-linear classifier decisions by layer-wise relevance propagation. " + {Italic = 1, Text = "PLoS ONE"} + ", 10 (7):e0130140, 07 2015.";

	t + Gap()
	+ Bullet({Text = "[2] ", Type = DE_BULLET_CUSTOMTEXT}) + "R. Collobert, J. Weston, L. Bottou, M. Karlen, K. Kavukcuoglu, and P. P. Kuksa. Natural language processing (almost) from scratch. " + {Italic = 1, Text = "Journal of Machine Learning Research"} + ", 12:2493–2537, 2011.";

	t + Gap()
	+ Bullet({Text = "[3] ", Type = DE_BULLET_CUSTOMTEXT}) + "M. Gevrey, I. Dimopoulos, and S. Lek. Review and comparison of methods to study the contribution of variables in artificial neural network models. " + {Italic = 1, Text = "Ecological Modelling"} + ", 160(3):249– 264, 2003.";

	t + Gap()
	+ Bullet({Text = "[4] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. Kim. Convolutional neural networks for sentence classification. In " + {Italic = 1, Text = "Proceedings of the 2014 Conference on Empirical Methods in Natural Language Processing"} + ", pages 1746–1751, 2014.";

	t + Gap()
	+ Bullet({Text = "[5] ", Type = DE_BULLET_CUSTOMTEXT}) + "A. Krizhevsky, I. Sutskever, and G. E. Hinton. Imagenet classification with deep convolutional neural networks. In " + {Italic = 1, Text = "Advances in Neural Information Processing Systems 25"} + ", pages 1106–1114, 2012.";

	t + Gap()
	+ Bullet({Text = "[6] ", Type = DE_BULLET_CUSTOMTEXT}) + "G. Montavon, S. Bach, A. Binder, W. Samek, and K. R. Müller. Explaining nonlinear classification decisions with deep Taylor decomposition. " + {Italic = 1, Text = "CoRR"} + ", abs/1512.02479, 2015.";

	t + Gap()
	+ Bullet({Text = "[7] ", Type = DE_BULLET_CUSTOMTEXT}) + "B. Poulin, R. Eisner, D. Szafron, P. Lu, R. Greiner, D. S. Wishart, A. Fyshe, B. Pearcy, C. Macdonell, and J. Anvik. Visual explanation of evidence with additive classifiers. In " + {Italic = 1, Text = "Proceedings, The Twenty-First National Conference on Artificial Intelligence"} + ", pages 1822–1829, 2006.";

	t + Gap()
	+ Bullet({Text = "[8] ", Type = DE_BULLET_CUSTOMTEXT}) + "W. Samek, A. Binder, G. Montavon, S.Bach, and K.R. Müller. Evaluating the visualization of what a deep neural network has learned. " + {Italic = 1, Text = "CoRR"} + ", abs/1509.06321, 2015.";

	t + Gap()
	+ Bullet({Text = "[9] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Simonyan, A. Vedaldi, and A. Zisserman. Deep inside convolutional networks: Visualising image classification models and saliency maps. " + {Italic = 1, Text = "CoRR"} + ", abs/1312.6034, 2013.";

	t + Gap()
	+ Bullet({Text = "[10] ", Type = DE_BULLET_CUSTOMTEXT}) + "C. Szegedy, W. Liu, Y. Jia, P. Sermanet, S. E. Reed, D. Anguelov, D. Erhan, V. Vanhoucke, and A. Rabinovich. Going deeper with convolutions. In " + {Italic = 1, Text = "IEEE Conference on Computer Vision and Pattern Recognition"} + ", pages 1–9, 2015.";

	t + Gap()
	+ Bullet({Text = "[11] ", Type = DE_BULLET_CUSTOMTEXT}) + "M. D. Zeiler and R. Fergus. Visualizing and understanding convolutional networks. In " + {Italic = 1, Text = "Computer Vision - ECCV 2014 - 13th European Conference"} + ", pages 818–833, 2014.";

	TextFlow(params.Page, 3, 2, 100, params.X, params.Y, params.w_col, params.H, t, {VAlign = DE_VALIGN_JUSTIFIED}, [{Adjust = 12, Dy = params.h_authors + params.h_title + 240, Count = 2}, {Adjust = 4, Dy = params.h_footnote + 120, Count = 2}]);
}


function CMyDocument::ExecUnit(params)
{
	local p = params.Page;
	local x = params.X;
	local y = params.Y;
	local w = params.W;
	local h = params.H;

	params.w_col <- (w - 100) / 2;
	params.h_title <- 460;
	params.h_authors <- 800;
	params.h_footnote <- 500;

	TextArea(p, x, y + 160, w, 0, {Text = "Deep Taylor Decomposition of Neural Networks", Align = DE_ALIGN_CENTER, FontSize = 170, FontUniqueID = "F0011_STIX1__cS4", RowboundMarginTop = -100, RowboundMarginBottom = -100, RowboundOutlineColor = "508EFA00", RowboundOutlineThickness = 800, RowboundMerge = 1}, {RowType = DE_ROW_WIN});

	MakeArticle(Article_Authors, "Second Unit - Authors", params);
	MakeArticle(Article_MainContent, "ARTICLE 2 - Article Text", params);
	MakeArticle(Article_Footnote, "ARTICLE 2 - Footnote", params);
}
