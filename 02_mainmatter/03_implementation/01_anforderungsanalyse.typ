#import "/etc/utils.typ"

== Anforderungsanalyse <anforderungsanalyse>

Da die eigentlichen Anforderungen an die #utils.gls-short("library") und den Prototypen in @zielsetzung und @planung bereits formuliert wurden, wird hier lediglich auf den Prozess der Anforderungsanalyse näher eingegangen.

Die Anforderungen an die #utils.gls-short("library") sind in @tabelle-anforderungen-bibliothek formuliert, während die Anforderungen an den Prototypen in @tabelle-anforderungen-prototyp dargestellt sind.

Die Anforderungsanalyse ist in verschiedenen Arbeitsschritten erfolgt, die grob gesagt in folgende Kategorien eingeteilt werden können:

1. Gespräche mit Stakeholdern
2. Analyse bestehender Arbeitsergebnisse von #utils.gls-short("kite2")
3. Analyse bestehender Tools und Technologien

Dieses Kapitel wird sich auf die ersten beiden Punkte konzentrieren, da die Analyse bestehender Tools und Technologien in @technik_stand behandelt wird.

=== Stakeholder-Gespräche <stakeholder-gespraeche>

Um eine Lösung zu entwickeln, die den Anforderungen seiner Nutzer*innen entspricht, müssen verschiedene Aspekte berücksichtigt werden. Dazu werden zunächst verschiedene Stakeholder identifiziert, die an ein Interesse an der #utils.gls-short("library") haben könnten.

Zu diesem Zwecke wurden folgende Stakeholder-Gruppen durch Gespräche mit Betreuenden der Thesis und dem Projektteam von #utils.gls-short("kite2") identifiziert, welche in @tabelle-stakeholder-gruppen zusammengefasst sind:

#let stakeHolderTable = table(
  columns: 3,
  table.header([*Stakeholder-Gruppe*], [*Beschreibung*], [*Bedürfnisse*]),

  [
    _Endbenutzer*innen_
  ],
  [
    Umfasst die Benutzer*innen, die #utils.gls-plural("visual_novel") spielen, die in einer Anwendung eingebettet sind, die die #utils.gls-plural("visual_novel") mit Hilfe der #utils.gls-short("library") implementiert.
  ],
  [
    Benötigen eine benutzerfreundliche Oberfläche und eine reibungslose Benutzererfahrung.
  ],

  [
    _Entwickler*innen_
  ],
  [
    Umfasst die Entwickler*innen, die die #utils.gls-short("library") nutzen werden, um #utils.gls-plural("visual_novel") zu erstellen.
  ],
  [
    Benötigen eine einfache und intuitive API, um die #utils.gls-short("library") in ihre Anwendungen zu integrieren.
  ],

  [
    _Author*innen_
  ],
  [
    Umfasst die Autor*innen, die die interaktive Geschichten verfassen.
  ],
  [
    Benötigen Werkzeuge, um ihre kreativen Ideen umzusetzen.
  ],

  [
    _Künstler*innen_
  ],
  [
    Umfasst die Künstler*innen, die visuelle Elemente für die #utils.gls-short("library") erstellen werden.
  ],
  [
    Benötigen klar definierte Schnittstellen für die Integration ihrer Arbeit in die #utils.gls-short("library").
  ],
)
#figure(stakeHolderTable, caption: "Stakeholder-Gruppen und ihre Bedürfnisse.") <tabelle-stakeholder-gruppen>

In Gesprächen mit den verschiedenen Stakeholdern wurden dann die Bedürfnisse und Anforderungen an die Lösung konkretisiert. Dazu wurde mit Personen in leitenden Funktionen des #utils.gls-short("kite2") Projektteams, Autor*innen von interaktiven Geschichten, sowie Künstler*innen und Entwickler*innen des Projektteams gesprochen.

Die dadurch gewonnenen Erkenntnisse sind in die Formulierung der Anforderungen an die jeweiligen Komponenten der Lösung eingeflossen und sind in @tabelle-anforderungen-bibliothek und @tabelle-anforderungen-prototyp zusammengefasst. Zusätzlich sind hierdurch Probleme und Herausforderungen identifiziert worden, die aktuell in der Entwicklung von #utils.gls-short("kite2") bestehen und die durch die #utils.gls-short("library") adressiert werden sollen. Diese Erkenntnisse sind in @problemstellung zusammengefasst.

