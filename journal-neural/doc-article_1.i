function CMyDocument::Article_Authors(title, params)
{
	UpdateBaseFormat({FontSize = 78, MarginLeft = 0, Align = DE_ALIGN_CENTER, RowboundMerge = 1, RowboundMarginTop = -50, RowboundMarginBottom = -50, RowboundColor = "F5EDC688"});

	/* text */

	local t = Run()
	+ {Text = "Yann LeCun, Koray Kavukcuoglu and Clement Farabet", Bold = 1}

	+ Gap()
	+ "Computer Science Department, Courant Institute of Mathematical Sciences, New York University\r{yann,koray,cfarabet}@cs.nyu.edu";

	TextArea(params.Page, params.X, params.Y + params.h_title + 150, params.W, params.h_authors, t, {VAlign = DE_VALIGN_MIDDLE, VAlignEnd = DE_VALIGN_MIDDLE});
}


function CMyDocument::Article_MainContent(title, params)
{
	UpdateBaseFormat({FontSize = 78, MarginLeft = 0, Align = DE_ALIGN_JUSTIFY_A_LEFT, Bold = 1, Hyphenation = 1});

	/* H1 */
	AddToIndex(Index, 0, 1, "Convolutional Networks and Applications in Vision");

	/* text */

	local t = Run();

	t + {Italic = 1, Text = "Abstract"} + " — Intelligent tasks, such as visual perception, auditory perception, and language understanding require the construction of good internal representations of the world (or ”features”), which must be invariant to irrelevant variations of the input while, preserving relevant information. A major question for Machine Learning is how to " + {Italic = 1, Text = "learn"} + " such good features automatically. " + Abbr("ConvNets", 3) + " are a biologically-​inspired trainable architecture that can learn invariant features. Each stage in a " + Abbr("ConvNets") + " is composed of a filter bank, some non-linearities, and feature pooling layers. With multiple stages, a " + Abbr("ConvNets") + " can learn multi-level hierarchies of features. While " + Abbr("ConvNets") + " have been successfully deployed in many commercial applications from OCR to video surveillance, they require large amounts of labeled training samples. We describe new unsupervised learning algorithms, and new non-linear stages that allow " + Abbr("ConvNets") + " to be trained with very few labeled samples. Applications to visual object recognition and vision navigation for off-road mobile robots are described.";

	UpdateBaseFormat({Bold = 0});

	t + Gap({SpacingFactor = 1024})

	+ H2("1. Learning Internal Representations");

	t + Gap()
	+ "One of the key questions of " + Stress("Vision Science") + " (natural and artificial) is how to produce good internal representations of the visual world. What sort of internal representation would allow an artificial vision system to detect and classify objects into categories, independently of pose, scale, illumination, conformation, and clutter? More interestingly, how could an artificial vision system " + {Italic = 1, Text = "learn"} + " appropriate internal representations automatically, the way animals and human seem to learn by simply looking at the world? In the time-honored approach to computer vision (and to pattern recognition in general), the question is avoided: internal representations are produced by a hand-crafted feature extractor, whose output is fed to a trainable classifier. While the issue of learning features has been a topic of interest for many years, considerable progress has been achieved in the last few years with the development of so-called " + {Italic = 1, Text = "deep learning"} + " methods." + Endnote("Here is the fourth endnote");

	t + Gap()
	+ "Good internal representations are hierarchical. In vision, pixels are assembled into edglets, edglets into motifs, motifs into parts, parts into objects, and objects into scenes. This suggests that recognition architectures for vision (and for other modalities such as audio and natural language) should have multiple trainable stages stacked on top of each other, one for each level in the feature hierarchy. This raises two new questions: what to put in each stage? and how to train such " + {Italic = 1, Text = "deep, multi-stage architectures"} + "? " + Abbr("ConvNets", 3) + " are an answer to the first question. Until recently, the answer to the second question was to use gradient-based supervised learning, but recent research in " + {Italic = 1, Text = "deep learning"} + " has produced a number of unsupervised methods which greatly reduce the need for labeled samples.";

	t + Gap({SpacingFactor = 768})
	+ H3("1.1. Convolutional networks");

	t + Gap()
	+ "Convolutional Networks [1], [2] are trainable multistage architectures composed of multiple stages. The input and output of each stage are sets of arrays called " + {Italic = 1, Text = "feature maps"} + ". For example, if the input is a color image, each feature map would be a 2D array containing a color channel of the input image (for an audio input each feature map would be a 1D array, and for a video or volumetric image, it would be a 3D array). At the output, each feature map represents a particular feature extracted at all locations on the input. Each stage is composed of three layers: a " + {Italic = 1, Text = "filter bank layer"} + ", a " + {Italic = 1, Text = "non-linearity layer"} + ", and a " + {Italic = 1, Text = "feature pooling layer"} + ". A typical " + Abbr("ConvNet") + " is composed of one, two or three such 3-layer stages, followed by a classification module. Each layer type is now described for the case of image recognition.";

	t + Gap({SpacingFactor = 768})
	+ Figure("conv-nets-1.png", 1000, "Fig. 1.  A typical ConvNet architecture with two feature stages");

	t + Gap()
	+ {Bold = 1, Text = "Filter Bank Layer - "} + {BoldItalic = 1, Text = "F:"} + " the input is a 3D array with " + Sub("n", 1) + " 2D " + {Italic = 1, Text = "feature maps"} + " of size " + Sub("n", 2) + MulX + Sub("n", 3) + ". Each component is denoted " + Sub("x", "ijk") + ", and each feature map is denoted " + Sub("x", "i") + ". The output is also a 3D array, " + Math("y") + " composed of " + Sub("m", 1) + " feature maps of size " + Sub("m", 2) + MulX + Sub("m", 3) + ". A trainable filter (kernel) " + Sub("k", "ij") + " in the filter bank has size " + Sub("l", 1) + MulX + Sub("l", 2) + " and connects input feature map " + Sub("x", "i") + " to output feature map " + Sub("y", "j") + ". The module computes " + Sub("y", "j") + Eq + Sub("b", "j") + Sum + Summation(Sub("k", "ij") + " * " + Sub("x", "i"), "i") + " where * is the 2D discrete convolution operator and " + Sub("b", "j") + " is a trainable bias parameter. Each filter detects a particular feature at every location on the input. Hence spatially translating the input of a feature detection layer will translate the output but leave it otherwise unchanged.";

	t + Gap()
	+ {Bold = 1, Text = "Non-Linearity Layer:"} + " In traditional " + Abbr("ConvNets") + " this simply consists in a pointwise " + Math("tanh()") + " sigmoid function applied to each site " + Brack("ijk") + ". However, recent implementations have used more sophisticated non-linearities. A useful one for natural image recognition is the rectified sigmoid " + Sub("R", "abs") + ": " + Math("abs") + Brack(Sub("g", "i") + Mul2 + M1("tanh()")) + " where " + Sub("g", "i") + " is a trainable gain parameter. The rectified sigmoid is sometimes followed by a subtractive and divisive local normalization " + Math("N") + ", which enforces local competition between adjacent features in a feature map, and between features at the same spatial location. The subtractive normalization operation for a given site " + Sub("x", "ijk") + " computes: " + Sub("v", "ijk") + Eq + Sub("x", "ijk") + Diff + Summation(Sub("w", "pq") + Mul2 + Sub("x", "i," + ThinSp + "j+p," + ThinSp + "k+q"), "ipq") + ", where " + Sub("w", "pq") + " is a normalized truncated Gaussian weighting window (typically of size 9 × 9). The divisive normalization computes " + Sub("y", "ijk") + Eq + Frac(Sub("v", "ijk"), Run() + "max" + Brack(Run() + Math("mean") + Brack(Sub("σ", "jk")) + "," + ThinSp + Sub("σ", "jk"))) + " where " + Sub("σ", "jk") + Eq + Sup(Brack(Summation(Sub("w", "pq") + Mul2 + Sub(Sup("v", 2), "i," + ThinSp + "j+p," + ThinSp + "k+q"), "ipq")), OneHalf) + ". The local contrast normalization layer is inspired by visual neuroscience models [3], [4].";

	t + Gap()
	+ {Bold = 1, Text = "Feature Pooling Layer:"} + " This layer treats each feature map separately. In its simplest instance, called P" + RunSub("A") + ", it computes the average values over a neighborhood in each feature map. The neighborhoods are stepped by a stride larger than 1 (but smaller than or equal the pooling neighborhood). This results in a reduced-resolution output feature map which is robust to small variations in the location of features in the previous layer. The average operation is sometimes replaced by a max P" + RunSub("M") + ". Traditional " + Abbr("ConvNets") + " use a pointwise " + Math("tanh()") + " after the pooling layer, but more recent models do not. Some " + Abbr("ConvNets") + " dispense with the separate pooling layer entirely, but use strides larger than one in the filter bank layer to reduce the resolution [5], [6]. In some recent versions of " + Abbr("ConvNets") + ", the pooling also pools similar feature at the same location, in addition to the same feature at nearby locations [7].";

	t + Gap({SpacingFactor = 768})
	+ Figure("conv-nets-2.png", 1050, Run() + "Fig. 2.  An example of feature extraction stage of the type F − R" + RunSub("abs") + " − N − P" + RunSub("A") + ". An input image (or a feature map) is passed through a filter bank, followed by abs(g" + RunSub("i") + ".tanh()), local subtractive and divisive contrast normalization, and spatial pooling/sub-sampling.");

	t + Gap()
	+ "Supervised training is performed using a form of stochastic gradient descent to minimize the discrepancy between the desired output and the actual output of the network. All the coefficient of all the filters in all the layers are updated simultaneously by the learning procedure. The gradients are computed with the back-propagation method. Details of the procedure are given in [2], and methods for efficient training are detailed in [8].";

	t + Gap({SpacingFactor = 768})
	+ H3("1.2. History and applications");

	t + Gap()
	+ Abbr("ConvNets") + " can be seen as a representatives of a wide class of models that we will call " + {Italic = 1, Text = "Multi-Stage Hubel-Wiesel Architectures"} + ". The idea is rooted in Hubel and Wiesel’s classic 1962 work on the cat’s primary visual cortex. It identified orientation-selective " + {Italic = 1, Text = "simple cells"} + " with local receptive fields, whose role is similar to the " + Abbr("ConvNets") + " filter bank layers, and " + {Italic = 1, Text = "complex cells"} + ", whose role is similar to the pooling layers. The first such model to be simulated on a computer was Fukushima’s Neocognitron [9], which used a layer-wise, unsupervised competitive learning algorithm for the filter banks, and a separately-trained supervised linear classifier for the output layer. The innovation in [5], [1] was to simplify the architecture and to use the back-propagation algorithm to train the entire system in a supervised fashion. The approach was very successful for such tasks as OCR and handwriting recognition. An operational bank check reading system built around " + Abbr("ConvNets") + " was developed at AT&T in the early 1990’s [2]. It was first deployed commercially in 1993, running on a DSP board in check-reading ATM machines in Europe and the US, and was deployed in large bank check reading machines in 1996. By the late 90’s it was reading over 10% of all the checks in the US. This motivated Microsoft to deploy " + Abbr("ConvNets") + " in a number of OCR and handwriting recognition systems [6], [10], [11] including for Arabic [12] and Chinese characters [13]. Supervised " + Abbr("ConvNets") + " have also been used for object detection in images, including faces with record accuracy and real-time performance [14], [15], [16], [17], Google recently deployed a " + Abbr("ConvNet") + " to detect faces and license plate in StreetView images so as to protect privacy [18]. NEC has deployed " + Abbr("ConvNet") + "-based system in Japan for tracking customers in supermarket and recognizing their gender and age. Vidient Technologies has developed a " + Abbr("ConvNet") + "-based video surveillance system deployed in several airports in the US. France Télécom has deployed " + Abbr("ConvNet") + "-based face detection systems for video-conference and other systems [15]. Other experimental detection applications include hands/gesture [19], logos and text [20]. A big advantage of " + Abbr("ConvNets") + " for detection is their computational efficiency: even though the system is trained on small windows, it suffices to extend the convolutions to the size of the input image and replicate the output layer to compute detections at every location. Supervised " + Abbr("ConvNets") + " have also been used for vision-based obstacle avoidance for off-road mobile robots [21]. Two participants in the recent DARPA-sponsored LAGR program on vision-based navigation for off-road robots used " + Abbr("ConvNets") + " for long-range obstacle detection [22], [23]. In [22], the system is pre-trained off-line using a combination of unsupervised learning (as described in section II) and supervised learning. It is then adapted online, as the robot runs, using labels provided by a short-range stereovision system (see videos at " + URL("http://www.cs.nyu.edu/yann/research/lagr") + "). Interesting new applications include image restoration [24] and image segmentation, particularly for biological images [25]. The big advantage over MRFs is the ability to take a large context window into account. Stunning results were obtained at MIT for reconstructing neuronal circuits from an stack of brain slice images a few nanometer thick. [26].";

	t + Gap()
	+ "Over the years, other instances of the Multi-Stage Hubel-Wiesel Architecture have appeared that are in the tradition of the Neocognitron: unlike supervised " + Abbr("ConvNets") + ", they use a combination of hand-crafting, and simple unsupervised methods to design the filter banks. Notable examples include Mozer’s visual models [27], and the so-called HMAX family of models from T. Poggio’s lab at MIT [28], [29], which uses hard-wired Gabor filters in the first stage, and a simple unsupervised random template selection algorithm for the second stage. All stages use point-wise non-linearities and max pooling. From the same institute, Pinto et al. [4] have identified the most appropriate non-linearities and normalizations by running systematic experiments with a single-stage architecture using GPU-based parallel hardware.";

	t + Gap({SpacingFactor = 1024})

	+ H2("2. Unsupervised Learning of Convnets");

	t + Gap()
	+ "Training deep, multi-stage architectures using supervised gradient back propagation requires many labeled samples. However in many problems labeled data is scarce whereas unlabeled data is abundant. Recent research in deep learning [30], [31], [32] has shown that " + {Italic = 1, Text = "unsupervised learning"} + " can be used to train each stage one after the other using only unlabeled data, reducing the requirement for labeled samples significantly. In [33], using abs and normalization non-linearities, unsupervised pre-training, and supervised global refinement has been shown to yield excellent performance on the Caltech-101 dataset with only 30 training samples per category (more on this below). In [34], good accuracy was obtained on the same set using a very different unsupervised method based on sparse Restricted Boltzmann Machines. Several works at NEC have also shown that using " + {Italic = 1, Text = "auxiliary tasks"} + " [35], [36] helps regularizing the system and produces excellent performance.";

	t + Gap({SpacingFactor = 768})
	+ H3("2.1. Unsupervised training with predictive sparse decomposition");

	t + Gap()
	+ "The unsupervised method we propose, to learn the filter coefficients in the filter bank layers, is called Predictive Sparse Decomposition (PSD) [37]. Similar to the well-known sparse coding algorithms [38], inputs are approximated as a sparse linear combination of dictionary elements. In conventional sparse coding for any given input X, one needs to run an expensive optimization algorithm to find " + Sup("Z", "*") + " (the “basis pursuit” problem). PSD trains a feed-forward regressor (or " + {Italic = 1, Text = "encoder"} + ") " + Math("C(X,K)") + " to quickly approximate the sparse solution " + Sup("Z", "*") + ". During training, the feature vector " + Sup("Z", "*") + " is obtained by minimizing:";

	t + Gap();

	UpdateBaseFormat({Align = DE_ALIGN_CENTER});

	t + Math("E(Z,W,K)") + Eq + SupSub(Norm("X" + Diff + "WZ"), 2, 2) + Sum + Math(Lambda) + Sub(Norm("Z"), 1) + Sum + SupSub(Norm("Z" + Diff + "C(X,K)"), 2, 2);

	UpdateBaseFormat({Align = DE_ALIGN_JUSTIFY_A_LEFT});

	t + Gap()
	+ "where " + Math("W") + " is the matrix whose columns are the dictionnary elements and " + Math("K") + " are the filters. For each training sample " + Math("X") + ", one first finds " + Sup("Z", "*") + " that minimizes " + Math("E") + ", then " + Math("W") + " and " + Math("K") + " are adjusted by stochastic gradient descent to lower " + Math("E") + ". Once training is complete, the feature vector for a given input is simply obtained with " + Sup("Z", "*") + Eq + Math("C(X,K)") + ", hence the process is extremely fast (feed-forward).";

	t + Gap({SpacingFactor = 768})
	+ H3("2.2. Results on object recognition");

	t + Gap()
	+ "In this section, various architectures and training procedures are compared to determine which non-linearities are preferable, and which training protocol makes a difference.";

	t + Gap()
	+ {Italic = 1, Text = "Generic Object Recognition using Caltech 101 Dataset:"} + " We use a two-stage system where, the first stage is composed of an " + {Italic = 1, Text = "F"} + " layer with 64 filters of size 9 × 9, followed by different combinations of non-linearities and pooling. The second-stage feature extractor is fed with the output of the first stage and extracts 256 output features maps, each of which combines a random subset of 16 feature maps from the previous stage using 9 × 9 kernels. Hence the total number of convolution kernels is 256 × 16 = 4096.";

	t + Gap();

	local tbl = Run() + {Underline = 1, Text = "TABLE I"} + "\rAVERAGE RECOGNITION RATES ON CALTECH-101."
	+ Gap()
	+ Table(
	["", Run() + "R" + RunSub("abs") + " - N - P" + RunSub("A"), Run() + "R" + RunSub("abs") + " - P" + RunSub("A"), Run() + "N - P" + RunSub("M"), Run() + "P" + RunSub("A")],
	[Run() + "U" + RunSup("+"), "65.5%", "60.5%", "61.0%", "32.0%"],
	[Run() + "R" + RunSup("+"), "64.7%", "59.5%", "60.0%", "29.7%"],
	["U ", "63.7%", "46.7%", "56.0%", "9.1%"],
	["R ", "62.9%", "33.7%", "37.6%", "8.8%"],
	{
		ColWidths = [300 * 0.78, 600 * 0.78, 450 * 0.78, 400 * 0.78, 350 * 0.78],
		//RunFormat = {Align = DE_ALIGN_CENTER},
		StyleID = 63
	})
	+ Gap();

	tbl * {Align = DE_ALIGN_CENTER};

	t + tbl

	+ "Table I summarizes the results for the experiments, where U and R denotes unsupervised pre-training and random initialization respectively, and " + RunSup("+") + " denotes supervised fine-tuning of the whole system.";

	t + Gap()
	+ {Bold = 1, Text = "1."} + " Excellent accuracy of 65.5% is obtained using unsupervised pre-training and supervised refinement with abs and normalization non-linearities. The result is on par with the popular model based on SIFT and pyramid match kernel SVM [39]. It is clear that abs and normalization are crucial for achieving good performance. This is an extremely important fact for users of convolutional networks, which traditionally only use " + Math("tanh()") + ".";

	t + Gap()
	+ {Bold = 1, Text = "2."} + " Astonishingly, " + {Italic = 1, Text = "random filters without any filter learning whatsoever achieve decent performance"} + " (62.9% for R), as long as abs and normalization are present (R" + RunSub("abs") + " − N − P" + RunSub("A") + "). A more detailed study on this particular case can be found in [33].";

	t + Gap()
	+ {Bold = 1, Text = "3."} + " Comparing experiments from rows R vs R" + RunSup("+") + ", U vs U" + RunSup("+") + ", we see that supervised fine tuning consistently improves the performance, particularly with weak non-linearities.";

	t + Gap()
	+ {Bold = 1, Text = "4."} + " It seems that unsupervised pre-training (U, U" + RunSup("+") + ") is crucial when newly proposed non-linearities are not in place.";

	t + Gap()
	+ {Italic = 1, Text = "Handwritten Digit Classification using MNIST Dataset:"} + " Using the evidence gathered in previous experiments, we used a two-stage system with a two-layer fully-connected classifier. The two convolutional stages were pre-trained unsupervised, and refined supervised. An error rate of 0.53% was achieved ont he test set. To our knowledge, " + {Italic = 1, Text = "this is the lowest error rate ever reported on the original MNIST dataset, without distortions or preprocessing"} + ". The best previously reported error rate was 0.60% [32].";

	t + Gap({SpacingFactor = 768})
	+ H3("2.3. Connection with other approaches in object recognition");

	t + Gap()
	+ "Many recent successful object recognition systems can also be seen as single or multi-layer feature extraction systems followed by a classifier. Most common feature extraction systems like SIFT [40], HoG [41] are composed of filterbanks (oriented edge detectors at multiple scales) followed by non-linearities (winner take all) and pooling (histogramming). A Pyramid Match Kernel (PMK) SVM [39] classifer can also be seen as another layer of feature extraction since it performs a K-means based feature extraction followed by local histogramming.";

	t + Gap({SpacingFactor = 1024})
	+ H2("3. Hardware and Software Implementations");

	t + Gap()
	+ "Implementing " + Abbr("ConvNets") + " in software is best achieved using the modular, object-oriented approach suggested in [2]. Each basic module (convolution, pooling, etc) is implemented as a class with three member functions " + Code("module.fprop(input,output)") + ", which computes the output from the input, " + Code("module.bprop(input,output)") + ", which back-propagates gradients from the outputs back to the inputs and the internal trainable parameters, and optionally " + Code("module.bbprop(input,output)") + ", which may back-propagate second diagonal derivatives for the implementation of second-order optimization algorithms [8].";

	t + Gap()
	+ "Several software implementations of " + Abbr("ConvNets") + " are built around this concept, and have four basic capabilities: 1. a flexible multi-dimensional array library with basic operations such as dot products, and convolutions, 2. a class hierarchy of basic learning machine building blocs (e.g. multiple convolutions non-linear transforms, cost functions, ...), 3. a set of classes for energy-based inference [42], gradient-based optimization, and performance measurement.";

	t + Gap()
	+ "Three available " + Abbr("ConvNet") + " implementations use this concept. The first one is part of the Lush system, a Lisp dialect with an interpreter and compiler with an easy interface to C [43]. The second one is EBlearn, a C++ machine learning library with class hierarchy to the Lush implementation [44]. Third is Torch-5 [45] a C library with an interpreter front end based on Lua. All three systems come with facilities to manipulate large datasets, images, and videos.";

	t + Gap()
	+ "The first hardware implementations of " + Abbr("ConvNets") + " date back to the early 90’s with Bell Labs’ ANNA chip, a mixed analog-digital processor that could compute 64 simultaneous 8 × 8 convolutions at a peak rate of 4.10" + RunSup("9") + " multiply-accumulate operations per second [46], [47], with 4 bit resolution on the states and 6 bits on the weights. More recently, a group from the Canon corporation developed a prototype " + Abbr("ConvNet") + " chip for low-power intelligent cameras [48]. Some current approaches rely on Addressed-Event Representation (AER) convolvers, which present the advantage of not requiring multipliers to compute the convolutions. CAVIAR is the leading such project, with a performance of 12G connections/sec [49].";

	t + Gap()
	+ "FPGA implementations of " + Abbr("ConvNets") + " appeared in the mid-90’s with [50], which used low-accuracy arithmetic to avoid implementing full-fledged multipliers. Fortunately, recent DSP-oriented FPGAs include large numbers of hard-wired MAC units, which allow extremely fast and low power implementations of " + Abbr("ConvNets") + ". The CNP developed in our group [51] achieves 10GOPS for 7 × 7 kernels, with an architecture that implements entire " + Abbr("ConvNets") + ", including pre/post-processing, and is entirely programmable. An actual face detection application was demonstrated on this system, achieving 10 fps on VGA images [52].";

	t + Gap({SpacingFactor = 1024})
	+ H2("4. Conclusion");

	t + Gap()
	+ "The Convolutional Network architecture is a remarkably versatile, yet conceptually simple paradigm that can be applied to a wide spectrum of perceptual tasks. While traditional " + Abbr("ConvNet") + " trained with supervised learning are very effective, training them require a large number of labeled training samples. We have shown that using simple architectural tricks such as rectification and contrast normalization, and using unsupervised pre-training of each filter bank, the need for labeled samples is considerably reduced. Because of their applicability to a wide range of tasks, and because of their relatively uniform architecture, " + Abbr("ConvNets") + " are perfect candidates for hardware implementations, and embedded applications, as demonstrated by the increasing amount of work in this area. We expect to see many new embedded vision systems based on " + Abbr("ConvNets") + " in the next few years.";

	t + Gap()
	+ "Despite the recent progress in deep learning, one of the major challenges of computer vision, machine learning, and AI in general in the next decade will be to devise methods that can automatically learn good features hierarchies from unlabeled and labeled data in an integrated fashion. Current and future research will focus on performing unsupervised learning on multiple stages simultaneously, on the integration of unsupervised and unsupervised learning, and on using the feedback path implemented by the decoders to perform visual inference, such as pattern completion and disambiguation.";

	t + Gap({SpacingFactor = 1024})
	+ H2("REFERENCES");

	t + Gap();

	UpdateBaseFormat({FontSize = 68, MarginLeft = 120, SpacingRow = -19});

	t + Bullet({Text = "[1] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. LeCun, B. Boser, J. S. Denker, D. Henderson, R. E. Howard, W. Hubbard, and L. D. Jackel, “Handwritten digit recognition with a back-propagation network,” in " + {Italic = 1, Text = "NIPS’89."};

	t + Gap()
	+ Bullet({Text = "[2] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y.LeCun, L.Bottou, Y.Bengio, and P.Haffner, “Gradient-basedlearning applied to document recognition,” " + {Italic = 1, Text = "Proceedings of the IEEE"} + ", 1998.";

	t + Gap()
	+ Bullet({Text = "[3] ", Type = DE_BULLET_CUSTOMTEXT}) + "S. Lyu and E. P. Simoncelli, “Nonlinear image representation using divisive normalization,” in " + {Italic = 1, Text = "CVPR"} + ", 2008.";

	t + Gap()
	+ Bullet({Text = "[4] ", Type = DE_BULLET_CUSTOMTEXT}) + "N. Pinto, D. D. Cox, and J. J. DiCarlo, “Why is real-world visual object recognition hard?” " + {Italic = 1, Text = "PLoS Comput Biol"} + ", vol. 4, no. 1, p. e27, 01 2008.";

	t + Gap()
	+ Bullet({Text = "[5] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. LeCun, B. Boser, J. S. Denker, D. Henderson, R. E. Howard, W. Hubbard, and L. D. Jackel, “Backpropagation applied to handwritten ZIP code recognition,” " + {Italic = 1, Text = "Neural Computation"} + ", 1989.";

	t + Gap()
	+ Bullet({Text = "[6] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. Simard, Patrice, D. Steinkraus, and J. C. Platt, “Best practices for convolutional neural networks applied to visual document analysis,” in " + {Italic = 1, Text = "ICDAR’03."};

	t + Gap()
	+ Bullet({Text = "[7] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Kavukcuoglu, M. Ranzato, R. Fergus, and Y. LeCun, “Learning invariant features through topographic filter maps,” in " + {Italic = 1, Text = "CVPR’09."};

	t + Gap()
	+ Bullet({Text = "[8] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. LeCun, L. Bottou, G. Orr, and K. Müller, “Efficient backprop,” in " + {Italic = 1, Text = "Neural Networks: Tricks of the trade"} + ", 1998.";

	t + Gap()
	+ Bullet({Text = "[9] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Fukushima and S. Miyake, “Neocognitron: A new algorithm for pattern recognition tolerant of deformations and shifts in position,” " + {Italic = 1, Text = "Pattern Recognition"} + ", vol. 15, no. 6, pp. 455–469, 1982.";

	t + Gap()
	+ Bullet({Text = "[10] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Chellapilla, M. Shilman, and P. Simard, “Optimally combining a cascade of classifiers,” in " + {Italic = 1, Text = "Proc. of Document Recognition and Retrieval 13, Electronic Imaging, 6067"} + ", 2006.";

	t + Gap()
	+ Bullet({Text = "[11] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Chellapilla, S. Puri, and P. Simard, “High performance convolutional neural networks for document processing,” in " + {Italic = 1, Text = "IWFHR’06."};

	t + Gap()
	+ Bullet({Text = "[12] ", Type = DE_BULLET_CUSTOMTEXT}) + "A. Abdulkader, “A two-tier approach for arabic offline handwriting recognition,” in " + {Italic = 1, Text = "IWFHR’06."};

	t + Gap()
	+ Bullet({Text = "[13] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Chellapilla and P. Simard, “A new radical based approach to offline handwritten east-asian character recognition,” in " + {Italic = 1, Text = "IWFHR’06."};

	t + Gap()
	+ Bullet({Text = "[14] ", Type = DE_BULLET_CUSTOMTEXT}) + "R. Vaillant, C. Monrocq, and Y. LeCun, “Original approach for the localisation of objects in images,” " + {Italic = 1, Text = "IEE Proc on Vision, Image, and Signal Processing"} + ", vol. 141, no. 4, pp. 245–250, August 1994.";

	t + Gap()
	+ Bullet({Text = "[15] ", Type = DE_BULLET_CUSTOMTEXT}) + "C. Garcia and M. Delakis, “Convolutional face finder: A neural architecture for fast and robust face detection,” " + {Italic = 1, Text = "IEEE Transactions on Pattern Analysis and Machine Intelligence"} + ", 2004."

	t + Gap()
	+ Bullet({Text = "[16] ", Type = DE_BULLET_CUSTOMTEXT}) + "M. Osadchy, Y. LeCun, and M. Miller, “Synergistic face detection and pose estimation with energy-based models,” " + {Italic = 1, Text = "Journal of Machine Learning Research"} + ", vol. 8, pp. 1197–1215, May 2007.";

	t + Gap()
	+ Bullet({Text = "[17] ", Type = DE_BULLET_CUSTOMTEXT}) + "F. Nasse, C. Thurau, and G. A. Fink, “Face detection using GPU-based convolutional neural networks,” pp. 83–90, 2009.";

	t + Gap()
	+ Bullet({Text = "[18] ", Type = DE_BULLET_CUSTOMTEXT}) + "A. Frome, G. Cheung, A. Abdulkader, M. Zennaro, B. Wu, A. Bissacco, H. Adam, H. Neven, and L. Vincent, “Large-scale privacy protection in street-level imagery,” in " + {Italic = 1, Text = "ICCV’09."};

	t + Gap()
	+ Bullet({Text = "[19] ", Type = DE_BULLET_CUSTOMTEXT}) + "S. Nowlan and J. Platt, “A convolutional neural network hand tracker.” San Mateo, CA: Morgan Kaufmann, 1995, pp. 901–908.";

	t + Gap()
	+ Bullet({Text = "[20] ", Type = DE_BULLET_CUSTOMTEXT}) + "M. Delakis and C. Garcia, “Text detection with convolutional neural networks,” in " + {Italic = 1, Text = "International Conference on Computer Vision Theory and Applications (VISAPP 2008)"} + ", 2008";

	t + Gap()
	+ Bullet({Text = "[21] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. LeCun, U. Müller, J. Ben, E. Cosatto, and B. Flepp, “Off-road obstacle avoidance through end-to-end learning,” in " + {Italic = 1, Text = "Advances in Neural Information Processing Systems (NIPS 2005)"} + ". MIT Press, 2005.";

	t + Gap()
	+ Bullet({Text = "[22] ", Type = DE_BULLET_CUSTOMTEXT}) + "R. Hadsell, P. Sermanet, M. Scoffier, A. Erkan, K. Kavackuoglu, U. Müller, and Y. LeCun, “Learning long-range vision for autonomous off-road driving,” " + {Italic = 1, Text = "Journal of Field Robotics"} + ", vol. 26, no. 2, pp. 120–144, February 2009.";

	t + Gap()
	+ Bullet({Text = "[23] ", Type = DE_BULLET_CUSTOMTEXT}) + "M. Happold and M. Ollis, “Using learned features from 3d data for robot navigation,” 2007.";

	t + Gap()
	+ Bullet({Text = "[24] ", Type = DE_BULLET_CUSTOMTEXT}) + "V. Jain and H. S. Seung, “Natural image denoising with convolutional networks,” in " + {Italic = 1, Text = "Advances in Neural Information Processing Systems 21 (NIPS 2008)"} + ". MIT Press, 2008.";

	t + Gap()
	+ Bullet({Text = "[25] ", Type = DE_BULLET_CUSTOMTEXT}) + "F. Ning, D. Delhomme, Y. LeCun, F. Piano, L. Bottou, and P. Barbano, “Toward automatic phenotyping of developing embryos from videos,” " + {Italic = 1, Text = "IEEE Transactions on Image Processing"} + ", 2005, special issue on Molecular and Cellular Bioimaging.";

	t + Gap()
	+ Bullet({Text = "[26] ", Type = DE_BULLET_CUSTOMTEXT}) + "V. Jain, J. F. Murray, F. Roth, S. Turaga, V. Zhigulin, K. Briggman, M. Helmstaedter, W. Denk, and H. S. Seung, “Supervised learning of image restoration with convolutional networks.” in " + {Italic = 1, Text = "ICCV’07."};

	t + Gap()
	+ Bullet({Text = "[27] ", Type = DE_BULLET_CUSTOMTEXT}) + "M. Mozer, " + {Italic = 1, Text = "The Perception of Multiple Objects, A Connectionist Approach."} + " MIT Press, 1991.";

	t + Gap()
	+ Bullet({Text = "[28] ", Type = DE_BULLET_CUSTOMTEXT}) + "T. Serre, L. Wolf, and T. Poggio, “Object recognition with features inspired by visual cortex,” in " + {Italic = 1, Text = "CVPR"} + ", 2005.";

	t + Gap()
	+ Bullet({Text = "[29] ", Type = DE_BULLET_CUSTOMTEXT}) + "J. Mutch and D. G. Lowe, “Multiclass object recognition with sparse, localized features,” in " + {Italic = 1, Text = "CVPR"} + ", 2006.";

	t + Gap()
	+ Bullet({Text = "[30] ", Type = DE_BULLET_CUSTOMTEXT}) + "G. E. Hinton and R. R. Salakhutdinov, “Reducing the dimensionality of data with neural networks.” " + {Italic = 1, Text = "Science"} + ", 2006.";

	t + Gap()
	+ Bullet({Text = "[31] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. Bengio, P. Lamblin, D. Popovici, and H. Larochelle, “Greedy layerwise training of deep networks,” in " + {Italic = 1, Text = "NIPS"} + ", 2007.";

	t + Gap()
	+ Bullet({Text = "[32] ", Type = DE_BULLET_CUSTOMTEXT}) + "M. Ranzato, Y. Boureau, and Y. LeCun, “Sparse feature learning for deep belief networks,” in " + {Italic = 1, Text = "NIPS’07"} + ", 2007.";

	t + Gap()
	+ Bullet({Text = "[33] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Jarrett, K. Kavukcuoglu, M.Ranzato, and Y. LeCun, “Whatisthebest multi-stage architecture for object recognition?” in " + {Italic = 1, Text = "Proc. International Conference on Computer Vision (ICCV’09)"} + ". IEEE, 2009.";

	t + Gap()
	+ Bullet({Text = "[34] ", Type = DE_BULLET_CUSTOMTEXT}) + "H. Lee, R. Grosse, R. Ranganath, and A. Y. Ng., “Convolutional deep belief networks for scalable unsupervised learning of hierarchical representations,” in " + {Italic = 1, Text = "ICML"} + ", 2009.";

	t + Gap()
	+ Bullet({Text = "[35] ", Type = DE_BULLET_CUSTOMTEXT}) + "A. Ahmed, K. Yu, W. Xu, Y. Gong, and E. Xing, “Training hierarchical feed-forward visual recognition models using transfer learning from pseudo-tasks,” in " + {Italic = 1, Text = "ECCV"} + ". Springer-Verlag, 2008.";

	t + Gap()
	+ Bullet({Text = "[36] ", Type = DE_BULLET_CUSTOMTEXT}) + "J. Weston, F. Rattle, and R. Collobert, “Deep learning via semi-supervised embedding,” in " + {Italic = 1, Text = "ICML"} + ", 2008.";

	t + Gap()
	+ Bullet({Text = "[37] ", Type = DE_BULLET_CUSTOMTEXT}) + "K. Kavukcuoglu, M. Ranzato, and Y. LeCun, “Fast inference in sparse coding algorithms with applications to object recognition,” Tech. Rep., 2008, tech Report CBLL-TR-2008-12-01.";

	t + Gap()
	+ Bullet({Text = "[38] ", Type = DE_BULLET_CUSTOMTEXT}) + "B. A. Olshausen and D. J. Field, “Sparse coding with an overcomplete basis set: a strategy employed by v1?” " + {Italic = 1, Text = "Vision Research"} + ", 1997.";

	t + Gap()
	+ Bullet({Text = "[39] ", Type = DE_BULLET_CUSTOMTEXT}) + "S. Lazebnik, C. Schmid, and J. Ponce, “Beyond bags of features: Spatial pyramid matching for recognizing natural scene categories,” in " + {Italic = 1, Text = "CVPR"} + ", 2006.";

	t + Gap()
	+ Bullet({Text = "[40] ", Type = DE_BULLET_CUSTOMTEXT}) + "D. G. Lowe, “Distinctive image features from scale-invariant keypoints,” " + {Italic = 1, Text = "International Journal of Computer Vision"} + ", 2004.";

	t + Gap()
	+ Bullet({Text = "[41] ", Type = DE_BULLET_CUSTOMTEXT}) + "N. Dalal and B. Triggs, “Histograms of oriented gradients for human detection,” in " + {Italic = 1, Text = "CVPR"} + ", 2005.";

	t + Gap()
	+ Bullet({Text = "[42] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. LeCun, S. Chopra, R. Hadsell, M. Ranzato, and F. Huang, “A tutorial on energy-based learning,” in " + {Italic = 1, Text = "Predicting Structured Data"} + ", G. Bakir, T. Hofman, B. Schökopf, A. Smola, and B. Taskar, Eds. MIT Press, 2006.";

	t + Gap()
	+ Bullet({Text = "[43] ", Type = DE_BULLET_CUSTOMTEXT}) + "Y. LeCun and L. Bottou, “Lush reference manual,” Tech. Rep., 2002, code available at " + URL("http://lush.sourceforge.net") + ". [Online]. Available: " + URL("http://lush.sourceforge.net");

	t + Gap()
	+ Bullet({Text = "[44] ", Type = DE_BULLET_CUSTOMTEXT}) + "P. Sermanet, K. Kavukcuoglu, and Y. LeCun, “Eblearn: Open-source energy-based learning in C++,” in " + {Italic = 1, Text = "Proc. International Conference on Tools with Artificial Intelligence (ICTAI’09)"} + ". IEEE, 2009.";

	t + Gap()
	+ Bullet({Text = "[45] ", Type = DE_BULLET_CUSTOMTEXT}) + "R. Collobert, “Torch,” presented at the Workshop on Machine Learning Open Source Software, NIPS, 2008.";

	t + Gap()
	+ Bullet({Text = "[46] ", Type = DE_BULLET_CUSTOMTEXT}) + "B. Boser, E. Sackinger, J. Bromley, Y. LeCun, and L. Jackel, “An analog neural network processor with programmable topology,” " + {Italic = 1, Text = "IEEE Journal of Solid-State Circuits"} + ", vol. 26, no. 12, pp. 2017–2025, December 1991.";

	t + Gap()
	+ Bullet({Text = "[47] ", Type = DE_BULLET_CUSTOMTEXT}) + "E. Säkinger, B. Boser, J. Bromley, Y. LeCun, and L. D. Jackel, “Application of the ANNA neural network chip to high-speed character recognition,” " + {Italic = 1, Text = "IEEE Transaction on Neural Networks"} + ", 1992.";

	t + Gap()
	+ Bullet({Text = "[48] ", Type = DE_BULLET_CUSTOMTEXT}) + "O. Nomura and T. Morie, “Projection-field-type vlsi convolutional neural networks using merged/mixed analog-digital approach,” in " + {Italic = 1, Text = "ICONIP’07"} + ".";

	t + Gap()
	+ Bullet({Text = "[49] ", Type = DE_BULLET_CUSTOMTEXT}) + "R. Serrano-Gotarredona, M. Oster, P. Lichtsteiner, A. Linares-Barranco, R. Paz-Vicente, F. Gómez-Rodríguez, L. Camunas-Mesa, R. Berner, M. Rivas-Pérez, T. Delbrück, S.-C. Liu, R. Douglas, P. Häfliger, G. Jiménez-Moreno, A. C. Ballcels, T. Serrano-Gotarredona, A. J. Acosta-Jiménez, and B. Linares-Barranco, “Caviar: a 45k neuron, 5m synapse, 12g connects/s aer hardware sensory-processing-learning-actuating system for high-speed visual object recognition and tracking,” " + {Italic = 1, Text = "Trans. Neur. Netw."} + ", vol. 20, no. 9, pp. 1417–1438, 2009.";

	t + Gap()
	+ Bullet({Text = "[50] ", Type = DE_BULLET_CUSTOMTEXT}) + "J. Cloutier, E. Cosatto, S. Pigeon, F. Boyer, and P. Y. Simard, “Vip: An FPGA-based processor for image processing and neural networks,” in " + {Italic = 1, Text = "MicroNeuro"} + ", 1996.";

	t + Gap()
	+ Bullet({Text = "[51] ", Type = DE_BULLET_CUSTOMTEXT}) + "C. Farabet, C. Poulet, J. Y. Han, and Y. LeCun, “Cnp: An FPGA-based processor for convolutional networks,” in " + {Italic = 1, Text = "International Conference on Field Programmable Logic and Applications"} + ", 2009.";

	t + Gap()
	+ Bullet({Text = "[52] ", Type = DE_BULLET_CUSTOMTEXT}) + "C. Farabet, C. Poulet, and Y. LeCun, “An FPGA-based stream processor for embedded real-time vision with convolutional networks,” in " + {Italic = 1, Text = "Fifth IEEE Workshop on Embedded Computer Vision (ECV’09)"} + ". IEEE, 2009.";

	TextFlow(params.Page, 5, 2, 100, params.X, params.Y, params.w_col, params.H, t, {VAlign = DE_VALIGN_JUSTIFIED}, [{Adjust = 12, Dy = params.h_authors + params.h_title + 240, Count = 2}]);
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
	params.h_authors <- 500;

	TextArea(p, x, y + 160, w, 0, {Text = "Convolutional Networks and Applications in Vision", Align = DE_ALIGN_CENTER, FontSize = 170, FontUniqueID = "F0011_STIX1__cS4", RowboundMarginTop = -100, RowboundMarginBottom = -100, RowboundOutlineColor = "508EFA00", RowboundOutlineThickness = 800, RowboundMerge = 1}, {RowType = DE_ROW_WIN});

	MakeArticle(Article_Authors, "ARTICLE 1 - Authors", params);
	MakeArticle(Article_MainContent, "ARTICLE 1 - Article Text", params);
}
