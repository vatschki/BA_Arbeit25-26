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

                            <ul class="dropdown-menu p-2 dropdown-overflow-control" aria-labelledby="dropdownLandButton" style="width: 220px;" id="countryDropdownMenu">

                                <!-- Suchfeld oben -->
                                <li>
                                    <input type="text" class="form-control" placeholder="Search..." id="searchCountryInput">
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <!-- Country-Liste -->
                                <?php if (!empty($countries)): ?>
                                    <?php foreach ($countries as $country): ?>
                                        <li class="filter-item-country">
                                            <label class="dropdown-item d-flex align-items-center">
                                                <input class="form-check-input me-2 country-filter-checkbox" type="checkbox" value="<?= $country['id'] ?>">
                                                <span class="filter-name-country"><?= $country['name_de'] ?></span>
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
                                    id="dropdownSectorButton" data-bs-toggle="dropdown" aria-expanded="false">
                                Sektor
                            </button>

                            <ul class="dropdown-menu p-2 dropdown-overflow-control" aria-labelledby="dropdownSectorButton" style="width: 220px;" id="sectorDropdownMenu">

                                <!-- Suchfeld oben -->
                                <li>
                                    <input type="text" class="form-control" placeholder="Search..." id="searchSectorInput">
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <!-- Sektors-Liste -->
                                <?php if (!empty($sectors)): ?>
                                    <?php foreach ($sectors as $sector): ?>
                                        <li class="filter-item-sector">
                                            <label class="dropdown-item d-flex align-items-center">
                                                <input class="form-check-input me-2 sector-filter-checkbox" type="checkbox" value="<?= $sector['id'] ?>">
                                                <span class="filter-name-sector"><?= $sector['name'] ?></span>
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
                                    id="dropdownIndustryButton" data-bs-toggle="dropdown" aria-expanded="false">
                                Industrie
                            </button>

                            <ul class="dropdown-menu p-2 dropdown-overflow-control" aria-labelledby="dropdownIndustryButton" style="width: 220px;" id="industryDropdownMenu">

                                <!-- Suchfeld oben -->
                                <li>
                                    <input type="text" class="form-control" placeholder="Search..." id="searchIndustryInput">
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <!-- Industry-Liste -->
                                <?php if (!empty($industries)): ?>
                                    <?php foreach ($industries as $industry): ?>
                                        <li class="filter-item-industry">
                                            <label class="dropdown-item d-flex align-items-center">
                                                <input class="form-check-input me-2 industry-filter-checkbox" type="checkbox" value="<?= $industry['id'] ?>">
                                                <span class="filter-name-industry"><?= $industry['name'] ?></span>
                                            </label>
                                        </li>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <li class="dropdown-item disabled">Keine Industrien vorhanden</li>
                                <?php endif; ?>
                            </ul>
                        </div>

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
                                    <input type="checkbox" class="column-toggle" data-column="2" checked> Land
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="3" checked> Sektor
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="4" checked> Industrie
                                </label>
                            </li>
                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Firmensuche" aria-label="Search">

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
                            <th data-field="company" data-sortable="true">Unternehmen</th>
                            <th data-field="country" data-sortable="true">Land</th>
                            <th data-field="sector" data-sortable="true">Sektor</th>
                            <th data-field="industry" data-sortable="true">Industrie</th>
                        </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($companies)): ?>
                                <?php foreach ($companies as $company): ?>
                                    <tr data-country-id="<?= esc($company['country_id']) ?>"
                                        data-sector-id="<?= esc($company['sector_id']) ?>"
                                        data-industry-id="<?= esc($company['industry_id']) ?>"
                                    >
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
                                            <i class="fa-regular fa-circle-question text-muted" title="Industrie / Unternehmensbranche"></i>
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