=== Analyse bestehender Arbeitsergebnisse von #utils.gls-short("kite2") <analyse-kite2>

Abgesehen von den Gesprächen mit Stakeholdern, wie in @stakeholder-gespraeche beschrieben, wurden auch bestehende Arbeitsergebnisse von #utils.gls-short("kite2") analysiert, um die Anforderungen an die #utils.gls-short("library") und den Prototypen zu konkretisieren.

Dank der Kooperation des #utils.gls-short("kite2") Projektteams wurde mir Zugang zu projektinternen Dokumenten und Code-Repositories gewährt. Dadurch konnten wertvolle Einblicke in die bestehende Architektur und Lösungsansätze gewonnen werden, die wiederum die Anforderungsanalyse und Konzeption der #utils.gls-short("library") und des Prototypen informiert haben. Außerdem standen Entwickler*innen des #utils.gls-short("kite2") Projektteams für Rückfragen zur Verfügung, was die Analyse weiter erleichtert hat und ein besseres Verständnis der bestehenden Lösungen ermöglicht hat.

==== Systemarchitektur von #utils.gls-short("kite2") <kite2-systemarchitektur>

Zur Veranschaulichung von Software-Systemen und deren Architektur wird in dieser Thesis das C4-Modell zum Visualisieren von Software-Architektur verwendet @noauthor_c4_nodate. Dieses Modell bietet eine strukturierte Herangehensweise, um Software-Systeme auf verschiedenen Abstraktionsebenen zu beschreiben. Es besteht aus mehreren Ebenen, die von der höchsten Ebene (Systemkontext) bis zur niedrigsten Ebene (Code) reichen.

Die @kite2-container-diagram stellt die Systemarchitektur von #utils.gls-short("kite2") auf der Container-Ebene mit ihren interagierenden Personen und externen Systemen dar. Die Bedeutung der einzelnen Komponenten des Diagramms ist in @kite2-container-diagram-legend erklärt.

#figure(
  image("/resources/images/diagrams/kite2-container-diagram.png"),
  caption: "KITE II Überblick über Projekt-Landschaft",
) <kite2-container-diagram>

#figure(
  image("/resources/images/diagrams/kite2-container-diagram-legend.png", width: 70%),
  caption: [Legende zu @kite2-container-diagram],
) <kite2-container-diagram-legend>

In @kite2-container-diagram lassen sich verschiedene Interaktions-Punkte mit der Entwicklungslandschaft von #utils.gls-short("kite2") erkennen. Diese können in verschiedene Kategorien eingeteilt werden:

1. _Externe Systeme_: Diese Systeme wie hier Kreativ-Software und Twine existieren außerhalb des System-Kontextes von #utils.gls-short("kite2").
2. _Akteure, die mit KITE II interagieren_: Hierzu zählen die verschiedenen Akteure, die mit #utils.gls-short("kite2") interagieren, wie Autor*innen, Künstler*innen und Entwickler*innen. Diese können entweder direkt mit #utils.gls-short("kite2") interagieren oder über externe Systeme, die wiederum in Beziehung mit #utils.gls-short("kite2") stehen.

Bei der Analyse ist gerade im Falle der Autor*innen aufgefallen, dass es hier zu Problemen kommen kann. Dadurch, dass Autor*innen ihre Geschichten direkt in dem externen System Twine erstellen und zum Gebrauch in der #utils.gls-short("kite2") Anwendung exportieren, besteht hier die Gefahr, dass die Geschichten nicht in dem Format vorliegen, die die Entwickler*innen erwarten, da die Anwendung selbst die Story Spezifikation implementiert und diese nicht in Twine erzwungen wird.

Bei Abweichung von der Story Spezifikation fallen solche Fehler dann erst auf, wenn die Geschichten in der Anwendung getestet werden. Dies kann zu stark verlängerten Feedback-Zyklen führen verglichen mit einem System, bei dem die Konformität der Geschichten zur Story Spezifikation bereits beim Erstellen der Geschichten, beispielsweise durch eine Art Compiler überprüft wird. Dieser identifizierte Schwachpunkt soll mit der #utils.gls-short("library") adressiert werden.

