<?php
$canManageContent = auth()->loggedIn() && auth()->user()->can('content.manage');
$errors = session('errors') ?? [];
?>

<!-- Darstellung des ausgewählten Menüs style="background-color: aliceblue !important; -->
<div id="main-content" class="container-card">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body container-fluid">
                <div class="d-flex justify-content-between mb-3">
                    <!-- Left: "Neu" Button -->
                    <div>
                        <?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createReportModal">
                                <i class="fas fa-plus-circle"></i> Neu
                            </button>
                        <?php endif; ?>
                    </div>

                    <!-- Right: Button Group mit Search Field -->
                    <div class="d-flex align-items-center">

                        <!-- Search Field mit kleinem Abstand -->
                        <!-- Dropdown für Jahr mit Suchfeld -->
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle rounded-end"
                                    type="button"
                                    id="dropdownYearButton"
                                    data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                Jahr
                            </button>

                            <ul class="dropdown-menu p-2 dropdown-overflow-control"
                                style="width: 230px;"
                                id="yearDropdownMenu">

                                <li>
                                    <input type="text"
                                           class="form-control"
                                           placeholder="Search..."
                                           id="searchYearInput">
                                </li>

                                <li><hr class="dropdown-divider"></li>

                                <?php foreach ($years as $year): ?>
                                    <li class="filter-item-year">
                                        <label class="dropdown-item d-flex align-items-center">
                                            <input class="form-check-input me-2 year-filter-checkbox"
                                                   type="checkbox"
                                                   value="<?= esc($year) ?>">
                                            <span class="filter-name-year">
                                                <?= esc($year) ?>
                                            </span>
                                        </label>
                                    </li>
                                <?php endforeach; ?>
                            </ul>
                        </div>

                        <!-- Dropdown für Industry mit Suchfeld -->
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle rounded-end" type="button"
                                    id="dropdownIndustryButton" data-bs-toggle="dropdown" aria-expanded="false">
                                Industrie
                            </button>

                            <ul class="dropdown-menu p-2 dropdown-overflow-control" aria-labelledby="dropdownIndustryButton" style="width: 230px;" id="industryDropdownMenu">

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
                                    <input type="checkbox" class="column-toggle" data-column="0" data-table-id="reportTable" checked> ID
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="1" data-table-id="reportTable" checked> Unternehmen
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="2" data-table-id="reportTable" checked> Author
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="3" data-table-id="reportTable" checked> Jahr
                                </label>
                            </li>
                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Bericht..." data-table-id="reportTable" aria-label="Search">

                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body container-fluid" id="table-view">
                <div class="table-responsive">

                    <?php if (session()->getFlashdata('error')): ?>
                        <div class="alert alert-danger alert-dismissible fade show">
                            <?= esc(session()->getFlashdata('error')) ?>
                        </div>
                    <?php endif; ?>

                    <table class="table table-hover table-border table-striped" id="reportTable" data-toggle="table">
                        <thead>
                            <tr>
                                <th data-field="id" data-sortable="true">ID</th>
                                <th data-field="company_name" data-sortable="true">Unternehmen</th>
                                <th data-field="author_name" data-sortable="true">Author</th>
                                <th data-field="reporting_year" data-sortable="true">Jahr</th>
                                <?php if ($canManageContent): ?>
                                    <th class="text-end">Aktionen</th>
                                <?php endif; ?>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($reports)): ?>
                                <?php foreach ($reports as $report): ?>
                                    <tr data-country-id="<?= esc($report['country_id']) ?>"
                                        data-sector-id="<?= esc($report['sector_id']) ?>"
                                        data-industry-id="<?= esc($report['industry_id']) ?>"
                                        data-company-id="<?= esc($report['company_id']) ?>"
                                        data-year-id="<?= esc($report['reporting_year']) ?>"
                                        data-href="<?= site_url('/esg-reports/value/' . $report['report_id']) ?>"
                                        style="cursor: pointer;"
                                    >
                                        <td><?= esc($report['report_id']) ?></td>
                                        <td><?= esc($report['company_name']) ?></td>
                                        <td><?= esc($report['author_name']) ?></td>
                                        <td><?= esc($report['reporting_year']) ?></td>
                                        <?php if ($canManageContent): ?>
                                            <td>
                                                <form action="<?= base_url('esg-reports/delete/' . $report['report_id']) ?>"
                                                      method="post"
                                                      class="d-inline">
                                                    <?= csrf_field() ?>
                                                    <button type="submit"
                                                            class="btn btn-link text-danger p-0"
                                                            onclick="return confirm('Report wirklich löschen?');"
                                                            title="Löschen">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        <?php endif; ?>
                                    </tr>
                                <?php endforeach; ?>
                            <?php else: ?>
                                <tr class="no-data-row">
                                    <td colspan="5">Keine Daten verfügbar.</td>
                                </tr>
                            <?php endif; ?>

                            <tr id="no-search-result-row" style="display:none;">
                                <td colspan="6">Kein Unternehmen gefunden.</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
    <div class="modal fade" id="createReportModal" tabindex="-1" aria-labelledby="dynamicModalTitle" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicModalTitle">Bericht hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form action="<?= site_url('/esg-reports/process') ?>"
                      method="post"
                      enctype="multipart/form-data"
                      id="createReportForm"
                      class="needs-validation"
                      novalidate
                >
                    <?= csrf_field() ?>

                    <div class="modal-body p-0">

                        <div class="d-flex" style="min-height: 350px;">

                            <!-- Content Area -->
                            <div class="flex-grow-1 p-4">
                                <div class="tab-content" id="modalContent">
                                    <!-- Tab 2: Bericht mit Drag & Drop -->
                                    <div class="tab-pane fade show active" id="tab-report" role="tabpanel">

                                        <!-- Unternehmen -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Unternehmen<span class="text-danger">*</span>
                                                <a href="<?= site_url('help') ?>#help-upload"
                                                   class="ms-2 text-muted"
                                                   data-bs-toggle="tooltip"
                                                   data-bs-placement="top"
                                                   title="Hier wählst du das Unternehmen aus, zu dem der Bericht gehört."
                                                   aria-label="Hilfe zum Feld Unternehmen">
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>

                                            <div class="col-sm-9">
                                                <select class="form-select select2-company" name="company_id" required>
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

                                        <!-- Author -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Author<span class="text-danger">*</span>
                                                <a href="<?= site_url('help') ?>#help-upload"
                                                   class="ms-2 text-muted"
                                                   data-bs-toggle="tooltip"
                                                   data-bs-placement="top"
                                                   title="Hier wählst du den Autor bzw. Ersteller des Berichts aus."
                                                   aria-label="Hilfe zum Feld Author">
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>

                                            <div class="col-sm-9">
                                                <select class="form-select select2-author" name="author_id" required>
                                                    <option value="" disabled <?= old('author_id') ? '' : 'selected' ?>>Author auswählen</option>

                                                    <?php if (!empty($authors)): ?>
                                                        <?php foreach ($authors as $author): ?>
                                                            <option value="<?= esc($author['id']) ?>" <?= old('author_id') == $author['id'] ? 'selected' : '' ?>>
                                                                <?= esc($author['name']) ?>
                                                            </option>
                                                        <?php endforeach; ?>
                                                    <?php else: ?>
                                                        <option value="" disabled>Keine Autoren vorhanden</option>
                                                    <?php endif; ?>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- JAHR -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Jahr<span class="text-danger">*</span>
                                                <a href="<?= site_url('help') ?>#help-upload"
                                                   class="ms-2 text-muted"
                                                   data-bs-toggle="tooltip"
                                                   data-bs-placement="top"
                                                   title="Hier wählst du das Berichtsjahr aus."
                                                   aria-label="Hilfe zum Feld Jahr">
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>

                                            <div class="col-sm-9">
                                                <select class="form-select" name="year" required>
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
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                ESRS-Standard<span class="text-danger">*</span>
                                                <a href="<?= site_url('help') ?>#help-upload"
                                                   class="ms-2 text-muted"
                                                   data-bs-toggle="tooltip"
                                                   data-bs-placement="top"
                                                   title="Hier wählst du den ESRS-Standard aus, nach dem der Bericht ausgewertet wird."
                                                   aria-label="Hilfe zum Feld ESRS-Standard">
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>


                                            <div class="col-sm-9">
                                                <select class="form-select select2-standard" name="standard_id" id="standardSelect" required>
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
                                            <!-- ESRS-Requirement -->

                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                ESRS-Anforderung<span class="text-danger">*</span>
                                                <a href="<?= site_url('help') ?>#help-upload"
                                                   class="ms-2 text-muted"
                                                   data-bs-toggle="tooltip"
                                                   data-bs-placement="top"
                                                   title="Hier wählst du eine konkrete ESRS-Anforderung oder alle Anforderungen des Standards aus."
                                                   aria-label="Hilfe zum Feld ESRS-Anforderung">
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>

                                            <div class="col-sm-9">

                                                <div id="select-all-requirements" class="form-check mb-2 d-none">
                                                    <input class="form-check-input" type="checkbox" id="allRequirementsCheck">
                                                    <label class="form-check-label" for="allRequirementsCheck">
                                                        Alle Anforderungen des gewählten Standards auswählen
                                                    </label>
                                                </div>

                                                <select class="form-select select2-requirement" id="requirementSelect" required>
                                                    <option value="" disabled <?= old('requirement_id') ? '' : 'selected' ?>>ESRS-Anforderung auswählen</option>

                                                    <?php if (!empty($requirements)): ?>
                                                        <?php foreach ($requirements as $requirement): ?>
                                                            <option value="<?= esc($requirement['id']) ?>" data-standard-id="<?= esc($requirement['standard_id']) ?>" <?= old('requirement_id') == $requirement['id'] ? 'selected' : '' ?>>
                                                                <?= esc($requirement['code']) ?>
                                                            </option>
                                                        <?php endforeach; ?>
                                                    <?php else: ?>
                                                        <option value="" disabled>Keine ESRS-Anforderung Vorhanden</option>
                                                    <?php endif; ?>
                                                </select>

                                                <input type="hidden" name="requirement_id" id="requirementHidden" value="">

                                            </div>
                                        </div>

                                        <!-- Relevante Seiten -->
                                        <input type="hidden" name="relevantPagesCheck" id="relevantPagesEnabled" value="0">

                                        <div class="mb-3 row align-items-start">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Relevante Seiten
                                                <a href="<?= site_url('help') ?>#help-upload"
                                                   class="ms-2 text-muted"
                                                   data-bs-toggle="tooltip"
                                                   data-bs-placement="top"
                                                   title="Optional: Hier kannst du Seitenbereiche angeben, die besonders relevant für die Analyse sind."
                                                   aria-label="Hilfe zum Feld Relevante Seiten">
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>


                                            <div class="col-sm-9">
                                                <div class="form-check mb-2">
                                                    <input class="form-check-input" type="checkbox" id="relevantPagesCheck" onchange="document.getElementById('relevantPagesEnabled').value = this.checked ? '1' : '0';">
                                                    <label class="form-check-label" for="relevantPagesCheck">
                                                        Relevante Seiten angeben
                                                    </label>
                                                </div>

                                                <div id="relevantPagesContainer" class="d-none">
                                                    <div class="range-row d-flex gap-2 mb-2">
                                                        <input type="number" min="1" class="form-control" name="relevant_pages[0][start]" placeholder="Start">
                                                        <input type="number" min="1" class="form-control" name="relevant_pages[0][end]" placeholder="Ende">
                                                    </div>

                                                    <button type="button" class="btn btn-sm btn-outline-secondary" id="addRangeBtn">
                                                        + Bereich hinzufügen
                                                    </button>
                                                </div>
                                                <div id="relevantPagesError" class="text-danger small d-none">
                                                    Bitte gib mindestens einen gültigen Seitenbereich an.
                                                </div>
                                            </div>
                                        </div>


                                        <!-- Drag and Drop Zone -->
                                        <div id="pdf-drop-zone" class="pdf-drop-zone">
                                            <!-- verstecktes File-Input -->
                                            <input id="pdf-input" type="file" name="report"
                                                   accept="application/pdf,.pdf"
                                                   hidden
                                                   required
                                            >

                                            <button type="button" class="btn btn-primary" id="pdf-browse-btn">
                                                PDF auswählen
                                            </button>

                                            <div class="mt-2 text-grey">
                                                oder<br>
                                                <strong>drag a PDF</strong>
                                            </div>

                                            <div id="pdf-file-list" class="mt-3 text-grey" style="font-size:.9rem;"></div>
                                        </div>

                                        <div class="invalid-feedback d-block" id="pdf-error">
                                            Bitte eine PDF-Datei auswählen.
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
<?php endif; ?>

<script>
    document.addEventListener("click", function (e) {
        const row = e.target.closest("#reportTable tbody tr[data-href]");
        if (!row) return;

        // Verhindert Weiterleitung wenn auf Delete-Button geklickt wird
        if (e.target.closest("button, a, form")) return;

        window.location.href = row.dataset.href;
    });

    document.addEventListener('DOMContentLoaded', function () {
        const standardSelect    = document.getElementById('standardSelect');
        const requirementSelect = document.getElementById('requirementSelect');

        console.log('standardSelect:', standardSelect);
        console.log('requirementSelect:', requirementSelect);
        console.log('Alle IDs im Dokument:', Array.from(document.querySelectorAll('[id]')).map(el => el.id));
    });


</script>

