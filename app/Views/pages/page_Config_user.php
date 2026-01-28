<?php $currentUser = auth()->user(); ?>

<div id="main-content" class="container-card p-0">
    <div class="config-page">

        <div class="config-page__header">
            <h5 class="config-page__title mb-0">User Einstellungen</h5>
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
                            <!-- Eingeloggter Benutzer -->
                            <h6 class="mb-3">
                                Profil: <?= esc($currentUser->username) ?>
                            </h6>

                            <div class="table-responsive">

                                <table class="table table-striped table-hover align-middle">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Rolle</th>
                                        <th>Aktiv</th>
                                        <th>Erstellt</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td><?= esc($currentUser->id) ?></td>
                                        <td><?= esc($currentUser->username) ?></td>
                                        <td><?= esc($currentUser->email) ?></td>
                                        <td><?= esc(implode(', ', $currentUser->getGroups())) ?></td>
                                        <td>
                                            <?= $currentUser->active
                                                    ? '<span class="badge bg-success">Ja</span>'
                                                    : '<span class="badge bg-danger">Nein</span>' ?>
                                        </td>
                                        <td><?= esc($currentUser->created_at) ?></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <?php if (auth()->user()->inGroup('admin')): ?>
                        <div class="card mt-4">
                            <div class="card-body container-fluid">

                                <!-- Alle anderen Benutzer -->
                                <h6 class="mb-3">Alle Benutzer</h6>


                                <div class="d-flex justify-content-between">
                                    <!-- Left: "Neu" Button -->

                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createUserModal">
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
                                                    <input type="checkbox" class="column-toggle" data-column="0" data-table-id="otherUserTable" checked>
                                                    ID
                                                </label>
                                            </li>
                                            <li>
                                                <label class="dropdown-item">
                                                    <input type="checkbox" class="column-toggle" data-column="1" data-table-id="otherUserTable" checked>
                                                    Username
                                                </label>
                                            </li>
                                            <li>
                                                <label class="dropdown-item">
                                                    <input type="checkbox" class="column-toggle" data-column="2" data-table-id="otherUserTable" checked>
                                                    Email
                                                </label>
                                            </li>
                                            <li>
                                                <label class="dropdown-item">
                                                    <input type="checkbox" class="column-toggle" data-column="3" data-table-id="otherUserTable" checked>
                                                    Rolle
                                                </label>
                                            </li>
                                            <li>
                                                <label class="dropdown-item">
                                                    <input type="checkbox" class="column-toggle" data-column="4" data-table-id="otherUserTable" checked>
                                                    Aktiv
                                                </label>
                                            </li>
                                            <li>
                                                <label class="dropdown-item">
                                                    <input type="checkbox" class="column-toggle" data-column="5" data-table-id="otherUserTable" checked>
                                                    Erstellt
                                                </label>
                                            </li>
                                        </ul>

                                        <input id="table-search" class="form-control w-75" type="search" placeholder="User" data-table-id="otherUserTable" aria-label="Search">

                                    </div>
                                </div>
                            </div>

                            <div class="card-body container-fluid" id="table-view">
                                <table class="table table-hover table-border table-striped" id="otherUserTable" data-toggle="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Username</th>
                                            <th>Email</th>
                                            <th>Rolle</th>
                                            <th>Aktiv</th>
                                            <th>Erstellt</th>
                                            <th class="text-end">Aktionen</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (!empty($otherUsers)): ?>
                                            <?php foreach ($otherUsers as $user): ?>
                                                <tr>
                                                    <td><?= esc($user->id) ?></td>
                                                    <td><?= esc($user->username) ?></td>
                                                    <td><?= esc($user->email) ?></td>
                                                    <td><?= esc($user->role) ?></td>
                                                    <td>
                                                        <?= $user->active
                                                                ? '<span class="badge bg-success">Ja</span>'
                                                                : '<span class="badge bg-danger">Nein</span>' ?>
                                                    </td>
                                                    <td><?= esc($user->created_at) ?></td>
                                                    <td class="text-end">

                                                        <!-- RESET -->
                                                        <form method="post"
                                                              action="<?= base_url('config/user/reset/' . $user->id) ?>"
                                                              class="d-inline"
                                                              onsubmit="return confirm('Passwort wirklich zurücksetzen?');">
                                                            <?= csrf_field() ?>
                                                            <button type="submit"
                                                                    class="btn btn-link text-warning p-0 me-2"
                                                                    title="Passwort zurücksetzen">
                                                                <i class="fa-solid fa-key"></i>
                                                            </button>
                                                        </form>

                                                        <!-- DELETE -->
                                                        <?php if ($user->role !== 'admin'): ?>
                                                            <form action="<?= base_url('config/user/delete/' . $user->id) ?>"
                                                                  method="post"
                                                                  class="d-inline">
                                                                <?= csrf_field() ?>
                                                                <button type="submit"
                                                                        class="btn btn-link text-danger p-0"
                                                                        onclick="return confirm('User wirklich löschen?');"
                                                                        title="Löschen">
                                                                    <i class="fa-solid fa-trash"></i>
                                                                </button>
                                                            </form>
                                                        <?php endif; ?>

                                                    </td>


                                                </tr>
                                            <?php endforeach; ?>
                                        <?php else: ?>
                                            <tr class="no-data-row">
                                                <td colspan="7">Keine Daten verfügbar.</td>
                                            </tr>
                                        <?php endif; ?>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>
            </main>
        </div>

        <div class="config-page__footer">
            <span class="config-page__footer-spacer"></span>
        </div>
    </div>