Neben der fehlenden Validierung der Spezifikation im Author*innen Tool Twine wurde auch festgestellt, dass es zum Zeitpunkt der Analyse noch keine niedergeschriebene Spezifikation des Story-Formates gab. Die Spezifikation existierte lediglich in Form von mündlichen Absprachen zwischen den Entwickler*innen und Autor*innen und in Form von Code zum Übersetzen des Formates in ein internes Format, das von der Anwendung verwendet wird. Dieser Code definiert hier somit die eigentliche Spezifikation. Dies kann aus verschiedenen Gründen problematisch sein:

- _Mangelnde Transparenz_: Die Spezifikation ist nicht für alle Stakeholder*innen zugänglich oder in verständlicher Form vorliegend, da sie nur in Form von Code existiert.
- _Fehlende Dokumentation_: Dadurch, dass die Spezifikation direkt in der Anwendung selbst als Code existiert, ist diese nicht für externe Akteure sichtbar dokumentiert. Dies macht es schwierig bis unmöglich, die Spezifikation zu anzuwenden ohne im direkten Kontakt mit den Entwickler*innen zu stehen.
- _Schwierige Wartbarkeit_: Änderungen an der Spezifikation müssen direkt im Code vorgenommen werden und sind nicht in einem separaten Dokument festgehalten. Dies kann zu Inkonsistenzen führen, wenn Änderungen nicht korrekt dokumentiert werden.
- _Fehlende Validierung_: Da die Spezifikation nicht in einem separaten Dokument vorliegt, ist es schwierig, die Konformität der Geschichten zu überprüfen. Dies kann zu Fehlern führen, die erst spät im Entwicklungsprozess auffallen.

Des Weiteren fällt auf, dass die #utils.gls-short("kite2") Anwendung als monolithische Anwendung gebaut ist, dessen Komponenten stark miteinander verwoben sind und daher nicht ohne Weiteres für andere Projekte wiederverwendbar sind. Durch Aufbrechen von der Anwendung in kleinere Module kann die Wiederverwendbarkeit dieser gewährleistet werden und deren Funktionalität für andere Projekte zugänglich gemacht werden. Dies ist ein zentrales Ziel der #utils.gls-short("library"), die im Rahmen dieser Thesis entwickelt wird. Kandidaten für solche Module sind beispielsweise:

- _Story Compiler_: Dieses Modul wäre dafür zuständig, die Geschichten zum Zeitpunkt der Erstellung auf Konformität zur Story Spezifikation zu überprüfen und Fehler frühzeitig zu identifizieren.
- _Story Parser_: Dieses Modul wäre dafür zuständig, die Geschichten in ein anwendungsinternes Format zu übersetzen. Dieses Modul könnte dann auch in anderen Projekten verwendet werden, die ähnliche Geschichten verwenden.
- _Story Player_: Dieses Modul wäre dafür verwendet werden, die Spielfluss-Logik zu implementieren.
- _Visual Novel Player_: Dieses Modul wäre dafür zuständig, die Geschichten audio-visuell aufzubereiten.

Durch Analyse der Systemarchitektur von #utils.gls-short("kite2") konnten somit verschiedene Schwachstellen und Verbesserungspotentiale identifiziert werden, die in die Anforderungsanalyse der #utils.gls-short("library") und des Prototypen eingeflossen sind. Im nächsten Schritt werden spezifische Komponenten der #utils.gls-short("kite2") Anwendung analysiert, um genauere Anforderungen für die verschiedenen Systemkomponenten zu ermitteln.

==== Konzeption einer Story Spezifikation <story-spezifikation>

Wie bereits im @kite2-systemarchitektur festgestellt, hat es zum Zeitpunkt der Analyse von #utils.gls-short("kite2") keine niedergeschriebene Spezifikation des Story-Formates gegeben. Nach Gesprächen mit Beteiligten am Projekt wurde in Konsequenz eine Spezifikation konzeptioniert und erstellt, die Struktur und Format der Geschichten dokumentiert.

Diese orientiert sich an einem vorhandenen Story-Format für Twine namens _Harlowe_ @noauthor_harlowe_nodate und erweitert dieses um zusätzliche Features, die speziell für die Anwendung der Geschichten in #utils.gls-plural("visual_novel") mit Unterstützung für Nutzer-Feedback zum Spieldurchlauf gedacht sind.

