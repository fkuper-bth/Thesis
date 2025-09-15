#import "/etc/utils.typ"

== Planung <planung>

Aus der in @zielsetzung definierten Zielsetzung dieser Thesis ergeben sich verschiedene Arbeitspakete, die im gegebenen Zeitrahmen umgesetzt werden sollen. Dieser Abschnitt beschreibt die zeitliche Einteilung der einzelnen Arbeitspakete und führt zusätzlich eine Abgrenzung der Arbeitsinhalte aus.

=== Terminplanung <terminplanung>

Der ursprüngliche Durchführungszeitraum der geplanten Arbeitspakete ist vom 30. April 2025 bis zum 30. August 2025 angesetzt. Aufgrund von unerwarteten Verzögerungen bei Umsetzung einiger Arbeitspakete wurde der Zeitraum auf den 30. September 2025 verlängert. Die nachfolgende Zeitplanung bezieht sich auf den ursprünglichen Durchführungszeitraum.

Ausgehend von der in @zielsetzung definierten Zielsetzung wurden für diesen Zeitraum Arbeitspakete definiert, die in @tabelle-terminplanung sequentiell aufgelistet sind und auch in dieser Reihenfolge umgesetzt werden sollen. Diese sind so geplant, dass sie aufeinander aufbauen, wobei die zwei größten Arbeitspakete (Entwurf und Umsetzung der #utils.gls-short("library") sowie Entwurf und Umsetzung des Prototypen) in iterativer Art und Weise erarbeitet werden.

#let tableWorkItems = table(
  columns: 2,
  table.header([*Beschreibung Arbeitspaket*], [*Bearbeitungszeit*]),

  [
    Analyse und Definitionen der Anforderungen an die #utils.gls-short("library") sowie den Prototypen.
  ],
  [
    1 Woche
  ],

  [
    Analyse von #utils.gls-short("twine") und anderen Tools zum Schreiben interaktiver Geschichten.
  ],
  [
    1/2 Woche
  ],

  [
    Analyse und Vergleich verschiedener #utils.gls-short("cross_platform") Technologien im Bezug auf Eignung an die Anforderungen and die #utils.gls-short("library") und den Prototypen.
  ],
  [
    1/2 Woche
  ],

  [
    Entwurf und Umsetzung einer #utils.gls-short("library") zur Darstellung und Verwendung von #utils.gls-short("twine")-Stories auf den Plattformen iOS, Android und dem Web.
  ],
  [
    5 Wochen
  ],

  [
    Entwurf und Umsetzung eines Prototypen, welcher sich inhaltlich an KITE II orientiert.
  ],
  [
    6 Wochen
  ],

  [
    Erstellung der schriftlichen Thesis.
  ],
  [
    3 Wochen
  ],
)
#figure(
  tableWorkItems,
  caption: "Beschreibung der Arbeitspakete und deren Bearbeitungszeitraum.",
) <tabelle-terminplanung>

=== Abgrenzung der Arbeitsinhalte <abgrenzung-arbeitsinhalte>

Die für diese Thesis umzusetzenden Arbeitspakete sind in der @tabelle-terminplanung in @terminplanung aufgeführt. Um diese weiter zu konkretisieren, wird hier aufgeführt, welche Inhalte explizit nicht dazu gehören.

In @tabelle-abgrenzung-arbeitsinhalte wird eine Übersicht der Inhalte gegeben, die als _nicht essentiell_ für die in @zielsetzung definierte Zielsetzung dieser Thesis anzusehen sind und daher _nicht_ im Rahmen dieser umzusetzen sind.

#let tableAbgrenzung = table(
  columns: (35%, 65%),
  table.header([*Kurzbeschreibung*], [*Anmerkungen*]),

  [
    Eine mit #utils.gls-short("kite2") feature-paritätische Implementierung einer Anwendung.
  ],
  [
    - Dies meint, dass sich lediglich auf die _Kernfunktionalitäten_ von #utils.gls-short("kite2") konzentriert werden soll und andere Funktionalitäten zunächst außer Acht gelassen werden.
    - Nicht essentielle Features, wie z.B. die Screens "Wissen", "Links" und "Gemerkt" sind zunächst _nicht Teil_ der Kernfunktionalitäten und sind somit nicht Teil des Prototypen.
  ],

  [
    1 zu 1 Umsetzung von graphischen Details, wie das Look and Feel von #utils.gls-short("gui") Elementen oder Animationen im Menü.
  ],
  [
    - Bei Nutzung einer anderen #utils.gls-short("gui") Technologie wird im Interesse der Entwicklungsgeschwindigkeit auf _Standard-Komponenten_ von dieser gesetzt.
    - Im Gegensatz dazu sind _Darstellungselemente in den #utils.gls-plural("visual_novel")_ essentielle Teile der Nutzererfahrung und sollen mit der geplanten #utils.gls-short("library") umsetzbar sein.
      - Dazu gehören die Darstellung von Umgebungen mit Vorder- und Hintergrund, wahlfreie Platzierung in den Umgebungen sowie die Darstellung von Charakteren.
      - Außerdem sollen die darstellerischen Elemente _animierbar_ sein.
  ],
)
#figure(
  tableAbgrenzung,
  caption: "Beschreibung von Funktionalitäten, die nicht Teil der Thesis sind.",
) <tabelle-abgrenzung-arbeitsinhalte>

Zur Veranschaulichung der Unterscheidung zwischen darstellerischen Elementen, die möglichst originalgetreu umgesetzt werden sollen und jenen, die lediglich funktional identisch umgesetzt werden sollen, dient @kite2-screenshot-dialogue-comparison.

#figure(
  grid(
    columns: 2,
    image("/resources/images/kite/kite-screenshot-dialogue.png", width: 70%),
    image("/resources/images/kite/kite-screenshot-dialogue-marked.png", width: 70%),
  ),
  caption: [Vergleich einer Szene aus einer Geschichte in #utils.gls-short("kite2").],
) <kite2-screenshot-dialogue-comparison>

Auf der linken Abbildung sieht man einen unbearbeiteten Screenshot einer Szene aus #utils.gls-short("kite2"). Die rechte Abbildung dagegen stellt Elemente, die visuell abweichen können, rot markiert dar. Grob gesagt werden sämtliche Bedienelemente der #utils.gls-short("gui") als nicht essentiell klassifiziert und können daher visuell von der Vorlage abweichen. Die Elemente, die die eigentliche Darstellung der #utils.gls-short("visual_novel") ausmachen, sollen dagegen mit der umzusetzenden #utils.gls-short("library") arrangiert werden können.

Nach Klärung der Anforderungen kann die Umsetzung der #utils.gls-short("library") und des Prototypen gezielt angegangen werden. Die Vorgehensweise bei Umsetzung der einzelnen Arbeitspakete wird in @implementierung ausgeführt.
