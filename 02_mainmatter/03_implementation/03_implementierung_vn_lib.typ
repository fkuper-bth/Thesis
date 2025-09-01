#import "/etc/utils.typ"

== Implementierung der #utils.gls-long("visual_novel") #utils.gls-short("library") <implementierung-visual-novel-library>

Nachdem im Rahmen der technischen Analyse (siehe @technik_stand) eine Wahl für eine geeignete #utils.gls-short("cross_platform") Technologie getroffen wurde, konnte mit der Umsetzung der #utils.gls-short("library") begonnen werden. Die Implementierung dieser wird in diesem Kapitel beschrieben.

Dieser Arbeitsschritt stellt neben der Umsetzung des Prototypen das größte in @tabelle-terminplanung definierte Arbeitspaket dar und bildet außerdem die technologische Grundlage für die Umsetzung des Prototypen, welche in @implementierung-prototyp beschrieben ist.

Der Entwicklungsprozess sämtlicher Implementierungsphasen dieser Arbeit verfolgt einen iterativen Ansatz, wie bereits in @terminplanung festgelegt wurde.

Dies bedeutet konkret, dass Entwicklungszyklen möglichst kurz gehalten werden sollen, um regelmäßig Feedback von Stakeholdern zum aktuellen Stand einholen zu können. Dies geschieht in Form von regelmäßigen Meetings, in denen Zwischenergebnisse präsentiert und besprochen werden können. Ein solcher Ansatz erlaubt es, Lösungsansätze laufend an Rückmeldungen und Anforderungen anzupassen und verspricht somit, mit größerer Wahrscheinlichkeit eine Lösung hervorzubringen, die den Anforderungen der Stakeholder gerecht wird.

=== Implementierung des #utils.gls-short("kite2") Story Formates <implementierung-story-format>

Bevor mit der Umsetzung der eigentlichen #utils.gls-short("library") in Compose Multiplatform begonnen werden konnte, musste zunächst, die in @story-spezifikation beschriebene Story-Spezifikation in Form eines _Story-Formates_ für _Twine_ implementiert werden. Eine genauere Beschreibung, was ein Story Format ist, ist ebenfalls in @story-spezifikation erfolgt.

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

Der Inhalt des Feldes `source` in Zeile 7 bildet also die Schnittstelle, zwischen Twine und dem Story Format. Hier übergibt Twine die internen Story-Daten an das Format, welches dann diese zu einer entsprechenden Ausgabe weiterverarbeiten kann.

Während die meisten etablierten Story Formate eine HTML-Ausgabe generieren, die direkt von Nutzer*innen konsumiert werden kann, soll das im Rahmen dieser Thesis geschaffene Format ein Ausgabe zur späteren Weiterverarbeitung in der #utils.gls-short("library") erstellen.

Hierzu wird als Ausgabeformat das Datenformat #utils.gls("json") gewählt, da für dieses einerseits in den meisten Programmiersprachen in Form von Parsern unterstützt wird (so auch in Kotlin und Kotlin Multiplatform mit Hilfe offizieller Bibliotheken @noauthor_kotlinkotlinxserialization_2025) und andererseits bereits andere Story Formate existieren, die #utils.gls-short("json") als Ausgabe generieren, an denen sich orientiert werden kann.

Glücklicherweise kann die Entwicklung des Story Formates auf einem vorhandenen Format namens _twine-to-json_ aufgebaut werden, welches quell-offen zur freien Bearbeitung und Verwendung zur Verfügung steht @jtschoonhoven_twine--json_nodate. Dieses erstellt aus in Twine 2 erstellten Geschichten JSON Objekte und unterstützt ebenfalls Geschichten, die auf dem _Harlowe 3_ Format basieren @noauthor_harlowe_nodate, auf welchem ebenfalls die KITE II Story Spezifikation basiert.

Daher kann diese Arbeit als Grundlage in großen Teilen übernommen werden und muss lediglich an die KITE II Spezifikation angepasst werden. Dazu wurde zunächst ein _Fork_ vom ausgehenden _twine-to-json_ Story Format erstellt, auf welchem die nötigen Anpassungen durchgeführt werden können @fkuper_twine--json-kite-2_nodate.

