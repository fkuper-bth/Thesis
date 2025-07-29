#import "/etc/utils.typ"

// Define glossary entry list
#let list = (
  (
    key: "visual_novel",
    short: "VN",
    long: "Visual Novel",
    plural: "VNs",
    description: "Eine Form von Interactive Fiction, welches zusätzlich audio-visuelle Elemente wie beispielsweise animierte Illustrationen verwendet.",
  ),
  (
    key: "interaktive_erzählung",
    short: "IE",
    long: "Interaktive Erzählung",
    plural: "IEs",
    description: "Eine Form von Erzählung, bei der der Handlungsverlauf nicht vorbestimmt ist. Nutzer*innen können je nach ihren Entscheidungen einen unterschiedlichen Handlungsverlauf erfahren.",
  ),
  (
    key: "interactive_fiction",
    short: "IF",
    long: "Interactive Fiction",
    plural: "IFs",
    description: "Ein textbasiertes Videospielgenre, bei dem Spieler*innen Einfluss auf die Handlung nehmen können.",
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
  (
    key: "serious_game",
    short: "Serious Game",
    plural: "Serious Games",
    description: "Ein Spiel, das nicht primär zur Unterhaltung, sondern zur Vermittlung von Wissen oder Fähigkeiten entwickelt wurde.",
  ),
  (
    key: "gamification",
    short: "Gamification",
    description: "Die Anwendung spieltypischer Elemente in einem nicht-spielerischen Kontext, um die Nutzererfahrung zu verbessern und das Engagement zu erhöhen.",
  ),
  (
    key: "prompt_engineering",
    short: "Prompt Engineering",
    description: "Prozess der Strukturierung einer Anfrage an ein generatives KI-Modell mit dem Ziel der Optimierung der Ausgabequalität.",
  ),
  (
    key: "bias",
    short: "Bias",
    plural: "Biases",
    description: "Im Fachbereich der Psychologie (auch kognitive Verzerrung oder kognitiver Fehler genannt): Eine systematische Abweichung von Normen oder Rationalität im Urteil. Biases können zu Wahrnehmungsverzerrung, ungenaue Beurteilung oder Irrationalität führen.",
  ),
  (
    key: "immersion",
    short: "Immersion",
    description: "Im Fachbereich der Videospiele: die Wahrnehmung physisch präsent in einer nicht-physischen Welt zu sein.",
  ),
  (
    key: "gui",
    short: "GUI",
    plural: "GUIs",
    long: "Grafische Benutzeroberfläche",
    longplural: "Grafische Benutzeroberflächen",
    description: "Eine Art von Benutzerschnittstelle, die es Nutzer*innen ermöglicht, mit Computern über visuelle Elemente zu interagieren.",
  ),
  (
    key: "bga",
    short: "BGA",
    long: "Bundesweite Gründerinnenagentur",
    description: "Ein deutschlandweites Kompetenz- und Servicezentrum zur unternehmerischen Selbstständigkeit von Frauen.",
  ),
  (
    key: "kite",
    short: "KITE",
    long: "KI Thinktank female Entrepreneurship",
    description: "Projekt der BGA zur Diskriminierungs-Bekämpfung für Gründerinnen durch gezielten Kompetenzaufbau beim Erkennen und Bewältigen von Diskriminierungsmustern.",
  ),
)
