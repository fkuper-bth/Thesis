#import "/etc/utils.typ"
#import "/etc/plots.typ"

== Stand der Technik <technik_stand>

In diesem Kapitel wird eine Übersicht über verschiedene Technologien gegeben werden, die für die Erstellung von interaktiven Geschichten verwendet werden können. Dabei wird auf verschiedene Aspekte eingegangen, wie die Unterstützung von audio-visuellen Elementen, die Interaktivität der Erzählung, Kompatibilität mit der in @story-spezifikation beschriebenen Story-Spezifikation und die Erweiterbarkeit der Funktionalitäten, um eine große Bandbreite an Anwendungsfällen abbilden zu können.

Neben diesen Domänen-spezifischen Technologien werden auch verschiedene #utils.gls-short("cross_platform") Technologien betrachtet, die für die Implementierung dieser Arbeit in Frage kommen können.

=== Vergleich verschiedener Technologien zur Erstellung von interaktiven Geschichten <interactive-fiction-technologien>

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

Die wohl am weitesten verbreitete Engine zur Erstellung von #utils.gls-plural("visual_novel") ist _Ren'Py_ @noauthor_renpy_nodate. Sie ist in Python geschrieben und ermöglicht es, interaktive Geschichten mit einer Vielzahl von Multimedia-Inhalten zu Erstellen. Neben Hobby-Projekten wird sie auch für kommerzielle Projekte verwendet und ist das Tool der Wahl für eine Vielzahl von erfolgreichen #utils.gls-plural("visual_novel") @noauthor_itchio_nodate.

Die Stärken dieser Engine liegen in ihrer großen Bandbreite an Funktionalitäten, ihrer Flexibilität sowie ihrer großen, aktiven Community von Nutzer*innen und Entwickler*innen, die kontinuierlich zur Verbesserung und Erweiterung der Engine beitragen. Aufgrund ihrer Script-basierten Schnittstelle ist sie vor allem für Programmierer*innen geeignet, die bereits Erfahrung mit Python haben.

Andere Tools wie _TyranoBuilder_ @noauthor_tyranobuilder_nodate, _Fungus_ @noauthor_fungus_nodate oder _Visual Novel Maker_ @noauthor_visual_nodate verfolgen dagegen einen No-Code-Ansatz, der es Nutzer*innen ermöglicht, interaktive Geschichten ohne Programmierkenntnisse zu erstellen. Dadurch sind diese Tools besser für Nutzer*innen geeignet, die keine oder geringe Erfahrung in der Spiele-Entwicklung haben und dennoch eine #utils.gls-short("visual_novel") erstellen möchten.

Um eine Idee von der Verbreitung dieser verschiedenen Tools zu bekommen, wurden die Anzahl der #utils.gls-short("visual_novel") Spiele auf der Plattform _itch.io_ @noauthor_itchio_nodate-1 nach den jeweiligen Tool-Tags ausgewertet.

Dazu sei erwähnt, dass es sich bei itch.io zwar um eine weit verbreitete Plattform zur Veröffentlichung von Indie Spielen, also Spiele, die ohne die Unterstützung eines Publishers erstellt und veröffentlicht werden, handelt, jedoch nicht um eine repräsentative Plattform für den gesamten Markt. Außerdem taucht die Technologie _Choicescript_ hier nicht auf, da das Unternehmen hinter dieser Technologie ihre eigene Plattform betreibt @noauthor_choice_nodate. Neben den zuvor diskutierten Technologien sind hier auch populäre Game Engines, wie _Unity_, _Unreal_ und _Godot_ Teil der Analyse.

Dennoch kann sie einen groben Überblick über die Verbreitung der verschiedenen Tools in der Indie-Entwickler-Szene gewähren.

#figure(
  plots.createVnEnginePopularityOnItchIoPlot(),
  caption: [Relative Popularität der diskutierten Technologien bei auf itch.io veröffentlichten #utils.gls-plural("visual_novel"), Datenquelle: itch.io @noauthor_itchio_nodate-1.],
) <vn-engine-popularity-on-itch-io>

@vn-engine-popularity-on-itch-io stellt die Ergebnisse der Datenerhebung vom 05.08.2025 dar, welche hier relativ zueinander abgebildet werden.

Das Bedeutet, dass von allen Tools, die hier diskutiert und im Rahmen der Analyse betrachtet wurden, hiervon mit 58% über die Hälfte Ren'Py verwenden. Gut ein Fünftel der Spiele verwenden Unity, gefolgt von Twine mit 10% und Godot mit 6%. Alle betrachteten Tools, deren Anteil weniger als 5% betrug, wurden in der Kategorie "Andere" zusammengefasst. Diese Kategorie umfasst: _TyranoBuilder_, _Unreal Engine_, _Ink_ und _Visual Novel Maker_ absteigend sortiert nach relativer Popularität.

