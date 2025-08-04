#import "/etc/utils.typ"

== Stand der Technik <technik_stand>

In diesem Kapitel wird eine Übersicht über verschiedene Technologien gegeben werden, die für die Erstellung von interaktiven Geschichten verwendet werden können. Dabei wird auf verschiedene Aspekte eingegangen, wie die Unterstützung von audio-visuellen Elementen, die Interaktivität der Erzählung, Kompatibilität mit der in @story-spezifikation beschriebenen Story-Spezifikation und die Erweiterbarkeit der Funktionalitäten, um eine große Bandbreite an Anwendungsfällen abbilden zu können.

Neben diesen Domänen-spezifischen Technologien werden auch verschiedene #utils.gls-short("cross_platform") Technologien betrachtet, die für die Implementierung dieser Arbeit in Frage kommen können.

=== Vorhandene Technologien zur Erstellung von interaktiven Geschichten <vorhandene-technologien>

Zunächst ist zu erwähnen, dass zwischen Tools zur Erstellung von #utils.gls("if"), wie das bereits im Rahmen von @story-spezifikation behandelte Tool #utils.gls-short("twine") und Tools zur Erstellung von #utils.gls-plural("visual_novel") unterschieden werden muss.

Tools mit einem Fokus auf #utils.gls-short("if") generieren als Ausgabe textbasierte Spiele und bieten eine einfache Möglichkeit, interaktive Geschichten zu erstellen. Ein großer Vorteil dieser Tools ist zumeist, dass diese keine Erfahrung in der Spiele-Entwicklung erfordern und somit Autor*innen einen einfachen Einstieg in die Welt der #utils.gls-plural("if") ermöglichen.

#let ifToolsOverviewTable = table(
  columns: 4,
  table.header([*Tool*], [*Primärer Nutzen*], [*Plattformen*], [*Lizenz*]),

  [
    *Twine*
  ],
  [
    Erstellung von #utils.gls-plural("if") durch Autor*innen ohne Programmierkenntnisse.
  ],
  [
    - Web
    - Export als HTML
  ],
  [
    Open Source, GPL 3.0
  ],

  [
    *Ink*
  ],
  [
    Spiele-Entwickler*innen, die #utils.gls-plural("if") in Unity oder anderen Engines verwenden möchten.
  ],
  [
    - Web
    - Unity
  ],
  [
    Open Source, MIT
  ],

  [
    *Choicescript*
  ],
  [
    #utils.gls-plural("if") mit einfacher UI und Fokus auf Charakter-Werte.
  ],
  [
    - Web
    - Export als HTML
  ],
  [
    Proprietär, frei verfügbar für nicht-kommerzielle Nutzung.
  ],
)
#figure(
  ifToolsOverviewTable,
  caption: [Kurzüberblick über populäre Tools zur Erstellung von #utils.gls-plural("if")],
) <if-tools-overview>

In @if-tools-overview sind einige der populärsten Tools zur Erstellung von #utils.gls-plural("if") gelistet. Es existieren noch weitere Tools in diesem Bereich, jedoch wurde sich hier auf diese Auswahl beschränkt, da es sich hier um etablierte Tools mit einer aktiven Gemeinschaft von Nutzer*innen handelt.

Einen genaueren Einblick in Stärken und Schwächen dieser Tools gibt @if-tools-pros-cons.

#let ifToolsProAndConsTable = table(
  columns: 3,
  table.header([*Tool*], [*Stärken*], [*Schwächen*]),

  [
    *Twine*
  ],
  [
    - einfacher Einstieg durch Editor mit #utils.gls-short("gui")
    - Anpassbarkeit der Ausgabe durch Story-Formate
    - ausführliche Dokumentation
    - große Community von Nutzer*innen
  ],
  [
    - limitierte Multimedia-Unterstützung
    - #utils.gls-short("gui") kann bei komplexen Geschichten unübersichtlich werden
  ],

  [
    *Ink*
  ],
  [
    - Text-basierte IDE mit sofortigem Feedback zu Syntax-Fehlern
    - Integration in Unity und Unreal Engine über Plugins möglich
    - Export als JSON möglich
  ],
  [
    - limitierte Multimedia-Unterstützung
    - Workflow eher für Programmierer*innen geeignet
  ],

  [
    *Choicescript*
  ],
  [
    - integrierte Funktionalität zum Anlegen und Verwalten von Charakter-Werten
    - aktive Community von Autor*innen
  ],
  [
    - limitierte Multimedia-Unterstützung
    - geringe Anpassbarkeit des Ausgabeformates
    - nicht frei nutzbar für kommerzielle Projekte
  ],
)
#figure(
  ifToolsProAndConsTable,
  caption: [Vergleich der Stärken und Schwächen der Tools zur Erstellung von #utils.gls-plural("if")],
) <if-tools-pros-cons>

