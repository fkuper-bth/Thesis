#import "/etc/utils.typ"

= Diskussion <diskussion>

In diesem Kapitel wird die Durchführung dieser Arbeit reflektiert, das Ergebnis evaluiert und über Herausforderungen und Erkenntnisse berichtet.

Außerdem werden offene Punkte detailliert, die für eine Weiterentwicklung der _VisualNovelEngine_ Bibliothek und der _VisualNovelExample_ Applikation relevant sind.

== Errungenschaften <errungenschaften>

Im gegebenen Zeitrahmen wurden eine Reihe von Projekten geschaffen, die eine jeweils unabhängige Funktion erfüllen und zur Gesamtlösung beitragen. Diese lauten wie folgt:

- eine _Spezifikation_, die das für KITE II geschaffene Format von Twine-Geschichten dokumentiert.
- eine _Implementierung der Spezifikation_ in Form eines Twine _Story-Formates_, welches von Autor*innen genutzt werden kann, um die geschriebenen Geschichten in einem leicht maschinen-verarbeitbarem Format zu exportieren.
- eine #utils.gls-long("kmp") _Bibliothek_ zur logischen Verarbeitung der Geschichten, die in diesem Format geschrieben wurden (_StoryEngine_).
- eine #utils.gls-long("cmp") _Bibliothek_ zur Darstellung der Geschichten (_VisualNovelEngine_).
- eine #utils.gls-long("cmp") _Anwendung_, die KITE II Geschichten spielbar macht und darstellt (_VisualNovelExample_).

#utils.todo("Repositories hier jeweils referenzieren?")

Somit wurde in dem gegebenen Zeitrahmen eine Reihe von Tools geschaffen, mit deren Hilfe Visual Novels umgesetzt werden können, die neben spielerischen Aspekten es auch erlauben, Spieler*innen Feedback zum Spielverlauf zu geben und somit einen Lerneffekt ausüben können. Hierfür sind die nötigen Schnittstellen geschaffen, sodass in Zukunft Projekte wie KITE II mit Hilfe der geschaffenen Tools umgesetzt werden können. Dies demonstriert außerdem der _VisualNovelExample_ Prototyp.

== Herausforderungen und Lernerfahrungen <challenges-and-learnings>

Während der Umsetzung dieser Arbeit sind einige Herausforderungen aufgetreten, mit denen in dieser Form vor Beginn nicht gerechnet wurde.

Zu Beginn der Arbeit an dieser Thesis ergaben sich vor allem Herausforderungen daraus, dass diese Arbeit an einem anderen laufenden Projekt anknüpft. Dadurch war es zunächst notwendig, im Rahmen der technischen Analyse von KITE II und der Anforderungserhebung für diese Thesis eine Reihe an Gesprächen und Abstimmungen mit dem Projekt-Team von KITE II zu führen. Dies kann wiederum zu Zeitverzögerungen führen, da die passende Person nicht immer zeitnah verfügbar ist.

Bei Abhängigkeiten zu anderen Projekten und Personen ist es daher wichtig, so früh wie möglich Termin-Abstimmungen bezüglich der nötigen Besprechungen zu tätigen, damit es hier nicht zu längeren Verzögerungen kommt.

Eine weitere Herausforderung, die sich aus dieser Ausgangssituation heraus ergeben hatte, war, dass es zum Start der Thesis noch keine Spezifikation bezüglich des Geschichts-Formates gab. Diese musste zunächst in Kooperation mit dem KITE II Projekt-Team erarbeitet werden, damit das Twine Story-Format implementiert werden konnte.

Dies stellte einen signifikanten Blocker dar, da diese Komponente die erste war, die im Rahmen dieser Arbeit implementiert werden musste. Daher wurde zunächst ohne eine festgelegte Spezifikation an dem Story-Format gearbeitet, während parallel die Spezifikation entwickelt wurde. Idealerweise wäre diese natürlich vor Beginn der Arbeit vorhanden. Dadurch, dass hier parallel gearbeitet wurde, musste die Implementierung des Story-Formates zu Beginn immer wieder leicht angepasst werden, um der erst später festgelegten Spezifikation gerecht zu werden.

Glücklicherweise wurde dieses Problem früh erkannt, sodass diese Limitation beachtet werden konnte und die Spezifikation zeitnah niedergeschrieben werden konnte. Da mit solchen unerwarteten Komplikationen in laufenden Projekten immer zu rechnen ist, ist es eine gute Idee, Entwicklungsprozesse mit kurzen Iterations-Zyklen zu gestalten, um schnell auf ändernde Bedingungen reagieren zu können.

Eine weitere Herausforderung war die Unerfahrenheit mit Game-Engines sowie der Verwendung und Programmierung von Animations-Systemen. Die Entwicklung einer Game-Engine stellte eine Menge an Herausforderungen dar, mit denen ich bisher noch nicht konfrontiert war. Dazu gehören beispielsweise:

- Die Manipulation verschiedener Entitäten in einem definierten Raum.
- Die Darstellung und Programmierung verschiedener Animationen.