Die absoluten Zahlen von allen betrachteten Tools sind in @vn-engine-popularity-on-itch-io-column-chart dargestellt.

#figure(
  plots.createVnEnginePopularityOnItchIoColumnChart(),
  caption: [Absolute Zahl der #utils.gls-plural("visual_novel") auf itch.io, die mit den jeweiligen Technologien verwenden, Datenquelle: itch.io @noauthor_itchio_nodate-1.],
) <vn-engine-popularity-on-itch-io-column-chart>

Unter den in diesem Abschnitt betrachteten Technologien scheint Ren'Py also die, zumindest in der Indie-Szene von #utils.gls-short("visual_novel") Entwickler*innen, das Tool der Wahl zu sein, wenn es darum geht, eine #utils.gls-short("visual_novel") zu erstellen.

Die Gründe hierfür sind vielfältig. Einige der meist genannten Gründe aus einer Recherche verschiedener Online Foren und Communities, die sich mit Spiele-Entwicklung und #utils.gls-plural("visual_novel") beschäftigen @noauthor_is_nodate @noauthor_is_nodate-1 @noauthor_any_nodate, sind:

- eine _aktive Community_, die bei Fragen und Problemen hilft
- eine große Anzahl an _Tutorials_ und _Dokumentation_
- Ren'Py ist _Open Source_ und kann _kostenlos_ genutzt werden
- _#utils.gls-short("cross_platform")_ Unterstützung
- große _Flexibilität_ und _Anpassbarkeit_ der Engine
- Verfügbarkeit von _Templates_ zum schnellen Einstieg in der Entwicklung eines neuen Projektes
- Python als Skript-Sprache ist _einfach zu Erlernen_ und _weit verbreitet_

Für die Konzeption der #utils.gls-short("library") in dieser Arbeit ist es wichtig, diese Stärken zu berücksichtigen und zu versuchen, diese in die #utils.gls-short("library") zu integrieren, wenn möglich. Die wirkt sich konkret darauf aus, wie die #utils.gls-short("library") gestaltet wird, um somit den Nutzer*innen eine möglichst gute Nutzererfahrung bieten zu können. Mehr hierzu findet sich in @implementierung-visual-novel-library.

Neben Ren'Py ist auch _Twine_ ein weit verbreitetes Tool zur Erstellung von #utils.gls-plural("if") und wird auch in der #utils.gls-short("kite2") verwendet. Im Anbetracht der Stärken und Schwächen von Twine, die in @if-tools-pros-cons diskutiert wurden wie beispielsweise der besonderen Eignung von Twine für Autor*innen ohne Programmierkenntnisse und der Erweiterbarkeit durch Story-Formate, ist es sinnvoll, Twine als Grundlage für die #utils.gls-short("library") zu wählen. Somit können nicht nur die für #utils.gls-short("kite2") bereits geschrieben Geschichten wiederverwendet werden, sondern auch die Stärken von Twine in Bezug auf die Erstellung von #utils.gls-plural("if") genutzt werden. Mehr zu diesem Thema finder sich ebenfalls in @implementierung-visual-novel-library.

=== Vergleich verschiedener Cross-Platform Technologien <cross-platform-technologien>

Neben den zuvor diskutierten Technologien, die speziell für die Erstellung von interaktiven Geschichten und #utils.gls-short("visual_novel") entwickelt wurden, gibt es auch eine Vielzahl von #utils.gls-short("cross_platform") Technologien, die für die Entwicklung von interaktiven Anwendungen verwendet werden können. In diesem Abschnitt werden einige der populärsten #utils.gls-short("cross_platform") Technologien vorgestellt, die für die Entwicklung der #utils.gls-short("library") zur Erstellung von #utils.gls-plural("visual_novel") in Frage kommen könnten.

Entscheidend ist hierbei, dass diese einerseits alle angestrebten Zielplattformen unterstützen, also Android, iOS, Web und Desktop, und andererseits dafür geeignet sind, die in @zielsetzung beschriebenen Anforderungen zu erfüllen.

In @cp-frameworks-overview wird ein Überblick über einige der #utils.gls-short("cross_platform") Frameworks gegeben, die für die Entwicklung der #utils.gls-short("library") in Frage kommen könnten. Dabei werden wichtige Eckdaten zu den Frameworks zusammengefasst, wie die unterstützten Plattformen, die verwendete Programmiersprache und die Lizenzierung.

