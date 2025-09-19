#import "/etc/utils.typ"

== Implementierung der #utils.gls-long("visual_novel") #utils.gls-short("library") <implementierung-visual-novel-library>

Nachdem im Rahmen der technischen Analyse (siehe @technik_stand) eine Wahl für eine geeignete #utils.gls-short("cross_platform") Technologie getroffen wurde, konnte mit der Umsetzung der #utils.gls-short("library") begonnen werden. Die Implementierung dieser wird in diesem Kapitel beschrieben.

Dieser Arbeitsschritt stellt neben der Umsetzung des Prototypen das größte in @tabelle-terminplanung definierte Arbeitspaket dar und bildet außerdem die technologische Grundlage für die Umsetzung des Prototypen, welche in @implementierung-prototyp beschrieben ist.

Der Entwicklungsprozess sämtlicher Implementierungsphasen dieser Arbeit verfolgt einen iterativen Ansatz, wie bereits in @terminplanung festgelegt wurde.

Dies bedeutet konkret, dass Entwicklungszyklen möglichst kurz gehalten werden sollen, um regelmäßig Feedback von Stakeholdern zum aktuellen Stand einholen zu können. Dies geschieht in Form von regelmäßigen Meetings, in denen Zwischenergebnisse präsentiert und besprochen werden können. Ein solcher Ansatz erlaubt es, Lösungsansätze laufend an Rückmeldungen und Anforderungen anzupassen und verspricht somit, mit größerer Wahrscheinlichkeit eine Lösung hervorzubringen, die den Anforderungen der Stakeholder gerecht wird.

=== Systemübersicht <system-overview>

Das implementierte System setzt sich aus einer Menge von verschiedenen Modulen zusammen, die jeweils als separate Projekte angelegt und entwickelt wurden.

@thesis-container-diagram bietet eine Übersicht über die verschiedenen Module, aus denen das System zusammengesetzt ist, den Technologien, die diesen zugrunde liegen, externen Systemen, die mit dem Hauptsystem interagieren, und den verschiedenen Nutzer*innen, wie sie mit dem System in Berührung kommen. Eine Erklärung der verwendeten Symbolik findet sich in @thesis-container-diagram-legend.

Bevor die Visual Novel Anwendung, sprich der Prototyp, erstellt werden kann, müssen die technischen Grundlagen hierfür gelegt werden.

Zu diesem Zweck wird zunächst auf Basis der ausgearbeiteten KITE II Story Spezifikation (mehr hierzu in @story-spezifikation) ein Twine _Story Format_ entwickelt, welches die interaktiven Geschichten in ein leicht maschinell verarbeitbares Format übersetzt. Eine detaillierte Ausführung zur Implementierung dieses Moduls ist in @implementierung-story-format zu finden.

Auf Basis der Ausgabe dieses Story Formats kann dann das sogenannte _Story Engine_ Modul implementiert werden. Dieses verarbeitet die Daten der jeweiligen Geschichte und stellt Schnittstellen zur Verfügung, um den Spielfluss dieser zu kontrollieren. Die Implementierung dieses Moduls ist in @implementierung-story-engine dokumentiert.

Daraufhin kann eine Bibliothek zur audiovisuellen Aufbereitung dieser Geschichten implementiert werden, hier _Visual Novel Engine_ genannt. Diese stellt sämtliche Funktionalitäten, die mit der Darstellung zu tun haben. Die Implementierung dieser ist der Kerninhalt von @implementierung-story-engine, wobei hier jedoch die Implementierung der Module von unten nach oben erklärt wird, beginnend mit dem _Story Format_ in @implementierung-story-format.

#figure(
  image("/resources/images/diagrams/thesis-container-diagram.png"),
  caption: "Systemübersicht über die verschiedenen Komponenten, die im Rahmen dieser Arbeit entwickelt worden sind.",
) <thesis-container-diagram>

#figure(
  image("/resources/images/diagrams/thesis-container-diagram-legend.png"),
  caption: [Legende zu @thesis-container-diagram.],
) <thesis-container-diagram-legend>

Nachdem die _Visual Novel Engine_ implementiert ist, sind sämtliche Entwicklungs-Tools bereitgestellt, die für die Entwicklung des Prototypen, in @thesis-container-diagram als _Visual Novel Anwendung_ bezeichnet, benötigt werden. Die Implementierung dieser Anwendung wird in @implementierung-prototyp ausgeführt.

=== Implementierung des #utils.gls-short("kite2") Story Formates <implementierung-story-format>

Bevor mit der Umsetzung der eigentlichen #utils.gls-short("library") in #utils.gls-short("cmp") begonnen werden konnte, musste zunächst die in @story-spezifikation beschriebene Story-Spezifikation in Form eines _Story-Formates_ für _Twine_ implementiert werden. Eine genauere Beschreibung, was ein Story Format ist, ist ebenfalls in @story-spezifikation erfolgt.

Kurz gesagt ist die Aufgabe eines solchen Formates vergleichbar mit einem _Compiler_. Eine Repräsentation einer interaktiven Geschichte wird in eine andere übersetzt. Die Ausgabe kann dabei beispielsweise zum Zwecke der direkten Interaktion mit Nutzer*innen als HTML-Seite erzeugt werden oder aber auch als eine Zwischenrepräsentation erfolgen, die weiterverarbeitet werden kann.

Das _Twine_ Projekt spezifiziert ein _Twine 2_ Story Format als eine JavaScript-Datei, normalerweise `format.js` genannt, die eine einzige Funktion aufruft, die ein JSON-Objekt als Parameter übergibt @noauthor_twine_nodate.

#utils.codly-enable()
#let storyFormatContent = ```javascript
window.storyFormat({
  "name": "Twine w/ Kite2 to JSON",
  "version": "0.0.8",
  "author": "Frederik Kuper",
  "description": "Convert Twine stories to JSON for the KITE 2 format.",
  "proofing": false,
  "source": "..."
});
```
#figure(
  storyFormatContent,
  caption: [Inhalt der `format.js` Datei des für #utils.gls-short("kite2") erstellten Story Formates.],
) <story-format-content>

Den Inhalt der `format.js` Datei des für diese Arbeit erstellten Story Formates ist in @story-format-content zu sehen. Hierbei ist zu beachten, dass unter `source` in Zeile 7 eigentlich der Inhalt der HTML-Datei gelistet ist, die intern von Twine beim Ausführen des Formates aufgerufen wird. Der Inhalt ist hier im Interesse der Lesbarkeit ausgeklammert.

Der Inhalt des Feldes `source` in Zeile 7 bildet also die Schnittstelle zwischen Twine und dem Story Format. Hier übergibt Twine die internen Story-Daten an das Format, welches diese daraufhin zu einer entsprechenden Ausgabe weiterverarbeiten kann.

Während die meisten etablierten Story Formate eine HTML-Ausgabe generieren, die direkt von Nutzer*innen konsumiert werden kann, soll das im Rahmen dieser Thesis geschaffene Format eine Ausgabe zur späteren Weiterverarbeitung in der #utils.gls-short("library") erstellen.

Hierzu wird als Ausgabeformat das Datenformat #utils.gls("json") gewählt, da für dieses einerseits in den meisten Programmiersprachen in Form von Parsern unterstützt wird (so auch in Kotlin und #utils.gls("kmp") mit Hilfe offizieller Bibliotheken @noauthor_kotlinkotlinxserialization_2025) und andererseits bereits andere Story Formate existieren, die #utils.gls-short("json") als Ausgabe generieren, an denen sich orientiert werden kann.

Glücklicherweise kann die Entwicklung des Story Formates auf einem vorhandenen Format namens _twine-to-json_ aufgebaut werden, welches quell-offen zur freien Bearbeitung und Verwendung zur Verfügung steht @jtschoonhoven_twine--json_nodate. Dieses erstellt aus in Twine 2 erstellten Geschichten JSON Objekte und unterstützt ebenfalls Geschichten, die auf dem _Harlowe 3_ Format basieren @noauthor_harlowe_nodate, auf welchem ebenfalls die KITE II Story Spezifikation basiert.

Daher kann diese Arbeit als Grundlage in großen Teilen übernommen werden und muss lediglich an die KITE II Spezifikation angepasst werden. Dazu wurde zunächst ein _Fork_ vom ausgehenden _twine-to-json_ Story Format erstellt, auf welchem die nötigen Anpassungen durchgeführt werden können @frederik_kuper_fkuper-bthtwine--json-kite-2_2025.

Dazu wurde zunächst die Implementierung des ursprünglichen Formats analysiert, um dann die nötigen Änderungen an den richtigen Stellen umsetzen zu können. Auf oberster Ebene ist der Programmablauf des twine-to-json Story Formats in @story-format-functionality-pseudo-code abgebildet. Hier wird die Funktion `generateJsonOutput` definiert, welche auf oberster Ebene die Story Daten verarbeitet.

Im Ausführungskontext des Formats existieren die Twine internen Story Daten innerhalb einer HTML-Datei, welche an das Format zur Verarbeitung weitergegeben wird. Diese wird dann beispielsweise in Zeile 3 gelesen, um die Daten in den nächsten Schritten weiter zu verarbeiten. Es wird ein Objekt namens `result` erstellt, welches später die Ausgabe des Story Formates bildet.

Neben Meta-Informationen zur Geschichte, wie der Name oder Name von Autor*in, werden als nächstes die Passagen der Geschichte in @story-format-functionality-pseudo-code:18 analysiert und als Objekt gespeichert. Sämtliche Passagen-Objekte werden dann als Array an das `result` Objekt angehängt, welches wiederum von der `generateJsonOutput` Funktion zurückgegeben wird, um als Ausgabe des Formates genutzt werden zu können.

#utils.codly(
  highlights: (
    (line: 18, start: 21, fill: utils.colorScheme.hhnOrange),
  ),
)
#let storyFormatFunctionalityPseudoCode = ```javascript
function generateJsonOutput() {
  // read story meta data from HTML document
  const storyMeta = getStoryMetaData();

  // create result JSON object with initial meta data
  const result = {
    name: storyMeta.name,
    creator: storyMeta.creator,
    // various other meta info fields...
  };

  // read story content (which is contained in passages)
  const passageElements = getPassages(storyMeta);

  // parse story passages
  const passages = [];
  for (passageElement in passageElements) {
    const passage = parsePassageElement(passageElement);
    passages.push(passage);
  }

  // add passages to result object
  results.passages = passages;

  // return final result object
  return result;
}
```
#figure(
  storyFormatFunctionalityPseudoCode,
  caption: "Programm-Ablauf zum Generieren der JSON Ausgabe auf oberster Ebene als Pseudo-Code.",
) <story-format-functionality-pseudo-code>

Da die Meta-Informationen einer Geschichte durch die KITE II Spezifikation unberührt bleiben und lediglich die Passagen um einige Funktionen erweitert werden, ist also die in @story-format-functionality-pseudo-code:18 aufgerufene Funktion der Punkt, an dem das KITE II Format _twine-to-json_ erweitern muss, um die Spezifikation zu implementieren. Diese Funktion konvertiert im Wesentlichen die Passagen-Daten von HTML in ein JSON Objekt.

In @parse-passage-element-pseudocode ist der Programmablauf dieser Funktion in Pseudo-Code dargestellt. Diese extrahiert zunächst wie auch schon zuvor auf Story-Ebene einige Meta-Daten über die jeweilige Passage und beginnt dann damit, den Inhalt der Passage zu analysieren, was im Funktionsaufruf in @parse-passage-element-pseudocode:13 geschieht.

#utils.codly(
  highlights: (
    (line: 13, start: 26, fill: utils.colorScheme.hhnOrange),
    (line: 27, start: 23, fill: utils.colorScheme.hhnOrange),
  ),
)
#let parsePassageElementPseudoCode = ```javascript
function parsePassageElement(passageElement) {
  // extract meta data from passage HTML element
  const passageMeta = getElementAttributes(passageElement);
  const result = {
    name: passageMeta.name,
    // ...
  };

  // clean passage text content before parsing
  const passageTextContent = passageElement.textContent.trim()

  // parse passage content and update result object with parsed content
  const passageContent = parsePassageContent(passageTextContent);
  Object.assign(result, passageContent);

  return result;
}

