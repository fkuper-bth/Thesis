// don't number headings in the front matter and user roman numerals for page numbering
#set heading(numbering: none)
#set page(numbering: "i")

#include "01_cover_page.typ"
#pagebreak()

#include "02_eidesstattliche_erklaerung.typ"
#pagebreak()

// reset page number to exclude cover page and statuary declaration from counting
#counter(page).update(1)

#include "03_abstract.typ"
#pagebreak()

= Inhaltsverzeichnis <inhaltsverzeichnis>
#outline(title: none)
#pagebreak()

= Tabellenverzeichnis <tabellenverzeichnis>
#outline(title: none, target: figure.where(kind: table))
#pagebreak()

= Abbildungsverzeichnis <abbildungsverzeichnis>
#outline(title: none, target: figure.where(kind: image))
#pagebreak()

= Listings <listings>
#outline(title: none, target: figure.where(kind: raw))