#let frameWorkTitleCell(title, imagePath, imageSourceReference) = {
  align(center)[
    #grid(
      rows: 2,
      gutter: 8pt,
      title,
      grid(
        rows: 2,
        gutter: 5pt,
        image(imagePath, height: 20pt),
        text(imageSourceReference, size: 10pt),
      ),
    )
  ]
}

#let cpFrameworksOverviewTable = table(
  columns: 4,
  table.header([*Framework*], [*Sprache*], [*Plattformen*], [*Lizenz*]),

  [
    #frameWorkTitleCell(
      [*Flutter*],
      "/resources/images/flutter-logo.svg",
      [@raddp_flutter_nodate],
    )
  ],
  [
    - Dart
  ],
  [
    - Android
    - iOS
    - Web
    - Desktop
  ],
  [
    - Kostenlos
    - Open Source (BSD)
  ],

  [
    #frameWorkTitleCell(
      [
        *Compose*

        *Multiplatform*
      ],
      "/resources/images/compose-logo.svg",
      [@noauthor_compose_nodate],
    )
  ],
  [
    - Kotlin
  ],
  [
    - Android
    - iOS
    - Web (Experimental)
    - Desktop
  ],
  [
    - Kostenlos
    - Open Source (Apache 2.0)
  ],

  [
    #frameWorkTitleCell(
      [*React Native*],
      "/resources/images/react-logo.svg",
      [@noauthor_react_nodate],
    )
  ],
  [
    - JavaScript
    - TypeScript
  ],
  [
    - Android
    - iOS
    - Web
    - Desktop
  ],
  [
    - Kostenlos
    - Open Source (MIT)
  ],

  [
    #frameWorkTitleCell(
      [*Unity*],
      "/resources/images/unity-logo.svg",
      [@unity_technologies_unity_nodate],
    )
  ],
  [
    - C\#
  ],
  [
    - Desktop
    - Mobile
    - Web
    - Konsolen
    - VR / AR Plattformen
  ],
  [
    - Proprietär
    - kostenlose für nicht-kommerzielle Nutzung
  ],

  [
    #frameWorkTitleCell(
      [*Godot*],
      "/resources/images/godot-logo.svg",
      [@andrea_calabro_godot_nodate],
    )
  ],
  [
    - GDScript
    - C\#
  ],
  [
    - Desktop
    - Mobile
    - Web
    - Konsolen
  ],
  [
    - Kostenlos
    - Open Source (MIT)
  ],

  [
    #frameWorkTitleCell(
      [*.NET MAUI*],
      "/resources/images/dotnet-logo.svg",
      [@microsoft_net_nodate],
    )
  ],
  [
    - C\#
  ],
  [
    - Android
    - iOS,
    - Windows
    - macOS
  ],
  [
    - Kostenlos
    - Open Source (MIT)
  ],
)

#figure(
  cpFrameworksOverviewTable,
  caption: [Kurzüberblick über populäre #utils.gls-short("cross_platform") Frameworks.],
) <cp-frameworks-overview>

// compare these frameworks with regards to their suitability for the library
Um einen besseren Eindruck über die Eignung der verschiedenen #utils.gls-short("cross_platform") Frameworks für die Entwicklung der #utils.gls-short("library") zu bekommen, wurden diese anhand verschiedener Kriterien bewertet. Diese Kriterien sind:

- _Grafik_: Wie gut unterstützt das Framework die Darstellung von Grafiken und Bildern?
- _Animation_: Wie gut unterstützt das Framework Animationen und Übergänge?
- _Einordnung_: Erfüllt das Framework die Anforderungen an die Entwicklung der #utils.gls-short("library")?

Die Frameworks sind mitsamt ihrer Bewertung bezüglich der Kriterien in @cp-framework-comparison dargestellt.

