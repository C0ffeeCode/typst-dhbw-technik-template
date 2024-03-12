
#let acronyms = yaml("acronyms.yml");
#let acroStates = state("acronymStates", ());

#let english_pack = (
	degree_1: "for the",
	degree_2: "from the Course of Studies Computer Science",
	by: "by",
	time_period: "Time Period",
	student_id_course: "Student ID, Course",
	company: "Company",
	supervisor: "Supervisor in the Company",
	decleration: (type, title) => [
		= Author's Declaration

		Hereby I solemnly declare:

		+ that this #type, titled #text(style: "italic")[#title] is entirely the product of my own scholarly work, unless otherwise indicated in the text or references, or acknowledged below;

		+ I have indicated the thoughts adopted directly or indirectly from other sources at the appropriate places within the document;

		+ this #type has not been submitted either in whole or part, for a degree at this or any other university or institution;

		+ I have not published this #type in the past;

		// + the printed version is equivalent to the submitted one.

		I am aware that a dishonest declaration will entail legal consequences.
	],
	abstract: "Abstract",
	contents: "Contents",
	list_of_figures: "List of Figures",
	acronyms: "Acronyms",
	bibliography: "Bibliography",
	chapter: "Chapter",
	section: "Section",
	confidentiality_clause: [
		= Confidentiality Clause

		The content of this work may not be made accessible to people outside of the
		testing process and the evaluation process neither as a whole nor as excerpts,
		unless an authorization stating otherwise is presented by the training facility.
	]
)

// TODO: Check alignment to LaTeX template
#let german_pack = (
	degree_1: "für den",
	degree_2: "im Studiengang Informatik an der Dualen Hochschule Baden-Württemberg Stuttgart",
	by: "von",
	time_period: "Bearbeitungszeitraum",
	student_id_course: "Matrikelnummer, Kurs",
	company: "Ausbildungsfirma",
	supervisor: "Betreuer",
	decleration: (type, title) => [
		== Erklärung

		Ich erkläre hiermit ehrenwörtlich:
		+ dass ich meine #type mit dem Thema #title ohne fremde Hilfe
			angefertigt habe;
		+ dass ich die Übernahme wörtlicher Zitate aus der Literatur sowie die Verwendung
			der Gedanken anderer Autoren an den entsprechenden Stellen innerhalb der
			Arbeit gekennzeichnet habe;
		+ dass ich meine T1000 bei keiner anderen Prüfung vorgelegt habe;

		Ich bin mir bewusst, dass eine falsche Erklärung rechtliche Folgen haben wird.

		#title
		*a big & fat _TODO_!*
	],
	abstract: "Abstract",
	contents: "Inhaltsverzeichnis",
	list_of_figures: "Abbildungsverzeichnis",
	acronyms: "Abkürzungsverzeichnis",
	bibliography: "Literaturverzeichnis",
	chapter: "Kapitel",
	section: "Abschnitt",
	confidentiality_clause: [
		= Sperrvermerk
	
		Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des
		Prüfungs- und des Evaluationsverfahrens zugänglich gemacht werden, sofern keine anders
		lautende Genehmigung des Dualen Partners vorliegt.
	]
)

