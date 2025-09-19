#import "/etc/utils.typ"

== Implementierung des #utils.gls-long("visual_novel") Prototypen <implementierung-prototyp>

Nachdem die in @implementierung-visual-novel-engine beschriebene _VisualNovelEngine_ implementiert wurde, konnte unter Nutzung dieser mit der Umsetzung eines Prototypen begonnen werden, der die für das KITE II Projekt geschriebenen interaktiven Geschichten spielbar macht und darstellt.

Dieser sollte wie auch KITE II für mehrere Plattformen verfügbar sein, wobei zunächst die Plattformen Android, iOS und das Web als Hauptplattformen angestrebt wurden.

Ebenso wie die Visual Novel Bibliothek soll der Prototyp als technologische Grundlage #utils.gls-long("cmp") verwenden.

In diesem Kapitel wird die Implementation beschrieben, wie sie im Rahmen dieser Arbeit angefertigt wurde. Da für das Projekt, welches den Prototypen umsetzt, der Name _VisualNovelExample_ gewählt wurde, wird folglich diese Bezeichnung verwendet und ist somit synonym mit dem Prototypen zu verstehen.

=== Übersicht über den Projekt-Aufbau <overview-prototype-project-structure>

Der zugrunde liegende Aufbau der _VisualNovelExample_ Applikation folgt im Großen und Ganzen der gleichen wie der Demo Applikation, die in @vn-engine-demo-app-listing-part-two zu sehen und in @implementierung-visual-novel-engine beschrieben ist.

Die Architektur folgt dem etablierten #utils.gls-short("mvvm") Muster und auch dieses Projekt macht von dem #utils.gls-short("di") Framework _Koin_ Gebrauch, um Abhängigkeiten aufzulösen.

Die Ordnerstruktur des Projektes ist in @listing:prototypeFolderStructure abgebildet. Im Root-Ordner `commonMain` befinden sich sämtliche Quell-Dateien, die für alle Zielplattformen verwendet werden.

In `composeResources` befinden sich wiederum Ressourcen-Dateien, welche keinen Quell-Code beinhalten. Dazu gehören hauptsächlich Assets, die für die Visual Novels benötigt werden, wie Bilder, Sounds, die Geschichten und eine `manifest.json`-Datei. Eine nähere Erläuterung dieser Datei erfolgt in @ausarbeitung-prototyp.

#utils.codly-disable()
#let prototypeFolderStructure = ```
commonMain/
|- composeResources/
   |- drawable/
   |- files/
      |- stories/
      |- manifest.json
|- kotlin/
   |- fk.visualnovel.example/
      |- di/
      |- domain/
         |- model/
         |- service/
      |- utils/
      |- view/
      |- viewmodel/
      |- App.kt
