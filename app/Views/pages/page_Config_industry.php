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

                    <div class="card">
                        <div class="card-body container-fluid">
                            <div class="d-flex justify-content-between mb-3">
                                <!-- Left: "Neu" Button -->

                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createIndustryModal">
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
                                                <input type="checkbox" class="column-toggle" data-column="0" data-table-id="industryTable" checked> ID
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="1" data-table-id="industryTable" checked> Sektor_ID
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="2" data-table-id="industryTable" checked> Name
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="3" data-table-id="industryTable" checked> Beschreibung
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="4" data-table-id="industryTable" checked> Zeitstempel
                                            </label>
                                        </li>
                                    </ul>

                                    <input id="table-search" class="form-control w-75" type="search" placeholder="Industrie" data-table-id="industryTable" aria-label="Search">

                                </div>
                            </div>
                        </div>


                        <!-- Tabellenansicht -->
                        <div class="card-body container-fluid" id="table-view">
                            <div class="table-responsive">
                                <table class="table table-hover table-border table-striped" id="industryTable" data-toggle="table">
                                    <thead>
                                    <tr>
                                        <th data-field="id" data-sortable="true">ID</th>
                                        <th data-field="sector_id" data-sortable="true">SeKtor_ID</th>
                                        <th data-field="name" data-sortable="true">Name</th>
                                        <th data-field="description" data-sortable="true">Beschreibung</th>
                                        <th data-field="timestamp" data-sortable="true">Timestamp</th>
                                        <th class="text-end">Aktionen</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php if (!empty($industries)): ?>
                                        <?php foreach ($industries as $industry): ?>
                                            <tr>
                                                <td><?= esc($industry['id']) ?></td>
                                                <td><?= esc($industry['sector_id']) ?></td>
                                                <td><?= esc($industry['name']) ?></td>
                                                <td><?= esc($industry['description']) ?></td>
                                                <td><?= esc($industry['timestamp']) ?></td>
                                                <td class="text-end">

                                                    <!-- EDIT -->
                                                    <a href="#"
                                                       class="text-secondary me-2 edit-btn"
                                                       title="Bearbeiten"
                                                       data-bs-toggle="modal"
                                                       data-bs-target="#createIndustryModal"

                                                       data-id="<?= $industry['id'] ?>"
                                                       data-sector_id="<?= $industry['sector_id'] ?>"
                                                       data-name="<?= esc($industry['name']) ?>"
                                                       data-description="<?= esc($industry['description']) ?>"
                                                    >
                                                        <i class="fa-solid fa-pen-to-square"></i>
                                                    </a>

                                                    <!-- DELETE -->
                                                    <form action="<?= base_url('config/industry/delete/' . $industry['id']) ?>"
                                                          method="post"
                                                          class="d-inline">
                                                        <?= csrf_field() ?>
                                                        <button type="submit"
                                                                class="btn btn-link text-danger p-0"
                                                                onclick="return confirm('Industrie wirklich löschen?');"
                                                                title="Löschen">
                                                            <i class="fa-solid fa-trash"></i>
                                                        </button>
                                                    </form>

                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <tr class="no-data-row">
                                            <td colspan="4">Keine Daten verfügbar.</td>
                                        </tr>
                                    <?php endif; ?>
                                    </tbody>
                                </table>
                            </div>
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

<!-- Modal: Create Industry -->
<?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
    <div class="modal fade config-modal" id="createIndustryModal" tabindex="-1" aria-labelledby="createIndustryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicModalTitle">Industrie hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form class="config-form needs-validation"
                      id="industryForm"
                      method="post"
                      action="<?= base_url('config/industry/create') ?>"
                      data-create-url="<?= base_url('config/industry/create') ?>"
                      data-update-url="<?= base_url('config/industry/update') ?>"
                      novalidate
                >
                    <?= csrf_field() ?>

                    <input type="hidden" name="industry_id" id="industry_id">

                    <div class="modal-body p-0">

                        <div class="d-flex" style="min-height: 350px;">
                            <!-- Content Area -->
                            <div class="flex-grow-1 p-4">
                                <div class="tab-content" id="modalContent">

                                    <!-- Tab 1 -->
                                    <div class="tab-pane fade show active" id="tab-industry" role="tabpanel">

                                        <!-- SECTOR -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Sektor<span class="text-danger">*</span>
                                                <a
                                                        href="<?= site_url('help') ?>#help-sector"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Jedem Industriezweig muss ein Sektor zugeordnet werden."
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>
                                            <div class="col-sm-9">
                                                <select
                                                        name="sector_id"
                                                        class="form-select <?= isset($errors['sector_id']) ? 'is-invalid' : '' ?>"
                                                        required
                                                >
                                                    <option value="">Bitte Sektor auswählen</option>

                                                    <?php foreach ($sectors as $sector): ?>
                                                        <option
                                                                value="<?= esc($sector['id']) ?>"
                                                                <?= old('sector_id') == $sector['id'] ? 'selected' : '' ?>
                                                        >
                                                            <?= esc($sector['name']) ?>
                                                        </option>
                                                    <?php endforeach; ?>

                                                </select>

                                                <div class="invalid-feedback">
                                                    <?= $errors['sector_id'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>



                                        <!-- Industry NAME -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Name<span class="text-danger">*</span>
                                                <a
                                                        href="<?= site_url('help') ?>#help-industry"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Name des Industrie."
                                                        aria-label="Hilfe zum Feld Name"
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>
                                            <div class="col-sm-9">
                                                <input
                                                        type="text"
                                                        class="form-control <?= isset($errors['name']) ? 'is-invalid' : '' ?>"
                                                        name="name"
                                                        id="industry_name"
                                                        value="<?= esc(old('name') ?? '') ?>"
                                                        placeholder="Industrie Namen eingeben"
                                                        required
                                                >

                                                <div class="invalid-feedback">
                                                    <?= $errors['name'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- DESCRIPTION -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                                Beschreibung
                                                <a
                                                        href="<?= site_url('help') ?>#help-industry"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Hier kann der Sektor kurz beschrieben werden."
                                                        aria-label="Hilfe zum Feld Beschreibung"
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" name="description" rows="3" placeholder="Kurze Beschreibung des Sektors eingeben"><?= esc(old('description') ?? '') ?></textarea>
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
            data-open="<?= session('openIndustryModal') ? '1' : '0' ?>"
    ></div>

<?php endif; ?>