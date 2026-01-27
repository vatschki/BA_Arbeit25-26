<div id="main-content" class="container-card p-0">
    <div class="config-page">

        <div class="config-page__header">
            <h5 class="config-page__title mb-0">Einstellungen</h5>
        </div>

        <div class="config-page__body">
            <?= view('pages/partials/config_sidebar_nav') ?>

            <main class="config-content">
                    <div class="card">

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

                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createRequirementModal">
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
                                                <input type="checkbox" class="column-toggle" data-column="0" data-table-id="requirementsTable" checked> ID
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="1" data-table-id="requirementsTable" checked> Standard ID
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="2" data-table-id="requirementsTable" checked> Disclosure Requirement
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="3" data-table-id="requirementsTable" checked> Paragraph
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="5" data-table-id="requirementsTable" checked> Titel
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="6" data-table-id="requirementsTable" checked> Data Type
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="7" data-table-id="requirementsTable" checked> Conditional / Alternative Disclosure
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="8" data-table-id="requirementsTable" checked> Timestamp
                                            </label>
                                        </li>
                                    </ul>

                                    <input id="table-search" class="form-control w-75" type="search" placeholder="Anforderung" data-table-id="requirementsTable" aria-label="Search">

                                </div>
                            </div>
                        </div>


                        <!-- Tabellenansicht -->
                        <div class="card-body container-fluid" id="table-view">
                            <div class="table-scroll">
                                <table class="table table-hover table-border table-striped" id="requirementsTable" data-toggle="table">
                                    <thead>
                                    <tr>
                                        <th data-field="id" data-sortable="true">ID</th>
                                        <th data-field="standard_id" data-sortable="true">Standard ID</th>
                                        <th data-field="disclosure_requirement" data-sortable="true">Disclosure Requirement</th>
                                        <th data-field="paragraph" data-sortable="true">Paragraph</th>
                                        <th data-field="title" data-sortable="true">Titel</th>
                                        <th data-field="data_type" data-sortable="true">Data Type</th>
                                        <th data-field="conditional_alternative_disclosure_requirement" data-sortable="true">
                                            Conditional / Alternative Disclosure
                                        </th>
                                        <th data-field="timestamp" data-sortable="true">Timestamp</th>
                                        <th class="text-end">Aktionen</th>
                                    </tr>

                                    </thead>
                                    <tbody>
                                        <?php if (!empty($requirements)): ?>
                                            <?php foreach ($requirements as $requirement): ?>
                                                <tr>
                                                    <td><?= esc($requirement['id']) ?></td>
                                                    <td><?= esc($requirement['standard_id']) ?></td>
                                                    <td><?= esc($requirement['disclosure_requirement']) ?></td>
                                                    <td><?= esc($requirement['paragraph']) ?></td>
                                                    <td><?= esc($requirement['title']) ?></td>
                                                    <td><?= esc($requirement['data_type']) ?></td>
                                                    <td><?= esc($requirement['conditional_alternative_disclosure_requirement']) ?></td>
                                                    <td><?= esc($requirement['timestamp']) ?></td>
                                                    <td class="text-end">

                                                        <!-- EDIT -->
                                                        <a href="#"
                                                           class="text-secondary me-2 edit-btn"
                                                           title="Bearbeiten"
                                                           data-bs-toggle="modal"
                                                           data-bs-target="#createRequirementModal"

                                                           data-id="<?= $requirement['id'] ?>"
                                                           data-standard_id="<?= esc($requirement['standard_id']) ?>"
                                                           data-disclosure_requirement="<?= esc($requirement['disclosure_requirement']) ?>"
                                                           data-paragraph="<?= esc($requirement['paragraph']) ?>"
                                                           data-title="<?= esc($requirement['title']) ?>"
                                                           data-data_type="<?= esc($requirement['data_type']) ?>"
                                                           data-conditional_alternative_disclosure_requirement="<?= esc($requirement['conditional_alternative_disclosure_requirement']) ?>"
                                                        >
                                                            <i class="fa-solid fa-pen-to-square"></i>
                                                        </a>

                                                        <!-- DELETE -->
                                                        <form action="<?= base_url('config/requirement/delete/' . $requirement['id']) ?>"
                                                              method="post"
                                                              class="d-inline">
                                                            <?= csrf_field() ?>
                                                            <button type="submit"
                                                                    class="btn btn-link text-danger p-0"
                                                                    onclick="return confirm('Anforderung wirklich löschen?');"
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

