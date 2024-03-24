#import "../template.typ": *

Fist, in the `thesis.typ` file, adapt the configuration to match your requirements.
For further configuration, look in the upper part of the `template.typ` file,
e.g. to learn how to change the company name and logo.
Of cause, you may change other parts of the template to adapt it to your preferences.

Also, make sure to read the #link("https://typst.app/docs/")[Typst documentation].

This template is for english documents only (for now),
but one could translate it...

To configure your the language of your thesis,
set the `language` parameter to either `en` (default) or `de`.

*Note* that the template needs to know your first chapter,
you can supply it if it is not "Introduction" using the `first_chapter_title` parameter.

#figure(```typ
  #show: thesis.with(
    ...
    first_chapter_title = "Introduction but with another title",
    language: "en",
  )
  ```, kind: "code", supplement: "Code example",
  caption: [Code example explaining how to configure language and a different first chapter]
)

// By default, the template will *not* apply a pagebreak
// on non-top-level headings to avoid headings without content
// on the same page but can be enabled.
// The threshold percentage on the page can be configured
// by providing the `heading_pagebreak_percentage` propery like `0.7` or `none`.
// Top-level headings will always have a (weak) pagebreak.

== Bibliography

As for bibliography / reference listing,
you may decide whether to use "Hayagriva", a yaml-based format format designed for Typst
or BibTeX (`.bib`) format, which is _well supported by other platforms
and tooling_ since it is commonly used by LaTeX.
To switch between bibliography formats, change the above to the following:

#figure(```typ
  #show: thesis.with(
    ...
    bibliography_path = "literature.bib", // or literature.yml for Hayagriva
  )
  ```, kind: "code", supplement: "Code example",
  caption: [Code example on how to use different bibliography formats with this template]
)

== Proposed Structure

But of cause, you can do it as you like.

Put each chapter in the `chapter/` directory,
prefixed i.e. with `01-` if it is the first chapter.
I'd recommend using CamelCase or snake_case but not spaces.
Also, I would recommend deciding if to put the heading `= Introduction`
in these files or to the parent file.

You can include files using the following e.g:
```typ
#include ./chapters/01-example.typ
```

If your chapter gets too large for one file, create a subdirectory
in `chapters` with the chapters name,
and create files for the different sections.

== Acronyms

These are implemented provided by this template, not typst itself.

You can use them like:

```typ
#acro("HPE")
#acro("HPE", pref: true) // To prefer the long version
#acro("JSON", append: "-schemata")
```

+ #acro("HPE")
+ #acro("HPE", pref: true) // To prefer the long version
+ #acro("JSON", append: "-schemata")

== TODO marker

Well, if you are too lazy to write now,
just add a todo-marker.

```typ
#todo([Your #strike[excuse] notes on what change here])
```

For example:
#todo([I could probably write more on how to use this template and Typst in general, if I wouldn't be too lazy...])

And the template makes sure it is well readable in the PDF and not forgotten.

== Once you are done

Add a signature to your thesis.
Use the `signature` property.
Set it to `hide`, to leave some blank space for you to sign manually,
e.g. in a printed version.
Or put in the path to your signature image or svg.