```
#figure(
  prototypeFolderStructure,
  caption: [Ordnerstruktur des Projektes _VisualNovelExample_.],
) <listing:prototypeFolderStructure>
#utils.codly-enable()

Im `kotlin`-Verzeichnis befinden sich sämtliche Quell-Code-Dateien, welche in diesem Fall in Kotlin verfasst sind. `App.kt` fungiert hier als Einstiegspunkt in das Programm.

In den Verzeichnissen `view` befinden sich die Composables, während in `viewmodel` die dazu gehörigen ViewModels definiert sind. Das `domain`-Verzeichnis beinhaltet die Modell-Definitionen und Service-Klassen-Definitionen.

Im `di`-Verzeichnis befindet sich die _Koin_-Modul-Definition und in `utils` werden beispielsweise Quell-Dateien abgelegt, die bei der Entwicklung helfen, wie Definitionen von Daten, die zur Live-Vorschau von UI-Komponenten verwendet werden können.

Der Fokus bei der Ausgestaltung der Applikation lag dabei auf den Visual Novels selbst, da diese das Herz der Anwendung bilden. Andere Bildschirme, die in KITE II implementiert sind, aber sekundäre Funktionen erfüllen, wie Informations-Screens oder Settings-Screens, wurden daher in der Implementation zunächst vernachlässigt.

#let prototypeMainScreenImage = image("/resources/images/prototype_mainscreen.png")
#let prototypeDialogueScreenImage = image("/resources/images/prototype_dialogscreen.png")
#let kiteMainScreenImage = image("/resources/images/kite/kite-screenshot-start-screen.png")
#let kiteDialogueScreenImage = image("/resources/images/kite/kite-screenshot-dialogue.png")
#let gridCaption(content) = align(center)[
  #par(justify: false)[#text(content, size: 10pt)]
]
#let screenshotComparisonGrid = grid(
  prototypeMainScreenImage, kiteMainScreenImage, prototypeDialogueScreenImage, kiteDialogueScreenImage,
  gridCaption([Der Hauptbildschirm des Prototypen.]),
  gridCaption([Der Hauptbildschirm von KITE II.]),
  gridCaption([Ein Dialogbildschirm des Prototypen.]),
  gridCaption([Ein Dialogbildschirm von KITE II.]),

  columns: 4,
  rows: 2,
  inset: 4pt,
  stroke: utils.colorScheme.hhnWhite,
  fill: utils.colorScheme.background,
)
#figure(
  screenshotComparisonGrid,
  caption: [Screenshots verschiedener Bildschirme jeweils aus der _VisualNovelExample_ Applikation und KITE II.],
) <figure:comparisonPrototypeAndKite2>

In @figure:comparisonPrototypeAndKite2 sieht man den beispielhaften Vergleich zweier Bildschirme, jeweils aus der Prototyp-Anwendung und von KITE II.

Hier ist zu sehen, dass insbesondere die Gestaltung von Benutzeroberflächen-Elementen im Prototypen auf Standard-Komponenten gesetzt wurde, die bereits durch das #utils.gls-short("cmp") Framework bereitgestellt wurden, während in KITE II diese ein eigenes Styling erhalten haben.

Die Darstellung der Umgebungen und Charaktere dagegen sollte möglichst KITE II nach empfunden werden, indem die originalen Assets hierfür wiederverwendet wurden und somit zu demonstrieren, dass die geschaffene Bibliothek in der Lage ist, eine äquivalente Visual Novel umzusetzen.

Außerdem ist hier sichtbar, dass viele der in KITE II existierenden Bildschirme nicht im Prototypen umgesetzt sind. Diese sind als nicht essentiell bewertet worden und wurden somit zunächst außen vor gelassen.

=== Ausarbeitung des Prototypen <ausarbeitung-prototyp>

Um die letztendliche Darstellung der interaktiven Geschichten umzusetzen, werden im Prototypen in Anlehnung an KITE II einige Mechanismen implementiert, die dort in ähnlicher Form auch existieren.

So werden die Story-Dateien zusätzlich mit einer Datei mit Meta-Daten verknüpft, die zur jeweiligen Geschichte verschiedene Meta-Informationen enthalten kann, wie z.B. Datenpunkte, die in der Benutzeroberfläche verwendet werden, wie eine Beschreibung der Geschichte, einen Titel oder eine Akzentfarbe. Außerdem können hier Infos, wie eine Kontext-Beschreibung für einen Prompt hinterlegt werden, welche in KITE II zur Generierung des Feedbacks durch ein LLM verwendet wird.

Sämtliche Informationen zu einer Visual-Novel werden in einer `manifest.json` Datei zusammengefasst, welche zum Programm-Start gelesen und verarbeitet wird.

In @listing:manifestFile ist ein Ausschnitt aus dieser Datei zu sehen. Jede Geschichte wird hier mit ihrer ID als Schlüssel gemeinsam mit den relevanten Daten abgespeichert, wie die dazugehörige Dateien, die die Geschichte selbst und die Meta-Informationen enthalten, sowie einen Schlüssel, um die passenden Assets zur Geschichte laden zu können.

#utils.codly(
  skips: (
    (8, 24),
  ),
)
#let manifestFileListing = ```json
{
  "stories": {
    "E72DE4D6-B3AC-4977-99C4-6CB5D7CFCF98": {
      "fileName": "Novel_Buero.json",
      "metaFileName": "Novel_Buero.meta.json",
      "assetListName": "novelBueroAssets"
    },
  }
}
```
#figure(
  manifestFileListing,
  caption: [Ausschnitt aus der `manifest.json` Datei.],
) <listing:manifestFile>

Zum Verarbeiten dieser Informationen wurde ein Dienst namens `ManifestManagerService` definiert, dessen Aufgabe es ist, die `manifest.json` zu lesen und alle nötigen Informationen zu den definierten Geschichten zur Laufzeit bereitzustellen.

In @listing:manifestManagerService ist die Definition dieses Dienstes zu sehen. Durch Aufruf der `init()` Methode werden sämtliche Daten aus der `manifest.json`-Datei geladen und verarbeitet, woraufhin das `state`-Feld aktualisiert wird, um dies zu reflektieren. Dieser Aufruf geschieht im Falle des Prototypen beim Start der Applikation.

Die Methode `updateStoryContentInfo()` kann genutzt werden, um den Status einer Geschichte zu aktualisieren, nachdem diese beispielsweise von Nutzer*innen durchgespielt wurde.

Das Feld `stories` erlaubt lediglich einen einfachen Zugriff auf alle geladenen Geschichten und gibt `null` zurück, falls keine Geschichten geladen sind. Dies wäre ebenso über das `state` Feld möglich, würde aber erfordern, den Status zu prüfen.

#let manifestManagerServiceListing = ```kotlin
interface ManifestManagerService {
    suspend fun init()
    fun updateStoryContentInfo(
      storyId: String,
      storyContentInfo: StoryContentInfo
    )
    val state: StateFlow<ManifestManagerServiceState>
    val stories: Map<String, StoryContentInfo>?
}
```
#figure(
  manifestManagerServiceListing,
  caption: [Definition des `ManifestManagerService` Interface.],
) <listing:manifestManagerService>

Der Einstiegspunkt in die Applikation erfolgt über ein Composable, welches in der `App.kt` definiert ist und in @listing:prototypeEntryPoint zu sehen ist.

#utils.codly(
  highlights: (
    (line: 7, start: 13, fill: utils.colorScheme.hhnOrange),
    (line: 10, start: 13, fill: utils.colorScheme.hhnOrange),
  ),
)
#let prototypeEntryPointListing = ```kotlin
@Composable
fun App() {
    KoinApplication(application = {
        modules(sharedModule)
    }) {
        LaunchedEffect(Unit) {
            performLaunchInitialization()
        }
        MaterialTheme {
            MainScreen()
        }
    }
}

