#import "/etc/utils.typ"

#set heading(numbering: none)
#show: utils.make-glossary

// Define glossary entry list
#let glossary-entry-list = (
  (
    key: "visual_novel",
    short: "VN",
    long: "Visual Novel",
    plural: "VNs",
    description: "Eine interaktive Geschichte mit audio-visuellen Elementen.",
  ),
  (
    key: "cross_platform",
    short: "Cross-Platform",
    description: "Beschreibt Software, die auf mehreren Betriebssystemen lauffähig ist.",
  ),
  (
    key: "ssot",
    short: "SSOT",
    long: "Single Source of Truth",
    description: "Ein Konzept in Informationssystemen, welches besagt, dass Informationsmodelle so strukturiert sein sollen, dass sie nur an einem einzigen Ort bearbeitet werden. Dieser ist der 'einzige Ort der Wahrheit'.",
  ),
  (
    key: "dsl",
    short: "DSL",
    plural: "DSLs",
    long: "Domain-Specific Language",
    description: "Eine Programmiersprache, die speziell für eine bestimmte Anwendungsdomäne entwickelt wurde.",
  ),
  (
    key: "gpl",
    short: "GPL",
    plural: "GPLs",
    long: "General Purpose Language",
    description: "Eine Programmiersprache, die für eine breite Palette von Anwendungen geeignet ist.",
  ),
  (
    key: "library",
    short: "Bibliothek",
    plural: "Bibliotheken",
    long: "Programmbibliothek",
    description: "Eine Sammlung von Funktionen und Klassen, die Lösungen für thematisch zusammengehörenden Problemstellungen anbieten.",
  ),
  (
    key: "framework",
    short: "Framework",
    plural: "Frameworks",
    long: "Software-Framework",
    description: "Ein Software-Framework ist ein Programmiergerüst, innerhalb dessen eine Anwendung erstellt werden kann. Dieses gibt in der Regel eine Anwendungsarchitektur vor und unterscheidet sich von einer Bibliothek durch Inversion of Control (deutsch Steuerungsumkehr).",
  ),
  (
    key: "ioc",
    short: "IoC",
    long: "Inversion of Control",
    description: "Design-Prinzip der Software-Entwicklung, bei dem die Steuerungskontrolle von der Anwendung an eine externe Komponente (wie ein Framework) übergeben wird.",
  ),
  (
    key: "kite2",
    short: "KITE II",
    description: "Projekt zur Entwicklung einer KI-gestützten, gamifizierten Anwendung, die Gründerinnen dabei unterstützen soll, resilienter im Umgang mit diskriminierenden Erfahrungen im Gründungsprozess zu werden.",
  ),
  (
    key: "llm",
    short: "LLM",
    long: "Large Language Model",
    plural: "LLMs",
    description: "Ein großes Sprachmodell, das auf maschinellem Lernen basiert und in der Lage ist, menschenähnliche Texte zu generieren und zu verstehen.",
  ),
  (
    key: "twine",
    short: "Twine",
    description: "Ein Open-Source-Werkzeug zur Erstellung interaktiver Geschichten.",
  ),
)
#utils.register-glossary(glossary-entry-list)


= Glossar <glossary>

#utils.print-glossary(glossary-entry-list, show-all: true)
