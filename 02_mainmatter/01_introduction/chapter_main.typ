#import "/etc/utils.typ"
#import "/etc/plots.typ"

= Einleitung <einleitung>

Interaktive Formen der Inhaltsvermittlung in der Bildung genießen in der heutigen Zeit ein hohes Interesse. Dabei können Konzepte, die Bildung und spielerische Elemente kombinieren, wie #utils.gls("gamification") oder #utils.glspl("serious_game") nachweislich zu einer verbesserten Lernerfahrung führen, wobei durch Nutzung von Spielmechaniken das Vermögen, sich neue Fähigkeiten anzueignen, deutlich verbessert wäre. Außerdem sei #utils.gls-short("gamification") in der Bildung ein effektives Mittel, um Lernende zu motivieren und zu engagieren @giang_gamification_2013 @kiryakova_gamification_2014.

Das öffentliche Interesse an diesen Methoden der Inhaltsvermittlung ist seit Anfang der 2010er Jahre bis heute wachsend, wie auch am in @gamification-google-trends-since-2010 dargestellten Suchinteresse am Begriff _#utils.gls-short("gamification")_ zu erkennen ist. Obwohl das Interesse von 2016 bis 2020 zu stagnieren schien, kam 2021 ein erneuter Schub an öffentlichen Interesse, wobei dieses in den letzten 3 Jahren auf einem historischen Hoch liegt.

#figure(
  plots.createGamificationInterestPlot(),
  caption: [
    Relatives weltweites Interesse am Suchbegriff _#utils.gls-short("gamification")_ im zeitlichen Verlauf seit 2010, Datenquelle: Google Trends @noauthor_google_nodate.
  ],
) <gamification-google-trends-since-2010>

Diese Renaissance kann vermutlich mit der globalen COVID-19 Pandemie in Verbindung gebracht werden, welche Bildungsinstitutionen weltweit dazu zwang, einen größeren Fokus auf digitale Angebote in der Lehre zu legen. Resultierend hieraus hat sich die Akzeptanz für Bildungsmethoden im Internet unter Schülern und Studenten erhöht, wenn auch traditionelle Bildung von Angesicht zu Angesicht noch immer bevorzugt würde @csorba_impact_2024. Mit einem besseren Verständnis der Chancen und Risiken dieser Methoden scheint es also erneut großes Interesse an der Entwicklung und Erforschung dieser zu geben.

Während es bei #utils.gls-short("gamification") darum geht, spielerische Elemente in einen nicht-spielerischen Kontext zu integrieren, um die Nutzererfahrung zu verbessern und das Engagement zu erhöhen, geht es bei #utils.gls-short("serious_game") darum, Spiele zu entwickeln, die zur Vermittlung von Wissen oder Fähigkeiten dienen. Hier stehen die spielerischen Elemente also im Vordergrund und sind nicht lediglich ein Mittel, um vorhandene Lerninhalte durch Integration von Spielmechaniken anzureichern.

Meta-Analysen bezüglich der Effektivität von #utils.gls-plural("serious_game") als Lernmaterial deuten darauf hin, dass diese zwar nicht anderen Lernmaterialien kategorisch überlegen sind, aber als sehr effektive Lernmittel eingestuft werden können @backlund_educational_2013.

Auch in anderen Anwendungsbereichen wie dem Gesundheitssektor deuten Meta-Analysen darauf hin, dass sowohl #utils.gls-plural("serious_game") als auch #utils.gls-short("gamification") effektiv darin sein können, positive gesundheitsresultate zu fördern, wobei hier jedoch auch darauf hingewiesen wird, dass weitere Forschung in diesem Bereich erforderlich ist, um die Chancen und Limitationen dieser Technologien besser zu verstehen @damasevicius_serious_2023.

Insgesamt scheinen #utils.gls-plural("serious_game") einen nachweislich positiven Effekt im Engagement der Lernenden zu haben @girard_serious_2013.

Abgesehen von der Modalität der Lernmittel besteht die Frage, welche Art von Spiel besonders effektiv im Lernprozess sein kann. In der Gestaltung eines #utils.gls-short("serious_game") sind viele verschiedene Faktoren zu berücksichtigen, wie die Lernziele, Zielgruppe, der Nutzungskontext, die Bewertungskriterien der Lernerfahrung oder das Budget.

Eine besonders kosteneffektive Art von Videospiel bezogen auf Produktionskosten können dabei #utils.glspl("visual_novel") sein. Bei dieser Art Spiel können Spielende eine #utils.gls("interaktive_erzählung") mit audio-visuellen Elementen erleben, die je nach ihren Entscheidungen einen anderen Verlauf nehmen kann.

Außerdem können #utils.gls-plural("visual_novel") großes Potenzial bergen, den Spieler*innen Lerninhalte effektiv zu präsentieren. Hierbei sei es sehr wichtig, dass die Charaktere und Geschichte gut entwickelt sind und den Spieler*innen eine Projektionsfläche bieten, sich hiermit zu identifizieren. Abgesehen von der Gestaltung der Geschichte und des Lernprozesses sei es außerdem wichtig, dass es eine klare Strategie zur Bewertung der Lernerfahrung gebe @oygardslia_educational_2020.

Die vorliegende Arbeit stellt einen Versuch dar, diese Potenziale mit Hilfe der Ergebnisse für Entwickler*innen leichter verfügbar zu machen, indem es die Produktion einer #utils.gls-long("visual_novel") unter Berücksichtigung der Anforderungen an diese Art Spiel im Bereich der #utils.gls-plural("serious_game") vereinfacht.

#pagebreak()
#include "01_leitgedanke.typ"
