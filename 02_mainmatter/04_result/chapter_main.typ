#import "/etc/utils.typ"

= Ergebnis <ergebnis>

In diesem Kapitel werden die Ziele dieser Arbeit evaluiert und mit dem implementierten System abgeglichen. Dazu werden die zuvor definierten Anforderungen betrachtet und mit dem Arbeitsergebnis verglichen, um festzustellen, ob das System diese erfüllt.

== Evaluation der Anforderungen an die Visual Novel Bibliothek _VisualNovelEngine_ <evaluation-anforderungen-vn-bibliothek>

In @tabelle-anforderungen-bibliothek sind die Anforderungen an die Bibliothek formuliert, die für die Darstellung der Visual Novels zuständig ist. In diesem Abschnitt werden diese mit dem Ergebnis abgeglichen.

Die erste Anforderung ist folgendermaßen formuliert:

- _Darstellen_ und _Ausführen_ von #utils.gls-plural("visual_novel"), die dem für #utils.gls-short("kite2") erstellten Format folgen.
  - Dazu gehört:
    - Darstellung von _Texten, Bildern und anderen Medien_, die in den #utils.gls-plural("visual_novel") verwendet werden.
    - _Animierbarkeit_ der einzelnen Darstellungselemente.
    - _Interaktion_ mit den #utils.gls-plural("visual_novel") durch den Nutzer, um Entscheidungen zu treffen und den Verlauf der Geschichte zu beeinflussen.

Das _VisualNovelEngine_ Modul ist in der Lage, die für KITE II verfassten Geschichten zu darzustellen und kann die Texte und Bilder, die hierfür erstellt wurden, wiederverwenden.

Abzüge gibt es in diesem Bezug darauf, dass die Bibliothek noch keine Unterstützung zum Abspielen von Sounds implementiert, obwohl hierfür die nötigen Schnittstellen bereits existieren. Diese Funktionalität steht also noch aus und kann in Zukunft implementiert werden.

Des Weiteren sind Animationen, die für KITE II erstellt wurden, nicht einfach wiederverwendbar. Dies ist dadurch bedingt, dass diese einem Format folgen, welches spezifisch für Unity geschaffen wurde und nicht ohne Weiteres für andere Plattformen wiederverwendet werden kann. Daher wurde entschieden, für die Bibliothek ein separates Animations-System zu erstellen (siehe @implementierung-animation-system), welches jedoch vom Funktionsumfang nicht vergleichbar mit dem von Unity ist. Es wurde so konzipiert, dass es möglichst erweiterbar ist, konnte jedoch im Zeitrahmen dieser Arbeit noch nicht im großen Maße ausgearbeitet werden.

Die Interaktion und Spielfluss der Geschichten wird vollständig unterstützt.

Insgesamt ist der Kern der Anforderung, nämlich die KITE II Geschichten abspielbar zu machen, erfüllt, wobei jedoch in den Details noch Funktionalitäten fehlen, die in Zukunft ausgebaut werden müssten, um eine äquivalente Nutzererfahrung bieten zu können.

Die nächste formulierte Anforderung an die Bibliothek lautet:

- _Exportieren_ von Spieldurchgängen in ein Format, welches für die Weiterverarbeitung durch eine andere Anwendung geeignet ist.
  - Dies soll es ermöglichen, Spieldurchgänge zu speichern oder anderweitig auszuwerten, wie zum Beispiel zur Analyse durch ein #utils.gls-short("llm").

Die _VisualNovelEngine_ unterstützt eine solche Funktionalität, indem der Spielverlauf einer Geschichte stetig protokolliert wird und jederzeit abrufbar ist. So kann zum Beispiel der Spielverlauf über eine Hilfsmethode zu einem Dialog-Text konvertiert werden, der dann wiederum für einen Prompt an ein #utils.gls-long("llm") verwendet werden kann.

Im Prototypen wird hiervon beispielsweise Gebrauch gemacht, um nach Beenden einer Geschichte in einem separaten Bildschirm den Spielverlauf in Form des Dialoges anzuzeigen. In @listing:playthroughDialogUsage:3 ist die Stelle zu sehen, an der die Hilfsmethode `toPlaythroughDialog()` zu diesem Zwecke verwendet wird.