function parsePassageContent(passageText) {
  // define result object with empty link collection
  const result = { links: [] };

  // loop through all characters of the passage text
  let currentIndex = 0;
  while (currentIndex < passageText.length) {
    // extract links to other passages and write them to the result object
    const maybeLink = extractLinksAtIndex(passageText, currentIndex);
    if (maybeLink) {
      result.links.push(maybeLink);
      currentIndex += maybeLink.original.length;
    }

    // extract other features ...

    // increment search index
    currentIndex += 1;
  }

  return result;
}
```
#figure(
  parsePassageElementPseudoCode,
  caption: "Programmablauf zur Übersetzung einer Story Passage von HTML in JSON im twine-to-json Story Format.",
) <parse-passage-element-pseudocode>

Die in @parse-passage-element-pseudocode:19 definierte Funktion `parsePassageContent` implementiert dabei die eigentlich Übersetzungslogik, indem durch den übergebenen Passagen-Text iteriert und diesen auf in der jeweiligen Story-Spezifikation definierten Elementen, wie beispielsweise Links zu anderen Passagen, untersucht und diese dann in ein jeweilige Feld des `result` JSON-Objektes übersetzt.

Dies geschieht beispielsweise im Funktionsaufruf in @parse-passage-element-pseudocode:27, welcher ein Objekt zurückgibt, falls an der zu untersuchenden Stelle ein Link gefunden werden konnte. Diese Logik kann ebenso auf andere Elemente angewandt werden, die in einer Story spezifiziert werden. So kann ein Link, wie er im _Harlowe 3_ Format spezifiziert ist, beispielsweise an seiner Formatierung erkannt werden, da diese immer mit den Charakteren "`[[`" beginnen, wie man auch in @beispiel-story-passagen:15 zu sehen ist.

Um die in der KITE II Story Spezifikation definierten Elemente also zusätzlich in der Ausgabe übersetzen zu können, kann die in @parse-passage-element-pseudocode:19 definierte Funktion um diese erweitert werden. Ähnlich wie Links anhand von "`[[`" erkannt werden können, können die für KITE II spezifizierten Elemente anhand der Charaktere "`<<`" erkannt werden.

Dazu wird das Programm um eine Funktion erweitert, die solche Charaktere aus dem Inhalt erkennt und zu entsprechenden JSON Objekten übersetzt. In @new-parse-passage-content:7 sieht man, wie in der erweiterten Funktion die neue Methode aufgerufen wird, welche die Inhalte nach KITE II Elementen untersucht und diese in JSON übersetzt.

#utils.codly(
  highlights: (
    (line: 2, start: 20, end: 34, fill: utils.colorScheme.hhnOrange),
    (line: 7, start: 30, end: none, fill: utils.colorScheme.hhnOrange),
  ),
)
#let newParsePassageContent = ```javascript
function parsePassageContent(passageText) {
  const result = { novelEvents: [] };

  let currentIndex = 0;
  while (currentIndex < passageText.length) {
    // extract KITE II keywords and write them to the result object
    const maybeKiteKeyword = extractKiteKeywordsAtIndex(passageText, currentIndex);
    if (maybeKiteKeyword) {
        currentIndex += maybeKiteKeyword.original.length;
        result.novelEvents.push(maybeKiteKeyword);
    }

    // ...
  }

  return result;
}
```
#figure(
  newParsePassageContent,
  caption: "Erweiterte Parsing Logik für KITE II Spezifikation.",
) <new-parse-passage-content>


So kann unter relativ geringem Entwicklungsaufwand ein Story Format entwickelt werden, welches die KITE II Spezifikation implementiert und das Ergebnis als leicht weiterverarbeitbare JSON-Datei ausgibt.

Die von KITE II definierten Schlüsselwörter wurden im angepassten Story-Format als Konstante hinterlegt, welche unter anderem in der `extractKiteKeywordsAtIndex` genutzt wird, um zwischen den verschiedenen Schlüsselwörtern zu unterscheiden (zu sehen in @kite-keyword-constant).

#let kiteKeywordConstant = ```javascript
const KITE2_KEYWORD_TYPES = Object.freeze({
  SEPARATOR: '--',
  INFO_TEXT: 'info',
  PLAYER_TEXT: 'player',
  END: 'end',
  SOUND: 'sound',
  BIAS: 'bias',
  CHARACTER_ACTION: 'character',
});
```
#figure(kiteKeywordConstant, caption: "Konstante, die Schlüsselwörter von KITE II definiert.") <kite-keyword-constant>

Zur Prüfung der Konformität mit der KITE II Spezifikation wurden Testfälle definiert, die verschiedene valide Eingaben an das Programm übergeben und mit einer erwarteten Ausgabe vergleichen. Dazu wurden beispielsweise für KITE II geschriebene Geschichten als Eingabe-Daten verwendet und zu diesen ein zu erwartetes JSON-Objekt als Ausgabe erstellt.

Zur Definition und automatisierten Ausführung dieser Testfälle wurde das populäre JavaScript Testing Framework _Jest_ @noauthor_jest_nodate gewählt. Die Beschreibung eines solchen Testfalles und wie diese mit Jest definiert werden, ist in @jest-test-cases zu sehen.

Dabei wird zunächst eine Sammlung von Testfällen mit ihren jeweiligen Parametern, wie Ein- und Ausgabe-Daten, definiert (siehe @jest-test-cases:1), welche dann genutzt werden können, um die Implementierung des Story Formats auf Korrektheit zu überprüfen.

Für jeden definierten Testfall werden diese Daten im Test geladen und die Einstiegsfunktion des Story Formats (namens `twineToJSON`) mit den jeweiligen Eingabedaten aufgerufen (siehe @jest-test-cases:20). Das Resultat wird mit dem erwarteten Ausgabe-Objekt auf Gleichheit verglichen (siehe @jest-test-cases:23).

Dies ermöglicht eine schnelle und automatisierte Validierung der Korrektheit der Implementierung und macht es einfacher, im Laufe der Entwicklung Änderungen vorzunehmen, da das Programm schnell auf Korrektheit geprüft werden kann.

Dieser Ansatz hat sich während der Entwicklung mehrmals als wertvoll erwiesen, da sich sowohl die Spezifikation in einigen Details geändert hatte, aber auch durch diesen Ansatz Implementierungsfehler im Story-Format schnell aufgedeckt werden konnten.

#utils.codly(
  highlights: (
    (line: 20, start: 7, fill: utils.colorScheme.hhnOrange),
    (line: 23, start: 7, fill: utils.colorScheme.hhnOrange),
  ),
)
#let jestTestCases = ```javascript
const testCases = [
    {
        input: 'kite2_story.html',
        expected: 'kite2_story.json',
        format: 'harlowe-3',
    },
    // more test cases here...
];

describe('twineToJSON with multiple input files', () => {
  testCases.forEach(({ input, expected, format }) => {
    it(`should correctly parse ${input} and match ${expected}`, () => {
      // arrange: setup the global document and load the expected JSON
      setupGlobalDocument(input);
      const jsonFilePath = path.join(__dirname, 'resources', expected);
      const expectedResult = JSON.parse(fs.readFileSync(jsonFilePath, 'utf-8'));
      expectedResult.createdAtMs = expect.any(Number); // allow any timestamp in the result object

      // act: run the main parsing function
      const result = twineToJSON(format);

      // assert: compare the result with the expected JSON
      expect(result).toEqual(expectedResult);
    });
  });
});
```
#figure(
  jestTestCases,
  caption: "Definition der Testfälle zum Prüfen der Korrektheit der Implementierung des Story-Formates.",
) <jest-test-cases>

Zur Auslieferung des Story-Formates, sodass dieses in Twine verwendet werden kann, wird dieses durch ein einfaches JavaScript-Programm in das in @story-format-content dargestellte Format in eine Datei namens `format.js` geschrieben, welche dann wiederum zur Einbindung in Twine zur Verfügung gestellt werden muss.

Hierfür hatte bereits das _twine-to-json_ Format, auf dem das KITE II Format basiert, eine Lösung implementiert, die GitHub Actions nutzt, um die `format.js` Datei im Internet zu veröffentlichen. Das KITE II Story Format Projekt ist ebenfalls auf GitHub publiziert und macht sich dieselbe Funktionalität zu nutze, um das Format zu veröffentlichen @frederik_kuper_fkuper-bthtwine--json-kite-2_2025.

Dadurch ist es allen Twine Nutzer*innen möglich, dieses Format zu nutzen und Geschichten zu schreiben, die dem KITE II Format folgen sowie diese so zu exportieren, dass sie in der im Rahmen dieser Arbeit erstellten Bibliothek verwendet werden können.

In @twine-kite2-story-format-gui sieht man, wie das importierte Format den Nutzer*innen angezeigt wird. Nach einem einfachen Import über den Link zur entsprechenden `format.js`-Datei kann dieses im Twine Editor genutzt werden wie jedes andere vorinstallierte Format.

#figure(
  image("/resources/images/twine-kite2-story-format.png"),
  caption: "Das KITE II Story Format in der Liste der importierten Story Formate in der Twine GUI.",
) <twine-kite2-story-format-gui>

==== Das Ausgabeformat des KITE II Story-Formates <ausgabeformat-kite2-story-format>

Im Wesentlichen orientiert sich die Struktur des JSON-Objektes, welches als Ausgabe des KITE II Story Formats generiert wird, am Ausgangsprojekt _twine-to-json_ und passt dieses den Anforderungen von KITE II an. Das Format einer Twine Geschichte ist bereits in @story-spezifikation näher erläutert, weshalb hier darauf nicht näher eingegangen wird.

Während im zugrunde liegenden Format eine Passage eine Liste an Links zu anderen Passagen haben könnte, kann eine Passage im KITE II Story Format eine Liste an sogenannten _Novel Events_ haben. Dies bezeichnet Ereignisse, wie sie in der Reihenfolge in einer Passage ablaufen sollen.

Diese können entweder einen der in der Spezifikation definierten Schlüsselwörter als Typen haben (siehe @kite-keyword-constant), ein Link zu einer anderen Passage sein oder aber auch ein von Nutzer*innen selbst definiertes Schlüsselwort sein, welches nicht Teil der KITE II Spezifikation ist. Dies dient der Anpassbarkeit und Erweiterbarkeit des Formats.

Im nächsten Schritt kann ein Modul entwickelt werden, welches die Ausgabe des erstellten KITE II Story Formats verarbeiten kann. Dieser Arbeitsschritt wird in @implementierung-story-engine näher erläutert.

=== Implementierung eines Moduls zur Verarbeitung der Story-Objekte <implementierung-story-engine>

Die Bibliothek zur Darstellung der interaktiven Geschichten muss diese auf logischer Ebene verarbeiten können. Dazu gehören sämtliche Funktionalitäten, die mit der Kontrolle der interaktiven Geschichte zu tun haben, wie:

- Das Laden einer Geschichte.
- Das Abspielen und Ausführen einer Geschichts-Passage.
- Das Protokollieren eines Spieldurchgangs.

Um diese Funktionalitäten unabhängig von den Aufgaben der Darstellung entwickeln und bereitstellen zu können, wurden diese in Form einer #utils.gls-short("cross_platform") Bibliothek realisiert, die später nicht nur von der Visual Novel Bibliothek konsumiert werden kann, sondern theoretisch auch anderen Projekten zur Verfügung gestellt werden kann.

Hierfür wurde auf die Technologie #utils.gls-short("kmp") gesetzt, welche es ermöglicht, Kotlin Bibliotheken für eine Vielzahl an Plattformen zu erstellen. Diese ist zu unterscheiden von der #utils.gls-short("cmp") Technologie, welche ein #utils.gls-short("cross_platform") UI Framework basierend auf #utils.gls-short("kmp") ist. Mehr zu verschiedenen Technologien in diesem Bereich ist in @cross-platform-technologien ausgeführt.

Im ersten Schritt der Implementierung dieses Moduls galt es, die Geschichtsdaten, die das Story Format als JSON-Objekt zur Verfügung stellt, zu serialisieren, damit diese im weiteren Programmablauf verwendet werden können.

Zur Serialisierung der JSON-Objekte wurde eine von Jetbrains entwickelte #utils.gls-short("kmp") Bibliothek verwendet @noauthor_kotlinkotlinxserialization_2025. Diese ermöglicht es, durch Annotationen an den Modell-Definitionen JSON Objekte ohne großen Aufwand in Kotlin-Objekte zu serialisieren.

Die Definitionen verschiedener Modellklassen, die ausgehend von den JSON-Objekten, die das Story Format ausgibt, erstellt werden können, sind in @model-definitions zu sehen.

Angefangen mit der Top-Level-Klasse `Story`, die neben Meta-Informationen eine Menge an Passagen (@model-definitions:12) hat. Die Menge ist in diesem Fall als `Map<String, StoryPassage>`, um später einen schnellen Zugriff auf entsprechende Passagen über deren Name zu gewährleisten.

Die Passagen werden wiederum als `StoryPassage` definiert, welche ebenfalls verschiedene Meta-Informationen umfassen und eine Liste von `StoryPassageNovelEvent`. Diese werden später sequentiell verarbeitet, weshalb hier die Liste als Datenstruktur geeignet ist.

Zuletzt werden die Events definiert. Hier fungiert `StoryPassageNovelEvent` als Superklasse, von der jeweils die konkreten Event-Typen erben. Zusätzlich können hier mit Hilfe eines Class-Discriminator Feldes die konkreten Klassen automatisch konstruiert werden und somit von starker Typisierung Gebrauch gemacht werden.

In @model-definitions:27 ist der Name des Feldes definiert, welches den Typ angibt, während in den konkreten Event-Typen über eine weitere Annotation der zugehörige Typ-Name angegeben wird (siehe @model-definitions:32 und @model-definitions:42).

#utils.codly(
  highlights: (
    (line: 2, start: 3, end: 16, fill: utils.colorScheme.hhnOrange),
  ),
)
#let novelEventJsonObject = ```json
{
  "type": "LINK",
  "linkText": "Wie war es denn gemeint?",
  "passageName": "Ageism Nachfrage Jung",
  "original": "[[Wie war es denn gemeint?->Ageism Nachfrage Jung]]"
}
```
#figure(
  novelEventJsonObject,
  caption: "Ein NovelEvent als JSON Objekt.",
) <novel-event-json-object>

In @novel-event-json-object sieht man beispielhaft, wie ein Event vom Typ Link in JSON definiert ist. In Zeile 2 ist das Feld, welches hier den Typen angibt, anhand dessen später die konkrete Klasse bestimmt werden kann, die konstruiert werden soll.

#utils.codly(
  skips: (
    (4, 8),
    (10, 3),
    (11, 2),
    (35, 72),
  ),
  highlights: (
    (line: 12, start: 5, fill: utils.colorScheme.hhnOrange),
    (line: 21, start: 5, end: 49, fill: utils.colorScheme.hhnOrange),
    (line: 27, fill: utils.colorScheme.hhnOrange),
    (line: 32, start: 5, fill: utils.colorScheme.hhnOrange),
    (line: 42, start: 5, fill: utils.colorScheme.hhnOrange),
  ),
)
#let modelDefinitions = ```kotlin
@Serializable
data class Story(
    val uuid: String,
    val passages: Map<String, StoryPassage>
)

@Serializable
data class StoryPassage(
    val id: String,
    val novelEvents: List<StoryPassageNovelEvent>,
)

@Serializable
@JsonClassDiscriminator("type")
sealed class StoryPassageNovelEvent constructor(
    val identifier: Uuid = Uuid.random()
) {
    @Serializable
    @SerialName("CHARACTER_ACTION")
    data class CharacterAction(
        @SerialName("typeValue")
        val characterName: String,
        @SerialName("associatedValue")
        val expression: String,
        val text: String
    ) : StoryPassageNovelEvent()

    @Serializable
    @SerialName("LINK")
    data class Link(
        val linkText: String? = null,
        @SerialName("passageName")
        val targetPassageName: String
    ) : StoryPassageNovelEvent()
}
```
#figure(
  modelDefinitions,
  caption: "Definition der Modell Klassen, die von JSON serialisiert und deserialisiert werden können.",
) <model-definitions>

Die Story Engine Bibliothek implementiert und stellt eine Schnittstelle bereit, um die Geschichten in JSON-Repräsentation zu laden, um daraufhin mit diesen interagieren zu können. Dazu wird ein Interface namens `StoryImportService` definiert und eine Implementation dieses als #utils.gls("singleton") zur Verfügung gestellt.

#utils.codly(
  skips: (
    (2, 2),
    (20, 15),
  ),
)
#let storyImportListing = ```kotlin
internal class StoryImportServiceImpl : StoryImportService {
    override fun importStory(storyJsonContent: String): StoryImportResult {
        try {
            val story = json.decodeFromString<Story>(storyJsonContent)
            return StoryImportResult.Success(story)
        } catch (e: SerializationException) {
            return StoryImportResult.Failure(
                jsonString = storyJsonContent,
                reason = "Error parsing JSON: ${e.message}",
                exception = e
            )
        } catch (e: Exception) {
            return StoryImportResult.Failure(
                jsonString = storyJsonContent,
                reason = "An unexpected error occurred: ${e.message}",
                exception = e
            )
        }
    }
}
```
#figure(
  storyImportListing,
  caption: [Die `StoryImportService` Implementation und die Funktion zum Import einer Geschichte.],
) <story-import-listing>

In @story-import-listing ist die Implementation des `StoryImportService` Interface zu sehen sowie die Funktion, die zum Import einer einzelnen Geschichte dient. Als einziger Parameter wird hier ein String erwartet, der die Geschichte als JSON-Objekt repräsentiert.

Die Fehlerbehandlung erfolgt hier sowie in den meisten Fällen in den #utils.gls-short("kmp") und #utils.gls-short("cmp") Modulen dieser Arbeit in Form von sogenannten Result-Types. Bei dieser Konvention werden nicht etwas wie beispielsweise in der Java-Welt üblich Exception-Objekte erstellt und geworfen, sondern ein spezieller Rückgabe-Typ definiert, der sämtliche Informationen über Erfolg der aufgerufenen Operation beinhaltet.

@story-import-result-type-listing zeigt, wie der Result-Type in diesem Fall definiert ist. Hier gibt es zwei mögliche Resultate: Erfolg oder Fehlschlag. Im Falle eines Erfolges wird die importierte Geschichte als Feld in der Klasse `StoryImportResult.Success` mitgegeben, während bei einem Misserfolg Informationen mitgegeben werden, die dem Aufrufenden bei der Diagnose helfen könnten.

Die Implementationslogik des Imports ist dadurch sehr einfach gehalten. Zunächst wird versucht, ein Story-Objekt aus dem übergebenen String zu konstruieren (@story-import-listing:6). Falls dies aus irgendeinem Grund fehlschlägt, wird ein entsprechender Result-Type konstruiert und zurückgegeben (@story-import-listing:9 und @story-import-listing:15). Bei Erfolg wird ebenfalls ein Result-Type mit dem konstruierten Story-Objekt zurückgegeben (@story-import-listing:7).

#let storyImportResultTypeListing = ```kotlin
sealed interface StoryImportResult {
    data class Success(
        val story: Story
    ) : StoryImportResult

    data class Failure(
        val jsonString: String,
        val reason: String,
        val exception: Throwable? = null
    ) : StoryImportResult
}
```
#figure(
  storyImportResultTypeListing,
  caption: "Definition des Result-Type, welcher bei Import einer Geschichte zurückgegeben wird.",
) <story-import-result-type-listing>

Neben einem einfachen Import gibt es ebenfalls eine Schnittstelle zum Importieren mehrerer Geschichten. Die Definition dieser Funktion ist in @import-multiple-stories-listing zu sehen.

#utils.codly(number-format: none, display-icon: false, display-name: false)
#let importMultipleStoryListing = ```kotlin
fun importStories(storyJsonContents: List<String>): StoryImportResults
```
#figure(
  importMultipleStoryListing,
  caption: "Definition der Funktion zum Importieren mehrerer Geschichten.",
) <import-multiple-stories-listing>

Nachdem die Geschichten erfolgreich importiert sind, kann nun mit diesen interagiert werden. Die zentrale Schnittstelle des Story Engine Moduls ist über ein Interface namens `StoryEngine` definiert, welches in @story-engine-interface-listing zu sehen ist.

Im Wesentlichen bietet dieses einerseits Zugang zu dem zuvor besprochenen `StoryImportService` Objekt (siehe @story-import-listing) und einer Funktion, um die Interaktion mit einer Geschichte zu starten (`startPlaying`, siehe @story-engine-interface-listing:4).

Die Implementation der `StoryEngine` ist als Singleton realisiert, dessen Instanz über ein statisches Feld namens `instance` abgerufen werden kann (siehe @story-engine-interface-listing:9). Die Instanz wird beim ersten Aufruf einmalig konstruiert.

Des Weiteren ist in @story-engine-interface-listing:12 zu erkennen, wie unter Nutzung des #utils.gls("di") Frameworks _Koin_ @noauthor_koin_nodate die sogenannte `KoinApplication` initialisiert wird und ein `sharedModule` konstruiert wird, welches sämtliche plattformunabhängige Klassendefinitionen und wie diese konstruiert werden sollen enthält (siehe @story-engine-interface-listing:14).

#utils.configureCodlyStyle()
#utils.codly(
  skips: (
    (7, 2),
    (17, 6),
  ),
)
#let storyEngineInterfaceListing = ```kotlin
interface StoryEngine {
    val importService: StoryImportService

    fun startPlaying(story: Story): StoryPlayer

    companion object {
        val instance: StoryEngine by lazy(::getStoryEngine)

        private fun getStoryEngine(): StoryEngine {
            if (koinApplication == null) {
                koinApplication = KoinApplication.init().apply {
                    modules(sharedModule())
                }
            }
            return koinApplication!!.koin.get()
        }
    }
}
```
#figure(
  storyEngineInterfaceListing,
  caption: [Definition des Interface `StoryEngine`, welches den Einstiegspunkt in die Bibliothek darstellt.],
) <story-engine-interface-listing>

Durch Nutzung eines #utils.gls-short("di") Frameworks wie Koin ist es einfacher, #utils.gls-long("di") zu implementieren, da die Konstruktion der Objekte von diesem übernommen wird und im Quell-Code lediglich definiert werden muss, welche Abhängigkeiten die jeweilige Klasse hat und wie die einzelnen Objekte konstruiert werden können. Des Weiteren bietet es Komfort-Funktionen zur Erstellung von beispielsweise Singleton-Klassen oder #utils.glspl("factory") zum Konstruieren von Objekten.

In @story-engine-module-listing ist die Definition der Funktion `sharedModule` zu sehen, welche definiert, wie sämtliche Komponenten der Bibliothek konstruiert werden können. Der Name `sharedModule` wurde gewählt, da alle hier niedergeschriebenen Definitionen für alle Zielplattformen der Bibliothek gelten sollen und es theoretisch in einem Cross-Platform-Projekt, wie es diese Bibliothek ist, auch plattformspezifische Definitionen geben kann. In diesem Fall gibt es jedoch keine.

Die Implementation der `sharedModule` Methode besteht aus verschiedenen Lambda-Ausdrücken (wie hier `single` in @story-engine-module-listing:2 oder `factory` in @story-engine-module-listing:8), die deklarieren, wie die jeweilige Komponente konstruiert werden kann. Hier geschieht dies durch Aufrufen eines Konstruktors, welcher wiederum andere Abhängigkeiten deklarieren kann. Diese können automatisch von Koin aufgelöst werden, sodass diese Objekte zur Laufzeit konstruiert werden.

#let storyEngineModuleListing = ```kotlin
internal fun sharedModule(): Module = module {
    single<StoryEngine> {
        StoryEngineImpl(get(), getKoin())
    }
    single<StoryRecordManager> {
        StoryRecordManagerImpl()
    }
    factory<StoryImportService> {
        StoryImportServiceImpl()
    }
    factory<StoryPlayer> { (story: Story) ->
        StoryPlayerImpl(story, get())
    }
    factory<StoryPassagePlayer> { (passage: StoryPassage) ->
        StoryPassagePlayerImpl(passage, get())
    }
}
```
#figure(
  storyEngineModuleListing,
  caption: [Definition des Moduls für die Komponenten der `StoryEngine` Bibliothek, die von sämtlichen Zielplattformen geteilt werden.],
) <story-engine-module-listing>

// TODO: StoryPlayer erklären (ausgehend von der startPlaying() Methode in der StoryEngine)

Der Einstiegspunkt zur Interaktion mit den importierten interaktiven Geschichten bietet die `startPlaying` Methode der `StoryEngine` Schnittstelle (siehe @story-engine-interface-listing:4). Diese konstruiert ein Objekt vom Typ `StoryPlayer` und gibt dieses als Ergebnis der Funktion zurück.

#let storyPlayerInterfaceListing = ```kotlin
interface StoryPlayer {
    val story: Story
    fun playPassage(link: StoryPassageNovelEvent.Link? = null)
    fun playPassage(passageName: String)
    val currentPlayResult: StateFlow<StoryPassagePlayResult?>
}
```
#figure(
  storyPlayerInterfaceListing,
  caption: [Definition des Interface `StoryPlayer`.],
) <story-player-interface-listing>

@story-player-interface-listing zeigt die Definition des `StoryPlayer` Interface. Dieses besteht aus zwei Funktionen, die zur Kontrolle des Spielflusses dienen (`playPassage`), die sich lediglich durch die Art der Parameter unterscheiden und zwei Feldern.

So kann beispielsweise eine interaktive Geschichte initial über die in @story-player-interface-listing:3 definierte Funktion mit dem Standard Parameter-Wert `null` über ihren in der Datenstruktur definierten Start-Passage gestartet werden. Darauf folgend können bestimmte Passagen über deren Name oder ein `Link` Objekt abgespielt werden. Mit Hilfe des Namens einer Passage können diese auch beliebig abgespielt werden, ohne dass ein `Link` Objekt erfordert ist (@story-player-interface-listing:4).

Das Feld `story` gibt das `Story` Objekt zurück, welches mit dem `StoryPlayer` assoziiert ist, und `currentPlayResult` ist ein Objekt vom Typ `StateFlow`, welches den aktuellen Status der interaktiven Geschichte widerspiegelt.

`StateFlow` ist ein Typ, der Teil der `kotlinx.coroutines` Bibliothek ist. Diese wird von JetBrains selbst entwickelt und veröffentlicht und stellt verschiedene Lösungen für asynchrone Operationen bereit. `StateFlow` repräsentiert dabei einen Status, der von interessierten Parteien beobachtet werden kann und unabhängig von diesen existiert @jetbrains_stateflow_nodate.

Hier wird dieser Mechanismus dazu genutzt, den momentanen Stand der interaktiven Geschichte mit dem Typen `StoryPassagePlayResult?` zu repräsentieren. Der Wert `null` repräsentiert hierbei, dass noch keine Passage abgespielt wurde.

Nach Abspielen einer Passage nimmt `currentPlayResult` einen Wert vom Typ `StoryPassagePlayResult` an, dessen Definition in @story-passage-play-result-listing zu sehen ist.

#let storyPassagePlayResultListing = ```kotlin
sealed interface StoryPassagePlayResult {
    data class DataReady(
        val passageEvents: List<StoryPassageNovelEvent>,
        val storyPlaythroughRecord: StoryPlaythroughRecord
    ) : StoryPassagePlayResult

    data class Error(
      val type: StoryPassagePlayErrorType,
      val message: String
    ) : StoryPassagePlayResult
}
```
#figure(
  storyPassagePlayResultListing,
  caption: [Definition des Interface `StoryPassagePlayResult`],
) <story-passage-play-result-listing>

Bei einem Abspielfehler, beispielsweise ausgelöst durch Übergabe eines Namens einer Passage, die nicht existiert, wird ein Fehler-Objekt konstruiert, welches zusätzliche Informationen zum Fehler enthält. Bei erfolgreicher Wiedergabe einer Passage wird das `DataReady` Objekt konstruiert, welches wiederum eine Liste der Events beinhaltet, welche in der Passage enthalten sind sowie ein Objekt vom Typ `StoryPlaythroughRecord`. Dieses repräsentiert den bisherigen Spielverlauf, sodass zu jedem Zeitpunkt der gesamte Geschichtsverlauf bekannt ist.

Zum Verarbeiten einer einzelnen Passage ist mit dem `StoryPassagePlayer` eine weitere, bibliotheksinterne, Schnittstelle vorhanden, welche lediglich Events innerhalb einer Passage verarbeiten kann.

Außerdem kümmert sich die interne Schnittstelle `StoryRecordManager` darum, den aktuellen Geschichtsverlauf zu speichern und in einem bestimmten Datenformat ausgeben zu können.

Zur automatisierten Validierung und Sicherstellung der hier beschriebenen Funktionalitäten der _StoryEngine_ wurden während der Entwicklung der einzelnen Komponenten jeweils Unit-Tests mit verschiedenen Testfällen angelegt, die jeweils verschiedene Eingaben und Abläufe an die zu testenden Schnittstellen liefern und daraufhin die Ausgaben prüfen.

@import-service-unit-test-listing zeigt beispielhaft einen Unit-Test mit einer relativ komplexen Eingabe. Die Tests folgen stets dem etablierten Muster zur Strukturierung von Unit Tests _Arrange-Act-Assert_:

1. _Arrange_: Aufsetzen der Test-Bedingungen wie z.B. Anlegen der Eingabedaten.
2. _Act_: Ausführen der zu testenden Methode.
3. _Assert_: Prüfen des Ergebnisses oder Zustand des zu testenden Objekte nach Ausführen der Methode.

#let importServiceUnitTestListing = ```kotlin
@Test
fun `importStories with mixed valid and invalid json strings`() {
    // Arrange
    val invalidJsonString = "invalidJsonString"
    val validJsonString = validStoryJsonContentList
    val storyJsonStrings = validJsonString.plus(invalidJsonString)

    // Act
    val result = underTest.importStories(storyJsonStrings)

    // Assert
    assertNotNull(result)
    assertTrue(result.hasFailures)
    assertEquals(invalidJsonString, result.failedImportInfos.first().jsonString)
    assertEquals(validJsonString.size, result.importedStories.size)
}
```
#figure(
  importServiceUnitTestListing,
  caption: [Ein Unit Test zum Prüfen des `StoryImportService` Interface.],
) <import-service-unit-test-listing>

Beim hier gezeigten wird die `importStories` Methode des `StoryImportService` mit Eingabe-Daten geprüft, die teilweise valide und teilweise invalide sind. Dazu werden neben validen Testdaten, die zur besseren Wiederverwendbarkeit separat angelegt sind, ein invalider Testdatensatz angelegt. Diese werden der Methode als Parameter übergeben und das Ergebnis wird mittels verschiedener `assert` Statements geprüft. Diesem beschriebenen Vorgehen folgen ebenso Tests anderer Schnittstellen.

Damit ist die Implementierung des _StoryEngine_ Moduls mit seinen wichtigsten Komponenten beschrieben und im nächsten Schritt kann zur Implementierung des _VisualNovelEngine_ Moduls übergegangen werden, welches dieses Modul um die audiovisuelle Darstellung der Geschichten erweitert.

=== Implementierung des _VisualNovelEngine_ Moduls <implementierung-visual-novel-engine>

In diesem Kapitel wird die Umsetzung des _VisualNovelEngine_ Moduls beschrieben, welches sich um die audiovisuelle Aufbereitung der Geschichten kümmert.

Wie in @system-overview beschrieben und in @thesis-container-diagram zu sehen, nutzt dieses Modul das zuvor entwickelte und in @implementierung-story-engine beschriebene _StoryEngine_ Modul, um die interaktiven Geschichten zu laden und diese zu manipulieren und kümmert sich darum, diese audiovisuell aufzubereiten.

Das Modul basiert auf der Cross-Platform UI Technologie #utils.gls-long("cmp") und kann die #utils.gls-long("kmp") Bibliothek _StoryEngine_ somit einfach als Abhängigkeit im Gradle Build Skript deklarieren.

In diesem Kapitel werden die wichtigsten Komponenten beschrieben, die im Rahmen dieses Moduls implementiert wurden, wobei davon ausgegangen wird, dass Bibliotheken und Technologien, die in @implementierung-story-engine beschrieben sind, bekannt sind.

In @figure:vnEngineComponentDiagram ist ein Komponenten-Diagramm abgebildet, welches des wichtigsten Komponenten, des _VisualNovelEngine_ Moduls darstellt. Die zugehörige Legende ist in @figure:vnEngineComponentDiagramLegend abgebildet.

#let vnEngineComponentDiagram = image("/resources/images/diagrams/vn-engine-component-diagram.png")
#let vnEngineComponentDiagramLegend = image("/resources/images/diagrams/vn-engine-component-diagram-legend.png")
#figure(
  vnEngineComponentDiagram,
  caption: [Komponenten-Diagramm, welches die wichtigsten Komponenten des _VisualNovelEngine_ Moduls darstellt.],
) <figure:vnEngineComponentDiagram>
#figure(
  vnEngineComponentDiagramLegend,
  caption: [Legende zu @figure:vnEngineComponentDiagram.],
) <figure:vnEngineComponentDiagramLegend>

Von links nach rechts betrachtet ist hier zunächst die _VisualNovelStory_-Komponente zu sehen. Diese ist ein _Composable_ und für die audiovisuelle Darstellung der Geschichten zuständig und bildet somit auch eine essentielle Schnittstelle des Moduls.

Ein _Composable_ ist die Bezeichnung für eine UI-Komponente innerhalb des #utils.gls-short("cmp") Frameworks.

Die _VisualNovelStory_-Komponente hat eine Abhängigkeit zur _VisualNovelStoryPlayer_-Komponente, welche für das Steuern der Wiedergabe und der Darstellungslogik einer Geschichte zuständig ist. Für die einzelnen Aufgaben, die hiermit zusammenhängen sind wiederum verschiedene Komponenten zuständig, von denen ein _VisualNovelStoryPlayer_ jeweils Gebrauch macht.

So wird hier die _StoryEngine_ verwendet, die die Logik zur Verwaltung des Story-Flusses und Logik einer Geschichte implementiert. Diese ist als separates Modul angelegt, dessen Implementierung in @implementierung-story-engine beschrieben ist.

Die _StoryRenderController_-Komponente verwaltet Daten, die den audiovisuellen Status einer Visual Novel repräsentieren. Dieser ist separat vom logischen Status der Geschichte zu behandeln und wird daher von dieser Komponente behandelt.

Der _NovelAnimationService_ erlaubt es, Animationen zu steuern und der _AssetStore_ agiert als Datenbank für sämtliche Assets, die in der _VisualNovelEngine_ verwendet werden können.

Um einen Überblick über die Nutzungsweise der Bibliothek zu geben, kann am besten die minimale Beispielanwendung betrachtet werden, die im Rahmen des Moduls erstellt wurde, um die Verwendung dieser zu demonstrieren. Zur besseren Übersicht wurde diese auf zwei separate Listings aufgeteilt.

@vn-engine-demo-app-listing-part-one zeigt den ersten Teil der Demo-Applikation. Hier wird zunächst eine Funktion deklariert, die eine Instanz von `KoinApplication` erstellt, welche eine Funktion aus dem #utils.gls-short("di") Framework _Koin_ ist, um eine Anwendung mit entsprechenden Koin-Modulen zu starten.

#utils.codly(
  highlights: (
    (line: 5, start: 17, end: 29, fill: utils.colorScheme.hhnOrange),
    (line: 7, start: 9, end: 30, fill: utils.colorScheme.hhnOrange),
    (line: 13, start: 9, end: 30, fill: utils.colorScheme.hhnOrange),
    (line: 20, start: 19, end: 46, fill: utils.colorScheme.hhnOrange),
    (line: 24, start: 3, fill: utils.colorScheme.hhnOrange),
  ),
)
#let vnEngineDemoAppListingPartOne = ```kotlin
@Preview
@Composable
private fun ExampleConsumerApplication() {
    KoinApplication(application = {
        modules(exampleModule)
    }) {
        ExampleSceneComposable()
    }
}

private val exampleModule = module {
    single<VisualNovelEngine> {
        VisualNovelEngine.init(
            applicationScope = CoroutineScope(
              SupervisorJob() + Dispatchers.Default
            ),
            config = Configuration()
        )
    }
    viewModelOf(::ExampleScenePreviewViewModel)
}

private class ExampleScenePreviewViewModel(
  val visualNovelEngine: VisualNovelEngine
) : ViewModel()
```
#figure(
  vnEngineDemoAppListingPartOne,
  caption: [Minimale Demo Applikation, die das _VisualNovelEngine_ verwendet (Teil 1).],
) <vn-engine-demo-app-listing-part-one>

In @vn-engine-demo-app-listing-part-one:5 wird das Beispiel-Modul übergeben, welches in @vn-engine-demo-app-listing-part-one:11 definiert ist und demonstriert, wie das _VisualNovelEngine_ konstruiert wird (siehe @vn-engine-demo-app-listing-part-one:13).

In @vn-engine-demo-app-listing-part-one:7 wird ein _Composable_ erzeugt. Außerdem wird hier beispielhaft eine _ViewModel_ Komponente deklariert, die als Abhängigkeit eine Instanz von `VisualNovelEngine` erwartet (siehe @vn-engine-demo-app-listing-part-one:24). Dieses wird auch im Modul definiert, damit _Koin_ dieses konstruieren kann (@vn-engine-demo-app-listing-part-one:20).

Das Beispiel folgt dem #utils.gls("mvvm") Architekturmuster, welches ein weit verbreitetes Pattern zur Strukturierung von Anwendungssoftware ist.

In @vn-engine-demo-app-listing-part-two wird die zuvor erwähnte _Composable_ Komponente deklariert, die letztendlich die Darstellung der Geschichte übernimmt. Für eine verbesserte Lesbarkeit wurden hier einige Teile ausgeklammert, welche jeweils  mit `/* ... */` kommentiert sind.

#let vnEngineDemoAppListingPartTwo = ```kotlin
@Composable
private fun ExampleSceneComposable(
    viewModel: ExampleScenePreviewViewModel = koinInject()
) {
    // Arrange required data for playing and showing visual novel
    val storyPlayer = viewModel.visualNovelEngine.storyPlayer
    val assets = listOf(/* ... */) // create assets...
    val story = Story() // load story to play...

    // Perform setup steps when loading composable
    LaunchedEffect(Unit) {
        // 1. - load assets
        viewModel.visualNovelEngine.loadAssets(assets)
        // 2. - load scene state via asset IDs
        storyPlayer.loadVisualNovelSceneState(/* ... */)
        // 3. - start story playback
        storyPlayer.playStory(story.id)
    }

    // Construct composable from VisualNovelEngine library
    VisualNovelStory(
        storyPlayer,
        onStoryEnded = {
            println("Story ended.")
        },
        onPlaybackError = {
            println("Playback error: $it")
        },
    )
}
```
#figure(
  vnEngineDemoAppListingPartTwo,
  caption: [Minimale Demo Applikation, die das _VisualNovelEngine_ verwendet (Teil 2).],
) <vn-engine-demo-app-listing-part-two>

Hierzu werden zunächst drei Variablen angelegt:

1. Die `StoryPlayer`-Instanz der _VisualNovelEngine_. Diese kann zum Abspielen und Steuern der interaktiven Geschichten genutzt werden.
2. Eine Liste von `Asset`-Objekten. Ein Asset ist hierbei alles, was zur audiovisuellen Aufbereitung der interaktiven Geschichten gehört (wie beispielsweise Bilder, Audio oder Animationen).
3. Die Geschichte, die hier beispielhaft abgespielt werden soll. Diese würde in einer echten Anwendung aus JSON-Objekten importiert werden (siehe @implementierung-story-engine).

Dann wird in @vn-engine-demo-app-listing-part-two:11 mit der `LaunchedEffect()` Methode ein Block generiert, der einmalig asynchron zur Komposition ausgeführt wird. Hier werden Konfigurations-Schritte ausgeführt, wie das Laden der erstellten Assets, das Initialisieren des Status der Visual Novel sowie dem Start des Abspielens der Geschichte.

Zum Schluss wird in @vn-engine-demo-app-listing-part-two:21 die _Composable_ Komponente `VisualNovelStory` aus dem _VisualNovelEngine_ Modul verwendet, um die Geschichte darzustellen. Diese erlaubt die Interaktion mit der Geschichte und bietet außerdem Schnittstellen, die bei bestimmten Ereignissen aufgerufen werden, wie zum Beispiel, wenn eine Geschichte ein Ende erreicht hat oder wenn ein Fehler beim Abspielen der Geschichte aufgetreten ist.

Das in @vn-engine-demo-app-listing-part-one:3 deklarierte _Composable_ kann nun dank der Annotation `@Preview` in einer geeigneten Entwicklungsumgebung wie Android Studio oder IntelliJ ausgeführt werden, um eine interaktive Vorschau der Demo-Anwendung zu erhalten.

#let vnEngineDemoAppImage = image(
  "/resources/images/vnengine-demo-preview.png",
  width: 60%,
)
#let fig = [
  #figure(
    vnEngineDemoAppImage,
    caption: [Screenshot aus der Vorschau der Demo-Applikation, welche die Nutzung des _VisualNovelEngine_ Moduls demonstriert.],
  ) <vn-engine-demo-app-figure>
]
#let body = [
  @vn-engine-demo-app-figure zeigt einen Screenshot aus der interaktiven Vorschau der Demo-Anwendung.

  Hier werden Assets gebraucht, um jeweils Vorder- und Hintergrund darzustellen, verschiedene Gegenstände zu platzieren (wie die Pflanze im Hintergrund oder das Glas Wasser im Vordergrund), Charaktere darzustellen und diese zu animieren.

  Der hier dargestellte Charakter ist transparent aufgrund einer Animation, die eine Änderung der Transparenz beschreibt und darstellt.

  Die Demo-Anwendung soll somit übersichtlich und kurz demonstrieren, wie das _VisualNovelEngine_ Modul in eine andere Anwendung integriert werden kann, um eine Visual Novel zu erstellen. Außerdem kann durch die interaktive Vorschau auch mit der Anwendung interagiert werden und beispielsweise verschiedene Pfade in der Geschichte ausgewählt werden.
]
#utils.wrap-content(
  fig,
  body,
  align: right,
  column-gutter: 2em,
)

Nun, da die Benutzung und Integration des _VisualNovelEngine_ Moduls in eine Anwendung etwas klarer sein sollte, werden im weiteren Verlauf einige der wichtigsten Komponenten dieses Moduls beleuchtet.

Ähnlich wie beim _StoryEngine_ Modul gibt es auch hier eine Schnittstelle, die als Einstiegspunkt zu den Funktionalitäten des Moduls dient. Diese heißt in diesem Fall `VisualNovelEngine`.

@vn-engine-interface-listing zeigt die öffentlich definierten Schnittstellen dieses Interface.

Neben statischen Methoden zum Konstruieren und Zerstören der Engine (siehe @vn-engine-interface-listing:10 und @vn-engine-interface-listing:33) wird hier Zugang zu einer Instanz von `VisualNovelStoryPlayer` gewährt, welche es erlaubt, das Abspielen von Geschichten zu steuern und den Status der Darstellung der Geschichten abzufragen.

Zuletzt ist die `loadAssets()` (siehe @vn-engine-interface-listing:2) Methode zu erwähnen, welche die Übergebenen Assets modul-intern bereitstellt, damit diese zur audiovisuellen Aufbereitung der Geschichten genutzt werden können.

#utils.codly(
  skips: (
    (7, 3),
    (11, 17),
    (14, 5),
    (15, 8),
  ),
)
#let vnEngineInterfaceListing = ```kotlin
interface VisualNovelEngine {
    fun loadAssets(assets: List<Asset>)

    val storyPlayer: VisualNovelStoryPlayer

    companion object {
        fun init(
            applicationScope: CoroutineScope,
            config: Configuration = Configuration()
        ) : VisualNovelEngine {
        }

        fun dispose() {
        }
    }
}
```
#figure(
  vnEngineInterfaceListing,
  caption: [Öffentliche Schnittstellen, welche im `VisualNovelEngine` Interface deklariert sind.],
) <vn-engine-interface-listing>

Das logische Herz des Moduls bildet `VisualNovelStoryPlayer`. Die Definition dieses Interface ist in @listing:vnStoryPlayer zu sehen. Primär bietet es Funktionen zum Steuern der interaktiven Geschichten, wie:

- `playStory()`: Startet das Abspielen einer Geschichte.
- `loadVisualNovelSceneState()`: Erlaubt es, den Status der visuellen Darstellung zu kontrollieren.
- `chooseStoryPassage()`: Spielt eine Passage einer Geschichte ab.
- `reset()`: Setzt den internen Status der `VisualNovelStoryPlayer` Instanz auf den initialen Status zurück.

#let vnStoryPlayerInterfaceListing = ```kotlin
interface VisualNovelStoryPlayer {
    fun playStory(storyId: String)
    fun loadVisualNovelSceneState(state: SceneRenderStateIds)
    fun chooseStoryPassage(link: StoryPassageNovelEvent.Link)
    fun reset()
    val uiState: StateFlow<StoryRenderState>
    val isBusy: StateFlow<Boolean>
}
```
#figure(
  vnStoryPlayerInterfaceListing,
  caption: [Definition des `VisualNovelStoryPlayer` Interface.],
) <listing:vnStoryPlayer>

Neben den beschriebenen Funktionen existieren außerdem zwei `StateFlow` Felder, die jeweils einen internen Status der Instanz reflektieren:

- `uiState`: Reflektiert den momentanen Status der Benutzeroberfläche, die die Geschichte darstellt.
- `isBusy`: Ein boolescher Wert, welcher reflektiert, ob die Engine momentan beschäftigt ist, beispielsweise durch Abspielen einer Animation.

Diese beiden Felder werden in der _Composable_ Komponente `VisualNovelStory` dazu verwendet, um je nach Status die korrekte Benutzeroberfläche anzuzeigen.

@listing:vnStoryComposable zeigt einen Ausschnitt aus der Implementation dieser Komponente, anhand dessen die Rendering Logik deutlich wird.

Zunächst werden einige Variablen angelegt, die, wenn geschrieben, dazu führen, dass das Composable erneut gerendert wird (siehe @listing:vnStoryComposable:1 bis @listing:vnStoryComposable:3).

Wenn sich beispielsweise der Wert hinter uiState ändert, wird das Composable mit dem neuen Wert neu evaluiert. Innerhalb des `Box()`-Composable, welches als ein Container für mehrere Composables verstanden werden kann, wird `uiState` evaluiert und je nach Status entsprechende Werte gesetzt (siehe @listing:vnStoryComposable:6).

Im Status `Rendering` wird zum Beispiel der Status `loading` auf falsch gesetzt und die Szene, die dargestellt werden soll, ausgelesen.

Dadurch wird wiederum eine erneute Komposition des `VisualNovelStory` Composable ausgeführt und die entsprechende Szene kann angezeigt werden. Hierzu wird ein weiteres Composable namens `VisualNovelScene` verwendet.

Bei anderen Status von `uiState` wie `Error` werden z.B. Fehlermeldungen angezeigt, um den Nutzer zu informieren, dass es einen Fehler gegeben hat. So können mit einfachen Mitteln komplexe Darstellungslogik umgesetzt werden und alle möglichen Status in der Benutzeroberfläche berücksichtigt sowie entsprechend behandelt werden.

#let visualNovelStoryComposableListing = ```kotlin
val uiState by storyPlayer.uiState.collectAsState()
val sceneToRender = remember { mutableStateOf<SceneRenderState?>(null) }
val loading = remember { mutableStateOf(false) }

Box(/* ... */) {
    when (uiState) {
        StoryRenderState.Initializing,
        StoryRenderState.Loading -> { /* ... */ }

        is StoryRenderState.Ended -> { /* ... */ }

        is StoryRenderState.Rendering -> {
            loading.value = false
            sceneToRender.value = (uiState as StoryRenderState.Rendering).scene
        }

        is StoryRenderState.Error -> { /* ... */ }
    }
    sceneToRender.value?.let { sceneToRender ->
        // show story scene using VisualNovelScene()...
    }
    errorMessage.value?.let {
        // show error message...
    }
    if (loading.value) {
        // show loading indicator...
    }
}
```
#figure(
  visualNovelStoryComposableListing,
  caption: [Ausschnitt aus `VisualNovelStory` _Composable_, welches die Rendering-Logik demonstriert.],
) <listing:vnStoryComposable>

Das bereits erwähnte `VisualNovelScene` Composable kümmert sich um die visuelle Darstellung einer Szene und ist in @listing:vnSceneComposable zu sehen. Der aktuelle Status der Darstellung einer Szene wird diesem als ein Objekt des Typs `SceneRenderState` übergeben (siehe @listing:sceneRenderState). Die Darstellung setzt sich hier aus drei möglichen Ebenen zusammen:

- _Hintergrund_: Wird mittels dem Composable `VisualNovelSceneEnvironment` dargestellt, falls vorhanden (siehe @listing:vnSceneComposable:9 und @listing:vnSceneComposable:12).
- _Mittelgrund_: Wird mittels dem Composable `VisualNovelMainContent` dargestellt (siehe @listing:vnSceneComposable:16).
- _Vordergrund_: Wird mittels dem Composable `VisualNovelSceneEnvironment` dargestellt, falls vorhanden (siehe @listing:vnSceneComposable:22 und @listing:vnSceneComposable:25).

Diese drei Ebenen sind einfach in einem `Box()` Composable eingebettet, welches die in seinem Block definierten Composables übereinander darstellt. Somit kann hiermit eine Szene aus drei Ebenen zusammengesetzt und dargestellt werden.

#utils.codly(
  highlights: (
    (line: 3, start: 5, end: 27, fill: utils.colorScheme.hhnOrange),
    (line: 9, start: 9, end: 29, fill: utils.colorScheme.hhnOrange),
    (line: 12, start: 17, end: 43, fill: utils.colorScheme.hhnOrange),
    (line: 16, start: 9, end: 35, fill: utils.colorScheme.hhnOrange),
    (line: 25, start: 17, end: 43, fill: utils.colorScheme.hhnOrange),
    (line: 22, start: 9, end: 29, fill: utils.colorScheme.hhnOrange),
  ),
)
#let visualNovelSceneComposableListing = ```kotlin
@Composable
internal fun VisualNovelScene(
    scene: SceneRenderState,
    onLinkClick: (StoryPassageNovelEvent.Link) -> Unit,
    aspectRatio: Float,
    modifier: Modifier = Modifier
) {
    Box(modifier = /* ... */) {
        scene.background?.let {
            BoxWithConstraints(modifier = Modifier.fillMaxSize()) {
                val size = IntSize(constraints.maxWidth, constraints.maxHeight)
                VisualNovelSceneEnvironment(environment = it, containerSize = size)
            }
        }

        VisualNovelSceneMainContent(
            scene = scene,
            onLinkClick = onLinkClick,
            modifier = Modifier.fillMaxSize()
        )

        scene.foreground?.let {
            BoxWithConstraints(modifier = Modifier.fillMaxSize()) {
                val size = IntSize(constraints.maxWidth, constraints.maxHeight)
                VisualNovelSceneEnvironment(environment = it, containerSize = size)
            }
        }
    }
}
```
#figure(
  visualNovelSceneComposableListing,
  caption: [Implementierung des `VisualNovelScene` Composable.],
) <listing:vnSceneComposable>

#let sceneRenderStateListing = ```kotlin
data class SceneRenderState(
    val background: Sprite.Environment? = null,
    val foreground: Sprite.Environment? = null,
    val characters: List<Sprite.Character> = emptyList(),
    val activeCharacter: Sprite.Character? = null,
    val textBoxes: List<Text> = emptyList()
)
```
#figure(
  sceneRenderStateListing,
  caption: [Definition des Typs `SceneRenderState`, welcher alle Informationen zur Darstellung einer Szene enthält.],
) <listing:sceneRenderState>

Während in den Hinter- und Vordergrundebenen lediglich verschiedene Darstellungselemente platziert werden können, sind in der Mittelgrund-Ebene neben den Charakteren der Geschichte auch die Text-Elemente angesiedelt, die einerseits die Geschichte erzählen und andererseits auch das Haupt-Element zur Interaktion mit der Geschichte darstellen.

Im Wesentlichen werden hierfür im `VisualNovelSceneMainContent` Composable einerseits die aktuellen Text-Elemente dargestellt und animiert, sowie der aktiv sprechende Charakter, welcher ebenfalls animiert werden kann.

Da das Animations-System einen wesentlichen Anteil der Entwicklungszeit dieses Moduls beansprucht hat und einige Herausforderungen mit sich gebracht hat, wird dessen Umsetzung in @implementierung-animation-system näher erläutert.

==== Umsetzung des Animation-Systems <implementierung-animation-system>

Um die Umsetzung des Animation-Systems der _VisualNovelEngine_ näher zu beleuchten, ist es zunächst wichtig, die Klassenhierarchie der Assets zu verstehen. Diese ist in @figure:vnEngineModelClassDiagram dargestellt.

`Asset` selbst ist ein einfaches Interface, welches lediglich eine ID vorschreibt, welche unter allen existierenden Assets einzigartig sein muss. Davon ausgehend gibt es wiederum andere Typen von Assets wie `Animation`, `Sprite`, `TextAsset` und `StoryAsset`. Die Namen `TextAsset` und `StoryAsset` wurden lediglich für dieses Diagramm so gewählt, um eine Verwechselung zu vermeiden.

#let vnEngineModelClassDiagram = image("/resources/images/diagrams/vn-engine-model-class-diagram-rotated.png")
#figure(
  vnEngineModelClassDiagram,
  caption: [Klassenhierarchie des Typs `Asset` im Modul _VisualNovelEngine_.],
) <figure:vnEngineModelClassDiagram>

Interessant ist hier das Interface `Animation`, welches eine Reihe von Eigenschaften vorschreibt, welche jede Art von Animation gemein hat. Die konkreten Animations-Typen, die hier definiert sind, lauten:

- `Text`: Beschreibt, wie ein Text-Element animiert werden soll.
- `SpriteSheet`: Beschreibt eine Animation, die aus einer Reihe von Sprites besteht.
- `SpriteTransition`: Beschreibt eine Animation, die einen Sprite durch einen anderen ersetzt.

Sämtliche werden von einem modul-internen Dienst gespeichert und verwaltet, der hier als eine Art In-Memory-Datenbank agiert, die sämtliche Assets beinhaltet, die zur Darstellung der aktuellen Geschichte genutzt werden können und somit für die Engine die #utils.gls-short("ssot") für sämtliche Assets bildet.

Die Definition dieses Dienstes `AssetStore` ist in @listing:assetStore abgebildet. Neben verschiedenen Methoden zum Hinzufügen, Ändern oder Löschen von Assets ist hier vor allem das `assets` Feld interessant (siehe @listing:assetStore:2).

Dieses stellt über einen `StateFlow` einen Zugriff auf die Assets bereit, die momentan zur Verfügung stehen und stellt sicher, dass sämtliche Konsumenten dieses Flows immer die aktuellste Version der Daten einsehen können.

#utils.codly(
  highlights: (
    (line: 2, start: 5, fill: utils.colorScheme.hhnOrange),
  ),
)
#let assetStoreListing = ```kotlin
internal interface AssetStore {
    val assets: StateFlow<Map<String, Asset>>
    fun addOrUpdateAsset(asset: Asset)
    fun addOrUpdateAsset(assetId: String, asset: Asset)
    fun addOrUpdateAssets(assets: List<Asset>) = assets.forEach(::addOrUpdateAsset)
    fun removeAsset(assetId: String)
}
```
#figure(assetStoreListing, caption: [Definition des `AssetStore` Interface.]) <listing:assetStore>

Während also im `AssetStore` sämtliche Assets zu finden sind, wozu auch alle Animationen gehören, die abgespielt werden können, muss auch noch die Aufgabe übernommen werden, Animationen starten, stoppen und verwalten zu können. Zu diesem Zweck existiert ein separater Dienst, der Schnittstellen für genau diese Funktionen zur Verfügung stellt.

In @listing:animationService ist die Definition des Interface `AnimationService` zu sehen, welches die Schnittstellen des Dienstes beschreibt.

Die Methode `playAnimationBatch()` erlaubt es, eine oder mehrere Animationen zu starten. Sobald alle Animationen verarbeitet sind, wird eine Callback-Funktion aufgerufen, die der aufrufenden Partei erlaubt, eventuell nötige Status Updates nach Abspielen der Animationen zu tätigen. Die Definition dieser Callback-Funktion ist in @listing:animationService:11 zu sehen.

Über `notifyAnimationComplete()` kann dem Dienst signalisiert werden, dass eine Animation fertig abgespielt hat, sodass dieser seinen internen Status aktualisieren kann. Diese Methode wird beispielsweise von Composables verwendet, wenn sie ihre Animation fertig abgespielt haben oder diese zum Beispiel über dem Timeout-Limit hinaus gelaufen ist.

Die Methode `clearAllAnimations()` bricht sämtliche aktiven Animationen ab.

Über das Feld `activeAnimations` können interessierte Parteien immer alle aktuell aktiven Animationen beobachten. Dies wird unter anderem dazu benötigt, in den eigentlichen Composables die Animationen abzuspielen.

#let animationServiceListing = ```kotlin
internal interface NovelAnimationService {
    val activeAnimations: StateFlow<List<Animation>>
    fun playAnimationBatch(
        animations: List<Animation>,
        onAllAnimationsComplete: AnimationBatchCompletionHandler
    )
    fun notifyAnimationComplete(animation: Animation)
    fun clearAllAnimations()
}

internal typealias AnimationBatchCompletionHandler = (
  playedAnimations: List<Animation>,
  timedOut: Boolean
) -> Unit
```
#figure(
  animationServiceListing,
  caption: [Definition des Dienstes zum Verwalten von Animationen `AnimationService`.],
) <listing:animationService>

Die Animationen werden beim Verarbeiten der einzelnen Novel Events durch den `VisualNovelStoryPlayer` getriggert.

In @listing:vnStoryPlayerEventProcessing ist ein Ausschnitt aus der Methode zu sehen, die in der Implementation von `VisualNovelStoryPlayer` die einzelnen Novel Events verarbeitet, die jeweils bei einer Passage einer Geschichte auftreten können.

Hier ist lediglich ein Fall dargestellt: die Verarbeitung von Events des Typs `InformationalText`. Diese repräsentieren einen informativen Text, der beispielsweise genutzt werden kann, um mehr Kontext über eine Geschichte zu geben.

In @listing:vnStoryPlayerEventProcessing:9 ist zu sehen, wie ein Animation-Batch über den Dienst gestartet wird. Hierzu wird als Liste der abzuspielenden Animationen in diesem Fall lediglich das `animationProps` Feld vom `Text.Info` Objekt übergeben, welches die Animations-Parameter beinhaltet (siehe @listing:vnStoryPlayerEventProcessing:10).

Nach Vervollständigung der Animationen wird eine Methode aufgerufen, die, falls nötig, Status Updates nach Beenden der Animationen ausführen kann (siehe @listing:vnStoryPlayerEventProcessing:11).

Erst wenn alle Animationen fertig verarbeitet sind, kann das nächste Novel Event behandelt werden. Dies geschieht deshalb auch in der angesprochenen Methode, indem einfach der Index hochgezählt wird und `processNextEvent()` erneut aufgerufen wird.

#utils.codly(
  highlights: (
    (line: 9, start: 13, end: 47, fill: utils.colorScheme.hhnOrange),
    (line: 10, start: 37, end: 59, fill: utils.colorScheme.hhnOrange),
    (line: 11, start: 45, fill: utils.colorScheme.hhnOrange),
  ),
)
#let vnStoryPlayerEventProcessingListing = ```kotlin
private fun processNextEvent() {
    // ...
    val currentEvent = currentPassageEvents[currentPassageEventIndex]
    when (currentEvent) {
        is StoryPassageNovelEvent.InformationalText -> {
            _isBusy.value = true
            val infoText = currentEvent.toText() as Text.Info
            assetStore.addOrUpdateAsset(infoText)
            animationService.playAnimationBatch(
                animations = listOf(infoText.animationProps),
                onAllAnimationsComplete = ::onAnimationBatchCompleted
            )
            storyRenderController.setScene(
                sceneIds.value.copy(
                    textBoxIds = sceneIds.value.textBoxIds + infoText.id
                )
            )
        }
        // process other event types here...
    }
    // ...
}
```
#figure(
  vnStoryPlayerEventProcessingListing,
  caption: [Ausschnitt aus der Methode zur Verarbeitung von Novel Events in der Implementation von `VisualNovelStoryPlayer`.],
) <listing:vnStoryPlayerEventProcessing>

So werden die Animationen also auf der Daten-Ebene verwaltet. Nun fehlt noch die eigentliche Umsetzung der jeweiligen Animationen.

Aufgrund von zeitlichen Beschränkungen, die im Rahmen dieser Thesis existieren, wurde sich zunächst auf die Umsetzung einfacher Animations-Typen beschränkt. Dabei ist das implementierte System jedoch erweiterbar und flexibel gestaltet, sodass verschiedene Arten von Animationen wie beispielsweise animierte Sprite Sheets oder animierte GIFs unterstützt werden können.

So kann beispielsweise das in @figure:vnEngineModelClassDiagram beschriebene Klassen-Modell um neue Animations-Typen erweitert werden, die dann in einem Composable entsprechend umgesetzt werden müssten. Das Abrufen und Verwalten der Animationen durch den `AnimationService` würde gleich bleiben.

Implementiert wurden in dieser Arbeit Text Animationen und Sprite-Transition Animationen, welche einen Übergang von einem Sprite zu einem anderen animieren können. In @listing:animatableTextComposable ist die Implementierung einer animierbaren Text Komponente zu sehen.

Folgende Objekte werden als Parameter übergeben: das Text-Asset, die Instanz des Animations-Dienstes und ein Composable, mit welchem der Text dargestellt werden soll. Dies erhöht die Wiederverwendbarkeit, da verschiedene Arten von Text-Assets, wie z.B. Info oder Player Text, unterschiedlich dargestellt werden sollen.

#let animatableTextComposableListing = ```kotlin
@Composable
private fun AnimatableTextComposable(
  textAsset: Text,
  animService: NovelAnimationService = koinInject(),
  textComposable: @Composable (displayedText: String) -> Unit,
) {
  val activeAnimations by animService.activeAnimations.collectAsState()
  val isCurrentlyAnimatingThisEvent = activeAnimations.any { animation ->
    animation.id == textAsset.animationProps.id
  }
  if (isCurrentlyAnimatingThisEvent) {
    var displayedText by remember(textAsset.value, textAsset.animationProps.id) {
      mutableStateOf("")
    }
    LaunchedEffect(textAsset.value, textAsset.animationProps.id) {
      displayedText = ""
      if (textAsset.value.isNotEmpty()) {
        textAsset.value.forEach { char ->
          displayedText += char
          delay(textAsset.animationProps.durationMillis.toLong())
        }
      }
      try {
        animService.notifyAnimationComplete(textAsset.animationProps)
      } catch (e: IllegalArgumentException) {
        println("Error trying to notify animation complete: ${e.message}")
      }
    }
    textComposable(displayedText)
  } else {
    textComposable(textAsset.value)
  }
}
```
#figure(
  animatableTextComposableListing,
  caption: [Implementierung einer animierbaren Text Komponente.],
) <listing:animatableTextComposable>

Über den `AnimationService` kann bestimmt werden, ob eine aktive Animation existiert, die das Composable betrifft (siehe @listing:animatableTextComposable:8).

Falls nicht, wird lediglich statischer Text angezeigt (siehe @listing:animatableTextComposable:31).

Falls eine aktive Animation existiert, die das Composable betrifft, wird in diesem Fall der Text dieser Komponente Buchstabe für Buchstabe mit einer in der Animation definierten Verzögerung angezeigt.

Sobald alle Buchstaben angezeigt sind, wird der `AnimationService` benachrichtigt, dass die Animation fertig abgespielt wurde, sodass dieser diese als fertig abgespielt markieren kann. Wenn keine anderen aktiven Animationen mehr existieren, teilt der Dienst dies darauf hin mit, und die nächsten Novel Events können verarbeitet werden.

Das Composable, welches die Sprite-Transition Animation implementiert, `AnimatableVisualNovelSprite`, verfolgt strukturell einen sehr ähnlichen Ansatz, welcher ebenfalls in Zukunft angewandt werden kann, um andere animierbare Komponenten zu implementieren und somit eine größere Bandbreite an Animationen zu unterstützen.

Mit dem implementierten Animations-System ist das _VisualNovelEngine_ Modul bereit, für den Prototypen verwendet zu werden, um die für KITE II geschriebenen interaktiven Geschichten spielbar zu machen und darzustellen. Die Implementierung des Prototypen ist in @implementierung-prototyp beschrieben.
