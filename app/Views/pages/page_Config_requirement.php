<div id="main-content" class="container-card p-0">
    <div class="config-page">

        <div class="config-page__header">
            <h5 class="config-page__title mb-0">Einstellungen</h5>
        </div>

        <div class="config-page__body">
            <?= view('pages/partials/config_sidebar_nav') ?>

            <main class="config-content">
                    <div class="card">
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