#utils.codly(
  highlights: (
    (line: 3, start: 25, fill: utils.colorScheme.hhnOrange),
  ),
)
#let playthroughDialogUsageListing = ```kotlin
StoryEndScreenContent(
    description = metaInfo.description,
    playthroughDialog = playthroughRecord.toPlaythroughDialog()
)
```
#figure(
  playthroughDialogUsageListing,
  caption: [Mit Hilfe von `toPlaythroughDialog()` wird aus dem Spielverlauf ein Dialog-Text erstellt, um diesen Nutzer*innen zu präsentieren.],
) <listing:playthroughDialogUsage>

Damit wird diese Anforderung als vollständig erfüllt gewertet.

Die letzte Anforderung, die an die Bibliothek gestellt wurde, lautet:

- _#utils.gls-short("cross_platform")-Fähigkeit_, um die #utils.gls-plural("visual_novel") auf verschiedenen Plattformen lauffähig zu machen.
  - Als primäre Zielplattformen gelten Android, iOS und das Web. In Zukunft sollen diese ebenfalls auf Desktop-Plattformen erweitert werden können.

Die _VisualNovelEngine_ Bibliothek verwendet das #utils.gls-long("cmp") Framework, welches theoretisch iOS, Android, Web und die Desktop-Plattformen Windows, macOS und Linux unterstützen kann. Die konkrete Umsetzung der _VisualNovelEngine_ hat sich zunächst auf die Plattformen iOS, Android und Web beschränkt, kann in Zukunft jedoch auf die Desktop-Plattformen erweitert werden.

Die im Rahmen dieser Arbeit erstellte Bibliothek _VisualNovelEngine_ erfüllt somit zum großen Teil alle gestellten Anforderungen, jedoch mit Einschränkungen im Bezug auf die Implementierung verschiedener Animations-Formate. Im folgenden @evaluation-anforderungen-prototyp wird mit der Evaluation der Anforderungen an den Prototypen namens _VisualNovelExample_ fortgefahren.

== Evaluation der Anforderungen an den Prototypen _VisualNovelExample_ <evaluation-anforderungen-prototyp>

In @tabelle-anforderungen-prototyp sind Anforderungen an den Prototypen formuliert, der beispielhaft eine Applikation implementiert, die unter Nutzung der _VisualNovelEngine_ Bibliothek die KITE II Visual Novels spielbar machen soll. In diesem Abschnitt werden diese mit dem implementierten Prototypen namens _VisualNovelExample_ abgeglichen.

Die erste Anforderung lautet: _Lauffähigkeit_ auf Android, iOS und im Web. Da der Prototyp wie auch die Bibliothek in #utils.gls-long("cmp") mit den Zielplattformen iOS, Android und Web implementiert ist, ist diese erfüllt. Außerdem unterstützt #utils.gls-short("cmp") auch Desktop-Plattformen, weshalb in Zukunft auch diese unterstützt werden könnten.

Die nächste Anforderung ist die Verwendung der im Rahmen dieser Thesis geschaffenen _#utils.gls-short("library")_ zur Darstellung und Ausführung von #utils.gls-plural("visual_novel"). Auch diese ist erfüllt, da die _VisualNovelEngine_ im Prototypen als Abhängigkeit deklariert und verwendet wird, um die Geschichten in Form von Visual Novels spielbar zu machen.

In @listing:prototypeGradleScript ist zu sehen, wie diese Abhängigkeit im Build-Skript des Prototypen deklariert wird. Zunächst wird in der Datei `libs.version.toml` die Modul-Bezeichnung und Versionsnummer der Bibliothek festgelegt (@listing:prototypeGradleScript:4), bevor sie dann im Build-Skript selbst niedergeschrieben wird (@listing:prototypeGradleScript:12).

#utils.codly(
  highlights: (
    (line: 4, end: 18, fill: utils.colorScheme.hhnOrange),
    (line: 12, start: 5, fill: utils.colorScheme.hhnOrange),
  ),
  display-icon: false,
  display-name: false,
)
#let prototypeGradleScriptListing = ```kotlin
// libs.version.toml
visualnovel-engine-version = "1.0.1"
[libraries]
visualnovel-engine = {
  module = "fk.visualnovel.engine:library",
  version.ref = "visualnovel-engine-version"
}