</div>

<!-- Modal zum Erstellen eines neuen Benutzers -->
<?php if (auth()->loggedIn() && auth()->user()->can('users.manage')): ?>
    <div class="modal fade config-modal" id="createUserModal" tabindex="-1" aria-labelledby="createUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="dynamicModalTitle">Nutzer hinzufügen</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <form class="config-form"
                      id="userForm"
                      method="post"
                      action="<?= base_url('config/user/create') ?>"
                      data-create-url="<?= base_url('config/user/create') ?>"
                      data-update-url="<?= base_url('config/user/update') ?>">

                    <?= csrf_field() ?>

                    <input type="hidden" name="user_id" id="user_id">

                    <div class="modal-body p-0">
                        <div class="d-flex" style="min-height: 350px;">
                            <div class="flex-grow-1 p-4">

                                <!-- USERNAME -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Username<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text"
                                               class="form-control <?= isset($errors['username']) ? 'is-invalid' : '' ?>"
                                               name="username"
                                               id="username"
                                               value="<?= esc(old('username') ?? '') ?>"
                                               placeholder="z.B. max.mustermann">
                                        <div class="invalid-feedback"><?= $errors['username'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- EMAIL -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">E-Mail<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="email"
                                               class="form-control <?= isset($errors['email']) ? 'is-invalid' : '' ?>"
                                               name="email"
                                               id="email"
                                               value="<?= esc(old('email') ?? '') ?>"
                                               placeholder="user@firma.de">
                                        <div class="invalid-feedback"><?= $errors['email'] ?? '' ?></div>
                                    </div>
                                </div>

                                <!-- ROLLE -->
                                <div class="mb-3 row align-items-center">
                                    <label class="col-sm-3 col-form-label">Rolle<span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <select name="role"
                                                id="role"
                                                class="form-select <?= isset($errors['role']) ? 'is-invalid' : '' ?>">
                                            <option value="">Bitte wählen</option>
                                            <option value="user" <?= old('role') == 'user' ? 'selected' : '' ?>>User</option>
                                            <option value="sub_admin" <?= old('role') == 'sub_admin' ? 'selected' : '' ?>>Sub-Admin</option>
                                            <option value="admin" <?= old('role') == 'admin' ? 'selected' : '' ?>>Admin</option>
                                        </select>
                                        <div class="invalid-feedback"><?= $errors['role'] ?? '' ?></div>
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