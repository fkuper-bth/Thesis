#import "/etc/utils.typ"

== Implementierung des #utils.gls-long("visual_novel") Prototypen <implementierung-prototyp>

Nachdem die in @implementierung-visual-novel-engine beschriebene _VisualNovelEngine_ implementiert wurde, konnte unter Nutzung dieser mit der Umsetzung eines Prototypen begonnen werden, der die für das KITE II Projekt geschriebenen interaktiven Geschichten spielbar macht und darstellt.

Dieser sollte wie auch KITE II für mehrere Plattformen verfügbar sein, wobei zunächst die Plattformen Android, iOS und das Web als Hauptplattformen angestrebt wurden.

Ebenso wie die Visual Novel Bibliothek soll der Prototyp als technologische Grundlage #utils.gls-long("cmp") verwenden.

In diesem Kapitel wird die Implementation beschrieben, wie sie im Rahmen dieser Arbeit angefertigt wurde. Da für das Projekt, welches den Prototypen umsetzt, der Namen _VisualNovelExample_ gewählt wurde, wird folglich diese Bezeichnung verwendet und ist somit synonym mit dem Prototypen zu verstehen.

Der zugrunde liegende Aufbau der _VisualNovelExample_ Applikation folgt im Großen und Ganzen der gleichen wie der Demo Applikation, die in @vn-engine-demo-app-listing-part-two zu sehen und in @implementierung-visual-novel-engine beschrieben ist.

Die Architektur folgt dem bekannten #utils.gls-short("mvvm") Muster und auch dieses Projekt macht von dem #utils.gls-short("di") Framework _Koin_ Gebrauch, um Abhängigkeiten aufzulösen.

Der Fokus bei der Ausgestaltung der Applikation lag dabei auf den Visual Novels selbst, da diese das Herz der Anwendung bilden. Andere Bildschirme, die in KITE II implementiert sind, aber sekundäre Funktionen erfüllen, wie Informations-Screens oder Settings-Screens wurden daher in der Implementation zunächst vernachlässigt.

#let prototypeMainScreenImage = image("/resources/images/prototype_mainscreen.png")
#let prototypeDialogueScreenImage = image("/resources/images/prototype_dialogscreen.png")
#let kiteMainScreenImage = image("/resources/images/kite/kite-screenshot-start-screen.png")
#let kiteDialogueScreenImage = image("/resources/images/kite/kite-screenshot-dialogue.png")
#let gridCaption(content) = align(center)[
  #par(justify: false)[#text(content, size: 10pt)]
]
#let screenshotComparisonGrid = grid(
  prototypeMainScreenImage, kiteMainScreenImage, prototypeDialogueScreenImage, kiteDialogueScreenImage,
  gridCaption([Der Hauptbildschirm des Prototypen.]),
  gridCaption([Der Hauptbildschirm von KITE II.]),
  gridCaption([Ein Dialogbildschirm des Prototypen.]),
  gridCaption([Ein Dialogbildschirm von KITE II.]),

  columns: 4,
  rows: 2,
  inset: 4pt,
  stroke: utils.colorScheme.hhnWhite,
  fill: utils.colorScheme.background,
)
#figure(
  screenshotComparisonGrid,
  caption: [Screenshots verschiedener Bildschirme jeweils aus der _VisualNovelExample_ Applikation und KITE II.],
) <figure:comparisonPrototypeAndKite2>

In @figure:comparisonPrototypeAndKite2 sieht man den beispielhaften Vergleich zweier Bildschirme jeweils aus der Prototyp-Anwendung und von KITE II.

Hier ist zu sehen, dass insbesondere die Gestaltung von Benutzeroberflächen-Elementen im Prototypen auf Standard-Komponenten gesetzt wurde, die bereits durch das #utils.gls-short("cmp") Framework bereitgestellt wurden, während in KITE II diese ein eigenes Styling erhalten haben.

Die Darstellung der Umgebungen und Charaktere dagegen sollte möglichst KITE II nach empfunden werden, indem die originalen Assets hierfür wiederverwendet wurden und somit zu demonstrieren, dass die geschaffene Bibliothek in der Lage ist, eine äquivalente Visual Novel umzusetzen.

Außerdem ist hier sichtbar, dass viele der in KITE II existierenden Bildschirme nicht im Prototypen umgesetzt sind. Diese sind als nicht essentiell bewertet worden und wurden somit zunächst außen vor gelassen.

Um die letztendliche Darstellung der interaktiven Geschichten umzusetzen werden im Prototypen in Anlehnung an KITE II einige Mechanismen implementiert, die in ähnlicher Form auch in diesem Projekt existieren.

So werden die Story-Dateien zusätzlich mit einer Datei mit Meta-Daten verknüpft, die zur jeweiligen Geschichte verschiedene Meta-Informationen enthalten kann, wie z.B. Datenpunkte, die in der Benutzeroberfläche verwendet werden wie eine Beschreibung der Geschichte, einen Titel oder eine Akzent-Farbe. Außerdem können hier Infos, wie eine Kontext-Beschreibung für einen Prompt hinterlegt werden, welche in KITE II zur Generierung des Feedbacks durch ein LLM verwendet wird.

Sämtliche Informationen zu einer Visual-Novel werden in einer `manifest.json` Datei zusammengefasst, welche zum Programm-Start gelesen und verarbeitet wird.

// TODO: manifest file listing beschreiben

#utils.codly(
  skips: (
    (8, 24),
  ),
)
#let manifestFileListing = ```json
{
  "stories": {
    "E72DE4D6-B3AC-4977-99C4-6CB5D7CFCF98": {
      "fileName": "Novel_Buero.json",
      "metaFileName": "Novel_Buero.meta.json",
      "assetListName": "novelBueroAssets"
    },
  }
}
```
#figure(
  manifestFileListing,
  caption: [Ausschnitt aus der `manifest.json` Datei.],
) <listing:manifestFile>
