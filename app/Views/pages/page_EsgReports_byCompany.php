<!-- Darstellung des ausgewählten Menüs style="background-color: aliceblue !important; -->
<div id="main-content" class="container-card">
    <div class="container">
        <div class="card">
            <div class="card-body container-fluid">
                <div class="d-flex justify-content-between mb-3">
                    <!-- Left: "Neu" Button -->

                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createReportModal">
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
                                    <input type="checkbox" class="column-toggle" data-column="0" checked> ID
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="1" checked> Unternehmen
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="2" checked> Land
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="3" checked> Sektor
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="4" checked> Industrie
                                </label>
                            </li>
                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Firmensuche" aria-label="Search">

                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body container-fluid" id="table-view">
                <div class="table-responsive">
                    <table class="table table-hover table-border table-striped" id="boardTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="id" data-sortable="true">ID</th>
                            <th data-field="company" data-sortable="true">Unternehmen</th>
                            <th data-field="company" data-sortable="true">Author</th>
                            <th data-field="company" data-sortable="true">Jahr</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php if (!empty($reportsbycompany)): ?>
                            <?php foreach ($reportsbycompany as $report): ?>
                                <tr data-country-id="<?= esc($report['country_id']) ?>"
                                    data-sector-id="<?= esc($report['sector_id']) ?>"
                                    data-industry-id="<?= esc($report['industry_id']) ?>"
                                    data-company-id="<?= esc($report['company_id']) ?>"
                                >
                                    <td><?= esc($report['report_id']) ?></td>
                                    <td><?= esc($report['company_name']) ?></td>
                                    <td><?= esc($report['author_name']) ?></td>
                                    <td><?= esc($report['reporting_year']) ?></td>
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