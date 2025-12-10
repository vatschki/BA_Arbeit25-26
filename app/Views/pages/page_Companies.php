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
                        <!-- Dropdown für Land mit Suchfeld -->
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle rounded-end" type="button"
                                    id="dropdownLandButton" data-bs-toggle="dropdown" aria-expanded="false">
                                Land
                            </button>

                            <ul class="dropdown-menu p-2" aria-labelledby="dropdownLandButton" style="width: 220px;" id="countryDropdownMenu">

                                <!-- Suchfeld oben -->
                                <li>
                                    <input type="text" class="form-control" placeholder="Search..." id="searchCountryInput">
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <!-- Country-Liste -->
                                <?php if (!empty($countries)): ?>
                                    <?php foreach ($countries as $country): ?>
                                        <li class="country-item">
                                            <label class="dropdown-item d-flex align-items-center">
                                                <input class="form-check-input me-2 country-filter-checkbox" type="checkbox" value="<?= $country['id'] ?>">
                                                <span class="country-name"><?= $country['name_de'] ?></span>
                                            </label>
                                        </li>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <li class="dropdown-item disabled">Keine Länder vorhanden</li>
                                <?php endif; ?>
                            </ul>
                        </div>

                        <!-- Dropdown für Sektor mit Suchfeld -->
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle rounded-end" type="button"
                                    id="dropdownLandButton" data-bs-toggle="dropdown" aria-expanded="false">
                                Sektor
                            </button>

                            <ul class="dropdown-menu p-2" aria-labelledby="dropdownLandButton" style="width: 220px;" id="countryDropdownMenu">

                                <!-- Suchfeld oben -->
                                <li>
                                    <input type="text" class="form-control" placeholder="Search..." id="searchCountryInput">
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <!-- Country-Liste -->
                                <?php if (!empty($sectors)): ?>
                                    <?php foreach ($sectors as $sector): ?>
                                        <li class="country-item">
                                            <label class="dropdown-item d-flex align-items-center">
                                                <input class="form-check-input me-2 country-filter-checkbox" type="checkbox" value="<?= $sector['id'] ?>">
                                                <span class="country-name"><?= $sector['name'] ?></span>
                                            </label>
                                        </li>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <li class="dropdown-item disabled">Keine Sektoren vorhanden</li>
                                <?php endif; ?>
                            </ul>
                        </div>

                        <!-- Dropdown für Industry mit Suchfeld -->
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle rounded-end" type="button"
                                    id="dropdownLandButton" data-bs-toggle="dropdown" aria-expanded="false">
                                Land
                            </button>

                            <ul class="dropdown-menu p-2" aria-labelledby="dropdownLandButton" style="width: 220px;" id="countryDropdownMenu">

                                <!-- Suchfeld oben -->
                                <li>
                                    <input type="text" class="form-control" placeholder="Search..." id="searchCountryInput">
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <!-- Country-Liste -->
                                <?php if (!empty($industries)): ?>
                                    <?php foreach ($industries as $industry): ?>
                                        <li class="country-item">
                                            <label class="dropdown-item d-flex align-items-center">
                                                <input class="form-check-input me-2 country-filter-checkbox" type="checkbox" value="<?= $industry['id'] ?>">
                                                <span class="country-name"><?= $industry['name'] ?></span>
                                            </label>
                                        </li>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <li class="dropdown-item disabled">Keine Industrien vorhanden</li>
                                <?php endif; ?>
                            </ul>
                        </div>

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
                                        <input type="checkbox" class="column-toggle" data-column="1" checked> Unternehmen
                                    </label>
                                </li>
                                <li>
                                    <label class="dropdown-item">
                                        <input type="checkbox" class="column-toggle" data-column="0" checked> Land
                                    </label>
                                </li>
                                <li>
                                    <label class="dropdown-item">
                                        <input type="checkbox" class="column-toggle" data-column="0" checked> Sektor
                                    </label>
                                </li>
                                <li>
                                    <label class="dropdown-item">
                                        <input type="checkbox" class="column-toggle" data-column="0" checked> Industrie
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
                    <table class="table table-hover table-border table-striped" id="boardTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="id" data-sortable="true">ID</th>
                            <th data-field="company" data-sortable="true">Unternhemen</th>
                            <th data-field="country" data-sortable="true">Land</th>
                            <th data-field="sector" data-sortable="true">Sektor</th>
                            <th data-field="industry" data-sortable="true">Industrie</th>
                        </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($companies)): ?>
                                <?php foreach ($companies as $company): ?>
                                    <tr data-country-id="<?= esc($company['country_id']) ?>">
                                        <td><?= esc($company['id']) ?></td>
                                        <td><?= esc($company['name']) ?></td>
                                        <td><?= esc($company['country_name_de']) ?></td>
                                        <td><?= esc($company['sector_name']) ?></td>
                                        <td><?= esc($company['industry_name']) ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php else: ?>
                            <tr class="no-data-row">
                                <td colspan="5">Keine Daten verfügbar.</td>
                            </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>


            <!-- Braucht man ?????ß -->
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

            <form action="<?= base_url('companies/create') ?>" method="post" >
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
                                            <input type="text" class="form-control" name="company_name" placeholder="Firma eingeben">
                                        </div>
                                    </div>

                                    <!-- LAND -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Land
                                            <i class="fa-regular fa-circle-question text-muted" title="Wähle ein Land aus"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <select class="form-select select2-country" name="country_id">
                                                <option value="" disabled <?= old('country_id') ? '' : 'selected' ?>>Land auswählen</option>

                                                <?php if (!empty($countries)): ?>
                                                    <?php foreach ($countries as $country): ?>
                                                        <option value="<?= esc($country['id']) ?>" <?= old('country_id') == $country['id'] ? 'selected' : '' ?>>
                                                            <?= esc($country['name_de']) ?>
                                                        </option>
                                                    <?php endforeach; ?>
                                                <?php else: ?>
                                                    <option value="" disabled>Keine Länder Vorhanden</option>
                                                <?php endif; ?>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- INDUSTRIE -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Industrie
                                            <i class="fa-regular fa-circle-question text-muted" title="Industrie / Unterbranche"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <select class="form-select select2-industry" name="industry_id" id="industry_id">
                                                <option value="" disabled <?= old('industry_id') ? '' : 'selected' ?>>Industrie auswählen</option>

                                                <?php if (!empty($industries)): ?>
                                                    <?php foreach ($industries as $industry): ?>
                                                        <option value="<?= esc($industry['id']) ?>" data-sector-name="<?= esc($industry['sector_name'] ?? '') ?>" <?= old('industry_id') == $industry['id'] ? 'selected' : '' ?>>
                                                            <?= esc($industry['name']) ?>
                                                            <?php if (! empty($industry['sector_name'])): ?>
                                                                (<?= esc($industry['sector_name']) ?>)
                                                            <?php endif; ?>
                                                        </option>
                                                    <?php endforeach; ?>
                                                <?php else: ?>
                                                    <option value="" disabled>Keine Industrien vorhanden</option>
                                                <?php endif; ?>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- SEKTOR -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Sektor
                                            <i class="fa-regular fa-circle-question text-muted" title="Branche/Sektor des Unternehmens"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <input
                                                    type="text"
                                                    class="form-control"
                                                    id="sector_display"
                                                    placeholder="Sektor wird automatisch anhand der Industrie gesetzt"
                                                    value=""
                                                    readonly
                                            >
                                        </div>
                                    </div>

                                    <!-- DESCRIPTION -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Beschreibung
                                            <i class="fa-regular fa-circle-question text-muted"
                                               title="Beschreibung oder zusätzliche Informationen zum Unternehmen"></i>
                                        </label>
                                        <div class="col-sm-9">
                                            <textarea class="form-control" name="description" rows="3" placeholder="Kurze Beschreibung des Unternehmens eingeben"><?= esc(old('description') ?? '') ?></textarea>

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
                    <button type="submit" id="createSaveBtn" class="btn btn-success">Speichern</button>
                </div>
            </form>

        </div>
    </div>