Eine Geschichte in Twine kann aus einer beliebigen Anzahl von _Passagen_ bestehen, die jeweils einen Teil der Geschichte beschreiben. Diese Passagen können beliebig miteinander verknüpft werden, um den Spielfluss zu steuern. So entsteht ein _gerichteter Graph_, der die Struktur der Geschichte beschreibt.

In @twine-story-graph ist ein solcher Graph zu sehen, wie er in der #utils.gls-short("gui") des Twine-Editors dargestellt wird. In diesem Falle ist der Graph einer Geschichte abgebildet, die für #utils.gls-short("kite2") erstellt wurde. Die _Knoten_ des Graphen repräsentieren die Passagen der Geschichte, während die _Kanten_ die Verknüpfungen zwischen den Passagen darstellen. Jede Kante repräsentiert eine Auswahlmöglichkeit, die Spieler*innen treffen können, um von einer Passage zur nächsten zu gelangen.

Da es sich um einen gerichteten Graphen handelt, können die Knoten eine beliebige Anzahl von Kanten haben, die optional auch bidirektional sein können. Das bedeutet, dass ein zwei Knoten in beiden Richtungen miteinander verknüpft sein können. Passagen können von mehreren anderen Passagen aus erreichbar sein und umgekehrt. Dies ermöglicht es, komplexe Geschichten mit vielen Verzweigungen und Entscheidungspunkten abzubilden.

Zusätzlich wird ein Knoten speziell als _Start-Passage_ markiert, die den Einstiegspunkt in die Geschichte darstellt. Diese ist auf @twine-story-graph mit einem grünen Punkt markiert. Wenn eine Passage keinerlei Verbindungen zu anderen Passagen hat, bildet sie ein mögliches Ende der Geschichte ab.

#figure(
  image("/resources/images/twine_story_graph.png"),
  caption: [Graph einer Twine Geschichte, die für #utils.gls-short("kite2") erstellt wurde.],
) <twine-story-graph>

Neben der eben beschriebenen Struktur der Geschichten, erweitert die #utils.gls-short("kite2") Story-Spezifikation die Möglichkeiten der Geschichten um zusätzliche Funktionalitäten, die für die Anwendung in #utils.gls-plural("visual_novel") gedacht sind. Diese werden in der Spezifikation als Schlüsselwörter festgelegt, die in den Passagen-Definitionen verwendet werden können, um bestimmte Funktionen zu erfüllen. Ein paar dieser Schlüsselwörter sind beispielhaft in @tabelle-story-spezifikation dargestellt.

Neben den gelisteten soll es außerdem möglich sein, eigene Schlüsselwörter zu definieren, um diese dann später auswerten zu können. Dadurch soll eine große Bandbreite an Anwendungsmöglichkeiten für die Geschichten ermöglicht werden, die über die Standard-Funktionalitäten hinausgehen.

#let specTable = table(
  columns: (15%, 35%, 50%),
  table.header([*Keyword*], [*Beschreibung*], [*Beispiel*]),

  [
    _Info_
  ],
  [
    Designiert einen Infotext, welcher Kontext-Informationen zur Geschichte bereitstellt.
  ],
  [
    ```
    >>Info<<
    Dies ist ein Infotext, der Kontext-Informationen zur Geschichte bereitstellt.
    ```
  ],

  [
    _Player_
  ],
  [
    Designiert einen Text, der automatisch dem / der Spieler*in zugeordnet wird.
  ],
  [
    ```
    >>Player<<
    Hallo Welt. Dieser Text stammt von mir, dem / der Spieler*in.
    ```
  ],

  [
    _Character_
  ],
  [
    Designiert einen Charakter-Text, der in der Geschichte vorkommt. Kann zusätzlich mit einem Attribut versehen werden, um beispielsweise eine zugehörige Animation zu definieren.
  ],
  [
    ```
    >>Character1|Smiling<<
    Hallo, ich bin ein Charakter, der in der Geschichte vorkommt.
    ```
  ],

  [
    _Bias_
  ],
  [
    Designiert einen Bias, der in der Geschichte vorkommt. Wird zusätzlich mit einem Attribut versehen, welches den Namen des Bias definiert.
  ],
  [
    ```
    >>Bias|WorkLifeBalanceExpectations<<
    ```
  ],
)
#figure(
  specTable,
  caption: "Einige Schlüsselwörter, die Teil der KITE II Story-Spezifikation sind.",
) <tabelle-story-spezifikation>