<!-- Modal: Create Requirement -->
<?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
    <div class="modal fade config-modal" id="createRequirementModal" tabindex="-1" aria-labelledby="createRequirementModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicModalTitle">Anforderung hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form class="config-form"
                      id="standardForm"
                      method="post"
                      action="<?= base_url('config/requirement/create') ?>"
                      data-create-url="<?= base_url('config/requirement/create') ?>"
                      data-update-url="<?= base_url('config/requirement/update') ?>"
                >

                    <?= csrf_field() ?>

                    <input type="hidden" name="requirement_id" id="requirement_id">

                    <div class="modal-body p-0">

                        <div class="d-flex" style="min-height: 350px;">
                            <!-- Content Area -->
                            <div class="flex-grow-1 p-4">
                                <div class="tab-content" id="modalContent">

                                    <!-- Tab 1 -->
                                    <div class="tab-pane fade show active" id="tab-standard" role="tabpanel">

                                        <!-- STANDARD -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label d-flex align-items-center">
                                                Standard<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-9">
                                                <select
                                                        name="standard_id"
                                                        class="form-select <?= isset($errors['standard_id']) ? 'is-invalid' : '' ?>"
                                                        required
                                                >
                                                    <option value="">Bitte Standard auswählen</option>

                                                    <?php foreach ($standards as $standard): ?>
                                                        <option
                                                                value="<?= esc($standard['id']) ?>"
                                                                <?= old('standard_id') == $standard['id'] ? 'selected' : '' ?>
                                                        >
                                                            <?= esc($standard['code']) ?> – <?= esc($standard['name']) ?>
                                                        </option>
                                                    <?php endforeach; ?>
                                                </select>

                                                <div class="invalid-feedback">
                                                    <?= $errors['standard_id'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Code -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label">
                                                Code<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-9">
                                                <input type="text"
                                                       name="code"
                                                       class="form-control <?= isset($errors['code']) ? 'is-invalid' : '' ?>"
                                                       value="<?= esc(old('code') ?? '') ?>"
                                                       placeholder="z. B. E4.EBM-3_01"
                                                       required>
                                                <div class="invalid-feedback">
                                                    <?= $errors['code'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- DISCLOSURE REQUIREMENT -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label">
                                                Disclosure Requirement<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-9">
                                                <input type="text"
                                                       name="disclosure_requirement"
                                                       class="form-control <?= isset($errors['disclosure_requirement']) ? 'is-invalid' : '' ?>"
                                                       value="<?= esc(old('disclosure_requirement') ?? '') ?>"
                                                       placeholder="z. B. DR 1"
                                                       required>
                                                <div class="invalid-feedback">
                                                    <?= $errors['disclosure_requirement'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- PARAGRAPH -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label">
                                                Paragraph<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-9">
                                                <input type="text"
                                                       name="paragraph"
                                                       class="form-control <?= isset($errors['paragraph']) ? 'is-invalid' : '' ?>"
                                                       value="<?= esc(old('paragraph') ?? '') ?>"
                                                       placeholder="z. B. §12"
                                                       required>
                                                <div class="invalid-feedback">
                                                    <?= $errors['paragraph'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- TITLE -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label">
                                                Titel<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-9">
                                                <input type="text"
                                                       name="title"
                                                       class="form-control <?= isset($errors['title']) ? 'is-invalid' : '' ?>"
                                                       value="<?= esc(old('title') ?? '') ?>"
                                                       placeholder="Titel der Anforderung"
                                                       required>
                                                <div class="invalid-feedback">
                                                    <?= $errors['title'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- DATA TYPE -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label">
                                                Datentyp<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-sm-9">
                                                <select name="data_type"
                                                        class="form-select <?= isset($errors['data_type']) ? 'is-invalid' : '' ?>"
                                                        required>
                                                    <option value="">Bitte Datentyp wählen</option>
                                                    <option value="text" <?= old('data_type') == 'area' ? 'selected' : '' ?>>area</option>
                                                    <option value="number" <?= old('data_type') == 'integer' ? 'selected' : '' ?>>integer</option>
                                                    <option value="boolean" <?= old('data_type') == 'mdr-a' ? 'selected' : '' ?>>mdr-a</option>
                                                    <option value="date" <?= old('data_type') == 'mdr-p' ? 'selected' : '' ?>>mdr-p</option>
                                                    <option value="date" <?= old('data_type') == 'mdr-t' ? 'selected' : '' ?>>mdr-t</option>
                                                    <option value="date" <?= old('data_type') == 'monetary' ? 'selected' : '' ?>>monetary</option>
                                                    <option value="date" <?= old('data_type') == 'narrative' ? 'selected' : '' ?>>narrative</option>
                                                    <option value="date" <?= old('data_type') == 'semi-narrative' ? 'selected' : '' ?>>semi-narrative</option>
                                                    <option value="date" <?= old('data_type') == 'narrative/monetary' ? 'selected' : '' ?>>narrative/monetary</option>
                                                </select>

                                                <div class="invalid-feedback">
                                                    <?= $errors['data_type'] ?? '' ?>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- CONDITIONAL ALTERNATIVE -->
                                        <div class="mb-3 row align-items-center">
                                            <label class="col-sm-3 col-form-label">
                                                Alternative Disclosure (optional)
                                            </label>
                                            <div class="col-sm-9">
                                                <textarea name="conditional_alternative_disclosure_requirement" class="form-control" rows="3" placeholder="Alternative Anforderung, falls zutreffend"><?= esc(old('conditional_alternative_disclosure_requirement') ?? '') ?></textarea>
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
            data-open="<?= session('openStandardModal') ? '1' : '0' ?>"
    ></div>

<?php endif; ?>
