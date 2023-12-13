#import "template.typ" : *

#show: thesis.with(
  title: "Creating a Typst template",
  author: "Your name",
  type: "TX000",
  student_id: "change-me",
  course: "TINF2XA",
  date: "00.00.2024",
  time_period: "01.01.2023 - 00.00.2024",
  supervisor: "Someone",
  signature: none, // TODO
)

// NOTE: https://www.dhbw.de/fileadmin/user_upload/Dokumente/Dokumente_fuer_Studierende/191212_Leitlinien_Praxismodule_Studien_Bachelorarbeiten.pdf

// Requirements:
// - 25-35 pages without directories und attachments
//   incl. graphics and tables
// - must document: task, process of implementation, solutions and results
// - proof that a connection between theoretical and practical was made
//   and that the holy theory taught by the DHBW is of relevance
// - No

= Introduction

#include "./chapters/01-Introduction.typ"

#pagebreak()

= Technical Background

== Spell checking

You can use #link("https://github.com/crate-ci/typos")[Typos],
but I am too lazy to explain.

#pagebreak()
= Summary and Conclusion

#lorem(100)
