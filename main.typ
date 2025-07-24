#import "/etc/utils.typ"

// styling
#set text(font: "Libertinus Serif", size: 12pt, lang: "de")
#set page(paper: "a4", margin: auto, numbering: "1", number-align: right)
#set par(justify: true, leading: 0.6em, first-line-indent: 12pt)
#set heading(numbering: "1.")
#show heading: value => [
  #set text(weight: "regular")
  #block(smallcaps(value))
  #v(2%)
]
#show link: set text(fill: blue.darken(50%))

// TODOs outline, remove this when finished
#utils.todo_outline

// adding cover page
#include "etc/cover_page.typ"
#pagebreak()

// adding eidestattliche erklaerung
#include "etc/eidesstattliche_erklaerung.typ"
#pagebreak()

// adding abstract
#include "etc/zusammenfassung.typ"
#pagebreak()

// adding table of contents
#outline()
#pagebreak()

// adding glossary
#include "etc/glossary.typ"
#pagebreak()

// adding chapters
#include "chapters/einleitung/einleitung.typ"
#pagebreak()
#include "chapters/technik_stand.typ"
#pagebreak()
#include "chapters/evaluierung_loesungsansaetze.typ"
#pagebreak()
#include "chapters/beschreibung_loesungsansatz.typ"
#pagebreak()
#include "chapters/ergebnis.typ"
#pagebreak()
#include "chapters/fazit.typ"
#pagebreak()

// adding appendices
#bibliography("resources/references.bib", style: "ieee", title: "Literaturverzeichnis")
#pagebreak()
#outline(title: "Abbildungsverzeichnis", target: figure.where(kind: image))
#pagebreak()
#outline(title: "Tabellenverzeichnis", target: figure.where(kind: table))
