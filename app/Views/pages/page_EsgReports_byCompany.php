<?php
$canManageContent = auth()->loggedIn() && auth()->user()->can('content.manage');
$errors = session('errors') ?? [];
?>
<!-- Darstellung des ausgewählten Menüs style="background-color: aliceblue !important; -->
<div id="main-content" class="container-card">
    <div class="container-fluid">
        <div class="card">
            <div class="card-body container-fluid">
                <div class="d-flex justify-content-between mb-3">

                    <div>
                        <h4 class="mb-0">
                            Berichte von: <?= esc($company['name']) ?>
                        </h4>
                        <small class="text-muted">
                            ESRS-Reports
                        </small>
                    </div>

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
                                    <input type="checkbox" class="column-toggle" data-column="0" data-table-id="reportsByCompaniesTable" checked> ID
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="1" data-table-id="reportsByCompaniesTable" checked> Unternehmen
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="2" data-table-id="reportsByCompaniesTable" checked> Prüfer
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="3" data-table-id="reportsByCompaniesTable" checked> Jahr
                                </label>
                            </li>
                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Berichtssuche " data-table-id="reportsByCompaniesTable" aria-label="Search">

                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body container-fluid" id="table-view">
                <div class="table-responsive">
                    <table class="table table-hover table-border table-striped" id="reportsByCompaniesTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="report_id" data-sortable="true">ID</th>
                            <th data-field="company_name" data-sortable="true">Unternehmen</th>
                            <th data-field="auditor_name" data-sortable="true">Prüfer</th>
                            <th data-field="reporting_year" data-sortable="true">Jahr</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php if (!empty($reportsbycompany)): ?>
                            <?php foreach ($reportsbycompany as $report): ?>
                                <tr data-href="<?= site_url('/esg-reports/value/' . $report['report_id']) ?>"
                                    style="cursor: pointer;"
                                >
                                    <td><?= esc($report['report_id']) ?></td>
                                    <td><?= esc($report['company_name']) ?></td>
                                    <td><?= esc($report['auditor_name']) ?></td>
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

<script>
    document.addEventListener("click", function (e) {
        const row = e.target.closest("#reportsByCompaniesTable tbody tr[data-href]");
        if (!row) return;

        window.location.href = row.dataset.href;
    });
</script>