Wie eine Passage in einer Geschichte definiert werden kann, ist in @beispiel-story-passagen dargestellt. Diese Passage enthält verschiedene Schlüsselwörter, die in der Story-Spezifikation festgelegt sind. Einerseits beschreiben diese die Interaktion zwischen den Charakteren und dem / der Spieler*in und andererseits bieten sie die Möglichkeit, Biases zu definieren, die in der Geschichte vorkommen. Diese Information wird in der Auswertung eines Spieldurchlaufs verwendet, um Spieler*innen Feedback zu geben und ihre Entscheidungen zu reflektieren.

Nach der Definition des Bias in @beispiel-story-passagen finden sich drei Verbindungen zu anderen Passagen, die Spieler*innen in diesem Punkt der Geschichte auswählen können. Diese bilden somit die Kanten zwischen den Knoten im Graphen ab, wie in @twine-story-graph zu sehen ist und bestehen jeweils aus einem Anzeigetext und einem Verweis auf einen anderen Knoten. Die verwendete Syntax ist Teil der _Harlowe_ Spezifikation @noauthor_harlowe_nodate-1, auf welcher die #utils.gls-short("kite2") Story-Spezifikation basiert.

#let storyPassageContent = [
  ```
  >>Info<<
  Du besuchst deine Eltern, um ihnen von deiner neuen Geschäftsidee zu erzählen.

  >>Player<<
  Hallo Mama, hallo Papa! Ich habe eine neue Geschäftsidee und würde gerne ein Unternehmen gründen.

  >>Character1|Critical<<
  Klingt sinnvoll, aber vergiss nicht, dass so eine Gründung oft mehr kostet als gedacht. Was ist, wenn du nicht genug Finanzierung erhältst?

  >>Character2|Neutral<<
  Ja das stimmt. Es ist wichtig, dass du dir darüber im Klaren bist, dass es oft schwierig ist, an Kapital zu kommen.

  >>Bias|AccessToFinancing<<

  [[Deshalb hab ich mir weitere Finanzierungsquellen angeschaut, damit mein Unternehmen auch ohne sofortige Finanzierung gut läuft.->Positiv]]

  [[Ehrlich gesagt, macht mir das echt Angst, dass das Geld nicht reicht, und ich weiß nicht, was ich dann machen soll.->Besorgt-Negativ]]

  [[Ja, ich habe mich gut informiert und packe das. Ich weiß, ihr macht euch nur Sorgen und wollt, dass ich alles im Blick habe.->Familie]]
  ```
]
#figure(
  utils.listing(storyPassageContent),
  caption: "Beispielhafte Definition einer Passage in einer Geschichte, die der Story-Spezifikation folgt.",
) <beispiel-story-passagen>

An dieser Stelle ist es wichtig zu verstehen, dass die in Twine geschriebenen Geschichten mit verschiedenen _Story-Formaten_ gebaut werden können, wobei _Harlowe_ in der aktuellen Version von Twine, _Twine 2_, das Standard-Format ist. Diese können als eine Art Compiler verstanden werden, die aus den Daten der Geschichte eine Ausgabe in einem bestimmten Format generieren.

Unterschiedliche Story-Formate bieten unterschiedliche Features, wie zum Beispiel Makros an, die in den Geschichten verwendet werden können, um benutzerdefinierte Funktionen zu implementieren. Verschiedene Formate unterscheiden sich in der Art, welche Makros sie unterstützen, wie stark anpassbar sie sind und in der Gestaltung ihrer Ausgabe @noauthor_twine_nodate-1.

Auf technischer Ebene übersetzen die Story-Formate die Story-Daten in eine HTML Datei @noauthor_twine_nodate. Der Aufbau eines Story-Formates ist durch Twine spezifiziert. Dadurch wird es Drittparteien ermöglicht, eigene Story-Formate zu entwickeln, welche dann wiederum in Twine verwendet werden können.

