#import "template.typ" : *

#show: thesis.with(
  title: "Creating a Typst template",
  author: "Your name",
  type: "TX000",
  student_id: "change-me",
  course: "TINF2XA",
  date: datetime(
    year: 1984,
    month: 10,
    day: 10,
  ),
  time_period_start: datetime(
    year: 1984,
    month: 1,
    day: 1,
  ),
  confidentiality_clause: true,
  language: "en",
  supervisor: "Someone",
  signature: none, // TODO
	bibliography_path: "literature.bib",
  additional_preamble: (
    // You could put files to place before the table of contents here
  )
)

// NOTE: https://www.dhbw.de/fileadmin/user_upload/Dokumente/Dokumente_fuer_Studierende/191212_Leitlinien_Praxismodule_Studien_Bachelorarbeiten.pdf

// Requirements:
// - 25-35 pages without directories und attachments
//   incl. graphics and tables
// - must document: task, process of implementation, solutions and results

// Include your chapters here
#include "./chapters/01-Introduction.typ"

= Summary and Conclusion

#lorem(250)
