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

#let table = table(
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
#figure(table, caption: "Stakeholder-Gruppen und ihre Bedürfnisse.") <tabelle-stakeholder-gruppen>

In Gesprächen mit den verschiedenen Stakeholdern wurden dann die Bedürfnisse und Anforderungen an die Lösung konkretisiert. Dazu wurde mit Personen in leitenden Funktionen des #utils.gls-short("kite2") Projektteams, Autor*innen von interaktiven Geschichten, sowie Künstler*innen und Entwickler*innen des Projektteams gesprochen.

Die dadurch gewonnenen Erkenntnisse sind in die Formulierung der Anforderungen an die jeweiligen Komponenten der Lösung eingeflossen und sind in @tabelle-anforderungen-bibliothek und @tabelle-anforderungen-prototyp zusammengefasst. Zusätzlich sind hierdurch Probleme und Herausforderungen identifiziert worden, die aktuell in der Entwicklung von #utils.gls-short("kite2") bestehen und die durch die #utils.gls-short("library") adressiert werden sollen. Diese Erkenntnisse sind in @problemstellung zusammengefasst.

=== Analyse bestehender Arbeitsergebnisse von #utils.gls-short("kite2") <analyse-kite2>

Abgesehen von den Gesprächen mit Stakeholdern, wie in @stakeholder-gespraeche beschrieben, wurden auch bestehende Arbeitsergebnisse von #utils.gls-short("kite2") analysiert, um die Anforderungen an die #utils.gls-short("library") und den Prototypen zu konkretisieren. Dazu wurden verschiedene Dokumente und Code-Repositories des #utils.gls-short("kite2") Projekts untersucht.

#utils.todo("Analyse von bestehenden Dokumenten und Code-Repositories beschreiben.")