#let thesis(
	// the title of your thesis
	title: none,
	// your name
	author: none,
	// your student id / matriculation number
	student_id: none,
	// the name of your course, such as "TINF21A"
	course: none,
	signature: none,

	// the name of your supervisor
	supervisor: none,

	// the due date of your thesis
	date: none,
	// the time period that the work described in your thesis took place in
	time_period: none,

	// the type of your thesis, such as T1000, T2000, etc.
	type: none,
	// your degree, such as "Bachelor of Science"
	degree: "Bachelor of Science",
	// your major, such as "Computer Science"
	major: "Computer Science",
	// Change the language to `de` if desired
	language: "en",

	// Details on your university
	university: (
		name: "Cooperative State University Baden-Württemberg",
		location: "Stuttgart",
		image: "assets/dhbw.svg",
	),

	// Details on your company
	company: (
		name: "Hewlett Packard Enterprise",
		image: "assets/hpe.svg",
	),

	// Does the document require a Confidentiality Clause?
	confidentiality_clause: false,

	// Path to your bibliography file
	// You may use `.yml` for Hayagriva format
	// or `.bib` for BibLaTeX format
	bibliography_path: "literature.yml",

	// The contents of your abstract
	abstract: include "./abstract.typ",

	// First chapter of your thesis
	// This is required to generate the content section correctly
	first_chapter_title: "Introduction",

	// set automatically by using the template via `#show: thesis.with(...)
	body,
) = [
	// Assert all parameters are set
	#assert.ne(title, none)
	#assert.ne(author, none)
	#assert.ne(student_id, none)
	#assert.ne(type, none)
	#assert.ne(course, none)
	#assert.ne(date, none)
	#assert.ne(time_period, none)
	#assert.ne(supervisor, none)

	// Use english by default
	#let selected_lang = if language == "de" {german_pack} else {english_pack}

	#set document(
		title: title,
		author: author,
	)

	#set page(
		paper: "a4",
		margin: 2.5cm,
		numbering: none, // don't number the first pages, i.e. titlepage and abstract
	)

	// suggested font and font size by the DHBW style guide
	#set text(
		font: "Linux Libertine", // Linux Biolinum O
		// font: "Linux Biolinum O",
		size: 12pt,
		hyphenate: false,
		lang: language,
		ligatures: true,
	)

	#set par(
		leading: 8pt, // 1.5x line spacing
		justify: true,
		linebreaks: "optimized",
	)

	#set figure(
		numbering: "I"
	)

	// don't outline or number the first headings
	#set heading(
		numbering: none,
		outlined: false,
	)

	// modify the spacing between various headings and the content below them
	#show heading: it => {
		let sizes = if it.level == 1 {
			(64pt, 24pt, 24pt)
		} else if it.level == 2 {
			(32pt, 20pt, 18pt)
		} else {
			(24pt, 16pt, 14pt)
		}

		// On top-level headers, do a weak pagebreak
		// (weak = no pagebreak on already blank pages)
		if it.level == 1 {
			pagebreak(weak: true)
		}

		[
			#set text(size: sizes.at(2))
			#v(sizes.at(0))
			#if it.numbering != none [
				#counter(heading).display(it.numbering) #h(4pt) #it.body
			] else [#it.body]
			#v(sizes.at(1))
		]
	}
	// Alternative formating for headdings
	// #show heading: it => {
	//   v(1em)
	//   if it.numbering != none {
	//     grid(
	//       columns: (auto, auto),
	//       {
	//         numbering(it.numbering, ..counter(heading).at(it.location()))
	//         h(24pt / it.level)
	//       },
	//       it.body,
	//     )
	//   } else {
	//     it.body
	//   }
	//   v(0.5em)
	// }
	// #show heading.where(level: 1): set text(size: 24pt)
	// #show heading.where(level: 2): set text(size: 20pt)
	// #show heading.where(level: 3): set text(size: 16pt)

	// Style figure captions
	// TODO: consider reenabling, broken
	// #show figure : it => block(breakable: false)[
	// 	#v(15pt, weak: true)
	// 	#it.body
	// 	#align(center)[
	// 		// #v(.5em)
	// 		#block(width: 80%, text(size: .9em)[
	// 			#it.supplement #it.counter.display(it.numbering):
	// 			#emph(it.caption.text)
	// 		])
	// 		#v(15pt)
	// 	]
	// ]

	// rename level 1 headings to "Chapter", otherwise "Section"
	#set ref(supplement: it => {
		if it.func() == heading and it.level == 1 {
			selected_lang.chapter
		} else {
			selected_lang.section
		}
	})

	// beginning of the document, render the title page

	#set align(center)

	// nice
	#grid(
		columns: (1fr, 1fr),
		align(center)[
			#image(company.image, width: 69%)
		],
		align(center)[
			#image(university.image, width: 69%)
		],
	)
	#v(64pt)

	#set par(justify: false)
	#text(20pt)[*#title*]
	#v(32pt)
	#set par(justify: true)

	#text(16pt)[*#type*]
	#v(16pt)

	#text(14pt, selected_lang.degree_1)

	#text(14pt)[*#degree*]

	#text(14pt)[#selected_lang.degree_2 #major]
	#v(32pt)

	#text(14pt, selected_lang.by)

	#text(16pt)[*#author*]
	#v(16pt)

	#text(14pt)[#date]

	#set align(bottom)

	#grid(
		columns: (1fr, 0.5fr, 1fr),
		align(left)[
			*#selected_lang.time_period* \
			*#selected_lang.student_id_course* \
			*#selected_lang.company* \
			*#selected_lang.supervisor*
		],
		none,
		align(left)[
			#time_period \
			#student_id, #course \
			#company.name \
			#supervisor
		],
	)

	#pagebreak()
	#set align(top)
	#set align(left)

	// initially set the page numbering to roman
	#set page(numbering: "I")
	#counter(page).update(1)

	// https://www.dhbw.de/fileadmin/user_upload/Dokumente/Broschueren_Handbuch_Betriebe/Infoblatt_Vertraulichkeit.pdf
	// English by default
	#if confidentiality_clause {
		selected_lang.confidentiality_clause
		pagebreak(weak: true)
	}

	// render the abstract aligned to the center of the page
	#set align(horizon)
	#set align(center)

	#heading(outlined: true, selected_lang.abstract)

	#block(width: 70%)[#abstract]

	#pagebreak()

	#set align(top)
	#set align(start)

	#(selected_lang.decleration)(type, title)
	
	#v(48pt)

	#university.location, #date
	// #v(48pt)

	#box(width: 196pt, height: 40pt)[
		#if signature == "hide" {
			box(height: 50pt)
		} else if signature == none {
			[
				Set your signature by setting the `signature` argument
				to an image or set it to `hide`, to leave place for signing otherwise
				#v(2pt)
			]
		} else {
			image(signature)
		}
		#v(0pt, weak: true)
		#line(length: 100%)
		#author
	]

	#pagebreak()

	= #selected_lang.contents

	#locate(loc => {
		let headings = query(heading, loc)
		let before_content = true
		let after_content = false

		for elem in headings {
			// kind of hacky, we track whether the main document has started by looking for a chapter by name
			if elem.body == [#first_chapter_title] {
				before_content = false
			}

			// similarly, track the end of the main content by the position of the "Bibliography" chapter
			if elem.body == [#selected_lang.bibliography] {
				after_content = true
			}

			// page numbers of the main document are arabic, the first pages are roman
			let index_fmt = if before_content {
				"I"
			} else {
				"1"
			}

			let location = elem.location()
			let page_index = counter(page).at(location).at(0)

			let formatted_index = numbering(index_fmt, page_index)

			// only the main content should be numbered
			let formatted_name = if before_content or after_content {
				elem.body
			} else [
				#numbering("1.1", ..counter(heading).at(location))
				#h(4pt)
				#elem.body
			]

			let is_chapter = elem.level == 1

			// indent headings in the table of contents based on their level
			let indent = if is_chapter {
				0pt
			} else if elem.level == 2 {
				2em
			} else {
				4em
			}

			// non-chapter headings have their line filled with dots
			let spacer = if is_chapter { " " } else { " . " }

			// if elem.body != [#selected_lang.abstract] and elem.outlined != false {
			if elem.outlined != false {
				link(
					location,
					[
						#h(indent)
						// add extra spacing between chapters
						#if is_chapter {v(1pt)}
						// chapters are bold, sections are not
						#if is_chapter [*#formatted_name*] else [#formatted_name]
						#box(width: 1fr, repeat(spacer))
						#h(8pt)
						#if is_chapter [*#formatted_index*] else [#formatted_index] \
					],
				)
			}
		}
	})

	// #outline(target: heading.)

	// #show outline.entry.where(
	//   level: 1
	// ): it => {
	//   v(12pt, weak: true)
	//   strong(it)
	// }

	// #outline(target: heading, depth: 3, indent: 2em, fill: repeat(" . "))

	#pagebreak()

	// start adding headings to the outline after the table of contents
	#set heading(outlined: true)

	#show outline.entry: it => [
		#v(12pt, weak: true) #it
	]

	// List of figures
	= #selected_lang.list_of_figures
	#outline(target: figure, title: none, fill: repeat(" . "))

	#pagebreak()

	= #selected_lang.acronyms

	#let acroArr = ();
	#for (k, v) in acronyms.pairs().sorted(key: s => lower(s.at(0))) {
		acroArr.push([*#k* #label(k)]);
		acroArr.push([#v]);
	}

	#table(
		columns: (1fr, 6fr),
		align: horizon,
		stroke: none,
		..acroArr,
	)

	#pagebreak(weak: true)

	// update heading and page numberings to begin the main part of the document
	#set heading(numbering: "1.1")
	#set page(numbering: "1 / 1")
	#counter(page).update(1)

	// the actual chapters
	#body

	// finally, include the bibliography chapter at the end of the document
	#pagebreak()
	#bibliography(bibliography_path, title: selected_lang.bibliography, style: "ieee")
]

// `pref` if to prefer the long form
#let acro(short, pref: false, append: "") = {
	let item = acronyms.at(short)

	locate(loc => {
	let entries = acroStates.at(loc).filter(e => e == short);

	// Already used once
	if entries.len() > 0 {
		if pref {
			link(label(short))[#item#append]
		} else {
			link(label(short))[#short#append]
		}
	// First usage
	} else {
		acroStates.update(e => {e.push(short); e;});
		if pref {
			link(label(short))[#item#append (#short)]
		} else {
			link(label(short))[#short#append (#item)]
		}
	}
	});
}

#let acroOnce(main, inside) = [#main (#inside)]

#let todo(content) = par(emph([
	#h(5pt) #text(weight: "bold")[To-do/WIP:] #content
]))
