#import "/etc/utils.typ"

== Ausgangslage <ausgangslage>

In Kooperation mit der Bundesweiten Gründerinnenagentur @bga_bundesweite_2025 verfolgt die Hochschule Heilbronn mit #utils.gls-short("kite2") ein Projekt, welches auf spielerische Art in Form einer interaktiven Visual Novel Nutzer*innen über bestimmte Inhalte aufklären und beraten möchte. Dazu wird außerdem von Anbindungen an Large Language Models (LLMs) Gebrauch gemacht, um Nutzern konkretes Feedback zu Entscheidungen zu geben, die diese getroffen haben.

Konkret geht es bei #utils.gls-short("kite2") darum, über diskriminierende Erfahrungen im Gründungsprozess bei Frauen aufzuklären, um Gründerinnen darin zu unterstützen, solche Erfahrungen zu bewältigen. Untersuchungen dieser Anwendung haben bereits gezeigt, dass der gewählte Ansatz effektiv darin sein kann, Nutzer*innen klares, relevantes und angemessen ausgedrücktes Feedback zu geben @reichert_empowering_2024.

Die Kernfunktionalität der vorhandenen Anwendung besteht darin, verschiedene #utils.gls-plural("visual_novel") auszuwählen, diese zu spielen und dann ein Feedback zu erhalten. Diese bereiten jeweils unterschiedliche Situation aus dem Alltag und der Arbeit auf, die Gründerinnen im Prozess der Gründung eines Unternehmens erleben könnten, um Nutzer*innen somit mit verschiedenen Herausforderungen zu konfrontieren, die in diesem Kontext existieren können.

#figure(
  grid(
    columns: 4,
    image("/resources/images/kite/kite-screenshot-start-screen.png", width: 80%),
    image("/resources/images/kite/kite-screenshot-novel-list.png", width: 80%),
    image("/resources/images/kite/kite-screenshot-pre-dialog-info.png", width: 80%),
    image("/resources/images/kite/kite-screenshot-dialogue.png", width: 80%),
  ),
  caption: [
    Screenshots der #utils.gls-short("kite2") Anwendung.
  ],
) <kite-ii-screenshots>

In @kite-ii-screenshots sind einige Screenshots aus der #utils.gls-short("kite2") Anwendung zu sehen, wie diese zum Zeitpunkt des Beginns an dieser Thesis vorliegt, um eine Vorstellung vom Referenz-Projekt dieser Arbeit zu schaffen. Von rechts nach links betrachtet ist zu sehen:

- Der Start-Bildschirm, der den Nutzer*innen die verschiedenen #utils.gls-plural("visual_novel") graphisch aufbereitet zur Auswahl anbietet.
- Die Liste der verfügbaren #utils.gls-plural("visual_novel"), die in der Anwendung gespielt werden können.
  - Die Navigation zwischen den einzelnen Bildschirmen im Hauptmenü erfolgt über eine Navigation Bar, wie man sie aus graphischen Oberflächen in mobilen Geräten kennt @google_navigation_2025.
- Der Bildschirm, der vor dem Start einer #utils.gls-short("visual_novel") erscheint und den Nutzer*innen Informationen zur jeweiligen Geschichte bietet.
- Der Bildschirm, der während des Spielens einer #utils.gls-short("visual_novel") erscheint und die Interaktion mit der Geschichte ermöglicht.

Zusätzlich wird nach einem Spieldurchgang einer #utils.gls-short("visual_novel") den Nutzer*innen ein Feedback zum Verlauf der Geschichte gegeben. Dieses wird mit Hilfe eines #utils.gls-short("llm") erstellt, welches durch gezieltes konstruieren einer Anfrage an das Modell (#utils.gls("prompt_engineering")), konstruktiv und zielführend sein soll. Dazu folgt der Prompt einer zuvor definierten Datenstruktur mit dem Ziel, die Qualität der Ausgabe des #utils.gls-short("llm")s zu optimieren.

Das Paper _Navigating Bias: Using LLMs to Analyze Discrimination in Entrepreneurial Game Dialogues_ @marsden_navigating_2025 beschreibt, wie #utils.gls-long("llm")s in #utils.gls-short("kite2") konkret genutzt werden, um das Feedback zu konstruieren. Eine Tabelle auf Seite 209 der Veröffentlichung stellt die hierbei verwendete Datenstruktur dar und ist hier zur Veranschaulichung dieser in @tabelle_kiteII_prompt_struktur übernommen und übersetzt worden.

#figure(
  table(
    columns: 2,
    inset: 8pt,
    align: left,
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
  caption: [Struktur des Prompts zum Erstellen des Feedbacks in #utils.gls-short("kite2"), übernommen und übersetzt aus @marsden_navigating_2025.],
) <tabelle_kiteII_prompt_struktur>

Neben den eigentlichen Inhalten der #utils.gls-plural("visual_novel"), die Nutzer*innen erfahren können stellt dieser Feedback Mechanismus hier eine zweite essentielle Funktionalität dar: Die Bewertung, Analyse und kritische Einordnung der Spielerfahrung und Inhalte. Dadurch erhalten die Spieler*innen eine für die Effektivität von #utils.gls-plural("serious_game") als Lern-Werkzeuge entscheidene Rückmeldung, wie es in @einleitung ist.

Die im Rahmen dieser Thesis zu erstellende #utils.gls-short("library") soll also unter Berücksichtigung dieser Elemente konzipiert und implementiert werden. In @problemstellung werden im Zuge dessen Probleme identifiziert und erläutert, die während der Entwicklung von #utils.gls-short("kite2") aufgetreten sind.
