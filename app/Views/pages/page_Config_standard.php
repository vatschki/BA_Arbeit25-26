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

                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createStandardModal">
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
                                                <input type="checkbox" class="column-toggle" data-column="0" data-table-id="standardTable" checked> ID
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="1" data-table-id="standardTable" checked> Code
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="2" data-table-id="standardTable" checked> Name
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="3" data-table-id="standardTable" checked> Beschreibung
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="4" data-table-id="standardTable" checked> Zeitstempel
                                            </label>
                                        </li>
                                    </ul>

                                    <input id="table-search" class="form-control w-75" type="search" placeholder="Standard" data-table-id="standardTable" aria-label="Search">

                                </div>
                            </div>
                        </div>


                        <!-- Tabellenansicht -->
                        <div class="card-body container-fluid" id="table-view">
                            <div class="table-responsive">
                                <table class="table table-hover table-border table-striped" id="standardTable" data-toggle="table">
                                    <thead>
                                        <tr>
                                            <th data-field="id" data-sortable="true">ID</th>
                                            <th data-field="code" data-sortable="true">Code</th>
                                            <th data-field="name" data-sortable="true">Name</th>
                                            <th data-field="description" data-sortable="true">Beschreibung</th>
                                            <th data-field="timestamp" data-sortable="true">Timestamp</th>
                                            <th class="text-end">Aktionen</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <?php if (!empty($standards)): ?>
                                        <?php foreach ($standards as $standard): ?>
                                            <tr>
                                                <td><?= esc($standard['id']) ?></td>
                                                <td><?= esc($standard['code']) ?></td>
                                                <td><?= esc($standard['name']) ?></td>
                                                <td><?= esc($standard['description']) ?></td>
                                                <td><?= esc($standard['timestamp']) ?></td>
                                                <td class="text-end">

                                                    <!-- EDIT -->
                                                    <a href="#"
                                                       class="text-secondary me-2 edit-btn"
                                                       title="Bearbeiten"
                                                       data-bs-toggle="modal"
                                                       data-bs-target="#createStandardModal"

                                                       data-id="<?= $standard['id'] ?>"
                                                       data-code="<?= $standard['code'] ?>"
                                                       data-name="<?= esc($standard['name']) ?>"
                                                       data-description="<?= esc($standard['description']) ?>"
                                                       data-description-eng="<?= esc($standard['description_eng']) ?>"
                                                    >
                                                        <i class="fa-solid fa-pen-to-square"></i>
                                                    </a>

                                                    <!-- DELETE -->
                                                    <form action="<?= base_url('config/standard/delete/' . $standard['id']) ?>"
                                                          method="post"
                                                          class="d-inline">
                                                        <?= csrf_field() ?>
                                                        <button type="submit"
                                                                class="btn btn-link text-danger p-0"
                                                                onclick="return confirm('Standard wirklich löschen?');"
                                                                title="Löschen">
                                                            <i class="fa-solid fa-trash"></i>
                                                        </button>
                                                    </form>

                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php else: ?>
                                        <tr class="no-data-row">
                                            <td colspan="6">Keine Daten verfügbar.</td>
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

<?php if (auth()->loggedIn() && auth()->user()->can('content.manage')): ?>
    <div class="modal fade config-modal" id="createStandardModal" tabindex="-1" aria-labelledby="createStandardModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicModalTitle">Standard hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form class="config-form"
                      id="standardForm"
                      method="post"
                      action="<?= base_url('config/standard/create') ?>"
                      data-create-url="<?= base_url('config/standard/create') ?>"
                      data-update-url="<?= base_url('config/standard/update') ?>">

                    <?= csrf_field() ?>

                    <input type="hidden" name="standard_id" id="standard_id">

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
                                               id="code"
                                               value="<?= esc(old('code') ?? '') ?>"
                                               placeholder="z.B. ISO-123">
                                        <div class="invalid-feedback"><?= $errors['code'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- NAME -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Name<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text"
                                               class="form-control <?= isset($errors['name']) ? 'is-invalid' : '' ?>"
                                               name="name"
                                               id="standard_name"
                                               value="<?= esc(old('name') ?? '') ?>"
                                               placeholder="Standardname">
                                        <div class="invalid-feedback"><?= $errors['name'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- DESCRIPTION -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Beschreibung<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                    <textarea class="form-control" name="description" id="description" rows="3" placeholder="Kurze Beschreibung des Standards auf Deutsch eingeben"><?= esc(old('description') ?? '') ?></textarea>
                                    </div>
                                </div>

                                <!-- DESCRIPTION ENG -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Beschreibung Englisch<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                    <textarea class="form-control" name="description_eng" id="description_eng" rows="3" placeholder="Kurze Beschreibung des Standards auf Englisch eingeben"><?= esc(old('description_eng') ?? '') ?></textarea>
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

    <div id="company-modal-trigger"
         data-open="<?= session('openStandardModal') ? '1' : '0' ?>">
    </div>
<?php endif; ?>
