# name: MathJax support for Discourse
# version: 0.4.1
# authors: Sam Saffron, Kasper Peulen

register_asset('javascripts/tex_dialect.js', :server_side)
register_javascript <<JS 

Discourse.addInitializer(function () {
	var mathjaxUrl = (window.location.protocol === 'https:') ? 'https://c328740.ssl.cf1.rackcdn.com/mathjax/latest/MathJax.js' : 'http://cdn.mathjax.org/mathjax/latest/MathJax.js';
	$LAB.script(mathjaxUrl + '?config=TeX-AMS-MML_HTMLorMML').wait(function () {

		MathJax.Hub.Config({
			"HTML-CSS": {
				preferredFont: "TeX",
				availableFonts: ["TeX"],
				linebreaks: {
					automatic: true
				},
				EqnChunk: (MathJax.Hub.Browser.isMobile ? 10 : 50)
			},
			tex2jax: {
				inlineMath: [
					["$", "$"],
					["\\\\(", "\\\\)"]
				],
				displayMath: [
					["$$", "$$"],
					["\\\\[", "\\\\]"]
				],
				processEscapes: true
			},
			TeX: {
				equationNumbers:{
					autoNumber: "AMS"
				},
				extensions: ["AMScd.js"],
				noUndefined: {
					attributes: {
						mathcolor: "red",
						mathbackground: "#FFEEEE",
						mathsize: "90%"
					}
				},
				Macros: {
					A: "{\\\\mathcal{A}}",
					abs: ["{\\\\left|{#1}\\\\right|}", 1],
						ad: "{\\\\operatorname{ad}}",
						Ad: "{\\\\operatorname{Ad}}",
						BX: "{\\\\mathbf{B}(X)}",
						CC: "{\\\\mathbb{C}}",
						char: "{\\\\operatorname{char}}",
						DD: "{\\\\mathbb{D}}",
						div: "{\\\\operatorname{div}}",
						embedto: "{\\\\hookrightarrow}",
						End: "{\\\\operatorname{End}}",
						eps: "{\\\\varepsilon}",
						eqdef: "{\\\\mathpunct{:}=}",
						g: "{\\\\mathfrak{g}}",
						gl: "{\\\\mathfrak{gl}}",
						h: "{\\\\mathfrak{h}}",
						H: "{\\\\mathcal{H}}",
						id: "{\\\\operatorname{id}}",
						inner: ["{\\\\langle #1 \\\\rangle}", 1],
						N: "{\\\\mathbb{N}}",
						norm: ["{\\\\left\\\\| #1 \\\\right\\\\|}", 1],
						pfrac: ["\\\\frac{\\\\partial{#1}}{\\\\partial{#2}}", 2],
							pt: "{\\\\partial}",
							ppt: ["{\\\\frac{\\\\pt }{\\\\pt {#1}}}", 1],
								R: "{\\\\mathbb{R}}",
								Real: "{\\\\mathbb{R}}",
								rd: "{\\\\operatorname{d}}",
								set: ["\\\\left\\\\{ {#1} \\\\right\\\\}", 1],
									To: "{\\\\longrightarrow}",
									tr: "{\\\\operatorname{tr}}",
									vol: "{\\\\mathrm{vol}}",
									weakto: "{\\\\rightharpoonup}",
									wc: "{\\\\llcorner}",
									Z: "{\\\\mathbb{Z}}"
				}
			},
			messageStyle: "none"
		});

		var applyPreview = function () {
			MathJax.Hub.Queue(["Typeset", MathJax.Hub, "wmd-preview"]);
			// if the caret is on the last line ensure preview scrolled to bottom
					 var caretPosition = Discourse.Utilities.caretPosition(this.wmdInput[0]);
					 if (!this.wmdInput.val().substring(caretPosition).match(/\\n/)) {
						 var $wmdPreview = $('#wmd-preview');
						 if ($wmdPreview.is(':visible')) {
							 $wmdPreview.scrollTop($wmdPreview[0].scrollHeight);
						 }
					 }
		};

		var applyBody = function () {
			MathJax.Hub.Queue(["Typeset", MathJax.Hub, "topic"]);
		};

		Discourse.PostView.prototype.on("postViewInserted", applyBody);
		Discourse.ComposerView.prototype.on("previewRefreshed", applyPreview);

	});

});
JS
