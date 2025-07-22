#import "/etc/utils.typ"

#set heading(numbering: none)
#show: utils.make-glossary

// Define glossary entry list
#let glossary-entry-list = (
  (
    key: "visual_novel",
    short: "VN",
    long: "Visual Novel",
    description: "Eine interaktive Geschichte mit audio-visuellen Elementen.",
  ),
  (
    key: "cross_platform",
    short: "Cross-Platform",
    description: "Beschreibt Software, die auf mehreren Betriebssystemen lauffähig ist.",
  ),
  // Add more terms
)
#utils.register-glossary(glossary-entry-list)


= Glossar <glossary>

#utils.print-glossary(glossary-entry-list, show-all: true)
#pagebreak()
