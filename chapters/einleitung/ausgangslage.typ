#import "/etc/utils.typ"

== Ausgangslage <ausgangslage>

In Kooperation mit der Bundesweiten Gründerinnenagentur @bga_bundesweite_2025 verfolgt die Hochschule Heilbronn mit #utils.gls-short("kite2") ein Projekt, welches auf spielerische Art in Form einer interaktiven Visual Novel Nutzer*innen über ernste Inhalte aufklären und beraten möchte. Dazu wird außerdem von Anbindungen an Large Language Models (LLMs) Gebrauch gemacht, um Nutzern konkretes Feedback zu Entscheidungen zu geben, die diese getroffen haben.

Im Falle von #utils.gls-short("kite2") geht es darum, über diskriminierende Erfahrungen im Gründungsprozess bei Frauen aufzuklären, um Gründerinnen darin zu unterstützen, solche Erfahrungen zu bewältigen. Diese Anwendung hat bereits gezeigt, dass der gewählte Ansatz effektiv darin sein kann, Nutzer*innen klares, relevantes und angemessen ausgedrücktes Feedback zu geben @reichert_empowering_2024.

Die Kernfunktionalität der vorhandenen Anwendung besteht darin, verschiedene #utils.gls-plural("visual_novel") auszuwählen, diese zu spielen und dann ein Feedback zu erhalten. Die darstellerischen Elemente der Anwendung lassen sich mit etablierten UI #utils.gls("framework")s auf verschiedenen Betriebssystemen reproduzieren.

#figure(
  grid(
    columns: 4,
    image("../../resources/images/kite/kite-screenshot-start-screen.png", width: 80%),
    image("../../resources/images/kite/kite-screenshot-novel-list.png", width: 80%),
    image("../../resources/images/kite/kite-screenshot-pre-dialog-info.png", width: 80%),
    image("../../resources/images/kite/kite-screenshot-dialogue.png", width: 80%),
  ),
  caption: [
    Screenshots der #utils.gls-short("kite2") Anwendung.
  ],
) <kite-ii-screenshots>

In @kite-ii-screenshots sind einige Screenshots aus der #utils.gls-short("kite2") Anwendung zu sehen. Dabei sieht man einmal den Start-Screen, der einerseits den Nutzer*innen graphisch aufbereitet die verschiedenen Novels zur Auswahl anbietet, diese andererseits aber auch in Form einer einfach Liste anbietet. Navigation zwischen den einzelnen Screens im Start-Screen erfolgt über eine Navigation Bar, wie man sie aus graphischen Oberflächen in mobilen Geräten kennt @google_navigation_2025.
