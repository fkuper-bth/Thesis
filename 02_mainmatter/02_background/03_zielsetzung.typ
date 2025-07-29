#import "/etc/utils.typ"

== Zielsetzung der Thesis <zielsetzung>

Die Ziele dieser Thesis leiten sich aus der Ausgangslage und sich daraus ergebenden Problemstellung ab, die in @ausgangslage und @problemstellung beschrieben sind.

Primäre Zielstellung ist es, eine #utils.gls-short("library") zu konzipieren und zu implementieren, die in Anbetracht der analysierten Problemlage eine Anforderungsgerechte Lösung bietet, die Geschichten, die bereits für #utils.gls-short("kite2") erstellt wurden, als #utils.gls-plural("visual_novel") auf verschiedenen Plattformen spielbar macht. Dabei soll diese jedoch auch auf andere Domänen anwendbar sein, um somit eine generische Lösung zu bieten, die nicht nur auf #utils.gls-short("kite2") beschränkt ist.

In Zusammenarbeit mit den Betreuenden der Thesis wurden eine Reihe von Anforderungen an die zu erstellende #utils.gls-short("library") definiert, die als essentielle Bestandteile der Lösung gelten und somit den Kern dieser Arbeit bilden. Neben Gesprächen mit Betreuenden der Thesis und dem Projektteam von #utils.gls-short("kite2") wurde zusätzlich eine Analyse der #utils.gls-short("kite2") Anwendung durchgeführt.

Die Anforderungen an die #utils.gls-short("library"), die sich hieraus ergeben haben, sind in @tabelle-anforderungen-bibliothek dargestellt.

#let tableRequirementsLibrary = table(
  columns: (40%, 60%),
  table.header([*Kurzbeschreibung*], [*Anmerkungen*]),

  [
    _Darstellen_ und _Ausführen_ von #utils.gls-plural("visual_novel"), die dem für #utils.gls-short("kite2") erstellten Format folgen.
  ],
  [
    Dies beinhaltet:
    - Darstellung von _Texten, Bildern und anderen Medien_, die in den #utils.gls-plural("visual_novel") verwendet werden.
    - _Animierbarkeit_ der einzelnen Darstellungselemente.
    - _Interaktion_ mit den #utils.gls-plural("visual_novel") durch den Nutzer, um Entscheidungen zu treffen und den Verlauf der Geschichte zu beeinflussen.
  ],

  [
    _Exportieren_ von Spieldurchgängen in ein Format, welches für die Weiterverarbeitung durch eine andere Anwendung geeignet ist.
  ],
  [
    - Dies soll es ermöglichen, Spieldurchgänge zu speichern oder anderweitig auszuwerten, wie zum Beispiel zur Analyse durch ein #utils.gls-short("llm").
  ],

  [
    _#utils.gls-short("cross_platform")-Fähigkeit_, um die #utils.gls-plural("visual_novel") auf verschiedenen Plattformen lauffähig zu machen.
  ],
  [
    - Als primäre Zielplattformen gelten Android, iOS und das Web. In Zukunft sollen diese ebenfalls auf Desktop-Plattformen erweitert werden können.
  ],
)
#figure(tableRequirementsLibrary, caption: [Beschreibung der Anforderungen an die #utils.gls-short("library").]) <tabelle-anforderungen-bibliothek>

Neben der Konzeption und Umsetzung der #utils.gls-short("library") soll auch ein Prototyp erstellt werden, der die #utils.gls-short("library") nutzt, um eine #utils.gls-short("cross_platform") Anwendung zu erstellen, die sich an #utils.gls-short("kite2") inhaltlich und in ihrer Darstellung der #utils.gls-plural("visual_novel") orientiert.

Diese Anwendung soll als _Proof of Concept_ fungieren und somit die Funktionalitäten der #utils.gls-short("library") in einem realen Anwendungsfall demonstrieren. Die Anforderungen an diesen Prototypen sind in @tabelle-anforderungen-prototyp dargestellt.

#let tableRequirementsPrototype = table(
  columns: (35%, 65%),
  align: left,
  table.header([*Kurzbeschreibung*], [*Anmerkungen*]),

  [
    _Lauffähigkeit_ auf Android, iOS und im Web.
  ],
  [
    - In Zukunft soll dieser Prototyp ebenfalls auf _Desktop_-Plattformen lauffähig gemacht werden können.
  ],

  [
    Verwendung der im Rahmen dieser Thesis geschaffenen _#utils.gls-short("library")_ zur Darstellung und Ausführung von #utils.gls-plural("visual_novel").
  ],
  [
    - Dies demonstriert einerseits die Funktionalität der #utils.gls-short("library") und andererseits die Möglichkeit, bestehende #utils.gls-plural("visual_novel") in dieser Anwendung zu verwenden.
    - Zusätzlich dokumentiert dies beispielhaft die Verwendung der #utils.gls-short("library") in einer #utils.gls-short("cross_platform") Anwendung.
  ],

  [
    _Wiederverwendung_ der für #utils.gls-short("kite2") geschriebenen Geschichten.
  ],
  [
    - Die für #utils.gls-short("kite2") geschriebenen Geschichten sollen in diesem Prototypen wiederverwendet werden können, ohne dass diese angepasst werden müssen.
  ],

  [
    Möglichkeit der _Auswertung_ von Spieldurchgängen durch ein #utils.gls-short("llm").
  ],
  [
    - Die Spieldurchgänge müssen von der #utils.gls-short("library") in einem Format exportiert werden, welches dem Prototypen ermöglicht, einen wie in @tabelle_kiteII_prompt_struktur strukturierten Prompt zu generieren, der an ein #utils.gls-short("llm") übergeben werden kann.
  ],

  [
    _Speichern_ von Spieldurchgängen, um diese später fortsetzen zu können.
  ],
  [
    - Diese Funktionalität ist zum Zeitpunkt der Erstellung dieser Thesis noch nicht in #utils.gls-short("kite2") implementiert, soll aber im Prototypen demonstriert werden.
  ],
)
#figure(tableRequirementsPrototype, caption: [Beschreibung der Anforderungen an den Prototypen.]) <tabelle-anforderungen-prototyp>

Das Arbeitsergebnis dieser Thesis setzt sich insgesamt aus drei verschiedenen Komponenten zusammen:

1. die_ #utils.gls-short("library")_, die die oben genannten Anforderungen erfüllt und somit eine generische Lösung für die Darstellung und Ausführung von #utils.gls-plural("visual_novel") bietet.
2. der _Prototyp_, der die #utils.gls-short("library") nutzt, um eine #utils.gls-short("cross_platform") Anwendung zu erstellen, die sich an #utils.gls-short("kite2") orientiert.
3. die _Dokumentation_ der Ergebnisse dieser Thesis, die die Konzeption, Implementierung und Evaluation der #utils.gls-short("library") und des Prototypen beschreibt.

Eine genauere Erläuterung der Planung und der einzelnen Arbeitspakete erfolgt in @planung.
