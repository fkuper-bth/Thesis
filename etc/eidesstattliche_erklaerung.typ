#import "/etc/utils.typ"

#set page(numbering: none)
#set heading(numbering: none, outlined: false)
#let signingLineLength = 85%

= Eidesstattliche Erklärung

Hiermit erkläre ich eidesstattlich, dass die vorliegende Arbeit von mir selbstständig und ohne
unerlaubte Hilfe angefertigt wurde, insbesondere, dass ich alle Stellen, die wörtlich oder annähernd wörtlich oder dem Gedanken nach aus Veröffentlichungen und unveröffentlichten Unterlagen und Gesprächen entnommen worden sind, als solche an den entsprechenden Stellen innerhalb der Arbeit durch Zitate kenntlich gemacht habe, wobei in den Zitaten jeweils der Umfang der entnommenen Originalzitate kenntlich gemacht wurde. Ich bin mir bewusst, dass eine falsche Versicherung rechtliche Folgen haben wird.

#utils.todo([Abgabetermin aktualisieren])

#pad(top: 3cm)[
  #grid(
    columns: 2,
    rows: 1,
    row-gutter: 4cm,
    [
      #align(left + bottom)[Heilbronn, 8. August 2025]
      #align(left + bottom, line(length: signingLineLength))
      #align(left + bottom)[Ort, Datum]
    ],
    [
      #align(right + bottom, line(length: signingLineLength))
      #align(right + bottom)[Unterschrift]
    ],
  )
]