Dazu wurde zunächst die Implementierung des ursprünglichen Formates analysiert, um dann die nötigen Änderungen an den richtigen Stellen umsetzen zu können. Auf oberster Ebene ist der Programmablauf des twine-to-json Story Formates in @story-format-functionality-pseudo-code abgebildet. Hier wird die Funktion `generateJsonOutput` definiert, welche auf oberster Ebene die Story Daten verarbeitet.

Im Ausführungskontext des Formates existieren die Twine internen Story Daten innerhalb einer HTML-Datei, welche an das Format zur Verarbeitung weitergegeben wird. Diese wird dann beispielsweise in Zeile 3 gelesen, um die Daten in den nächsten Schritten weiter zu verarbeiten. Es wird ein Objekt namens `result` erstellt, welches später die Ausgabe des Story Formates bildet.

Neben Meta-Informationen zur Geschichte, wie der Name oder Name von Autor*in werden als nächstes die Passagen der Geschichte in @story-format-functionality-pseudo-code:18 analysiert und als Objekt gespeichert. Sämtliche Passagen-Objekte werden dann als Array an das `result` Objekt angehängt, welches wiederum von der `generateJsonOutput` Funktion zurückgegeben wird, um als Ausgabe des Formates genutzt werden zu können.

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

Da die Meta-Informationen einer Geschichte durch die KITE II Spezifikation unberührt bleiben und lediglich die Passagen um einige Funktionen erweitert werden, ist also die in @story-format-functionality-pseudo-code:18 aufgerufene Funktion der Punkt, an dem das KITE II Format _twine-to-json_ erweitern muss, um die Spezifikation zu implementieren. Diese Funktion konvertiert im wesentlichen die Passagen-Daten von HTML in ein JSON Objekt.

In @parse-passage-element-pseudocode ist der Programmablauf dieser Funktion in Pseudo-Code dargestellt. Diese extrahiert zunächst wie auch schon zuvor auf Story-Ebene einige Meta-Daten über die jeweilige Passage und beginnt dann damit, den Inhalt der Passage zu analysieren, was im Funktionsaufruf in @parse-passage-element-pseudocode:13 geschieht.

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

Die in @parse-passage-element-pseudocode:19 definierte Funktion `parsePassageContent` implementiert dabei die eigentlich Übersetzungslogik, indem durch den übergebenen Passagen-Text iteriert und diesen auf in der jeweiligen Story-Spezifikation definierten Elemente, wie beispielsweise Links zu anderen Passagen, untersucht und diese dann in ein jeweilige Feld des `result` JSON-Objektes übersetzt.

Dies geschieht beispielsweise im Funktionsaufruf in @parse-passage-element-pseudocode:27, welcher ein Objekt zurückgibt, falls an der zu untersuchenden Stelle, ein Link gefunden werden konnte. Diese Logik kann ebenso auf andere Elemente angewandt werden, die in einer Story spezifiziert werden. So kann ein Link, wie er im _Harlowe 3_ Format spezifiziert ist, beispiels an seiner Formatierung erkannt werden, da diese immer mit den Charakteren "`[[`" beginnen, wie man auch in @beispiel-story-passagen:15 zu sehen ist.

Um die in der KITE II Story Spezifikation definierten Elemente also zusätzlich in der Ausgabe übersetzen zu können, kann die in @parse-passage-element-pseudocode:19 definierte Funktion um diese erweitert werden. Ähnlich wie Links anhand von "`[[`" erkannt werden können, können die für KITE II spezifizierten Elemente anhand der Charaktere "`<<`" erkannt werden.

Dazu wird das Programm um eine Funktion erweitert, die solche Charaktere aus dem Inhalt erkennt und zu entsprechenden JSON Objekten übersetzt. In @new-parse-passage-content:7 sieht man wie in der erweiterten Funktion die neue Methode aufgerufen wird, welche die Inhalte nach KITE II Elementen untersucht und diese in JSON übersetzt.

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

Zur Prüfung der Konformität mit der KIT II Spezifikation wurden Testfälle definiert, die verschiedene valide Eingaben an das Programm übergeben und mit einer erwarteten Ausgabe vergleichen. Dazu wurden beispielsweise für KITE II geschriebene Geschichten als Eingabe-Daten verwendet und zu diesen ein zu erwartetes JSON-Objekt als Ausgabe erstellt.

Zur Definition und automatisierten Ausführung dieser Testfälle wurde das populäre JavaScript Testing Framework _Jest_ @noauthor_jest_nodate gewählt. Die Beschreibung eines solchen Testfalles und wie diese mit Jest definiert werden, ist in @jest-test-cases zu sehen.

