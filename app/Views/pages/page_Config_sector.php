<?php
$canManageContent = auth()->loggedIn() && auth()->user()->can('content.manage');
$errors = session('errors') ?? [];
?>
<div id="main-content" class="container-card p-0">
    <div class="config-page">

        <div class="config-page__header">
            <h5 class="config-page__title mb-0">Einstellungen</h5>
        </div>

        <div class="config-page__body">
            <?= view('pages/partials/config_sidebar_nav') ?>

            <main class="config-content">
                <div class="container">
                    <div class="card">
                        <div class="card-body container-fluid">
                            <div class="d-flex justify-content-between mb-3">
                                <!-- Left: "Neu" Button -->

                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createSectorModal">
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
                                                <input type="checkbox" class="column-toggle" data-column="0" data-table-id="sectorTable" checked> ID
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="1" data-table-id="sectorTable" checked> Name
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="2" data-table-id="sectorTable" checked> Beschreibung
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="3" data-table-id="sectorTable" checked> Zeitstempel
                                            </label>
                                        </li>
                                    </ul>

                                    <input id="table-search" class="form-control w-75" type="search" placeholder="Sektor" data-table-id="sectorTable" aria-label="Search">

                                </div>
                            </div>
                        </div>


                        <!-- Tabellenansicht -->
                        <div class="card-body container-fluid" id="table-view">
                            <div class="table-responsive">
                                <table class="table table-hover table-border table-striped" id="sectorTable" data-toggle="table">
                                    <thead>
                                    <tr>
                                        <th data-field="id" data-sortable="true">ID</th>
                                        <th data-field="name" data-sortable="true">Name</th>
                                        <th data-field="description" data-sortable="true">Description</th>
                                        <th data-field="timestamp" data-sortable="true">Timestamp</th>
                                        <th class="text-end">Aktionen</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php if (!empty($sectors)): ?>
                                        <?php foreach ($sectors as $sector): ?>
                                            <tr>
                                                <td><?= esc($sector['id']) ?></td>
                                                <td><?= esc($sector['name']) ?></td>
                                                <td><?= esc($sector['description']) ?></td>
                                                <td><?= esc($sector['timestamp']) ?></td>
                                                <td class="text-end">

                                                    <!-- EDIT -->
                                                    <a href="#"
                                                       class="text-secondary me-2 edit-sector-btn"
                                                       title="Bearbeiten"
                                                       data-bs-toggle="modal"
                                                       data-bs-target="#createSectorModal"

                                                       data-id="<?= $sector['id'] ?>"
                                                       data-name="<?= esc($sector['name']) ?>"
                                                       data-description="<?= esc($sector['description']) ?>"
                                                    >
                                                        <i class="fa-solid fa-pen-to-square"></i>
                                                    </a>

                                                    <!-- DELETE -->
                                                    <form action="<?= base_url('config/sector/delete/' . $sector['id']) ?>"
                                                          method="post"
                                                          class="d-inline">
                                                        <?= csrf_field() ?>
                                                        <button type="submit"
                                                                class="btn btn-link text-danger p-0"
                                                                onclick="return confirm('Sektor wirklich löschen?');"
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

<!-- Modal: Create Sector -->
<?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
    <div class="modal fade" id="createSectorModal" tabindex="-1" aria-labelledby="createSektorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicModalTitle">Sektor hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form id="sectorForm" action="<?= base_url('config/sector/create') ?>" method="post" data-create-url="<?= base_url('config/sector/create') ?>" data-update-url="<?= base_url('config/sector/update') ?>">
                    <input type="hidden" name="sector_id" id="sector_id">

                    <div class="modal-body p-0">

                        <div class="d-flex" style="min-height: 350px;">
                            <!-- Content Area -->
                            <div class="flex-grow-1 p-4">
                                <div class="tab-content" id="modalContent">

                                    <!-- Tab 1 -->
                                    <div class="tab-pane fade show active" id="tab-sector" role="tabpanel">

                                        <!-- SECTOR NAME -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Name<span class="text-danger">*</span>
                                                <a
                                                        href="<?= site_url('help') ?>#help-sector"
                                                        class="ms-2 text-muted"
                                                        data-bs-toggle="tooltip"
                                                        data-bs-placement="top"
                                                        title="Name des Sectors."
                                                        aria-label="Hilfe zum Feld Name"
                                                >
                                                    <i class="fa-regular fa-circle-question"></i>
                                                </a>
                                            </label>
                                            <div class="col-sm-9">
                                                <input
                                                        type="text"
                                                        class="form-control <?= isset($errors['sector_name']) ? 'is-invalid' : '' ?>"
                                                        name="sector_name"
                                                        value="<?= esc(old('sector_name') ?? '') ?>"
                                                        placeholder="Sector Namen eingeben"
                                                >

                                                <div class="invalid-feedback">
                                                    <?= $errors['sector_name'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- DESCRIPTION -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center gap-2">
                                                Beschreibung
                                                <a
                                                        href="<?= site_url('help') ?>#help-sector"
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
            data-open="<?= session('openSectorModal') ? '1' : '0' ?>"
    ></div>

<?php endif; ?>
