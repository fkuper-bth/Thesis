#import "../../etc/utils.typ"

== Ausgangslage und Problemsituation <ausgangslage>

In Kooperation mit der Bundesweiten Gründerinnenagentur @bga_bundesweite_2025 verfolgt die Hochschule Heilbronn mit KITE II ein Projekt, welches auf spielerische Art in Form einer interaktiven Visual Novel Nutzer*innen über ernste Inhalte aufklären und beraten möchte. Dazu wird außerdem von Anbindungen an Large Language Models (LLMs) Gebrauch gemacht, um Nutzern konkretes Feedback zu Entscheidungen zu geben, die diese getroffen haben.

Im Falle von KITE II geht es darum, über diskriminierende Erfahrungen im Gründungsprozess bei Frauen aufzuklären, um Gründerinnen darin zu unterstützen, solche Erfahrungen zu bewältigen. Diese Anwendung hat bereits gezeigt, dass der gewählte Ansatz effektiv darin sein kann, Nutzer*innen klares, relevantes und angemessen ausgedrücktes Feedback zu geben @reichert_empowering_2024.

Im Zuge der originalen Konzeption von KITE II wurde eine größere Bandbreite von spielerischen Elementen, wie zum Beispiel eine navigierbare Spielwelt, geplant. Im Laufe der Entwicklung und Evaluation der Anwendung wurde sich jedoch auf die wesentliches Elemente konzentriert, wodurch sich die breite an umgesetzten Features verringert hat. Die gewählte Technologie Unity @unity_technologies_unity_2019 wurde für die zunächst größere Vision gewählt, um alle geplanten Features umsetzen zu können.

Die Unity Engine ist für Spiele oder Anwendungen mit 3 dimensionaler Darstellung optimiert und hat dementsprechend sehr viele Funktionalitäten, die für den vorliegenden Anwendungsfall nicht relevant sind. Durch die Wahl einer Technologie, die für den Anwendungsfall optimiert ist, kann die resultierende Anwendung intuitiver in der Bedienung, Ressourcensparender sowie auch einfacher in der Entwicklung gestaltet werden.

Die Kernfunktionalität der vorhandenen Anwendung besteht darin, verschiedene Geschichten (Visual Novels) auszuwählen, diese zu spielen und dann ein Feedback zu erhalten. Alle Elemente der Anwendung lassen sich recht einfach mit etablierten UI Frameworks auf mobilen Betriebssystemen wie Android oder iOS darstellen.

#figure(
  grid(
    columns: 4,
    image("../../resources/kite-screenshot-start-screen.png", width: 80%),
    image("../../resources/kite-screenshot-novel-list.png", width: 80%),
    image("../../resources/kite-screenshot-pre-dialog-info.png", width: 80%),
    image("../../resources/kite-screenshot-dialogue.png", width: 80%),
  ),
  caption: [
    Screenshots der KITE II Anwendung.
  ],
) <kite-ii-screenshots>

In @kite-ii-screenshots sind einige Screenshots aus der KITE II Anwendung zu sehen. Dabei sieht man einmal den Start-Screen, der einerseits den Nutzer*innen graphisch aufbereitet die verschiedenen Novels zur Auswahl anbietet, diese andererseits aber auch in Form einer einfach Liste anbietet. Navigation zwischen den einzelnen Screens im Start-Screen erfolgt über eine Navigation Bar, wie man sie aus graphischen Oberflächen in mobilen Geräten kennt @google_navigation_2025.

#utils.todo([Absatz korrigieren. In KITE II wird nicht HTML gerendert, sondern die Novels werden in Unity dargestellt.])

Die Darstellung der Novels dagegen erfolgt über HTML. Die Novels werden mit Twine erstellt. Ein entsprechender Twine Compiler erstellt aus den vor-definierten Novels dann interaktive HTML-Pages. Diese können einfach mit vorhandenen mobilen UI Frameworks dargestellt werden (wie z.B. der WebView Komponente von Android @google_webview_2025).

Die Kernelemente der vorliegenden Anwendung KITE II lassen sich also problemlos in eine alternative mobile UI Technologie wie beispielsweise Android Compose @google_jetpack_2025 oder SwiftUI @apple_xcode_2025 umsetzen. Im Zuge dieser Umsetzung soll ein Rahmenwerk geschaffen werden, mit dem der durch KITE II verfolgte Ansatz zur interaktiven Aufklärung und Schulung von Nutzer*innen auch mit wenig Aufwand auf andere Themengebiete angewandt werden kann.
