<div id="main-content" class="container-card p-0">
    <div class="config-page">

        <div class="config-page__header">
            <h5 class="config-page__title mb-0">Einstellungen</h5>
        </div>

        <div class="config-page__body">
            <?= view('pages/partials/config_sidebar_nav') ?>

            <main class="config-content">
                <div class="container">

                    <?php if (session()->getFlashdata('success')): ?>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <?= esc(session()->getFlashdata('success')) ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <?php endif; ?>

                    <?php if (session()->getFlashdata('error')): ?>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <?= esc(session()->getFlashdata('error')) ?>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    <?php endif; ?>

                    <div class="card-body container-fluid">
                        <div class="d-flex justify-content-between mb-3">
                            <!-- Left: "Neu" Button -->

                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createCountryModal">
                                <i class="fas fa-plus-circle"></i> Neu
                            </button>

                            <!-- Right: Button Group mit Search Field -->
                            <div class="d-flex align-items-center">

                                <!-- Spaltenfilter Dropdown (Direkt in der Gruppe) -->
                                <button class="btn btn-secondary dropdown-toggle rounded-end" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-bars"></i>
                                </button>

                                <!-- Dropdown-Menü außerhalb von btn-group -->
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" class="column-toggle" data-column="0" data-table-id="countryTable" checked> ID
                                        </label>
                                    </li>
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" class="column-toggle" data-column="1" data-table-id="countryTable" checked> code
                                        </label>
                                    </li>
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" class="column-toggle" data-column="2" data-table-id="countryTable" checked> Name_de
                                        </label>
                                    </li>
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" class="column-toggle" data-column="3" data-table-id="countryTable" checked> Name_eng
                                        </label>
                                    </li>
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" class="column-toggle" data-column="4" data-table-id="countryTable" checked> Region
                                        </label>
                                    </li>
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" class="column-toggle" data-column="5" data-table-id="countryTable" checked> EU-Mitglied
                                        </label>
                                    </li>
                                    <li>
                                        <label class="dropdown-item">
                                            <input type="checkbox" class="column-toggle" data-column="6" data-table-id="countryTable" checked> Zeitstempel
                                        </label>
                                    </li>
                                </ul>

                                <input id="table-search" class="form-control w-75" type="search" placeholder="Land" data-table-id="countryTable" aria-label="Search">

                            </div>
                        </div>
                    </div>


                    <!-- Tabellenansicht -->
                    <div class="card-body container-fluid" id="table-view">
                        <div class="table-responsive">
                            <table class="table table-hover table-border table-striped" id="countryTable" data-toggle="table">
                                <thead>
                                <tr>
                                    <th data-field="id" data-sortable="true">ID</th>
                                    <th data-field="code" data-sortable="true">Code</th>
                                    <th data-field="name_de" data-sortable="true">Name_de</th>
                                    <th data-field="name_eng" data-sortable="true">Name_eng</th>
                                    <th data-field="region" data-sortable="true">Region</th>
                                    <th data-field="eu_member" data-sortable="true">EU-Mitglied</th>
                                    <th data-field="timestamp" data-sortable="true">Zeitstempel</th>
                                    <th class="text-end">Aktionen</th>
                                </tr>
                                </thead>
                                <tbody>
                                <?php if (!empty($countries)): ?>
                                    <?php foreach ($countries as $country): ?>
                                        <tr>
                                            <td><?= esc($country['id']) ?></td>
                                            <td><?= esc($country['code']) ?></td>
                                            <td><?= esc($country['name_de']) ?></td>
                                            <td><?= esc($country['name_eng']) ?></td>
                                            <td><?= esc($country['region']) ?></td>
                                            <td><?= esc($country['eu_member']) ?></td>
                                            <td><?= esc($country['timestamp']) ?></td>
                                            <td class="text-end">

                                                <!-- EDIT -->
                                                <a href="#"
                                                   class="text-secondary me-2 edit-btn"
                                                   title="Bearbeiten"
                                                   data-bs-toggle="modal"
                                                   data-bs-target="#createCountryModal"

                                                   data-id="<?= $country['id'] ?>"
                                                   data-code="<?= esc($country['code']) ?>"
                                                   data-name_de="<?= esc($country['name_de']) ?>"
                                                   data-name_eng="<?= esc($country['name_eng']) ?>"
                                                   data-region="<?= esc($country['region']) ?>"
                                                   data-eu_member="<?= esc($country['eu_member']) ?>"
                                                >
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </a>

                                                <!-- DELETE -->
                                                <form action="<?= base_url('config/country/delete/' . $country['id']) ?>"
                                                      method="post"
                                                      class="d-inline">
                                                    <?= csrf_field() ?>
                                                    <button type="submit"
                                                            class="btn btn-link text-danger p-0"
                                                            onclick="return confirm('Land wirklich löschen?');"
                                                            title="Löschen">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </form>

                                            </td>

                                        </tr>
                                    <?php endforeach; ?>
                                <?php else: ?>
                                    <tr class="no-data-row">
                                        <td colspan="8">Keine Daten verfügbar.</td>
                                    </tr>
                                <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </main>
        </div>

        <div class="config-page__footer">
            <span class="config-page__footer-spacer"></span>
        </div>

    </div>
