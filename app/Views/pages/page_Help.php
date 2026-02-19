<div id="main-content" class="container-card">
    <div class="container">
        <div class="card">
            <div class="card-body container-fluid">

                <div class="d-flex justify-content-end mb-4">
                    <div class="help-search-wrapper position-relative">
                        <input
                                type="search"
                                id="helpSearchInput"
                                class="form-control"
                                placeholder="Suchen …"
                                aria-label="Hilfe durchsuchen"
                        >
                    </div>
                </div>


                <!-- ===================== -->
                <!-- Einführung -->
                <!-- ===================== -->
                <section id="help-intro" class="mb-5">
                    <h3>Überblick</h3>
                    <p class="text-grey">
                        Diese Anwendung ermöglicht es, ESG- bzw. ESRS-PDF-Berichte hochzuladen,
                        automatisiert zu analysieren und strukturierte Inhalte direkt in einer Datenbank abzulegen.
                        Ziel ist es, relevante Informationen effizient auffindbar, vergleichbar und
                        weiterverarbeitbar zu machen.
                    </p>

                    <p class="text-grey">
                        Bei Fragen oder Problemen finden Sie auf dieser Seite unterstützende Hinweise.
                        Zusätzlich können Sie über die Suchfunktion in der oberen rechten Ecke gezielt nach bestimmten
                        Problemen oder Themen suchen.
                    </p>
                </section>

                <!-- ===================== -->
                <!-- Ablauf -->
                <!-- ===================== -->
                <section id="help-flow" class="mb-5">
                    <h3>Gesamtablauf</h3>

                    <p class="text-grey mb-3">
                        Die Funktionalität der Anwendung ist an einen festen Ablauf gekoppelt.
                        Damit alle Funktionen vollständig genutzt werden können, müssen zunächst
                        bestimmte Voraussetzungen erfüllt sein (insbesondere ein gültiger API-Key).
                        Die folgenden Schritte führen Sie durch den gesamten Prozess.
                    </p>

                    <div class="d-flex flex-wrap align-items-center gap-2 mt-3 help-flow-buttons">

                        <a href="#help-apikey" class="btn btn-primary btn-sm">
                            API-Key hinterlegen
                        </a>

                        <span class="help-flow-arrow" aria-hidden="true">→</span>

                        <a href="#help-upload" class="btn btn-primary btn-sm">
                            PDF-Bericht hochladen
                        </a>

                        <span class="help-flow-arrow" aria-hidden="true">→</span>

                        <a href="#help-pipeline" class="btn btn-primary btn-sm">
                            Automatische Verarbeitung
                        </a>

                        <span class="help-flow-arrow" aria-hidden="true">→</span>

                        <a href="#help-results" class="btn btn-primary btn-sm">
                            Ergebnisse anzeigen
                        </a>

                    </div>

                    <p class="text-grey mt-3 mb-0">
                        Jeder Schritt ist weiter unten auf dieser Seite detailliert beschrieben.
                    </p>
                </section>


                <!-- ===================== -->
                <!-- API Key -->
                <!-- ===================== -->
                <section id="help-apikey" class="mb-5">
                    <h3>API-Key hinterlegen</h3>

                    <p class="text-grey">
                        Die Nutzung der Anwendung ist zwingend an einen gültigen API-Key gekoppelt.
                        Ohne hinterlegten API-Key ist keine Verarbeitung von Berichten möglich,
                        da sämtliche Analyse- und Extraktionsschritte über einen externen KI-Dienst erfolgen.
                    </p>

                    <p class="text-grey">
                        Zusätzlich zum API-Key müssen der gewünschte LLM-Provider sowie das zu verwendende
                        Modell konfiguriert werden. Erst wenn alle erforderlichen Angaben vollständig
                        gesetzt sind, stehen die Funktionen der Anwendung uneingeschränkt zur Verfügung.
                    </p>

                    <small class="d-block mt-2 text-grey">
                        Zurzeit wird der LLM-Provider „Gemini“ unterstützt.
                        Es wird die Nutzung des Modells „gemini-2.5-flash“ empfohlen.
                    </small>


                    <div class="d-flex flex-wrap gap-3 mt-4">

                        <!-- Provider -->
                        <p class="mb-1 fw-semibold">LLM-Provider</p>
                        <div class="help-step card flex-grow-1 position-relative">
                            <div class="card-body">

                                <!-- Copy Icon -->
                                <button
                                        type="button"
                                        class="help-copy-btn"
                                        data-copy="gemini"
                                        aria-label="Provider kopieren"
                                >
                                    <i class="fa-regular fa-copy"></i>
                                    <span class="help-copy-text">Provider kopieren</span>
                                </button>

                                <code>gemini</code>
                            </div>
                        </div>

                        <!-- Model -->
                        <p class="mb-1 fw-semibold">LLM-Modell</p>
                        <div class="help-step card flex-grow-1 position-relative">
                            <div class="card-body">

                                <!-- Copy Icon -->
                                <button
                                        type="button"
                                        class="help-copy-btn"
                                        data-copy="models/gemini-2.5-flash"
                                        aria-label="Modell kopieren"
                                >
                                    <i class="fa-regular fa-copy"></i>
                                    <span class="help-copy-text">Model kopieren</span>
                                </button>

                                <code>models/gemini-2.5-flash</code>
                            </div>
                        </div>

                    </div>


                    <div class="mt-5">
                        <a href="/config/api-key" class="btn btn-primary">
                            Zur API-Key- und Modell-Konfiguration
                        </a>
                    </div>

                </section>


                <!-- ===================== -->
                <!-- PDF Upload -->
                <!-- ===================== -->
                <section id="help-upload" class="mb-5">
                    <h3>Bericht hochladen</h3>

                    <p class="text-grey">
                        Nach erfolgreicher Konfiguration kann ein ESG- bzw. ESRS-Bericht im PDF-Format hochgeladen werden.
                        Zusätzlich zum PDF werden Metadaten erfasst, damit der Bericht eindeutig zugeordnet und gezielt
                        ausgewertet werden kann.
                    </p>




                    <!-- Kurzüberblick: was wird benötigt -->
                    <div class="mb-4">
                        <h5 class="mb-2">Pflicht Eingabefelder im Upload-Formular</h5>
                        <ul class="text-grey mb-0">
                            <li><strong>Unternehmen</strong> (Zuordnung des Berichts)</li>
                            <li><strong>Author</strong> (Verfasser des Berichts)</li>
                            <li><strong>Jahr</strong> (Berichtsjahr für Historie und Vergleich)</li>
                            <li><strong>ESRS-Standard</strong> (bestimmt Struktur und verfügbare Anforderungen)</li>
                            <li><strong>ESRS-Anforderung</strong> (Einzelauswertung oder alle Anforderungen)</li>
                            <li><strong>PDF-Datei</strong> (eigentliche Datenquelle)</li>
                        </ul>
                    </div>

                    <!-- Unternehmen -->
                    <div class="mb-4">
                        <h5 class="mb-1">Unternehmen</h5>

                        <p class="text-grey mb-2">
                            Wählen Sie das Unternehmen aus, zu dem der Bericht gehört.
                            Diese Zuordnung ist notwendig, um mehrere Berichte sauber zu verwalten
                            und spätere Abfragen/Auswertungen unternehmensbezogen durchführen zu können.
                        </p>

                        <div class="help-important-note mt-3 mb-3">
                            <strong>Wichtiger Hinweis:</strong>
                            Der Unternehmensname muss bereits in der Unternehmensverwaltung angelegt sein
                            und exakt mit einem vorhandenen Eintrag in der Datenbank übereinstimmen.
                            Eigene Eingaben werden automatisch gegengeprüft.
                        </div>
                    </div>

                    <!-- Author -->
                    <div class="mb-4">
                        <h5 class="mb-1">Autor</h5>

                        <div class="help-indented">
                            <p class="text-grey mb-2">
                                Wählen Sie den Autor aus, der das Unternehmen dabei unterstützt hat, den Bericht zu Verfassen.
                                Diese Information wird für regulatorische Zuordnungen und spätere
                                Auswertungen verwendet. Der Autor kann zum einen das Unternehmen selber sein,
                                oder ein externer Dienstleister wie KPMG oder Deloitte.
                            </p>
                        </div>

                        <!-- Richtiger Link zu Auhtorverwaltung -->
                        <div class="mt-4">
                            <a href="#help-author" class="btn btn-primary">
                                Author Hinzufügen
                            </a>
                        </div>
                    </div>

                    <!-- Jahr -->
                    <div class="mb-4">
                        <h5 class="mb-1">Jahr</h5>

                        <p class="text-grey mb-2">
                            Geben Sie an, für welches Berichtsjahr das PDF gilt.
                            Das Jahr wird benötigt, um Berichte zeitlich einzuordnen, Entwicklungen
                            über mehrere Jahre zu vergleichen und Analysen gezielt zu filtern.
                        </p>

                    </div>

                    <!-- ESRS-Standard -->
                    <div class="mb-4">
                        <h5 class="mb-1">ESRS-Standard</h5>
                        <p class="text-grey mb-2">
                            Der Standard definiert, nach welchem ESRS-Rahmen der Bericht ausgewertet wird.
                            Diese Auswahl steuert, welche Anforderungen im nächsten Feld verfügbar sind
                            und welche Logik für die Verarbeitung angewendet wird.
                        </p>

                        <div class="help-important-note mt-3 mb-3">
                            <strong>Hinweis:</strong>
                            Der ausgewählte Standard bestimmt über die Anzeige derAnforderungen.
                            Es werden nur Anforderungen angezeigt, die zum gewählten Standard gehören.
                        </div>

                        <p class="text-grey mb-2">
                            Zur genaueren Erklärung von Standards:
                        </p>

                        <div class="mt-4">
                            <a href="#help-standards" class="btn btn-primary">
                                Standards
                            </a>
                        </div>
                    </div>


                    <!-- ESRS-Anforderung -->
                    <div class="mb-4">
                        <h5 class="mb-1">ESRS-Anforderung</h5>

                        <p class="text-grey mb-2">
                            Legt fest, welche Anforderungen innerhalb des gewählten ESRS-Standards ausgewertet werden.
                            Sie können zwischen Einzelanforderungen oder allen Anforderungen wählen.
                            Bei Einzelanforderung wird eine gezielte Extraktion einer einzelnen ESRS-Anforderung
                            durchgeführt. Wenn Sie "Alle Anforderungen" wählen, wird der gesamte Bericht umfassend analysiert
                            und alle relevanten Informationen zu jeder Anforderung extrahiert.
                        </p>

                        <p class="text-grey mb-2">
                            Zur genaueren Erklärung von Anforderungen:
                        </p>

                        <div class="mt-4">
                            <a href="#help-requirements" class="btn btn-primary">
                                Anforderungen
                            </a>
                        </div>
                    </div>

                    <!-- CTA -->
                    <h6 class="mt-3 mb-2">Zum PDF Upload Formular:</h6>

                    <div class="mt-3">
                        <a href="/esg-reports" class="btn btn-primary">
                            PDF-Upload
                        </a>
                    </div>
                </section>


                <!-- ===================== -->
                <!-- Unternehmen hochladen -->
                <!-- ===================== -->
                <section id="help-company" class="mb-5">
                    <h3>Unternehmen hinzufügen</h3>

                    <p class="text-grey">
                        Bevor ein ESG- bzw. ESRS-Bericht hochgeladen werden kann,
                        muss das zugehörige Unternehmen in der Unternehmensverwaltung
                        angelegt sein. Nur so kann der Bericht eindeutig zugeordnet
                        und verwaltet werden.
                    </p>

                    <!-- Kurzüberblick: was wird benötigt -->
                    <div class="mb-4">
                        <h5 class="mb-2">Pflicht Eingabefelder um ein Unternehmen hinzuzufügen</h5>
                        <ul class="text-grey mb-0">
                            <li><strong>Namen</strong></li>
                            <li><strong>Land</strong></li>
                            <li><strong>Industrie</strong></li>
                            <li><strong>Sektor</strong></li>
                        </ul>
                    </div>

                    <div class="mb-4">
                        <h5 class="mb-2">Optionale Eingabefelder um ein Unternehmen hinzuzufügen</h5>
                        <ul class="text-grey mb-0">
                            <li><strong>Beschreibung</strong></li>
                        </ul>
                    </div>

                    <!-- Firma -->
                    <div class="mb-4">
                        <h5 class="mb-1">Firma</h5>

                        <div class="help-indented">
                            <p class="text-grey mb-2">
                                Geben Sie den offiziellen Namen des Unternehmens ein.
                                Der Name dient als zentrale Zuordnung für alle späteren Berichte,
                                Auswertungen und Vergleiche.
                            </p>

                            <div class="help-important-note">
                                <strong>Hinweis:</strong>
                                Der Unternehmensname sollte eindeutig und konsistent verwendet werden.
                                Mehrfacheinträge desselben Unternehmens sind zu vermeiden.
                            </div>
                        </div>
                    </div>

                    <!-- Land -->
                    <div class="mb-4">
                        <h5 class="mb-1">Land</h5>

                        <div class="help-indented">
                            <p class="text-grey mb-2">
                                Wählen Sie das Land aus, in dem das Unternehmen seinen Hauptsitz hat.
                                Diese Information wird für regulatorische Zuordnungen und spätere
                                Auswertungen verwendet. Das Land sollte im ISO 3166-1 Alpha-2 Format angegeben werden
                                (z.B. "DE" für Deutschland).
                            </p>
                        </div>

                        <!-- Richtiger Link zu Länderverwaltung -->
                        <div class="mt-4">
                            <a href="#help-country" class="btn btn-primary">
                                Länder
                            </a>
                        </div>
                    </div>

                    <!-- Industrie -->
                    <div class="mb-4">
                        <h5 class="mb-1">Industrie</h5>

                        <div class="help-indented">
                            <p class="text-grey mb-2">
                                Die Industrie beschreibt die Branche, in der das Unternehmen tätig ist.
                                Sie bildet die Grundlage für die automatische Zuordnung zu einem Sektor
                                sowie für branchenspezifische ESG-Auswertungen.
                            </p>
                        </div>

                        <div class="help-important-note mt-3 mb-3">
                            <strong>Hinweis:</strong>
                            Die Industrie hängt vom gewählten Sektor ab. Stellen Sie sicher,
                            dass Sie zuerst den Sektor auswählen,
                            damit die entsprechenden Industrien korrekt angezeigt werden.
                            Wenn zuerst die Industrie ausgewählt wird, wird der dazugehörige Sektor automatisch gesetzt.
                        </div>

                        <div class="mt-4">
                            <a href="#help-industry" class="btn btn-primary">
                                Industrien
                            </a>
                        </div>

                    </div>

                    <!-- Sektor -->
                    <div class="mb-4">
                        <h5 class="mb-1">Sektor</h5>

                        <div class="help-indented">
                            <p class="text-grey mb-2">
                                Der Sektor wird automatisch auf Basis der ausgewählten Industrie gesetzt
                                und kann nicht manuell geändert werden.
                            </p>

                            <div class="help-important-note">
                                <strong>Hinweis:</strong>
                                Änderungen am Sektor sind nur durch eine andere Industrieauswahl möglich.
                            </div>
                        </div>

                        <div class="mt-4">
                            <a href="#help-sector" class="btn btn-primary">
                                Sektoren
                            </a>
                        </div>
                    </div>

                    <!-- Beschreibung -->
                    <div class="mb-4">
                        <h5 class="mb-2">Beschreibung</h5>

                        <div class="help-indented">
                            <p class="text-grey mb-2">
                                Optional können zusätzliche Informationen zum Unternehmen hinterlegt werden,
                                etwa zum Geschäftsfeld, zur Marktposition oder zu besonderen Merkmalen.
                                Geeignet sind kurze, öffentlich verfügbare Unternehmensbeschreibungen,
                                beispielsweise von der offiziellen Website.
                            </p>
                        </div>
                    </div>

                </section>

                <!-- ===================== -->
                <!-- Ergebnisse -->
                <!-- ===================== -->
                <section id="help-results" class="mb-5">
                    <h3>Ergebnisse anzeigen</h3>

                    <p class="text-grey">
                        Nach erfolgreicher Verarbeitung des Berichts können die extrahierten
                        und strukturierten Daten in der Ergebnisübersicht eingesehen werden.
                        Dort stehen verschiedene Filter- und Sortiermöglichkeiten zur Verfügung,
                        um die Daten gezielt zu analysieren und auszuwerten.
                    </p>

                    <p class="text-grey">
                        Um auf die aus den Berichten extrahierten Ergebnisse zuzugreifen, können Sie entweder
                        über das Hauptmenü zur Tabellenansicht der hochgeladenen Berichte navigieren.
                        Dort werden alle Berichte angezeigt, die dem jeweiligen Unternehmen zugeordnet sind.
                        Durch Auswahl eines Berichts gelangen Sie zur Detailansicht mit den entsprechenden Inhalten.
                        <br><br>
                        Alternativ können Sie über die untenstehende Schaltfläche eine Übersicht aller hochgeladenen
                        Berichte öffnen und anschließend gezielt auswählen, welche Inhalte eines bestimmten
                        Berichts angezeigt werden sollen.
                    </p>

                    <div class="mt-4">
                        <a href="/esg-reports" class="btn btn-primary">
                            Zur Ergebnisübersicht
                        </a>
                    </div>
                </section>

                <!-- ===================== -->
                <!-- Länder -->
                <!-- ===================== -->
                <section id="help-country" class="mb-5">
                    <h3>Länder </h3>

                    <p class="text-grey">
                        Länder dienen der geografischen Zuordnung von Unternehmen,
                        Standorten und ESG-Berichten. Sie ermöglichen eine strukturierte
                        regionale Auswertung sowie regulatorische Einordnung, beispielsweise
                        im Hinblick auf EU-Mitgliedschaften.
                        <br><br>
                        Jedes Land enthält folgende Attribute:
                            <ul>
                                <li><strong>Code</strong> – standardisierter Ländercode (z. B. ISO-Alpha-2)</li>
                                <li><strong>Name (DE)</strong> – offizielle Bezeichnung auf Deutsch</li>
                                <li><strong>Name (EN)</strong> – offizielle Bezeichnung auf Englisch</li>
                                <li><strong>Region</strong> – geografische Zuordnung (z. B. Westliches Europa, Nordeuropa)</li>
                                <li><strong>EU-Mitglied</strong> – Kennzeichnung, ob das Land Mitglied der Europäischen Union ist</li>
                            </ul>
                        Diese Struktur stellt eine konsistente geografische Klassifikation
                        innerhalb des Systems sicher.
                    </p>


                    <div class="mt-4">
                        <a href="/config/country" class="btn btn-primary">
                            Zur Länderverwaltung
                        </a>
                    </div>

                </section>

                <!-- ===================== -->
                <!-- Sektoren -->
                <!-- ===================== -->
                <section id="help-sector" class="mb-5">
                    <h3>Sektoren </h3>

                    <p class="text-grey">
                        Sektoren dienen der Kategorisierung von Unternehmen
                        und sind entscheidend für die Zuordnung von ESG-Berichten.
                        Jeder Sektor umfasst mehrere Industrien, die spezifische Branchen
                        innerhalb des Sektors repräsentieren.
                    </p>

                    <div class="mt-4">
                        <a href="/config/sector" class="btn btn-primary">
                            Zur Sektorenverwaltung
                        </a>
                    </div>

                </section>

                <!-- ===================== -->
                <!-- Industrien -->
                <!-- ===================== -->
                <section id="help-industry" class="mb-5">
                    <h3>Industrien</h3>

                    <p class="text-grey">
                        Industrien dienen der fachlichen Kategorisierung von Unternehmen und beschreiben
                        deren konkrete wirtschaftliche Tätigkeit. Sie stellen eine zentrale Grundlage
                        für die strukturierte Zuordnung und Auswertung von ESG-Berichten dar.
                        Jede Industrie ist eindeutig genau einem Sektor zugeordnet und repräsentiert
                        eine spezifische Branche innerhalb dieses Rahmens.
                        Die Auswahl der Industrie ist daher besonders wichtig, da sie die inhaltliche
                        Einordnung des Unternehmens bestimmt und die Basis für die weitere Analyse
                        und Auswertung der Berichte bildet.
                    </p>

                    <div class="mt-4">
                        <a href="/config/industry" class="btn btn-primary">
                            Zur Indstrienverwaltung
                        </a>
                    </div>

                </section>

                <!-- ===================== -->
                <!-- Standards -->
                <!-- ===================== -->
                <section id="help-standards" class="mb-5">
                    <h3>Standards</h3>

                    <p class="text-grey">
                        ESRS-Standards, im Folgenden auch als Standard bezeichnet, definieren den inhaltlichen
                        Rahmen und die strukturelle Grundlage für die Analyse und Auswertung von ESG-Berichten.
                        Sie werden von der Europäischen Union vorgegeben und beschreiben übergeordnete Themenbereiche,
                        die in den Berichten behandelt werden müssen.
                        Jeder Standard umfasst eine Reihe spezifischer Anforderungen (Requirements),
                        die festlegen, welche Inhalte im Bericht relevant sind und welche Informationen
                        im Rahmen der Analyse gezielt extrahiert werden.
                    </p>

                    <div class="mt-4">
                        <a href="/config/standard" class="btn btn-primary">
                            Zur Standardverwaltung
                        </a>
                    </div>
                </section>

                <!-- ===================== -->
                <!-- Requirements -->
                <!-- ===================== -->
                <section id="help-requirements" class="mb-5">
                    <h3>Anforderungen</h3>

                    <p class="text-grey">
                        Anforderungen, im Folgenden auch als Requirements, ESRS-Requirements oder
                        ESRS-Anforderungen bezeichnet, sind spezifische Vorgaben innerhalb eines
                        ESRS-Standards. Sie definieren, welche Informationen in einem ESG-Bericht
                        enthalten sein können und wie diese inhaltlich einzuordnen sind.
                        Jede Anforderung ist eindeutig einem bestimmten Standard zugeordnet und legt fest,
                        welche Inhalte aus dem Bericht gezielt extrahiert werden sollen.
                        Anforderungen nehmen dabei eine zentrale Rolle ein, da sie die inhaltliche
                        Grundlage für die Analyse bilden und es dem System ermöglichen,
                        mithilfe des eingesetzten LLM relevante Textstellen mit hoher Wahrscheinlichkeit
                        den jeweiligen Standards zuzuordnen.
                    </p>

                    <div class="mt-4">
                        <a href="/config/requirement" class="btn btn-primary">
                            Zur Anforderungsverwaltung
                        </a>
                    </div>
                </section>

                <!-- ===================== -->
                <!-- Autoren -->
                <!-- ===================== -->
                <section id="help-authoren" class="mb-5">
                    <h3>Autor </h3>

                    <p class="text-grey">
                        Sektoren dienen der Kategorisierung von Unternehmen
                        und sind entscheidend für die Zuordnung von ESG-Berichten.
                        Jeder Sektor umfasst mehrere Industrien, die spezifische Branchen
                        innerhalb des Sektors repräsentieren.
                    </p>

                    <div class="mt-4">
                        <a href="/config/sector" class="btn btn-primary">
                            Zur Sektorenverwaltung
                        </a>
                    </div>

                </section>

                <!-- ===================== -->
                <!-- Backend Pipeline -->
                <!-- ===================== -->
                <section id="help-pipeline" class="mb-5">
                    <h3>Automatische Verarbeitung</h3>

                    <p class="text-grey">
                        Die automatische Verarbeitungspipeline bildet das technische Kernstück der Anwendung.
                        Sie übernimmt die vollständige Analyse der hochgeladenen ESG- bzw. ESRS-Berichte und
                        sorgt dafür, dass relevante Inhalte strukturiert extrahiert und in der Datenbank abgelegt werden.
                    </p>

                    <p class="text-grey">
                        Nach dem Upload eines PDF-Dokuments wird der Bericht zunächst eingelesen und in einzelne
                        Textbestandteile zerlegt. Diese Inhalte werden anschließend vorverarbeitet und gefiltert,
                        um irrelevante oder nicht auswertbare Textbereiche auszuschließen.
                    </p>

                    <p class="text-grey">
                        In einem ersten Verarbeitungsschritt wird ein KI-Modell eingesetzt, um die für die
                        ausgewählten ESRS-Standards und Anforderungen relevanten Seiten des Berichts zu identifizieren.
                        Auf Basis dieser Vorauswahl erfolgt eine weitere Filterung, sodass nur inhaltlich
                        relevante Textpassagen in die tiefergehende Analyse einfließen.
                    </p>

                    <p class="text-grey">
                        In einem zweiten KI-gestützten Verarbeitungsschritt werden die gefilterten Inhalte
                        detailliert analysiert und den jeweiligen ESRS-Anforderungen zugeordnet.
                        Nach einer abschließenden Qualitäts- und Konsistenzprüfung werden die extrahierten
                        Ergebnisse strukturiert gespeichert und für die Anzeige im Frontend bereitgestellt.
                    </p>

                    <p class="text-grey">
                        Die vollständige Verarbeitung kann – abhängig von Umfang und Komplexität des Dokuments –
                        zwischen etwa 7 und 15 Minuten in Anspruch nehmen. Während dieses Zeitraums wird der
                        aktuelle Fortschritt in einem Statusfenster angezeigt. Nach Abschluss der Pipeline
                        aktualisiert sich die Ansicht automatisch.
                    </p>

                    <figure class="mt-4">
                        <img
                                src="/resources/images/two_llm_call_pipeline.svg"
                                alt="Diagramm der automatischen Verarbeitungspipeline"
                                class="img-fluid help-diagram"
                        >
                        <figcaption class="text-grey mt-2">
                            Schematische Darstellung der automatischen Verarbeitungspipeline.
                        </figcaption>
                    </figure>

                </section>

                <!-- ===================== -->
                <!-- FAQ - kommt noch -->
                <!-- ===================== -->

            </div>
        </div>
    </div>
</div>