// build.gradle.kts
commonMain.dependencies {
    // ...
    implementation(libs.visualnovel.engine)
}
```
#figure(
  prototypeGradleScriptListing,
  caption: [Ausschnitt aus dem Gradle Build-Skript vom _VisualNovelExample_ Projekt und der `libs.version.toml`-Datei, in der die Versionen der verwendeten Bibliotheken hinterlegt werden.],
) <listing:prototypeGradleScript>

Die nächste Anforderung an den Prototypen ist folgendermaßen formuliert:

- _Wiederverwendung_ der für #utils.gls-short("kite2") geschriebenen Geschichten.
  - Die für #utils.gls-short("kite2") geschriebenen Geschichten sollen in diesem Prototypen wiederverwendet werden können, ohne dass diese angepasst werden müssen.

Obwohl die Geschichten spielbar gemacht werden konnten, konnte dies nicht bei allen Geschichten ohne Anpassung realisiert werden. Da die Spezifikation und das Story-Format welches diese implementiert, erst im Rahmen dieser Arbeit entwickelt wurde (mehr hierzu in @story-spezifikation und @implementierung-story-format), waren noch nicht alle verfassten Geschichten mit diesem konform, weshalb diese in Zukunft entsprechend angepasst werden müssten.

Durch die Entwicklung der Spezifikation und des Formates wurde jedoch ein wichtiger Schritt für die Wiederverwendbarkeit der Geschichten gemacht, da es nun ein definiertes Format gibt, welchem diese folgen können. Daher würde es in Zukunft auch einfacher sein, eine konforme Geschichte mit Hilfe des Twine Story-Formates zu entwickeln, die mit dem Prototypen und der Bibliothek verwendbar ist. Außerdem wurde hier im Sinne von _Specification by Example_ Dokumentation geschaffen, die anhand von Beispiel die Nutzung des Formates erklärt.

Es sind letztendlich die meisten der KITE II Geschichten ohne Anpassungen für den Prototypen verwendbar gewesen, aber eben nicht alle. Daher ist diese Anforderung nicht ohne Einschränkungen erfüllt.

Als nächstes ist folgende Anforderung zu evaluieren:

- Möglichkeit der _Auswertung_ von Spieldurchgängen durch ein #utils.gls-short("llm").
  - Die Spieldurchgänge müssen von der #utils.gls-short("library") in einem Format exportiert werden, welches dem Prototypen ermöglicht, einen wie in @tabelle_kiteII_prompt_struktur strukturierten Prompt zu generieren, der an ein #utils.gls-short("llm") übergeben werden kann.

Der Prototyp implementiert noch keine konkrete Anfrage an ein #utils.gls-long("llm"), es sind jedoch alle hierfür nötigen Kontext-Informationen abrufbar, um einen Prompt zu konstruieren, wie er in @tabelle_kiteII_prompt_struktur für KITE II strukturiert wurde. Dazu müsste lediglich eine Anbindung an beispielsweise einen Web-Service erfolgen, der die Anfrage an ein LLM ausführt.

Es ist also möglich, einen Prompt zu generieren, um die Spieldurchgänge auswerten zu lassen, auch wenn die Anfrage selbst nicht implementiert ist. Daher ist die Möglichkeit gegeben und die Anforderung ist als vollständig erfüllt zu bewerten.

Zuletzt ist diese Anforderung an den Prototypen gestellt worden:

- _Speichern_ von Spieldurchgängen, um diese später fortsetzen zu können.
  - Diese Funktionalität ist zum Zeitpunkt der Erstellung dieser Thesis noch nicht in #utils.gls-short("kite2") implementiert, soll aber im Prototypen demonstriert werden.

Diese ist in der initialen Planung dieser Arbeit gestellt worden, jedoch konnte zeitlich bedingt nicht umgesetzt werden. Diese Funktionalität ist gerade für längere Geschichten wünschenswert, jedoch für die KITE II Geschichten weniger essentiell, da diese in wenigen Minuten durchgespielt werden können. In KITE II existierte eine solche Funktionalität zum Start-Zeitpunkt der Thesis auch nicht. Trotzdem ist diese Anforderung wichtig und sollte für zukünftige Entwicklungen berücksichtigt und geplant werden.

Der Prototyp _VisualNovelExample_ konnte insgesamt nicht alle geplanten Anforderungen vollständig umsetzen. Nicht alle KITE II Geschichten sind spielbar. Durch das entwickelte Twine Story-Format sollte eine Anpassung und Prüfung der noch nicht kompatiblen Geschichten jedoch unter geringem Aufwand realisiert werden können. Die größte offene Anforderung bezogen des Prototypen ist wohl die Unterstützung des Speicherns der Spieldurchgänge. Die Planung und Umsetzung eines solchen Features wäre in einer zukünftigen Iteration der Applikation zu tätigen.

Letztendlich demonstriert _VisualNovelExample_ jedoch, wie die im Rahmen dieser Thesis geschaffenen Entwicklungs-Tools genutzt werden können, um Visual Novels auf einer Reihe von Plattformen realisiert zu können und insbesondere, wie die für KITE II geschriebenen Geschichten mit Hilfe dieser realisiert werden können. Eine tiefere Evaluation und Diskussion der Arbeitsergebnisse findet sich in @diskussion.