</div>


<?php if (auth()->loggedIn() && auth()->user()->can('content.manage')): ?>
    <div class="modal fade config-modal" id="createCountryModal" tabindex="-1" aria-labelledby="createCountryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicCountryModalTitle">Land hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form class="config-form"
                      id="countryForm"
                      method="post"
                      action="<?= base_url('config/country/create') ?>"
                      data-create-url="<?= base_url('config/country/create') ?>"
                      data-update-url="<?= base_url('config/country/update') ?>">

                    <?= csrf_field() ?>

                    <input type="hidden" name="country_id" id="country_id">

                    <div class="modal-body p-0">
                        <div class="d-flex" style="min-height: 350px;">
                            <div class="flex-grow-1 p-4">

                                <!-- CODE -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Code<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text"
                                               class="form-control <?= isset($errors['code']) ? 'is-invalid' : '' ?>"
                                               name="code"
                                               id="country_code"
                                               value="<?= esc(old('code') ?? '') ?>"
                                               placeholder="z.B. DE">
                                        <div class="invalid-feedback"><?= $errors['code'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- NAME DE -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Name (DE)<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text"
                                               class="form-control <?= isset($errors['name_de']) ? 'is-invalid' : '' ?>"
                                               name="name_de"
                                               id="country_name_de"
                                               value="<?= esc(old('name_de') ?? '') ?>"
                                               placeholder="Deutschland">
                                        <div class="invalid-feedback"><?= $errors['name_de'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- NAME ENG -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Name (ENG)<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text"
                                               class="form-control <?= isset($errors['name_eng']) ? 'is-invalid' : '' ?>"
                                               name="name_eng"
                                               id="country_name_eng"
                                               value="<?= esc(old('name_eng') ?? '') ?>"
                                               placeholder="Germany">
                                        <div class="invalid-feedback"><?= $errors['name_eng'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- REGION -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Region<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text"
                                               class="form-control <?= isset($errors['region']) ? 'is-invalid' : '' ?>"
                                               name="region"
                                               id="country_region"
                                               value="<?= esc(old('region') ?? '') ?>"
                                               placeholder="Europa">
                                        <div class="invalid-feedback"><?= $errors['region'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- EU MEMBER -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">EU-Mitglied<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <select class="form-select"
                                                name="eu_member"
                                                id="country_eu_member"
                                                title="EU-Mitglied Ja/Nein"
                                        >
                                            <option value="1">Ja</option>
                                            <option value="0">Nein</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn abbrechen_button" data-bs-dismiss="modal">Abbrechen</button>
                        <button type="submit" id="countrySaveBtn" class="btn btn-success">Speichern</button>
                    </div>

                </form>

            </div>
        </div>
    </div>

    <div id="country-modal-trigger"
         data-open="<?= session('openCountryModal') ? '1' : '0' ?>">
    </div>
<?php endif; ?>