#let cpFrameworkComparisonTable = table(
  columns: (18%, 22%, 22%, 38%),
  table.header([*Framework*], [*Grafik*], [*Animation*], [*Einordnung*]),

  [
    #frameWorkTitleCell(
      [],
      "/resources/images/flutter-logo.svg",
      [@raddp_flutter_nodate],
    )
  ],
  [
    - GPU-beschleunigte 2D Grafiken über Skia.
  ],
  [
    - native Unterstützung
    - flexibel (implizite und explizite Animationen)
  ],
  [
    - unterstützt alle nötigen Funktionalitäten
    - Fragezeichen bezüglich langfristiger Unterstützung @elye_is_2024
  ],

  [
    #frameWorkTitleCell(
      [],
      "/resources/images/compose-logo.svg",
      [@noauthor_compose_nodate],
    )
  ],
  [
    - Compose Grafik API
  ],
  [
    - native Unterstützung
  ],
  [
    - unterstützt alle nötigen Funktionalitäten
    - Plattformen wie Web und iOS sind noch in früher Entwicklungsphase
  ],

  [
    #frameWorkTitleCell(
      [],
      "/resources/images/react-logo.svg",
      [@noauthor_react_nodate],
    )
  ],
  [
    - gut für #utils.gls-short("gui") basierte Anwendungen
    - für komplexe Grafiken muss auf zusätzliche Bibliotheken zurückgegriffen werden
  ],
  [
    - native Unterstützung für einfache Animationen
    - komplexe Animationen erfordern zusätzliche Bibliotheken
  ],
  [
    - gut für #utils.gls-short("gui") basierte Anwendungen
    - weniger geeignet für komplexe Grafiken und Animationen
  ],

  [
    #frameWorkTitleCell(
      [],
      "/resources/images/unity-logo.svg",
      [@unity_technologies_unity_nodate],
    )
  ],
  [
    - GPU-beschleunigte 2D und 3D Grafiken
  ],
  [
    - starke Unterstützung verschiedener Animationsarten
  ],
  [
    - unterstützt alle nötigen Funktionalitäten
    - bringt viel Komplexität und Funktionalitäten mit sich, die für die #utils.gls-short("library") nicht benötigt werden
  ],

  [
    #frameWorkTitleCell(
      [],
      "/resources/images/godot-logo.svg",
      [@andrea_calabro_godot_nodate],
    )
  ],
  [
    - ausgereifte 2D Grafik-Engine
  ],
  [
    - umfangreiche, flexible Animations-API
  ],
  [
    - unterstützt alle nötigen Funktionalitäten
    - gut für Entwicklung 2D-basierter Spiele geeignet
  ],

  [
    #frameWorkTitleCell(
      [],
      "/resources/images/dotnet-logo.svg",
      [@microsoft_net_nodate],
    )
  ],
  [
    - gut für #utils.gls-short("gui") basierte Anwendungen
    - limitierte Grafik-API
  ],
  [
    - native Unterstützung für einfache Animationen
  ],
  [
    - gut für #utils.gls-short("gui") basierte Anwendungen
    - weniger geeignet für komplexe Grafiken und Animationen
  ],
)

#figure(
  cpFrameworkComparisonTable,
  caption: [Vergleich der #utils.gls-short("cross_platform") Frameworks bezüglich ihrer Eignung für die Entwicklung der #utils.gls-short("visual_novel") #utils.gls-short("library").],
) <cp-framework-comparison>

Die Bewertung der Frameworks zeigt, dass für diese Arbeit eine Vielzahl verschiedener #utils.gls-short("cross_platform") Frameworks geeignet sind. Auszuschließen sind zunächst _.NET MAUI_ und _React Native_, da diese weniger umfangreiche Funktionalitäten im Bereich der von Grafiken und Animationen bieten. Die Spiele-Engines _Unity_ und _Godot_ bieten in diesen Bereichen die umfangreichsten Funktionalitäten. Im Vergleich dazu bieten _Flutter_ und _Compose_ ebenfalls für den vorgeschlagenen Nutzungsfall völlig ausreichende Unterstützung für Grafiken und Animationen.

Die Entscheidung für ein Framework hängt letztlich auch von den persönlichen Vorlieben und Erfahrungen der Entwickler*innen ab.

In dieser Arbeit wird sich für _#utils.gls("cmp")_ entschieden, da es eine moderne und gut unterstützte Technologie ist, die alle benötigten Funktionalitäten bietet. Kurz- und mittelfristig hängt mit der Entscheidung für _#utils.gls-short("cmp")_ auch ein gewisses Risiko zusammen, da diese Technologie noch recht jung ist (die erste Veröffentlichung war im April 2021) und besonders die Zielplattform Web noch im experimentellen Status ist.

Andererseits existieren in der _Flutter_ Community Bedenken bezüglich der langfristigen Unterstützung dieser Technologie durch Google, welche auch durch die zunehmende Popularität von Kotlin und #utils.gls-short("cmp") zu Tage gekommen sind @elye_is_2024.

Trotzdem könnten Frameworks wie _Flutter_ oder _Godot_ ebenfalls eine gute oder sogar bessere Wahl sein, je nach individuellen Vorlieben und Erfahrungen der Entwickler*innen.

Mit der Analyse der verschiedenen #utils.gls-short("cross_platform") Frameworks und der Entscheidung für _#utils.gls-short("cmp")_ ist die Grundlage für die Entwicklung der #utils.gls-short("library") gelegt. Im folgenden @implementierung-visual-novel-library wird die Umsetzung der #utils.gls-short("library") detailliert beschrieben.
