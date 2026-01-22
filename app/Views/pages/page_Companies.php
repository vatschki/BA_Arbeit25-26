<?php
$canManageContent = auth()->loggedIn() && auth()->user()->can('content.manage');
$errors = session('errors') ?? [];
?>
<div id="main-content" class="container-card">
    <div class="container">
        <div class="card">
            <div class="card-body">
                <div class="d-flex justify-content-between mb-3">
                    <!-- Left: "Neu" Button -->

                    <?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createCompanyModal">
                            <i class="fas fa-plus-circle"></i> Neu
                        </button>
                    <?php endif; ?>

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
                                    <input type="checkbox" class="column-toggle" data-column="0" data-table-id="companiesTable" checked> ID
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="1" data-table-id="companiesTable" checked> Unternehmen
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="2" data-table-id="companiesTable" checked> Land
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="3" data-table-id="companiesTable" checked> Sektor
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="4" data-table-id="companiesTable" checked> Industrie
                                </label>
                            </li>
                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Firma..." data-table-id="companiesTable" aria-label="Search">

                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body" id="table-view">
                <div class="table-responsive">
                    <table class="table table-hover table-border table-striped" id="companiesTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="id" data-sortable="true">ID</th>
                            <th data-field="company" data-sortable="true">Unternehmen</th>
                            <th data-field="country" data-sortable="true">Land</th>
                            <th data-field="sector" data-sortable="true">Sektor</th>
                            <th data-field="industry" data-sortable="true">Industrie</th>
                            <?php if ($canManageContent): ?>
                                <th class="text-end">Aktionen</th>
                            <?php endif; ?>
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
                                        <td>
                                            <a href="<?= site_url('esg-reports/company/' . $company['id']) ?>">
                                                <?= esc($company['name']) ?>
                                            </a>
                                        </td>
                                        <td><?= esc($company['country_name_de']) ?></td>
                                        <td><?= esc($company['sector_name']) ?></td>
                                        <td><?= esc($company['industry_name']) ?></td>
                                        <?php if ($canManageContent): ?>
                                            <td class="text-end">
                                                <a href="#"
                                                   class="text-secondary me-2 edit-company-btn"
                                                   title="Bearbeiten"
                                                   data-bs-toggle="modal"
                                                   data-bs-target="#createCompanyModal"

                                                   data-id="<?= $company['id'] ?>"
                                                   data-name="<?= esc($company['name']) ?>"
                                                   data-country="<?= $company['country_id'] ?>"
                                                   data-industry="<?= $company['industry_id'] ?>"
                                                   data-description="<?= esc($company['description']) ?>"
                                                >
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>

                                                <form action="<?= base_url('companies/delete/' . $company['id']) ?>"
                                                      method="post"
                                                      class="d-inline">
                                                    <?= csrf_field() ?>
                                                    <button type="submit"
                                                            class="btn btn-link text-danger p-0"
                                                            onclick="return confirm('Unternehmen wirklich löschen?');"
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
    <div class="modal fade" id="createCompanyModal" tabindex="-1" aria-labelledby="createCompanyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicModalTitle">Unternehmen hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form id="companyForm" action="<?= base_url('companies/create') ?>" method="post" data-create-url="<?= base_url('companies/create') ?>" data-update-url="<?= base_url('companies/update') ?>">
                    <input type="hidden" name="company_id" id="company_id">

                    <div class="modal-body p-0">

                        <div class="d-flex" style="min-height: 350px;">
                            <!-- Content Area -->
                            <div class="flex-grow-1 p-4">
                                <div class="tab-content" id="modalContent">

                                    <!-- Tab 1 -->
                                    <div class="tab-pane fade show active" id="tab-company" role="tabpanel">

                                        <!-- FIRMA NAME -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Firma<span class="text-danger">*</span>
                                                <a
                                                        href="<?= site_url('help') ?>#help-company"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Hier gibst du den offiziellen Namen deines Unternehmens an."
                                                        aria-label="Hilfe zum Feld Firma"
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>
                                            <div class="col-sm-9">
                                                <input
                                                        type="text"
                                                        class="form-control <?= isset($errors['company_name']) ? 'is-invalid' : '' ?>"
                                                        name="company_name"
                                                        value="<?= esc(old('company_name') ?? '') ?>"
                                                        placeholder="Firma eingeben"
                                                >

                                                <div class="invalid-feedback">
                                                    <?= $errors['company_name'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- LAND -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center ">
                                                Land<span class="text-danger">*</span>
                                                <a
                                                        href="<?= site_url('help') ?>#help-company"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Hier wählst du das Land aus."
                                                        aria-label="Hilfe zum Feld Land"
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>

                                            <div class="col-sm-9">
                                                <select class="form-select select2-country <?= isset($errors['country_id']) ? 'is-invalid' : '' ?>" name="country_id">
                                                    <option value="" disabled <?= old('country_id') ? '' : 'selected' ?>>
                                                        Land auswählen
                                                    </option>

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
                                                <div class="invalid-feedback">
                                                    <?= $errors['country_id'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- INDUSTRIE -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Industrie<span class="text-danger">*</span>
                                                <a
                                                        href="<?= site_url('help') ?>#help-company"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Hier wählst du die zugehörige Industrie aus."
                                                        aria-label="Hilfe zum Feld Industrie"
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>

                                            <div class="col-sm-9">
                                                <select class="form-select select2-industry <?= isset($errors['industry_id']) ? 'is-invalid' : '' ?>" name="industry_id" id="industry_id">
                                                    <option value="" disabled <?= old('industry_id') ? '' : 'selected' ?>>
                                                        Industrie auswählen
                                                    </option>

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
                                                <div class="invalid-feedback">
                                                    <?= $errors['industry_id'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- DESCRIPTION -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                                Beschreibung
                                                <a
                                                        href="<?= site_url('help') ?>#help-company"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Hier kann das Unternehmen kurz beschrieben werden."
                                                        aria-label="Hilfe zum Feld Beschreibung"
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" name="description" rows="3" placeholder="Kurze Beschreibung des Unternehmens eingeben"><?= esc(old('description') ?? '') ?></textarea>

                                            </div>
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
    <div
            id="company-modal-trigger"
            data-open="<?= session('openCompanyModal') ? '1' : '0' ?>"
    ></div>

<?php endif; ?>