private suspend fun performLaunchInitialization() {
    getKoin().get<ManifestManagerService>().init()
}
```
#figure(
  prototypeEntryPointListing,
  caption: [Einstiegspunkt in die _VisualNovelExample_ Applikation, wie er in `App.kt` definiert ist.],
) <listing:prototypeEntryPoint>

In @listing:prototypeEntryPoint:7 wird über eine Funktion die Initialisierung des `ManifestManagerService` ausgeübt während in @listing:prototypeEntryPoint:10 mit `MainScreen()` das Composable konstruiert wird, welches die Wurzel der Benutzeroberfläche bildet.

Um Mechanismen, wie die Navigation zwischen den verschiedenen Bildschirmen zu implementieren, wird auf etablierte Techniken und Bibliotheken aus der Android und #utils.gls-long("cmp") Welt zurückgegriffen.

Entwickler und Herausgeber von #utils.gls-short("cmp"), JetBrains, haben hierzu eine Bibliothek veröffentlicht, die denselben Ansatz aus der Android-Welt verfolgt. Gleiches gilt für bekannte Bibliotheken zur Umsetzung des #utils.gls-short("mvvm")-Patterns in der Android-Welt. Somit können diese unter geringem Aufwand für den Prototypen implementiert werden.

Innerhalb des `MainScreen` Composables kann mit Hilfe des `NavHost` Composables aus der Navigations-Bibliothek ein Navigations-Graph definiert werden, welcher verschiedene mögliche Bildschirme definiert, die angesteuert werden können und wie zwischen diesen navigiert werden kann (siehe @listing:prototypeNavGraph).

#utils.codly(
  highlights: (
    (line: 1, start: 28, end: 43, fill: utils.colorScheme.hhnOrange),
    (line: 2, start: 16, end: 31, fill: utils.colorScheme.hhnOrange),
    (line: 4, start: 36, end: 51, fill: utils.colorScheme.hhnBlueLight),
    (line: 8, start: 16, end: 31, fill: utils.colorScheme.hhnBlueLight),
  ),
)
#let prototypeNavGraphListing = ```kotlin
NavHost(startDestination = StartDestination, /* ... */) {
    composable<StartDestination> {
        StartScreen(onStorySelected = {
            val storyScreenRoute = StoryDestination(storyId = it.storyAsset.id)
            navController.navigate(storyScreenRoute)
        })
    }
    composable<StoryDestination> {
        val storyScreenRoute = it.toRoute<StoryDestination>()
        StoryScreen(
            storyId = storyScreenRoute.storyId,
            onStoryEnded = {
                // navigate to StoryEndDestination...
            }
        )
    }
    composable<StoryEndDestination> {
        // ...
    }
    composable<AboutDestination> {
        // ...
    }
}
```
#figure(
  prototypeNavGraphListing,
  caption: [Ausschnitt aus der Definition des Navigations-Graphen des Prototypen.],
) <listing:prototypeNavGraph>

In @listing:prototypeNavGraph:1 ist beispielsweise zu sehen, dass `StartDestination` als Start-Knoten des Navigations-Graphen definiert wird. In dessen Definition in @listing:prototypeNavGraph:2 wird dann wiederum ein `StartScreen` Composable konstruiert und über eine Callback-Methode kann die Navigation zu einer ausgewählten Geschichte mit Hilfe der ID erfolgen (siehe @listing:prototypeNavGraph:4 und @listing:prototypeNavGraph:5).

Der `StoryDestination`-Knoten (@listing:prototypeNavGraph:8) wiederum kann daraufhin in seiner Definition die übergebene ID verwenden, um diese dem `StoryScreen` Composable zu übergeben, damit dieses die entsprechende Geschichte laden und anzeigen kann.

=== Darstellung der Visual Novels <implementierung-prototyp-darstellung-visual-novels>

Da das Herz dieser Anwendung die Darstellung von Visual Novels ist, soll diese Komponente des Prototypen im Folgenden näher beleuchtet werden.

Das `StoryScreen` Composable bildet hier den Einstiegspunkt und ist in @listing:storyScreen zu sehen. Wenn dieses konstruiert wird, wird über eine Methode im ViewModel das Laden der entsprechenden Geschichte über ihre ID geladen (siehe @listing:storyScreen:9).

#utils.codly(
  highlights: (
    (line: 7, start: 5, fill: utils.colorScheme.hhnOrange),
    (line: 9, start: 9, fill: utils.colorScheme.hhnOrange),
    (line: 18, start: 17, end: 31, fill: utils.colorScheme.hhnOrange),
  ),
)
#let storyScreenListing = ```kotlin
@Composable
fun StoryScreen(
    storyId: String,
    onStoryEnded: (String) -> Unit,
    viewModel: StoryScreenViewModel = koinViewModel()
) {
    val uiState by viewModel.uiState.collectAsState()
    LaunchedEffect(Unit) {
        viewModel.loadStory(storyId)
    }
    Column(/* ... */) {
        when (uiState) {
            StoryScreenUiState.Initializing -> {
                Text("Loading...", modifier = Modifier.padding(12.dp))
            }
            is StoryScreenUiState.DataReady -> {
                val storyContentInfo = (uiState as StoryScreenUiState.DataReady).storyContentInfo
                StoryPlayerView(
                    story = storyContentInfo.storyAsset,
                    onStoryEnded = onStoryEnded
                )
            }
            is StoryScreenUiState.Error -> {
                val errorMessage = (uiState as StoryScreenUiState.Error).message
                Text("Error: $errorMessage", modifier = Modifier.padding(12.dp))
            }
        }
    }
}
```
#figure(
  storyScreenListing,
  caption: [Definition des `StoryScreen` Composable.],
) <listing:storyScreen>

Das ViewModel gibt über das `uiState`-Feld einen beobachtbaren Status wieder, über den das Composable entsprechende Gestaltungsmittel wählen kann.

Im Falle eines Fehlers oder beim Laden wird hier eine einfache Text-Komponente verwendet (siehe @listing:storyScreen:14 und @listing:storyScreen:25). Diese Lösungen sind rudimentär und könnten in Zukunft durch nutzerfreundlichere Alternativen ersetzt werden, wie einem animierten Lade-Indikator und einer robusteren Fehlerbehandlung.

Bei erfolgreichem Laden der Geschichte kann das `StoryPlayerView` Composable konstruiert werden, welches sich letztendlich um die Darstellung der Geschichte kümmert (siehe @listing:storyScreen:18).

Ein Ausschnitt der Definition dieses ist in @listing:storyPlayerViewPartOne zu sehen. Hier wird auf Basis des `uiState`-Feldes des ViewModels der interne Status des Composables aktualisiert und nötige Operationen ausgeführt.

#utils.codly(
  highlights: (
    (line: 16, start: 13, fill: utils.colorScheme.hhnOrange),
    (line: 17, start: 13, fill: utils.colorScheme.hhnOrange),
    (line: 18, start: 13, fill: utils.colorScheme.hhnOrange),
  ),
)
#let storyPlayerViewListingPartOne = ```kotlin
@Composable
fun StoryPlayerView(
    story: Story,
    onStoryEnded: (String) -> Unit,
    viewModel: StoryPlayerViewModel = koinViewModel { parametersOf(story) },
) {
    val uiState by viewModel.uiState.collectAsState()
    val loading = remember { mutableStateOf(true) }
    val showStory = remember { mutableStateOf(false) }
    val showStoryEndedDialog = remember { mutableStateOf(false) }

    // perform updates based on the ViewModels uiState
    when (uiState) {
        is StoryPlayerUiState.Loading -> {
            loading.value = true
            val assetsProvider = (uiState as StoryPlayerUiState.Loading).assetsProvider
            val storyAssets = assetsProvider?.loadAssets()
            viewModel.onAssetsLoaded(storyAssets)
        }
        StoryPlayerUiState.Playing -> { /* ... */ }
        StoryPlayerUiState.StoryEnded -> { /* ... */ }
        is StoryPlayerUiState.Error -> { /* ... */ }
    }

    // construct UI composables here...
}
```
#figure(
  storyPlayerViewListingPartOne,
  caption: [Ausschnitt aus Definition des `StoryPlayerView` Composable (Teil 1).],
) <listing:storyPlayerViewPartOne>

In @listing:storyPlayerViewPartOne:16 bis @listing:storyPlayerViewPartOne:18 ist zu sehen, wie Assets geladen werden.

Da die API zum Laden von Bild-Ressourcen nur in einem `@Composable` Kontext verfügbar ist, wird dieser Schritt in dem Composable selbst ausgeführt. Dazu wurde ein `AssetsProvider`-Interface definiert und eine optionale Instanz dieses über die Datenklasse `StoryContentInfo` zur Verfügung gestellt.

Das ViewModel erlaubt Zugriff auf diese über den UI-Status `Loading` (@listing:storyPlayerViewPartOne:16), sodass das entsprechende Composable den Aufruf tätigen kann (@listing:storyPlayerViewPartOne:17).

Über die `onAssetsLoaded()`-Methode des ViewModels wird dann der Ladeprozess vervollständigt indem die angegebenen Assets in der _VisualNovelEngine_ geladen werden und das Abspielen der Geschichte gestartet wird. Die Definition dieser ist in @listing:onAssetsLoaded zu sehen.

Falls Assets vorhanden sind, werden diese über die _VisualNovelEngine_ Instanz geladen und der Status der Darstellung wird aktualisiert (siehe @listing:onAssetsLoaded:8 und @listing:onAssetsLoaded:9).

In jedem Fall wird jedoch das Abspielen der Geschichte gestartet und der ViewModel-interne `uiState` wird aktualisiert, sodass dieser Status entsprechend weiter propagiert werden kann (siehe @listing:onAssetsLoaded:11 und @listing:onAssetsLoaded:12).

#utils.codly(
  highlights: (
    (line: 8, start: 9, fill: utils.colorScheme.hhnOrange),
    (line: 9, start: 9, fill: utils.colorScheme.hhnOrange),
    (line: 11, start: 5, fill: utils.colorScheme.hhnOrange),
    (line: 12, start: 5, fill: utils.colorScheme.hhnOrange),
  ),
)
#let onAssetsLoadedListing = ```kotlin
fun onAssetsLoaded(storyAssets: StoryAssets?) {
    if (storyContentInfo == null) {
        _uiState.value = StoryPlayerUiState.Error("Story not found")
        return
    }
    storyPlayer.reset()
    storyAssets?.let {
        visualNovelEngine.loadAssets(it.assets)
        storyPlayer.loadVisualNovelSceneState(it.sceneStateIds)
    }
    storyPlayer.playStory(story.id)
    _uiState.value = StoryPlayerUiState.Playing
}
```
#figure(
  onAssetsLoadedListing,
  caption: [Implementation der `onAssetsLoaded()`-Methode in `StoryPlayerViewModel`.],
) <listing:onAssetsLoaded>

Daraufhin kann im `StoryPlayerView` Composable die Visual Novel angezeigt werden. In @listing:storyPlayerViewPartTwo ist die zweite Hälfte der Definition dieses Composables zu sehen (die erste Hälfte ist in @listing:storyPlayerViewPartOne abgebildet). Hier ist zu sehen, welche UI-Komponenten letztendlich konstruiert werden, basierend auf dem internen Status von `StoryPlayerView`.

Falls Daten geladen werden, wird ein Fortschritt-Indikator erstellt (@listing:storyPlayerViewPartTwo:6). Wenn die Geschichte gerade abgespielt wird, wird das Composable `VisualNovelStory` aus der _VisualNovelEngine_ Bibliothek verwendet, um die Visual Novel anzuzeigen (@listing:storyPlayerViewPartTwo:9). Sobald die Geschichte endet, wird eine UI-Komponente generiert, die Nutzer*innen hierüber informiert (@listing:storyPlayerViewPartTwo:16).

#utils.codly(
  highlights: (
    (line: 9, start: 13, end: 28, fill: utils.colorScheme.hhnOrange),
  ),
)
#let storyPlayerViewListingPartTwo = ```kotlin
@Composable
fun StoryPlayerView(/* ... */) {
    // ...
    Box(modifier = Modifier.fillMaxSize()) {
        if (loading.value) {
            CircularProgressIndicator()
        }
        if (showStory.value) {
            VisualNovelStory(
                storyPlayer = viewModel.storyPlayer,
                onStoryEnded = viewModel::onStoryEnded,
                onPlaybackError = viewModel::onPlaybackError
            )
        }
        if (showStoryEndedDialog.value) {
            MessageDialog(
                onDismissRequest = { onStoryEnded(story.id) },
                message = "${story.content.name} has ended."
            )
        }
    }
}
```
#figure(
  storyPlayerViewListingPartTwo,
  caption: [Ausschnitt aus Definition des `StoryPlayerView` Composable (Teil 2).],
) <listing:storyPlayerViewPartTwo>

So konnte unter Verwendung der _VisualNovelEngine_-Bibliothek mit wenigen Zeilen Code eine Applikation geschaffen werden, die in der Lage ist, Visual Novels darzustellen und spielbar zu machen.
