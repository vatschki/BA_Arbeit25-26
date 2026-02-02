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

                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createAuthorModal">
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
                                                <input type="checkbox" class="column-toggle" data-column="0" data-table-id="authorTable" checked> ID
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="1" data-table-id="authorTable" checked> Name
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="2" data-table-id="authorTable" checked> Beschreibung
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="3" data-table-id="authorTable" checked> Typ
                                            </label>
                                        </li>
                                        <li>
                                            <label class="dropdown-item">
                                                <input type="checkbox" class="column-toggle" data-column="4" data-table-id="authorTable" checked> Zeitstempel
                                            </label>
                                        </li>
                                    </ul>

                                    <input id="table-search" class="form-control w-75" type="search" placeholder="Autor" data-table-id="authorTable" aria-label="Search">

                                </div>
                            </div>
                        </div>


                        <!-- Tabellenansicht -->
                        <div class="card-body container-fluid" id="table-view">
                            <div class="table-responsive">
                                <table class="table table-hover table-border table-striped" id="authorTable" data-toggle="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Beschreibung</th>
                                            <th>Typ</th>
                                            <th>Zeitstempel</th>
                                            <th class="text-end">Aktionen</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <?php if (!empty($authors)): ?>
                                        <?php foreach ($authors as $author): ?>
                                            <tr>
                                                <td><?= esc($author['id']) ?></td>
                                                <td><?= esc($author['name']) ?></td>
                                                <td><?= esc($author['description']) ?></td>
                                                <td><?= esc($author['type']) ?></td>
                                                <td><?= esc($author['timestamp']) ?></td>
                                                <td class="text-end">

                                                    <!-- EDIT -->
                                                    <a href="#"
                                                       class="text-secondary me-2 edit-btn"
                                                       title="Bearbeiten"
                                                       data-bs-toggle="modal"
                                                       data-bs-target="#createAuthorModal"

                                                       data-id="<?= $author['id'] ?>"
                                                       data-name="<?= esc($author['name']) ?>"
                                                       data-description="<?= esc($author['description']) ?>"
                                                       data-type="<?= esc($author['type']) ?>"
                                                    >
                                                        <i class="fa-solid fa-pen-to-square"></i>
                                                    </a>

                                                    <!-- DELETE -->
                                                    <form action="<?= base_url('config/author/delete/' . $author['id']) ?>"
                                                          method="post"
                                                          class="d-inline">
                                                        <?= csrf_field() ?>
                                                        <button type="submit"
                                                                class="btn btn-link text-danger p-0"
                                                                onclick="return confirm('Autor wirklich löschen?');"
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
                </div>
            </main>
        </div>

        <div class="config-page__footer">
            <span class="config-page__footer-spacer"></span>
        </div>

    </div>
</div>


<?php if (auth()->loggedIn() && auth()->user()->can('content.manage')): ?>
    <div class="modal fade config-modal" id="createAuthorModal" tabindex="-1" aria-labelledby="createAuthorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicAuthorModalTitle">Autor hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form class="config-form needs-validation"
                      id="countryForm"
                      method="post"
                      action="<?= base_url('config/author/create') ?>"
                      data-create-url="<?= base_url('config/author/create') ?>"
                      data-update-url="<?= base_url('config/author/update') ?>"
                      novalidate
                >

                    <?= csrf_field() ?>

                    <input type="hidden" name="author_id" id="author_id">

                    <div class="modal-body p-0">
                        <div class="d-flex" style="min-height: 350px;">
                            <div class="flex-grow-1 p-4">

                                <!-- NAME -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label d-flex align-items-center">
                                        Name
                                        <a
                                                href="<?= site_url('help') ?>#help-author"
                                                class="ms-2 text-muted"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="top"
                                                title="Name des Autors."
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
                                                value="<?= esc(old('name') ?? '') ?>"
                                                placeholder="Autor Namen eingeben"
                                                required
                                        >

                                        <div class="invalid-feedback">
                                            <?= $errors['name'] ?? '' ?>
                                        </div>
                                    </div>
                                </div>

                                <!-- DESCRIPTION -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">
                                        Beschreibung
                                        <a
                                                href="<?= site_url('help') ?>#help-author"
                                                class="ms-2 text-muted"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="top"
                                                title="Hier kann der Autor kurz beschrieben werden."
                                                aria-label="Hilfe zum Feld Autor Beschreibung"
                                        >
                                            <i class="fa-regular fa-circle-question"></i>
                                        </a>
                                    </label>
                                    <div class="col-sm-9">
                                        <textarea class="form-control" name="description" rows="3" placeholder="Kurze Beschreibung des Autors eingeben"><?= esc(old('description') ?? '') ?></textarea>
                                    </div>
                                </div>

                                <!-- Type-->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label d-flex align-items-center">
                                        Type
                                        <a
                                                href="<?= site_url('help') ?>#help-author"
                                                class="ms-2 text-muted"
                                                data-bs-toggle="tooltip"
                                                data-bs-placement="top"
                                                title="Type des Autors."
                                                aria-label="Hilfe zum Feld Type"
                                        >
                                            <i class="fa-regular fa-circle-question"></i>
                                        </a>
                                    </label>
                                    <div class="col-sm-9">
                                        <input
                                                type="text"
                                                class="form-control <?= isset($errors['type']) ? 'is-invalid' : '' ?>"
                                                name="type"
                                                value="<?= esc(old('type') ?? '') ?>"
                                                placeholder="Type Namen eingeben"
                                        >
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn abbrechen_button" data-bs-dismiss="modal">Abbrechen</button>
                        <button type="submit" id="countrySaveBtn" class="btn btn-success SaveBtn">Speichern</button>
                    </div>

                </form>

            </div>
        </div>
    </div>

    <div id="country-modal-trigger"
         data-open="<?= session('openAuthorModal') ? '1' : '0' ?>">
    </div>
<?php endif; ?>
