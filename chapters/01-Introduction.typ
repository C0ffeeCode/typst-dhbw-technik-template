#import "/template.typ": *

// Keep the import above, the following is just an example


= Introduction

Fist, in the `thesis.typ` file, adapt the configuration to match your requirements.
For further configuration, look in the upper part of the `template.typ` file,
e.g. to learn how to change the company name and logo.
Of cause, you may change other parts of the template to adapt it to your preferences.

Also, make sure to read the #link("https://typst.app/docs/")[Typst documentation].

This template is for english documents only (for now),
but one could translate it...

To configure your the language of your thesis,
set the `language` parameter to either `en` (default) or `de`.

#figure(```typ
  #show: thesis.with(
    ...
    company: (
      name: "Hewlett Packard Enterprise",
      image: "assets/hpe.svg",
    ),
    language: "en",
  )
  ```, kind: "code", supplement: "Code example",
  caption: [Code example explaining how to configure language and your company]
)

== Bibliography

As for bibliography / reference listing,
you may decide whether to use "Hayagriva", a yaml-based format format designed for Typst
or BibTeX (`.bib`) format, which is _well supported by other platforms and tooling_
since it is commonly used by LaTeX.
You may use the Zotero `zotero-better-bibtex` extension
for automatic synchronization.
To switch between bibliography formats, change the above to the following:

#figure(```typ
  #show: thesis.with(
    ...
    bibliography_path = "literature.bib", // or literature.yml for Hayagriva
    customized_ieee_citations = true, // default
  )
  ```, kind: "code", supplement: "Code example",
  caption: [Code example on how to use different bibliography formats with this template]
)

By default, this template displays ISBNs in the Bibliography.
If no DOI is known, the ISBN is shown instead, and as a fallback the URL if available.
This deviates from the normal/usual IEEE citation style.
To disable this behavior and use the normal IEEE,
set ```typ customized_ieee_citations = false```.

You can provide a reference to a good reference @tanenbaum_os[p. 123] like:
#box[```typ @tanenbaum_os```] or #box[```typ @tanenbaum_os[p. 123]```].
They will also show up in the bibliography.

== Proposed Structure

Of cause, you can do it as you like...

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

At the beginning of each `.typ` file, place the following to have all functions accessible:
```typ
#import "/template.typ": *
```

== Acronyms

These are implemented provided by this template, not Typst itself.

You can use them like:

```typ
#acro("HPE")
#acro("HPE", pref: "long") // To prefer the long version
#acro("JSON", append: "-schemata")
```

+ #acro("HPE")
+ #acro("HPE", pref: "long") // To prefer the long version
+ #acro("JSON", append: "-schemata")

Now, once used, acronyms, for example like #acro("HPE"), are displayed in their short form by default.

== TODO marker

Well, if you are too lazy to write now,
just add a todo-marker.

```typ
#todo([Your #strike[excuse] notes on what change here])
```

For example:
#todo([I could probably write more on how to use this template and Typst in general, if I wouldn't be too lazy...])

And the template makes sure it is well readable in the PDF and and refrains you from signing a document which includes these TODO-markers.

== Once you are done

Add a signature to your thesis.
Use the `signature` property.
Set it to `hide`, to leave some blank space for you to sign manually,
e.g. in a printed version.
Or put in the path to your signature image or svg.

Note that having TODO-markers in your document will refrain you from compiling a signed document to ensure they are not forgotten. 