Da sämtliche darstellerischen Elemente in der Visual Novel beispielsweise animierbar sein können oder irgendeine Form von Interaktion unterstützen können sollen, müssen hierfür Systeme geschaffen werden, die dies ermöglichen. Bei Nutzung eines mir geläufigen Objekt-orientierten Ansatzes können hierbei komplexe Klassen-Hierarchien entstehen und Interaktionen zwischen diesen können schnell kompliziert werden.

Andere Ansätze, wie beispielsweise ein #utils.gls("ecs"), bevorzugen Komposition über Vererbung und implementieren Systeme, die global über eine Menge von Entitäten agieren können, die über bestimmte Komponenten verfügen.

Durch Wählen eines anderen Ansatzes, wie #utils.gls-short("ecs"), hätten Probleme, die bei der Entwicklung aufgetreten sind, wie Schwierigkeiten mit der Implementation von Animationen der Assets, eventuell besser gelöst werden können, sodass diese in Zukunft auch einfacher erweiterbar und wartbar sein könnten.

Eine große Lernerfahrung ist hier, dass Architektur-Ansätze abseits der in der Lehre omnipräsenten Objekt-orientierten Paradigmen besser geeignet sein könnten, um bestimmte Probleme zu lösen, und, dass OOP genau wie jedes Paradigma Stärken und Schwächen ausweist.

Um eine möglichst gut geeignete Lösung implementieren zu können, sollte zwischen verschiedenen Architektur-Mustern abgewogen werden und ein Ansatz gewählt werden, der den Anforderungen an das System möglichst gerecht wird.

Neben der Herausforderung mit der Architektur von Animations-System und der Game-Engine Komponenten der _VisualNovelEngine_ war außerdem der Umgang mit Spiele-Engines eine Herausforderung. Dadurch, dass sich Spiele in ihren Herausforderungen von den Systemen unterscheiden, die ich bisher in meiner Laufbahn implementiert habe, sind hier auch ganz andere Lösungsansätze etabliert.

Insgesamt haben diese Herausforderungen dazu geführt, dass gerade die Entwicklung der Komponenten der _VisualNovelEngine_ wie das Animations-System mit einem hohem Zeitaufwand verbunden war und hier rückblickend betrachtet andere Lösungsansätze besser geeignet wären im Anblick auf Entwicklungsgeschwindigkeit sowie Erweiterbarkeit und Wartbarkeit. Aufgrund von zeitlichen Limitationen war hier jedoch keine Zeit mehr, diese Systeme von Grund auf zu überarbeiten.

== Zukünftige Entwicklungen <future-developments>

Die Quellcode-Repositories der im Rahmen dieser Arbeit erstellten Projekte sind auf der Entwickler-Plattform _GitHub_ unter der MIT Open Source Lizenz veröffentlicht, sodass diese frei verwendet und weiterentwickelt werden können.

#utils.todo("GitHub Projekte verlinken.")

Künftige Entwicklungsarbeiten können sich darauf konzentrieren, offene Arbeitspakete zu implementieren, die nicht im zeitlichen Rahmen dieser Thesis umgesetzt werden konnten. In @table:openIssues sind offene Punkte notiert.

Neben den in der Tabelle erwähnten Punkten könnten auch größere Themen, wie die Umstrukturierung der _VisualNovelEngine_ hin zu einem #utils.gls-long("ecs") Ansatz, angegangen werden, um zukünftige Entwicklungen und Erweiterungen zu begünstigen.

Abgesehen davon wäre es interessant, Rückmeldungen von Entwickler*innen zu den verschiedenen Tools zu bekommen, die geschaffen wurden, damit Schnittstellen optimiert und eventuelle Fehler gelöst werden können.

#let openIssuesTable = table(
  columns: 2,
  table.header([*Projekt*], [*Offene Themen*]),
  [
    StoryEngine
  ],
  [
    - Veröffentlichung der Bibliothek in einem öffentlichen Repository.
  ],

  [
    VisualNovelEngine
  ],
  [
    - Veröffentlichung der Bibliothek in einem öffentlichen Repository.
    - Erweiterung der unterstützten Animations-Typen.
    - Implementierung eines Audio-Systems zum Abspielen von Sound-Effekten.
    - Überarbeitung der System-Architektur zu einem #utils.gls-long("ecs").
  ],

  [
    VisualNovelExample
  ],
  [
    - Unterstützung von Speichern und Fortsetzen von Spieldurchgängen.
    - Implementieren eines LLM gestützten Feedback-Mechanismus.
  ],
)
#figure(
  openIssuesTable,
  caption: "Offene Punkte bei den verschiedenen Projekten dieser Thesis.",
) <table:openIssues>

== Limitationen <limitationen>

Im Rahmen dieser Arbeit wurden keine Nutzer-Tests durchgeführt, um die Schnittstellen der verschiedenen Projekte zu testen. Diese wurden lediglich automatisiert durch Unit-Tests und durch Implementierung von Beispiel-Anwendungen getestet.

Das Feedback echter Nutzer*innen kann hier noch wertvolle Einsichten geben, um diese zu verbessern und mögliche Probleme zu entdecken.
