#import "/etc/utils.typ"
#import "/etc/glossary_entries.typ"

// root level styling rules
#set text(font: "Libertinus Serif", size: 12pt, lang: "de")
#set page(paper: "a4", margin: auto, numbering: "1", number-align: right)
#set par(justify: true, leading: 0.6em, first-line-indent: 12pt)
#set heading(numbering: "1.")
#set table(
  fill: (utils.colorScheme.hhnBlueLight.lighten(95%), none),
  stroke: utils.tableFrame(utils.colorScheme.hhnBlueLight),
  align: left,
  inset: 8pt,
)
#show heading: value => [
  #set text(weight: "regular")
  #block(smallcaps(value))
  #v(2%)
]
#show link: set text(fill: utils.colorScheme.hhnBlue)
#show: utils.codly-init.with()
#utils.codly(languages: utils.codly-languages, zebra-fill: none)

// TODOs outline, remove this when finished
#utils.todo_outline

// register glossary entries
#include "/etc/glossary_entries.typ"
#utils.register-glossary(glossary_entries.list)

// add frontmatter
#include "01_frontmatter/section_main.typ"
#pagebreak()

// add mainmatter
#include "02_mainmatter/section_main.typ"
#pagebreak()

// add backmatter
#include "03_backmatter/section_main.typ"