Eine Schwäche der #utils.gls-plural("if") Tools ist die limitierte Unterstützung von Multimedia-Inhalten. Da diese Tools primär auf Text-basierte Geschichten ausgelegt sind, ist für die audio-visuelle Darstellung eine andere Technologie erforderlich, die sich hierum kümmert. Im Falle von #utils.gls-short("kite2") wird zum Beispiel Twine genutzt, um die #utils.gls-plural("if") zu erstellen, und Unity, um die audio-visuelle Darstellung zu realisieren.

Andererseits existieren auch Tools, die es ermöglichen, neben der interaktiven Geschichte auch die audio-visuelle Darstellung zu realisieren und somit eine vollständige Lösung zur Erstellung einer #utils.gls-short("visual_novel") bieten. Diese Tools sind in der Regel komplexer haben eine steilere Lernkurve, erlauben ihren Nutzer*innen dafür aber, eine ganze #utils.gls-short("visual_novel") mit einem Tool zu erstellen und eignen sich daher beispielsweise auch besonders für Projekte, die von einer Person umgesetzt werden.

Die @vn-tools-overview gibt einen groben Überblick über einige der populärsten Tools zur Erstellung von #utils.gls-plural("visual_novel").

#let vnToolsOverview = table(
  columns: (15%, 40%, 20%, 25%),
  table.header([*Tool*], [*Interaktions-Art*], [*Plattformen*], [*Lizenz*]),

  [
    *Ren'Py*
  ],
  [
    - Script-basiert
    - Python
  ],
  [
    - Desktop
    - Mobile
    - Web
  ],
  [
    - Open Source
    - MIT
  ],

  [
    *TyranoBuilder*
  ],
  [
    - No-Code (visuelles Scripting)
    - Drag & Drop von Komponenten
  ],
  [
    - Desktop
    - Mobile
    - Web
  ],
  [
    - Proprietär
    - kostenpflichtig
  ],

  [
    *Fungus*
  ],
  [
    - No-Code (visuelles Scripting)
    - optionales Lua-Scripting
    - Unity Plugin
  ],
  [
    - Unity
  ],
  [
    - Open Source
    - MIT
  ],

  [
    *Visual Novel Maker*
  ],
  [
    - No-Code und Scripting
    - Eigenständige Entwicklungsumgebung mit #utils.gls-short("gui")
  ],
  [
    - Desktop
    - Mobile
    - Web
  ],
  [
    - Proprietär
    - kostenpflichtig
  ],
)
#figure(
  vnToolsOverview,
  caption: [Kurzüberblick über populäre Tools zur Erstellung von #utils.gls-plural("visual_novel")],
) <vn-tools-overview>

Die wohl am weitesten verbreitete und am besten unterstützte Engine zur Erstellung von #utils.gls-plural("visual_novel") ist _Ren'Py_ @noauthor_renpy_nodate. Sie ist in Python geschrieben und ermöglicht es, interaktive Geschichten mit einer Vielzahl von Multimedia-Inhalten zu erstellen. Aufgrund ihrer Script-basierten Schnittstelle ist sie vor allem für Programmierer*innen geeignet, die bereits Erfahrung mit Python haben.

Andere Tools dagegen wie _TyranoBuilder_, _Fungus_ oder _Visual Novel Maker_ verfolgen einen No-Code-Ansatz, der es Nutzer*innen ermöglicht, interaktive Geschichten ohne Programmierkenntnisse zu erstellen.

// TODO: weitere Differenzierung der Tools
// Was kann ich auch diesen Tools für meine Bibliothek lernen?
// Kann ich eines dieser Tools als Basis für meine Arbeit verwenden? (Twine -> Story-Format -> Story-Engine -> VN Engine)
