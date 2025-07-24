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

== Problemstellung <problemstellung>

Im Zuge der originalen Konzeption von #utils.gls-short("kite2") wurde eine größere Bandbreite von spielerischen Elementen, wie zum Beispiel eine navigierbare Spielwelt, geplant. Für solch eine Art von Anwendung wurde die populäre Game Engine Unity @unity_technologies_unity_2019 gewählt, welche unter Spielentwickler*innen, die eine Game Engine verwenden, sehr beliebt ist, wobei fast 40% dieser Gruppe Unity als primäre Engine verwenden @slashdata_team_did_2022.

Im Laufe der Entwicklung haben sich jedoch die Anforderungen an #utils.gls-short("kite2") geändert, sodass die ursprünglich konzeptionierte navigierbare Spielwelt nicht mehr benötigt wurde. Dadurch, dass sich durch die initialen Annahmen für Unity entschieden wurde und die Entwicklung bereits weit fortgeschritten war, war ein Wechsel auf eine andere eventuell besser an die aktuellen Anforderungen geeignete Technologie nicht mehr wirtschaftlich.

Doch haben sich durch die Wahl von Unity im frühen Stadium des Projektes später einige Probleme ergeben, die die Entwicklung der Anwendung erschwert haben und außerdem einige qualitative Aspekte der Anwendung negativ beeinflusst haben. Des Weiteren haben sich im Laufe der Entwicklung andere technische Schwierigkeiten ergeben.

=== Schmerzpunkte in der Entwicklung von KITE II <schmerzpunkte>

Der folgende Abschnitt beschreibt einige der größten Schmerzpunkte, die sich im Laufe der Entwicklung von #utils.gls-short("kite2") ergeben haben, welche durch diese Arbeit adressiert werden sollen. Diese wurden in Zusammenarbeit mit dem Projektteam von #utils.gls-short("kite2") erarbeitet und sind nicht abschließend.

Die Unity Engine bringt viel Funktionalität und Komplexität mit sich, die für den Anwendungsfall von #utils.gls-short("kite2") nicht benötigt wird. Im Vergleich zu anderen Technologien können hierunter folgende Aspekte leiden:
- _Performance_ der Anwendung im Bezug auf Speicherbedarf und CPU-Auslastung.
- _Größe_ der ausgelieferten Anwendung.
- _Komplexität_ der Entwicklung durch die Vielzahl an Features, die Unity bietet.

Der Produktionsprozess der Visual Novels ist aufgrund einiger Tatsachen eng mit dem Entwicklungsprozess gekoppelt.
So gibt es zum Startzeitpunkt dieser Arbeit keine Spezifikation des Formats der Geschichten, die für #utils.gls-short("kite2") geschrieben wurden. Dadurch ist es einerseits schwierig, diese Geschichten in anderen Anwendungen zu verwenden, andererseits ist es mit großem Aufwand verbunden, das Geschichten-Format zu erweitern oder zu ändern.

Die Geschichten werden außerdem nicht in einem Format exportiert, welches eine einfache Weiterverarbeitung in einer Anwendung erlaubt. Daraus resultierend wurde für #utils.gls-short("kite2") ein Parser direkt in der Anwendung selbst implementiert, welcher das Ausgabeformat der Geschichten in ein für die Anwendung verwendbares Format umwandelt. Mangels Modularität ist dieser Parser jedoch nicht für andere Anwendungen verwendbar und nicht einfach zu testen.

So herrscht hier insgesamt eine hohe Abhängigkeit zwischen dem Entwicklungsteam und den Autor*innen der Geschichten. Bei jeder Änderung des Formats der Geschichten ist eine enge Abstimmung zwischen Autor*innen und Entwickler*innen notwendig, um die Geschichten weiterhin in der Anwendung verwenden zu können.

Durch das Schaffen _wohl definierter Schnittstellen_ zwischen den Beteiligten an der Entwicklung einer Anwendung, die Visual Novels verwendet, kann der Abstimmungsbedarf zwischen den einzelnen Parteien deutlich verringert werden und die Testbarkeit und Stabilität der Anwendung verbessert werden. Des Weiteren kann durch Schaffen einer geeigneten #utils.gls-short("library") zum Darstellen von interaktiven Geschichten in einer den Anforderungen entsprechenden Technologie die Performance, Größe und Komplexität der Anwendung verringert werden. Eine detaillierte Auseinandersetzung mit der Thematik der Schnittstellen in interdisziplinären Software-Projekten erfolgt in @analyse-team-schnittstellen.

Da sich die Darstellung der Geschichten in #utils.gls-short("kite2") auf 2-dimensionale Graphiken mit einfachen Animationen beschränkt (wobei die dargestellten Umgebungen hier aus verschiedenen Inhalten komponiert werden können; siehe @kite-ii-screenshots rechts), lassen diese sich in einer alternativen UI Technologie wie beispielsweise Android Compose @google_jetpack_2025 oder SwiftUI @apple_xcode_2025 umsetzen.

Im Zuge dieser Umsetzung soll ein Rahmenwerk geschaffen werden, mit dem der durch #utils.gls-short("kite2") verfolgte Ansatz zur interaktiven Aufklärung und Schulung von Nutzer*innen auch mit wenig Aufwand auf andere Themengebiete angewandt werden kann.

=== Schnittstellen in interdisziplinären Software-Projekten <analyse-team-schnittstellen>

Das #utils.gls-short("kite2") Projekt ist ein interdisziplinäres Projekt, an dem Personen mit unterschiedlichen Rollen beteiligt sind. Diese Rollen sind Beispielsweise:

- _Entwickler*innen_, die die Anwendung entwickeln und pflegen.
- _Autor*innen_, die die Geschichten für die Anwendung schreiben.
- _Künstler*innen_, die die grafischen Elemente der Anwendung gestalten.

Bedingt durch die unterschiedlichen Rollen und die damit verbundenen unterschiedlichen Fähigkeiten und Interessen der Beteiligten ergeben sich Herausforderungen in der Zusammenarbeit und der Kommunikation.

So gibt es beispielsweise in der Spiele-Industrie bestimmte Rollen, die sich darauf spezialisieren, die Lücke zwischen Künstler*innen und Entwickler*innen zu schließen, wie zum Beispiel die _Technical Artists_ @dealessandri_introduction_2022. Ein Bericht über den Job-Markt in der Spiele-Industrie in Großbritannien zeigt, dass Technical Artist dort der am dritthäufigsten gesuchte Job-Titel von Arbeitgebern in der Industrie ist @benjamin_williams_uk_2022.

Die Zusammenarbeit zwischen den verschiedenen Rollen in einem interdisziplinären Software-Projekt kann durch das Schaffen von _Schnittstellen_ zwischen den Beteiligten verbessert werden. Diese Schnittstellen können beispielsweise in Form von Dokumentationen, Spezifikationen oder Protokollen definiert werden, die die Anforderungen und Erwartungen der verschiedenen Rollen an die Zusammenarbeit festlegen.

Kollaborative Arbeitspraktiken wie beispielsweise _Specification By Example_ versuchen, das Verständnis zwischen den verschiedenen Rollen zu verbessern, indem sie die Anforderungen an die Software in Form von Beispielen definieren, die von allen Beteiligten verstanden werden können @gojko_adzic_specification_2011. Außerdem dienen diese Beispiele als rollenübergreifende #utils.gls("ssot"), was die Konsistenz und Nachvollziehbarkeit der Anforderungen erhöht.

Andere Ansätze zum kollaborativen Definieren und Erarbeiten von Anforderungen und anderer Projektdokumentation wie _Pair Documentation_ können ebenfalls helfen, die Qualität der Dokumentation und das Verständnis der Anforderungen innerhalb des Team zu verbessern @qamar_evaluating_2023. Hierbei wird die Dokumentation in Paaren erstellt, die sich aus Team-Mitgliedern mit unterschiedlichen Rollen zusammensetzen. Dadurch wird eine größere Vielfalt an Perspektiven und Erfahrungen in den Dokumentationsprozess einbezogen, was zu einer höheren Qualität der Dokumentation führen kann.

Andererseits muss bei Wahl der Arbeitsprozess bei Erstellung von Dokumentation von Spezifikationen und Anforderungen darauf geachtet werden, dass der Grad der Formalität den Bedürfnissen des Projektes angepasst werden sollte. Ein iterativer Ansatz, welcher vom Projekt-Team akzeptiert wird, kann ein wichtiger Faktor für eine nachhaltige Praxis sein @christoph_johann_stettina_documentation_2012. So könne Dokumentationsarbeit innerhalb eine Entwicklungsteams als aufdringlich wahrgenommen werden und Kollaboration innerhalb des Teams mindern, weshalb es sehr wichtig sei, eine Form der Dokumentation zu wählen, dessen Wert vom Team anerkannt wird und als richtiges Produkt empfunden wird.

=== Domänenspezifische und Mehrzweck Werkzeuge <dsl-gpl>

Die in @schmerzpunkte beschriebenen Schmerzpunkte in der Entwicklung von #utils.gls-short("kite2") deuten auf eine Problematik hin, die im Laufe von vielen Software-Projekten auftritt. Die Wahl einer Technologie, die für eine große Bandbreite von Anwendungsfällen geeignet ist, wie hier die Unity Engine, kann im Verlauf eine Projektes Kosten mit sich bringen, die zu Beginn nicht immer offensichtlich sind. Andererseits ist es durch die iterative Natur der Software-Entwicklung im frühen Stadium eines Projektes oft notwendig auf Technologien zu setzen, die ein breites Spektrum an Anwendungsfällen abdecken können, um mögliche Änderungen an Anforderungen im Laufe des Projektes umsetzen zu können.

So gibt es in der Software-Entwicklung zwei Arten von Programmiersprachen, die sich in ihrer Eignung für verschiedene Anwendungsfälle unterscheiden: #utils.glspl("dsl") und #utils.glspl("gpl"). #utils.gls-plural("dsl") sind Programmiersprachen, die speziell für eine bestimmte Anwendungsdomäne entwickelt wurden, während #utils.gls-plural("gpl") für eine breite Palette von Anwendungen geeignet sind.

#utils.gls-plural("dsl") können verglichen mit #utils.gls-plural("gpl") zu erhöhter Produktivität führen, sogar wenn Nutzer weniger vertraut mit einer #utils.gls-short("dsl") sind @kosar_comparing_2010. Dies liegt daran, dass #utils.gls-plural("dsl") speziell für eine bestimmte Anwendungsdomäne entwickelt wurden und daher eine höhere Abstraktionsebene bieten, die es ermöglicht, komplexe Probleme einfacher zu lösen.

Durch das Schaffen von Werkzeugen, die auf eine bestimmte Anwendungsdomäne zugeschnitten sind, können also Produktivität gesteigert werden. Bei stabilen und präzisen Anforderungen an Lösungen, kann durch Entwicklung von domänenspezifischen Werkzeugen also durchaus sowohl höhere Produktivität der Entwicklung, also auch höhere Qualität und Modularität der Software erreicht werden, in dem domänenspezifische Lösungen abstrahiert und wiederverwendbar beispielsweise in Form einer #utils.gls-short("library") bereitgestellt werden.