Dabei wird zunächst eine Sammlung von Testfällen mit ihren jeweiligen Parametern, wie Eingabe und Ausgabe-Daten, definiert (siehe @jest-test-cases:1), welche dann genutzt werden können, um die Implementierung des Story Formates auf Korrektheit zu überprüfen.

Für jeden definierten Testfall werden diese Daten im Test geladen und die Einstiegsfunktion des Story Formates (namens `twineToJSON`) mit den jeweiligen Eingabedaten aufgerufen (siehe @jest-test-cases:20). Das Resultat wird mit dem erwarteten Ausgabe-Objekt auf Gleichheit verglichen (siehe @jest-test-cases:23).

Dies ermöglicht eine schnelle und automatisierte Validierung der Korrektheit der Implementierung und macht es einfacher im Laufe der Entwicklung Änderungen vorzunehmen, da das Programm schnell auf Korrektheit geprüft werden kann.

Dieser Ansatz hat sich während der Entwicklung mehrmals als wertvoll erwiesen, da sich sowohl die Spezifikation in einigen Details geändert hatten, aber auch durch diesen Implementierungsfehler im Story-Format selbst schnell auffallen konnten.

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

Zur Auslieferung des Story-Formates, sodass dieses in Twine verwendet werden kann, wird dieses durch ein einfaches JavaScript Programm in das in @story-format-content dargestellte Format in eine Datei namens `format.js` geschrieben, welche dann wiederum zur Einbindung in Twine zur Verfügung gestellt werden muss.

Hierfür hatte bereits das _twine-to-json_ Format, auf dem das KITE II Format basiert, eine Lösung implementiert, die GitHub Actions nutzt, um die `format.js` Datei im Internet zu veröffentlichen. Das KITE II Story Format ist ebenfalls auf GitHub gehostet und macht sich dieselbe Funktionalität zu nutze, um das Format zu veröffentlichen @fkuper_twine--json-kite-2_nodate.

Dadurch ist es allen Twine Nutzer*innen möglich, dieses Format zu nutzen und Geschichten zu schreiben, die dem KITE II Format folgen sowie diese so zu exportieren, dass sie in der im Rahmen dieser Arbeit erstellten Bibliothek verwendet werden können.

In @twine-kite2-story-format-gui sieht man, wie das importierte Format den Nutzerinnen angezeigt wird. Nach einem einfachen import über den Link zur entsprechenden `format.js` Datei kann dieses im Twine Editor genutzt werden wie jedes andere vorinstallierte Format.

#figure(
  image("/resources/images/twine-kite2-story-format.png"),
  caption: "Das KITE II Story Format in der Liste der importierten Story Formate in der Twine GUI.",
) <twine-kite2-story-format-gui>

==== Das Ausgabeformat des KITE II Story-Formates <ausgabeformat-kite2-story-format>

Im Wesentlichen orientiert sich die Struktur des JSON-Objektes, welches als Ausgabe des KITE II Story Formates generiert wird am Ausgangsprojekt _twine-to-json_ und passt dieses den Anforderungen von KITE II an. Das Format eine Twine Geschichte ist bereits in @story-spezifikation näher erläutert, weshalb hier darauf nicht näher eingegangen wird.

Während im zugrunde liegenden Format eine Passage eine Liste an Links zu anderen Passagen haben konnte, kann eine Passage im KITE II Story Format eine Liste an sogenannten _Novel Events_ haben. Dies bezeichnet Ereignisse, wie sie in der Reihenfolge in einer Passage ablaufen sollen.

Diese können entweder einen der in der Spezifikation definierten Schlüsselwörter als Typen haben (siehe @kite-keyword-constant), ein Link zu einer anderen Passage sein oder aber auch ein von Nutzer*innen selbst definiertes Schlüsselwort sein, welches nicht Teil der KITE II Spezifikation ist. Dies dient der Anpassbarkeit und Erweiterbarkeit des Formates.

Im nächsten Schritt kann ein Modul entwickelt werden, welches die Ausgabe des erstellten KITE II Story Formates verarbeiten kann. Dieser Arbeitsschritt wird in @implementierung-story-engine näher erläutert.

=== Implementierung eines Moduls zur Verarbeitung der Story-Objekte <implementierung-story-engine>

// TODO: implementierung der story engine beschreiben