</div>

<script>

    // Suchfunktion tabelle
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

    // Suchfunktion Dropdown Land
    document.addEventListener('DOMContentLoaded', function () {

        const searchInput = document.getElementById('searchCountryInput');

        // Live-Suche im Länder-Dropdown
        if (searchInput) {
            searchInput.addEventListener('keyup', function () {
                const value = this.value.toLowerCase();

                const items = document.querySelectorAll('#countryDropdownMenu .country-item');

                items.forEach(function (li) {
                    const nameSpan = li.querySelector('.country-name');
                    if (!nameSpan) return;

                    const text = nameSpan.textContent.toLowerCase();
                    li.style.display = text.includes(value) ? '' : 'none';
                });
            });
        }

        // Filter-Logik für Tabelle
        function filterTableByCountries() {
            // IDs der ausgewählten Länder
            const selected = Array.from(document.querySelectorAll('.country-filter-checkbox:checked'))
                .map(cb => cb.value);

            // Alle Tabellenzeilen jedes Mal frisch holen
            const rows = document.querySelectorAll('#boardTable tbody tr');

            rows.forEach(function (row) {
                const countryId = row.getAttribute('data-country-id');

                if (selected.length === 0 || selected.includes(countryId)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Event-Listener für Checkboxen
        document.querySelectorAll('.country-filter-checkbox').forEach(function (cb) {
            cb.addEventListener('change', filterTableByCountries);
        });

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

    // Industrie zu Sektor automatisch setzen
    $(document).ready(function () {
        const $industrySelect = $('#industry_id');
        const $sectorInput = $('#sector_display');

        function updateSector() {
            const selectedOption = $industrySelect.find('option:selected');
            const sectorName = selectedOption.data('sector-name') || '';
            $sectorInput.val(sectorName);
        }

        // Select2 feuert ebenfalls ein 'change'-Event, daher reicht das
        $industrySelect.on('change', updateSector);

        // Initial setzen (falls ein Wert vorausgewählt ist)
        updateSector();
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