Dadurch ist es also auch möglich, die für #utils.gls-short("kite2") entwickelte Story Spezifikation in Form eines Twine Story-Formates zu implementieren, sodass bereits zum Zeitpunkt der Erstellung der Geschichten die Konformität zur Spezifikation validiert wird und die Ausgabe in einem Format erfolgen kann, welches direkt von einer entsprechenden Anwendung verwendet werden kann, ohne dass eine zusätzliche Übersetzung notwendig ist. Mehr zur Umsetzung dieses Formates ist in #utils.todo("Abschnitt Umsetzung Story Format referenzieren.") beschrieben.

==== Audio-visuelle Darstellung <audio-visuelle-darstellung>

Neben der Datenstruktur der Geschichten, die in @story-spezifikation beschrieben ist, ist auch die audio-visuelle Darstellung der Geschichten ein wichtiger Aspekt der #utils.gls-short("kite2") Anwendung. Die wichtigsten Aspekte dieser sind bereits in @zielsetzung beschrieben. In diesem Abschnitt wird auf einige technische Details eingegangen, die durch die Bestandsanalyse identifiziert worden sind und für die Umsetzung der #utils.gls-short("library") und des Prototypen von Relevanz sind.

Im Anbetracht auf die Konzeption und Umsetzung der #utils.gls-short("library") wurde zunächst analysiert, wie die Geschichten in #utils.gls-short("kite2") visuell gestaltet sind.

Die Unity Engine bedient sich in ihrer Terminologie teilweise aus der Theater und Filmwelt. So werden #utils.glspl("scene") als Metapher verwendet, um einen Spiele-Abschnitt zu beschreiben, der aus verschiedenen #utils.glspl("asset") zusammengesetzt wird, um einen Teil der Handlung darzustellen.

In #utils.gls-short("kite2") ist die visuelle Darstellung der Szenen folgendermaßen strukturiert:

- _Hintergrund_: Wird hauptsächlich verwendet, um die Umgebung darzustellen, in der sich die Geschichte abspielt.
- _Mittelgrund_: Wird hauptsächlich für die Darstellung von Charakteren verwendet.
- _Vordergrund_: Kann dazu verwendet werden, um vor Mittel- und Hintergrund #utils.glspl("sprite") zu platzieren, um beispielsweise einen Eindruck von Tiefe zu schaffen.

In den beschriebenen Ebenen können verschiedene Assets beliebig platziert werden, die dann in der Szene dargestellt werden. Separat von diesen existieren noch die UI-Elemente, die für die Darstellung der Gespräche in der Geschichte und Benutzerinteraktion zuständig sind.

#figure(
  grid(
    columns: 6,
    gutter: 4pt,
    stroke: 1pt + utils.colorScheme.hhnBlue,
    align: bottom + center,
    image("/resources/images/kite/kite-screenshot-dialogue.png"),
    image("/resources/images/kite/bank_environment.png"),
    image("/resources/images/kite/plant.png", width: 45%),
    image("/resources/images/kite/bank_character_cropped.png", width: 90%),
    image("/resources/images/kite/bank_foreground.png"),
    image("/resources/images/kite/glass.png", width: 20%),
  ),
  caption: "Die Darstellung einer Szene in KITE II und ihre Bestandteile.",
) <kite2-scene-components>

Anhand von @kite2-scene-components lässt sich erkennen, wie sich eine komplette Szene, aus verschiedenen Assets zusammensetzt. Von links nach rechts betrachtet sieht man:

1. Die Szene, die aus den verschiedenen Assets komponiert wird.
2. Ein Sprite, welches die Umgebung dargestellt und in der Hintergrund-Ebene platziert ist.
3. Ein Sprite, welches eine Pflanze darstellt und ebenfalls in der Hintergrund-Ebene platziert ist.
4. Das Charakter-Sprite, welches in der Mittelgrund-Ebene platziert ist.
5. Ein Sprite, welches in der Vordergrund-Ebene platziert ist, um der Szene den Eindruck von Tiefe zu verleihen.
6. Ein Sprite, welches ein Glas Wasser darstellt und ebenfalls im Vordergrund platziert ist.

Während die beschriebenen Assets von Entwickler*innen zur Compile-Zeit, dass, bevor das Programm ausgeführt wird, in der Szene platziert werden, werden UI-Elemente wie die Textboxen zur Darstellung der Gespräche während der Laufzeit generiert je nach Verlauf der Geschichte basierend auf den Entscheidungen der Spieler*innen.

// TODO: Animationen von Assets und Sounds / Sound-Effekte
