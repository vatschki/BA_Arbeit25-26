<!-- Darstellung des ausgewählten Menüs style="background-color: aliceblue !important; -->
<div id="main-content" class="container-card">
    <div class="container">
        <div class="card">
            <div class="card-body container-fluid">
                <div class="d-flex justify-content-between mb-3">
                    <!-- Left: "Neu" Button -->

                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createCompanyModal">
                        <i class="fas fa-plus-circle"></i> Neu
                    </button>

                    <!-- Right: Button Group mit Search Field -->
                    <div class="d-flex align-items-center">

                        <!-- Search Field mit kleinem Abstand -->
                        <button class="btn btn-secondary dropdown-toggle rounded-end" type="button" id="dropdownLandButton" data-bs-toggle="dropdown" aria-expanded="false">
                            Land
                        </button>

                        <button class="btn btn-secondary dropdown-toggle rounded-end" type="button" id="dropdownSectorButton" data-bs-toggle="dropdown" aria-expanded="false">
                            Sektor
                        </button>

                        <button class="btn btn-secondary dropdown-toggle rounded-end" type="button" id="dropdownIndustryButton" data-bs-toggle="dropdown" aria-expanded="false">
                            Industrie
                        </button>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Frimensuche" aria-label="Search" style="margin-right: 10px;">

                        <!-- Button Group für bessere Verbindung -->
                        <div class="btn-group">
                            <!-- Ansicht umschalten Button -->
                            <button id="toggleView" class="btn btn-secondary rounded-start" type="button" name="toggle" aria-label="Show card view" title="Show card view">
                                <i class="fa-solid fa-wand-magic-sparkles"></i>
                            </button>

                            <!-- Spaltenfilter Dropdown (Direkt in der Gruppe) -->
                            <button class="btn btn-secondary dropdown-toggle rounded-end" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-solid fa-bars"></i>
                            </button>

                            <!-- Dropdown-Menü außerhalb von btn-group -->
                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <li>
                                    <label class="dropdown-item">
                                        <input type="checkbox" class="column-toggle" data-column="0" checked> ID
                                    </label>
                                </li>
                                <li>
                                    <label class="dropdown-item">
                                        <input type="checkbox" class="column-toggle" data-column="1" checked> Name
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body container-fluid" id="table-view">
                <div class="table-responsive">
                    <table class="table table-hover" id="boardTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="id" data-sortable="true">Unternehmen</th>
                            <th data-field="name" data-sortable="true">Verfasser</th>
                            <th data-field="name" data-sortable="true">Jahr</th>
                            <th data-field="name" data-sortable="true">ESRS-Punkt</th>
                            <th data-field="name" data-sortable="true">Inhalt</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php if (!empty($companies)): ?>
                            <?php foreach ($companies as $company): ?>
                                <tr>
                                    <td><?= $company['id'] ?></td>
                                    <td><?= $company['name'] ?></td>
                                    <td><?= $company['bericht'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php else: ?>
                            <tr class="no-data-row">
                                <td colspan="3">Keine Daten verfügbar.</td>
                            </tr>
                        <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>


            <!-- Kartenansicht als Tabelle -->
            <div class="d-none card-body container-fluid" id="card-view">
                <table class="table" id="cardTable">
                    <tbody>
                    <?php if (!empty($companies)): ?>
                        <?php foreach ($companies as $company): ?>
                            <tr class="card-table-row">
                                <td colspan="2">
                                    <div class="card-entry"><strong>ID:</strong> <span><?= $company['id'] ?></span></div>
                                    <div class="card-entry"><strong>Name:</strong> <span><?= $company['name'] ?></span></div>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr class="no-data-row">
                            <td colspan="2">Keine Daten verfügbar.</td>
                        </tr>
                    <?php endif; ?>
                    </tbody>
                </table>
            </div>
            <div id="no-results-message" class="text-center mt-3 text-danger d-none">
                Leider musst du das Board noch erstellen
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="createCompanyModal" tabindex="-1" aria-labelledby="createCompanyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="dynamicModalTitle"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form>
                <div class="modal-body p-0">

                    <div class="d-flex" style="min-height: 350px;">

                        <!-- Sidebar -->
                        <div class="sidebar-nav p-3">
                            <div class="nav flex-column nav-pills" id="modalMenu" role="tablist">
                                <button class="nav-link active" id="tab-company-btn"
                                        data-bs-toggle="pill" data-bs-target="#tab-company"
                                        type="button" role="tab">
                                    Firma
                                </button>

                                <button class="nav-link" id="tab-report-btn"
                                        data-bs-toggle="pill" data-bs-target="#tab-report"
                                        type="button" role="tab">
                                    Bericht
                                </button>
                            </div>
                        </div>

                        <!-- Content Area -->
                        <div class="flex-grow-1 p-4">
                            <div class="tab-content" id="modalContent">

                                <!-- Tab 1 -->
                                <div class="tab-pane fade show active" id="tab-company" role="tabpanel">

                                    <!-- FIRMA NAME -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Firma
                                            <i class="fa-regular fa-circle-question text-muted" title="Name des Unternehmens"></i>
                                        </label>
                                        <div class="col-sm-9">
                                            <input type="text" class="form-control">
                                        </div>
                                    </div>

                                    <!-- LAND -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Land
                                            <i class="fa-regular fa-circle-question text-muted" title="Wähle ein Land aus oder tippe es ein."></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <input list="countries" class="form-control" placeholder="Land auswählen oder tippen">
                                            <datalist id="countries">
                                                <option value="Afghanistan">
                                                <option value="Ägypten">
                                                <option value="Albanien">
                                                <option value="Algerien">
                                                <option value="Andorra">
                                                <option value="Angola">
                                                <option value="Antigua und Barbuda">
                                                <option value="Äquatorialguinea">
                                                <option value="Argentinien">
                                                <option value="Armenien">
                                                <option value="Aserbaidschan">
                                                <option value="Äthiopien">
                                                <option value="Australien">
                                                <option value="Bahamas">
                                                <option value="Bahrain">
                                                <option value="Bangladesch">
                                                <option value="Barbados">
                                                <option value="Belarus">
                                                <option value="Belgien">
                                                <option value="Belize">
                                                <option value="Benin">
                                                <option value="Bhutan">
                                                <option value="Bolivien">
                                                <option value="Bosnien und Herzegowina">
                                                <option value="Botswana">
                                                <option value="Brasilien">
                                                <option value="Brunei">
                                                <option value="Bulgarien">
                                                <option value="Burkina Faso">
                                                <option value="Burundi">
                                                <option value="Chile">
                                                <option value="China">
                                                <option value="Costa Rica">
                                                <option value="Dänemark">
                                                <option value="Deutschland">
                                                <option value="Dominica">
                                                <option value="Dominikanische Republik">
                                                <option value="Dschibuti">
                                                <option value="Ecuador">
                                                <option value="El Salvador">
                                                <option value="Elfenbeinküste">
                                                <option value="Eritrea">
                                                <option value="Estland">
                                                <option value="Eswatini">
                                                <option value="Fidschi">
                                                <option value="Finnland">
                                                <option value="Frankreich">
                                                <option value="Gabun">
                                                <option value="Gambia">
                                                <option value="Georgien">
                                                <option value="Ghana">
                                                <option value="Grenada">
                                                <option value="Griechenland">
                                                <option value="Guatemala">
                                                <option value="Guinea">
                                                <option value="Guinea-Bissau">
                                                <option value="Guyana">
                                                <option value="Haiti">
                                                <option value="Honduras">
                                                <option value="Indien">
                                                <option value="Indonesien">
                                                <option value="Irak">
                                                <option value="Iran">
                                                <option value="Irland">
                                                <option value="Island">
                                                <option value="Israel">
                                                <option value="Italien">
                                                <option value="Jamaika">
                                                <option value="Japan">
                                                <option value="Jemen">
                                                <option value="Jordanien">
                                                <option value="Kambodscha">
                                                <option value="Kamerun">
                                                <option value="Kanada">
                                                <option value="Kap Verde">
                                                <option value="Kasachstan">
                                                <option value="Katar">
                                                <option value="Kenia">
                                                <option value="Kirgisistan">
                                                <option value="Kiribati">
                                                <option value="Kolumbien">
                                                <option value="Komoren">
                                                <option value="Kongo, Demokratische Republik">
                                                <option value="Kongo, Republik">
                                                <option value="Kosovo">
                                                <option value="Kroatien">
                                                <option value="Kuba">
                                                <option value="Kuwait">
                                                <option value="Laos">
                                                <option value="Lesotho">
                                                <option value="Lettland">
                                                <option value="Libanon">
                                                <option value="Liberia">
                                                <option value="Libyen">
                                                <option value="Liechtenstein">
                                                <option value="Litauen">
                                                <option value="Luxemburg">
                                                <option value="Madagaskar">
                                                <option value="Malawi">
                                                <option value="Malaysia">
                                                <option value="Malediven">
                                                <option value="Mali">
                                                <option value="Malta">
                                                <option value="Marokko">
                                                <option value="Marshallinseln">
                                                <option value="Mauretanien">
                                                <option value="Mauritius">
                                                <option value="Mexiko">
                                                <option value="Mikronesien">
                                                <option value="Moldau">
                                                <option value="Monaco">
                                                <option value="Mongolei">
                                                <option value="Montenegro">
                                                <option value="Mosambik">
                                                <option value="Myanmar">
                                                <option value="Namibia">
                                                <option value="Nauru">
                                                <option value="Nepal">
                                                <option value="Neuseeland">
                                                <option value="Nicaragua">
                                                <option value="Niederlande">
                                                <option value="Niger">
                                                <option value="Nigeria">
                                                <option value="Nordkorea">
                                                <option value="Nordmazedonien">
                                                <option value="Norwegen">
                                                <option value="Oman">
                                                <option value="Österreich">
                                                <option value="Pakistan">
                                                <option value="Palau">
                                                <option value="Panama">
                                                <option value="Papua-Neuguinea">
                                                <option value="Paraguay">
                                                <option value="Peru">
                                                <option value="Philippinen">
                                                <option value="Polen">
                                                <option value="Portugal">
                                                <option value="Ruanda">
                                                <option value="Rumänien">
                                                <option value="Russland">
                                                <option value="Sambia">
                                                <option value="Samoa">
                                                <option value="San Marino">
                                                <option value="São Tomé und Príncipe">
                                                <option value="Saudi-Arabien">
                                                <option value="Schweden">
                                                <option value="Schweiz">
                                                <option value="Senegal">
                                                <option value="Serbien">
                                                <option value="Seychellen">
                                                <option value="Sierra Leone">
                                                <option value="Simbabwe">
                                                <option value="Singapur">
                                                <option value="Slowakei">
                                                <option value="Slowenien">
                                                <option value="Somalia">
                                                <option value="Spanien">
                                                <option value="Sri Lanka">
                                                <option value="Sudan">
                                                <option value="Südsudan">
                                                <option value="Suriname">
                                                <option value="Syrien">
                                                <option value="Tadschikistan">
                                                <option value="Tansania">
                                                <option value="Thailand">
                                                <option value="Togo">
                                                <option value="Tonga">
                                                <option value="Trinidad und Tobago">
                                                <option value="Tschad">
                                                <option value="Tschechien">
                                                <option value="Tunesien">
                                                <option value="Türkei">
                                                <option value="Turkmenistan">
                                                <option value="Tuvalu">
                                                <option value="Uganda">
                                                <option value="Ukraine">
                                                <option value="Ungarn">
                                                <option value="Uruguay">
                                                <option value="Usbekistan">
                                                <option value="Vanuatu">
                                                <option value="Vatikanstadt">
                                                <option value="Venezuela">
                                                <option value="Vereinigte Arabische Emirate">
                                                <option value="Vereinigtes Königreich">
                                                <option value="Vereinigte Staaten">
                                                <option value="Vietnam">
                                                <option value="Weißrussland">
                                                <option value="Zentralafrikanische Republik">
                                                <option value="Zypern">
                                            </datalist>
                                        </div>
                                    </div>

                                    <!-- SEKTOR -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Sektor
                                            <i class="fa-regular fa-circle-question text-muted" title="Branche/Sektor des Unternehmens"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <input list="sectors" class="form-control" placeholder="Sektor auswählen oder tippen">
                                            <datalist id="sectors">
                                                <option value="Consumer Goods">
                                                <option value="Extractive & Mineral Processing">
                                                <option value="Financials">
                                                <option value="Food & Beverage">
                                                <option value="Health Care">
                                                <option value="Infrastructure">
                                                <option value="Renewable Resources & Alternative Energy">
                                                <option value="Resource Transformation">
                                                <option value="Services">
                                                <option value="Technology & Communications">
                                                <option value="Transportation">

                                            </datalist>
                                        </div>
                                    </div>


                                    <!-- INDUSTRIE -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Industrie
                                            <i class="fa-regular fa-circle-question text-muted" title="Industrie / Unterbranche"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <input list="industries" class="form-control" placeholder="Industrie auswählen oder tippen">
                                            <datalist id="industries">
                                                <option value="Advertising & Marketing">
                                                <option value="Aerospace & Defense">
                                                <option value="Agricultural Products">
                                                <option value="Air Freight & Logistics">
                                                <option value="Airlines">
                                                <option value="Alcoholic Beverages">
                                                <option value="Apparel, Accessories & Footwear">
                                                <option value="Appliance Manufacturers">
                                                <option value="Asset Management & Custody Activities">
                                                <option value="Auto Parts">
                                                <option value="Automobiles">
                                            </datalist>
                                        </div>
                                    </div>
                                </div>
                                <!-- Tab 2: Bericht mit Drag & Drop -->
                                <div class="tab-pane fade" id="tab-report" role="tabpanel">

                                    <h5 class="mb-3">ESG-Bericht hinzufügen:</h5>


                                    <div class="mb-4 d-flex align-items-center">
                                        <label for="CNameReport" class="form-label me-3 mb-0" style="white-space: nowrap;">
                                            Company Name:
                                        </label>
                                        <input type="text" id="CNameReport" name="CNameReport"
                                               class="form-control" style="max-width: 300px;">
                                    </div>

                                    <!-- Drag and Drop Zone -->
                                    <div id="pdf-drop-zone" class="pdf-drop-zone">
                                        <!-- verstecktes File-Input -->
                                        <input id="pdf-input" type="file"
                                               accept="application/pdf,.pdf"
                                               multiple hidden>

                                        <button type="button" class="btn btn-primary" id="pdf-browse-btn">
                                            PDF auswählen
                                        </button>

                                        <div class="mt-2 text-grey">
                                            oder<br>
                                            <strong>drag a PDF</strong>
                                        </div>

                                        <div id="pdf-file-list" class="mt-3 text-grey" style="font-size:.9rem;"></div>
                                    </div>

                                </div>

                            </div>
                        </div>

                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn abbrechen_button" data-bs-dismiss="modal">Abbrechen</button>
                    <button type="button" id="createSaveBtn" class="btn btn-success">Speichern</button>
                </div>
            </form>

        </div>
    </div>
</div>

<script>

    // Suchfunktion
    document.getElementById("table-search").addEventListener("keyup", function () {
        let value = this.value.toLowerCase();
        let rows = document.querySelectorAll("#boardTable tbody tr");
        let visibleRows = 0;

        rows.forEach(row => {
            if (row.textContent.toLowerCase().includes(value)) {
                row.style.display = "table-row";
                visibleRows++;
            } else {
                row.style.display = "none";
            }
        });

        let cards = document.querySelectorAll("#cardTable tbody .card-table-row");
        let visibleCards = 0;

        cards.forEach(card => {
            if (card.textContent.toLowerCase().includes(value)) {
                card.style.display = "table-row";
                visibleCards++;
            } else {
                card.style.display = "none";
            }
        });

        let noResultsMessage = document.getElementById("no-results-message");

        if (visibleRows === 0 && visibleCards === 0) {
            noResultsMessage.classList.remove("d-none");
        } else {
            noResultsMessage.classList.add("d-none");
        }
    });

    //Dropdowns open
    document.querySelectorAll(".dropdown-menu").forEach(menu => {
        menu.addEventListener("click", function (event) {
            event.stopPropagation();
        });
    });

    // Spaltenfilter
    document.querySelectorAll(".column-toggle").forEach(checkbox => {
        checkbox.addEventListener("change", function () {
            let checkboxes = document.querySelectorAll(".column-toggle:checked");
            let columnIndex = this.getAttribute("data-column");
            let isChecked = this.checked;


            if (checkboxes.length === 0) {
                this.checked = true;
                return;
            }


            document.querySelectorAll("#boardTable tr").forEach(row => {
                let cells = row.querySelectorAll("th, td");
                if (cells[columnIndex]) {
                    cells[columnIndex].style.display = isChecked ? "" : "none";
                }
            });


            document.querySelectorAll("#cardTable .card-table-row").forEach(row => {
                let cardEntries = row.querySelectorAll(".card-entry");
                if (cardEntries[columnIndex]) {
                    cardEntries[columnIndex].style.display = isChecked ? "" : "none";
                }
            });


            checkboxes = document.querySelectorAll(".column-toggle:checked");


            document.querySelectorAll(".column-toggle").forEach(cb => {
                cb.disabled = false;
                cb.parentElement.classList.remove("disabled-option");
            });

            if (checkboxes.length === 1) {
                checkboxes[0].disabled = true;
                checkboxes[0].parentElement.classList.add("disabled-option");
            }
        });
    });

    // Ansicht umschalten
    document.getElementById("toggleView").addEventListener("click", function () {
        let tableView = document.getElementById("table-view");
        let cardView = document.getElementById("card-view");

        if (tableView.classList.contains("d-none")) {
            tableView.classList.remove("d-none");
            cardView.classList.add("d-none");
        } else {
            tableView.classList.add("d-none");
            cardView.classList.remove("d-none");
        }
    });

    // PDF Drag & Drop
    document.addEventListener("DOMContentLoaded", function () {
        const dropZone   = document.getElementById("pdf-drop-zone");
        const fileInput  = document.getElementById("pdf-input");
        const browseBtn  = document.getElementById("pdf-browse-btn");
        const fileListEl = document.getElementById("pdf-file-list");
        const saveBtn    = document.getElementById("createSaveBtn");

        let selectedFiles = [];

        function setFiles(files) {
            selectedFiles = Array.from(files).filter(f =>
                f.type === "application/pdf" || f.name.toLowerCase().endsWith(".pdf")
            );

            if (selectedFiles.length === 0) {
                fileListEl.textContent = "Keine gültigen PDF-Dateien ausgewählt.";
                return;
            }

            fileListEl.innerHTML = selectedFiles
                .map(f => "• " + f.name + " (" + Math.round(f.size / 1024) + " KB)")
                .join("<br>");
        }

        // Klick auf Zone oder Button
        dropZone.addEventListener("click", () => fileInput.click());
        browseBtn.addEventListener("click", (e) => {
            e.stopPropagation();
            fileInput.click();
        });

        // Auswahl über Dialog
        fileInput.addEventListener("change", (e) => {
            setFiles(e.target.files);
        });

        // Drag & Drop
        dropZone.addEventListener("dragover", (e) => {
            e.preventDefault();
            dropZone.classList.add("dragover");
        });

        dropZone.addEventListener("dragleave", (e) => {
            e.preventDefault();
            dropZone.classList.remove("dragover");
        });

        dropZone.addEventListener("drop", (e) => {
            e.preventDefault();
            dropZone.classList.remove("dragover");
            if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
                setFiles(e.dataTransfer.files);
                e.dataTransfer.clearData();
            }
        });

        // Speichern-Button send PDF to Backend
        saveBtn.addEventListener("click", () => {
            // Beispiel: wenn du sicherstellen willst, dass ein Bericht hochgeladen ist
            // if (selectedFiles.length === 0) {
            //   alert("Bitte mindestens einen PDF-Bericht auswählen.");
            //   return;
            // }

            const formData = new FormData();
            selectedFiles.forEach((file, idx) => {
                formData.append("reports[]", file);
            });

            // TODO: hier deine URL eintragen
            // fetch("/api/company/create", {
            //   method: "POST",
            //   body: formData
            // });

            console.log("Ausgewählte PDFs:", selectedFiles);
        });

        //Modal-Titel
        const titleElement  = document.getElementById("dynamicModalTitle");
        const tabCompanyBtn = document.getElementById("tab-company-btn");
        const tabReportBtn  = document.getElementById("tab-report-btn");
        const modalEl       = document.getElementById("createCompanyModal");

        if (titleElement) {
            // Standard
            if (modalEl) {
                modalEl.addEventListener("shown.bs.modal", () => {
                    titleElement.textContent = "Firma hinzufügen";
                });
            } else {
                titleElement.textContent = "Firma hinzufügen";
            }

            if (tabCompanyBtn) {
                tabCompanyBtn.addEventListener("click", () => {
                    titleElement.textContent = "Firma hinzufügen";
                });
            }

            if (tabReportBtn) {
                tabReportBtn.addEventListener("click", () => {
                    titleElement.textContent = "ESG Bericht hinzufügen";
                });
            }
        }
    });
</script>