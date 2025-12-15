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
                            <th data-field="company" data-sortable="true">Author</th>
                            <th data-field="company" data-sortable="true">Jahr</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php if (!empty($reports)): ?>
                            <?php foreach ($reports as $report): ?>
                                <tr data-country-id="<?= esc($report['country_id']) ?>"
                                    data-sector-id="<?= esc($report['sector_id']) ?>"
                                    data-industry-id="<?= esc($report['industry_id']) ?>"
                                    data-company-id="<?= esc($report['company_id']) ?>"
                                >
                                    <td><?= esc($report['report_id']) ?></td>
                                    <td><?= esc($report['company_name']) ?></td>
                                    <td><?= esc($report['author_name']) ?></td>
                                    <td><?= esc($report['reporting_year']) ?></td>
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

<div class="modal fade" id="createCompanyModal" tabindex="-1" aria-labelledby="dynamicModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="dynamicModalTitle">Bericht hinzufügen</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form>
                <div class="modal-body p-0">

                    <div class="d-flex" style="min-height: 350px;">

                        <!-- Content Area -->
                        <div class="flex-grow-1 p-4">
                            <div class="tab-content" id="modalContent">
                                <!-- Tab 2: Bericht mit Drag & Drop -->
                                <div class="tab-pane fade show active" id="tab-report" role="tabpanel">

                                    <!-- Unternehmen -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Unternhemen
                                            <i class="fa-regular fa-circle-question text-muted" title="Wähle ein unternehmen"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <select class="form-select select2-company" name="company_id">
                                                <option value="" disabled <?= old('company_id') ? '' : 'selected' ?>>Unternehmen auswählen</option>

                                                <?php if (!empty($companies)): ?>
                                                    <?php foreach ($companies as $company): ?>
                                                        <option value="<?= esc($company['id']) ?>" <?= old('company_id') == $company['id'] ? 'selected' : '' ?>>
                                                            <?= esc($company['name']) ?>
                                                        </option>
                                                    <?php endforeach; ?>
                                                <?php else: ?>
                                                    <option value="" disabled>Keine Unternehmen Vorhanden</option>
                                                <?php endif; ?>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- JAHR -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            Jahr
                                            <i class="fa-regular fa-circle-question text-muted" title="Wähle ein Jahr aus"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <select class="form-select" name="year">
                                                <option value="" disabled <?= old('year') ? '' : 'selected' ?>>
                                                    Jahr auswählen
                                                </option>

                                                <?php
                                                    $currentYear = (int) date('Y');
                                                    $startYear   = $currentYear - 10;

                                                    for ($year = $currentYear; $year >= $startYear; $year--):
                                                        ?>
                                                        <option value="<?= $year ?>" <?= old('year') == $year ? 'selected' : '' ?>>
                                                            <?= $year ?>
                                                        </option>
                                                <?php endfor; ?>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- ESRS-Standard -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            ESRS-Standard
                                            <i class="fa-regular fa-circle-question text-muted" title="Wähle ein ESRS-Standard"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <select class="form-select select2-standard" name="standard_id">
                                                <option value="" disabled <?= old('standard_id') ? '' : 'selected' ?>>ESRS-Standard auswählen</option>

                                                <?php if (!empty($standards)): ?>
                                                    <?php foreach ($standards as $standard): ?>
                                                        <option value="<?= esc($standard['id']) ?>" <?= old('standard_id') == $standard['id'] ? 'selected' : '' ?>>
                                                            <?= esc($standard['name']) ?>
                                                        </option>
                                                    <?php endforeach; ?>
                                                <?php else: ?>
                                                    <option value="" disabled>Keine ESRS-Standard Vorhanden</option>
                                                <?php endif; ?>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- ESRS-Requirement -->
                                    <div class="mb-3 row align-items-center">
                                        <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                            ESRS-Anforderung
                                            <i class="fa-regular fa-circle-question text-muted" title="Wähle eine ESRS-Anforderung"></i>
                                        </label>

                                        <div class="col-sm-9">
                                            <select class="form-select select2-standard" name="requirement_id">
                                                <option value="" disabled <?= old('requirement_id') ? '' : 'selected' ?>>ESRS-Anforderung auswählen</option>

                                                <?php if (!empty($requirements)): ?>
                                                    <?php foreach ($requirements as $requirement): ?>
                                                        <option value="<?= esc($requirement['id']) ?>" <?= old('requirement_id') == $requirement['id'] ? 'selected' : '' ?>>
                                                            <?= esc($requirement['name']) ?>
                                                        </option>
                                                    <?php endforeach; ?>
                                                <?php else: ?>
                                                    <option value="" disabled>Keine ESRS-Anforderung Vorhanden</option>
                                                <?php endif; ?>
                                            </select>
                                        </div>
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