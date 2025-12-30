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
                                    <input type="checkbox" class="column-toggle" data-column="0" data-table-id="reportValueTable" checked> ID
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="1" data-table-id="reportValueTable" checked> Bericht
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="2" data-table-id="reportValueTable" checked> Anforderung
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="3" data-table-id="reportValueTable" checked> Inhalt
                                </label>
                            </li>
                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Wert Suche" data-table-id="reportValueTable" aria-label="Search">

                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body container-fluid" id="table-view">
                <div class="table-responsive">
                    <table class="table table-hover table-border table-striped" id="reportValueTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="value_id" data-sortable="true">ID</th>
                            <th data-field="report_id" data-sortable="true">Bericht</th>
                            <th data-field="requirement_code" data-sortable="true">Anforderung</th>
                            <th data-field="value_text" data-sortable="true">Inhalt</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php if (!empty($report_values)): ?>
                            <?php foreach ($report_values as $value): ?>
                                <tr>
                                    <td><?= esc($value['value_id']) ?></td>
                                    <td><?= esc($value['report_id']) ?></td>
                                    <td><?= esc($value['requirement_code']) ?></td>
                                    <td><?= esc($value['value_text']) ?></td>
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

