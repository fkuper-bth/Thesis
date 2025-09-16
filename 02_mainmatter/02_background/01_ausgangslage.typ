#import "/etc/utils.typ"

== Ausgangslage: Das Projekt KITE <ausgangslage>

#let fig = figure(
  image("/resources/images/kite/kite-Icon.png", width: 60%),
  caption: [Logo des #utils.gls-short("kite") Projektes @noauthor_kite_nodate.],
)
#let body = [
  In Kooperation mit der #utils.gls("bga", display: "Bundesweiten Gründerinnenagentur (BGA)") @bga_bundesweite_2025 verfolgt die Hochschule Heilbronn mit #utils.gls-short("kite2") ein Projekt, welches auf spielerische Art in Form von interaktiven Visual Novels Nutzer*innen über bestimmte Inhalte aufklären und beraten möchte. Dazu wird außerdem von gezielten Anfragen an #utils.gls-plural("llm") Gebrauch gemacht, um Nutzern konkretes Feedback zu Entscheidungen und zum Spielverlauf zu geben.
]
#utils.wrap-content(
  fig,
  body,
  align: top + right,
  column-gutter: 2em,
)

Auf der Projektseite der Hochschule Heilbronn wird dieses folgendermaßen beschrieben: "In KITE II wird eine KI-gestützte, gamifizierte Anwendung entwickelt, die Gründerinnen dabei unterstützen soll, resilienter im Umgang mit diskriminierenden Erfahrungen im Gründungsprozess zu werden." @hochschule_heilbronn_kite_2023. Der Durchführungszeitraum des Projektes beläuft sich vom 01.01.2023 bis zum 31.12.2025 und ist daher zum Zeitpunkt der Verfassung dieser Thesis noch nicht abgeschlossen.

Wie der Projektname impliziert, baut dieses auf einem Pilotprojekt namens #utils.gls("kite", long: false) auf, welches von 2020 bis 2021 lief. Das Kürzel steht für _#utils.gls-long("kite")_. Im Projekt wurde gemeinsam mit Gründerinnen daran gearbeitet, Ausgrenzungsmuster zu identifizieren und Strategien zu entwickeln, wie andere Gründerinnen ähnliche Situationen bewältigen können, um dadurch ihre Resilienz erhöhen zu können @noauthor_pilotprojekt_nodate.

Auf den Erkenntnissen des Pilotprojektes aufbauend erhebt #utils.gls-short("kite2") den Anspruch, Gründerinnen mit Hilfe einer spielerischen Anwendung aufzuklären und in ihren Ambitionen zu unterstützen. Dabei soll insbesondere auf #utils.gls-plural("bias") und Ausgrenzungsmuster hingewiesen werden, die Gründerinnen erfahren können, damit Nutzer*innen hiervon Lernen und neue Herangehensweisen entwickeln können (@bundesweite_grunderinnenagentur_bga_was_2024, Minute 2:23).

Untersuchungen der Anwendung haben bereits gezeigt, dass die gezielte Analyse durch ein #utils.gls-short("llm") effektiv darin sein kann, Nutzer*innen klares, relevantes und angemessen ausgedrücktes Feedback zu geben @reichert_empowering_2024.

Der Kern von #utils.gls-short("kite2") besteht also darin, verschiedene #utils.gls-plural("visual_novel") anzubieten, welche von Nutzer*innen gespielt werden können und hierzu jeweils Feedback zu geben. Diese bereiten jeweils unterschiedliche Situationen aus dem Alltag und der Arbeit auf, die Gründerinnen im Prozess der Gründung eines Unternehmens erleben könnten, um Nutzer*innen somit mit verschiedenen Herausforderungen zu konfrontieren, die in diesem Kontext existieren können.

#figure(
  grid(
    columns: 4,
    image("/resources/images/kite/kite-screenshot-start-screen.png", width: 80%),
    image("/resources/images/kite/kite-screenshot-novel-list.png", width: 80%),
    image("/resources/images/kite/kite-screenshot-pre-dialog-info.png", width: 80%),
    image("/resources/images/kite/kite-screenshot-dialogue.png", width: 80%),
  ),
  caption: [Screenshots der #utils.gls-short("kite2") Anwendung auf der Plattform iOS.],
) <kite-ii-screenshots>

In @kite-ii-screenshots sind einige Screenshots aus der #utils.gls-short("kite2") Anwendung zu sehen, wie diese zum Zeitpunkt des Beginns dieser Thesis vorliegt, um eine Vorstellung vom Referenz-Projekt dieser Arbeit zu schaffen. Von rechts nach links betrachtet ist zu sehen:

- Der Start-Bildschirm, der den Nutzer*innen die verschiedenen #utils.gls-plural("visual_novel") graphisch aufbereitet zur Auswahl anbietet.
- Die Liste der verfügbaren #utils.gls-plural("visual_novel"), die in der Anwendung gespielt werden können.
  - Die Navigation zwischen den einzelnen Bildschirmen im Hauptmenü erfolgt über eine Navigation Bar, wie man sie aus graphischen Oberflächen in mobilen Geräten kennt @google_navigation_2025.
- Der Bildschirm, der vor dem Start einer #utils.gls-short("visual_novel") erscheint und den Nutzer*innen Informationen zur jeweiligen Geschichte bietet.
- Der Bildschirm, der während des Spielens einer #utils.gls-short("visual_novel") erscheint und die Interaktion mit der Geschichte ermöglicht.

Zusätzlich wird nach einem Spieldurchgang einer #utils.gls-short("visual_novel") den Nutzer*innen ein Feedback zum Verlauf der Geschichte gegeben. Dieses wird mit Hilfe eines #utils.gls-short("llm") erstellt, welches durch gezieltes Konstruieren einer Anfrage an das Modell (#utils.gls("prompt_engineering")), konstruktiv und zielführend sein soll. Dazu folgt der Prompt einer zuvor definierten Datenstruktur mit dem Ziel, die Qualität der Ausgabe des #utils.gls-short("llm")s zu optimieren.

Das Paper _Navigating Bias: Using LLMs to Analyze Discrimination in Entrepreneurial Game Dialogues_ @marsden_navigating_2025 beschreibt, wie #utils.gls-long("llm")s in #utils.gls-short("kite2") konkret genutzt werden, um das Feedback zu konstruieren. Eine Tabelle auf Seite 209 der Veröffentlichung stellt die hierbei verwendete Datenstruktur dar und ist hier zur Veranschaulichung dieser in @tabelle_kiteII_prompt_struktur übernommen und übersetzt worden.

#figure(
  table(
    columns: 2,
    table.header([*Sektion*], [*Beispiel*]),

    [Rolle], ["Du bist Gender Researcher."],

    [Aufgabe],
    ["Deine Aufgabe ist es, den Gesprächsverlauf nach Diskriminierung und Gender #utils.glspl("bias") zu untersuchen und dem/der Spieler*in Feedback zu geben."],

    [Kontext],
    ["Die Gründerin plant, ein Software-Unternehmen zu gründen und redet darüber mit ihrer besorgten Mutter."],

    [Wissensbasis],
    [Bestehend aus einer Beschreibung von #utils.gls-plural("bias"), mit denen Gründerinnen konfrontiert werden.],

    [Ausgabeformat], [Ziel "Schreibe eine Analyse des Dialoges..."],

    [Ziel], [Umfasst den Gesprächsverlauf (z.B.: Mutter: "Hallo und danke, dass du gekommen bist" Spieler: "Hallo"...)],
  ),
  caption: [Struktur des Prompts zum Erstellen des Feedbacks in #utils.gls-short("kite2"), übernommen und übersetzt aus Marsden et al. 2025 @marsden_navigating_2025.],
) <tabelle_kiteII_prompt_struktur>

Neben den eigentlichen Inhalten der #utils.gls-plural("visual_novel"), die Nutzer*innen erfahren können, stellt dieser Feedback Mechanismus hier eine zweite essentielle Funktionalität dar: Die Bewertung, Analyse und kritische Einordnung der Spielerfahrungen und Inhalte. Dadurch erhalten die Spieler*innen eine für die Effektivität von #utils.gls-plural("serious_game") als Lern-Werkzeuge entscheidende Rückmeldung, wie es in @einleitung beschrieben ist.

Außerdem soll die Anwendung plattformübergreifend (also _#utils.gls-short("cross_platform")_) verfügbar gemacht werden, wobei hier als Ziel-Plattformen Android, iOS, PC und das Web genannt werden (@bundesweite_grunderinnenagentur_bga_was_2024, Minute 5:22).

Die im Rahmen dieser Thesis zu erstellende #utils.gls-short("library") soll also unter Berücksichtigung dieser Elemente konzipiert und implementiert werden. In @problemstellung werden im Zuge dessen Probleme identifiziert und erläutert, die während der Entwicklung von #utils.gls-short("kite2") aufgetreten sind.
