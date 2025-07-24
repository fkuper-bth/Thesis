#import "/etc/utils.typ"

== Ausgangslage <ausgangslage>

In Kooperation mit der Bundesweiten Gründerinnenagentur @bga_bundesweite_2025 verfolgt die Hochschule Heilbronn mit KITE II ein Projekt, welches auf spielerische Art in Form einer interaktiven Visual Novel Nutzer*innen über ernste Inhalte aufklären und beraten möchte. Dazu wird außerdem von Anbindungen an Large Language Models (LLMs) Gebrauch gemacht, um Nutzern konkretes Feedback zu Entscheidungen zu geben, die diese getroffen haben.

Im Falle von KITE II geht es darum, über diskriminierende Erfahrungen im Gründungsprozess bei Frauen aufzuklären, um Gründerinnen darin zu unterstützen, solche Erfahrungen zu bewältigen. Diese Anwendung hat bereits gezeigt, dass der gewählte Ansatz effektiv darin sein kann, Nutzer*innen klares, relevantes und angemessen ausgedrücktes Feedback zu geben @reichert_empowering_2024.

Die Kernfunktionalität der vorhandenen Anwendung besteht darin, verschiedene Geschichten (Visual Novels) auszuwählen, diese zu spielen und dann ein Feedback zu erhalten. Die darstellerischen Elemente der Anwendung lassen sich mit etablierten UI Frameworks auf verschiedenen Betriebssystemen reproduzieren.

#figure(
  grid(
    columns: 4,
    image("../../resources/images/kite/kite-screenshot-start-screen.png", width: 80%),
    image("../../resources/images/kite/kite-screenshot-novel-list.png", width: 80%),
    image("../../resources/images/kite/kite-screenshot-pre-dialog-info.png", width: 80%),
    image("../../resources/images/kite/kite-screenshot-dialogue.png", width: 80%),
  ),
  caption: [
    Screenshots der KITE II Anwendung.
  ],
) <kite-ii-screenshots>

In @kite-ii-screenshots sind einige Screenshots aus der KITE II Anwendung zu sehen. Dabei sieht man einmal den Start-Screen, der einerseits den Nutzer*innen graphisch aufbereitet die verschiedenen Novels zur Auswahl anbietet, diese andererseits aber auch in Form einer einfach Liste anbietet. Navigation zwischen den einzelnen Screens im Start-Screen erfolgt über eine Navigation Bar, wie man sie aus graphischen Oberflächen in mobilen Geräten kennt @google_navigation_2025.

== Problemstellung <problemstellung>

Im Zuge der originalen Konzeption von KITE II wurde eine größere Bandbreite von spielerischen Elementen, wie zum Beispiel eine navigierbare Spielwelt, geplant. Für solch eine Art von Anwendung wurde die populäre Game Engine Unity @unity_technologies_unity_2019 gewählt, welche unter Spielentwickler*innen, die eine Game Engine verwenden, sehr beliebt ist, wobei fast 40% dieser Gruppe Unity als primäre Engine verwenden @slashdata_team_did_2022.

Im Laufe der Entwicklung haben sich jedoch die Anforderungen an KITE II geändert, sodass die ursprünglich konzeptionierte navigierbare Spielwelt nicht mehr benötigt wurde. Dadurch, dass sich durch die initialen Annahmen für Unity entschieden wurde und die Entwicklung bereits weit fortgeschritten war, war ein Wechsel auf eine andere eventuell besser an die aktuellen Anforderungen geeignete Technologie nicht mehr wirtschaftlich.

Doch haben sich durch die Wahl von Unity im frühen Stadium des Projektes später einige Probleme ergeben, die die Entwicklung der Anwendung erschwert haben und außerdem einige qualitative Aspekte der Anwendung negativ beeinflusst haben. Des Weiteren haben sich im Laufe der Entwicklung andere technische Schwierigkeiten herausgestellt.

=== Schmerzpunkte in der Entwicklung von KITE II <schmerzpunkte>

Der folgende Abschnitt beschreibt einige der größten Schmerzpunkte, die sich im Laufe der Entwicklung von KITE II ergeben haben, welche durch diese Arbeit adressiert werden sollen. Diese wurden in Zusammenarbeit mit dem Projektteam von KITE II erarbeitet und sind nicht abschließend.

Die Unity Engine bringt viel Funktionalität und Komplexität mit sich, die für den Anwendungsfall von KITE II nicht benötigt wird. Im Vergleich zu anderen Technologien können hierunter folgende Aspekte leiden:
- _Performance_ der Anwendung im Bezug auf Speicherbedarf und CPU-Auslastung.
- _Größe_ der ausgelieferten Anwendung.
- _Komplexität_ der Entwicklung durch die Vielzahl an Features, die Unity bietet.

Der Produktionsprozess der Visual Novels ist aufgrund einiger Tatsachen eng mit dem Entwicklungsprozess gekoppelt.
So gibt es zum Startzeitpunkt dieser Arbeit keine Spezifikation des Formats der Geschichten, die für KITE II geschrieben wurden. Dadurch ist es einerseits schwierig, diese Geschichten in anderen Anwendungen zu verwenden, andererseits ist es mit großem Aufwand verbunden, das Geschichten-Format zu erweitern oder zu ändern.

Die Geschichten werden außerdem nicht in einem Format exportiert, welches eine einfache Weiterverarbeitung in einer Anwendung erlaubt. Daraus resultierend wurde für KITE II ein Parser direkt in der Anwendung selbst implementiert, welcher das Ausgabeformat der Geschichten in ein für die Anwendung verwendbares Format umwandelt. Mangels Modularität ist dieser Parser jedoch nicht für andere Anwendungen verwendbar und nicht einfach zu testen.

So herrscht hier insgesamt eine hohe Abhängigkeit zwischen dem Entwicklungsteam und den Autor*innen der Geschichten. Bei jeder Änderung des Formats der Geschichten ist eine enge Abstimmung zwischen Autor*innen und Entwickler*innen notwendig, um die Geschichten weiterhin in der Anwendung verwenden zu können.

Durch das Schaffen wohl definierter Schnittstellen zwischen den Beteiligten an der Entwicklung einer Anwendung, die Visual Novels verwendet, kann der Abstimmungsbedarf zwischen den einzelnen Parteien deutlich verringert werden und die Testbarkeit und Stabilität der Anwendung verbessert werden. Des Weiteren kann durch Schaffen einer geeigneten Bibliothek zum Darstellen von interaktiven Geschichten in einer den Anforderungen entsprechenden Technologie die Performance, Größe und Komplexität der Anwendung verringert werden.

Da sich die Darstellung der Geschichten in KITE II auf 2-dimensionale Graphiken mit einfachen Animationen beschränkt (wobei die dargestellten Umgebungen hier aus verschiedenen Inhalten komponiert werden können; siehe @kite-ii-screenshots rechts), lassen diese sich in einer alternativen UI Technologie wie beispielsweise Android Compose @google_jetpack_2025 oder SwiftUI @apple_xcode_2025 umsetzen.

Im Zuge dieser Umsetzung soll ein Rahmenwerk geschaffen werden, mit dem der durch KITE II verfolgte Ansatz zur interaktiven Aufklärung und Schulung von Nutzer*innen auch mit wenig Aufwand auf andere Themengebiete angewandt werden kann.
