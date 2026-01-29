<?php
$pipelineActive = $pipelineActive ?? false;
$job_id = $job_id ?? null;
$canManageContent = auth()->loggedIn() && auth()->user()->can('content.manage');
$errors = session('errors') ?? [];
?>

<!-- Darstellung des ausgewählten Menüs style="background-color: aliceblue !important; -->
<div id="main-content" class="container-card">
    <div class="container">
        <div class="card">
            <div class="card-body container-fluid">
                <div class="d-flex justify-content-between mb-3">

                    <div>
                        <?php
                        $companyName   = $report_values[0]['company_name'] ?? 'Unbekanntes Unternehmen';
                        $reportingYear = $report['reporting_year'] ?? '—';
                        ?>
                        <h4 class="mb-0">
                            Bericht: <?= esc($companyName) ?> (<?= esc($reportingYear) ?>)
                        </h4>
                        <small class="text-muted">
                            ESRS-Report
                        </small>
                    </div>

                    <!-- Right: Button Group mit Search Field -->
                    <div class="d-flex align-items-center">

                        <?php if (auth() -> loggedIn() && auth() -> user() -> can('content.manage')): ?>
                            <a href="/export/values/<?= $currentReportId ?>" class="btn btn-success">
                                <i class="fas fa-file-excel"></i>
                            </a>
                        <?php endif; ?>

                        <!-- Spaltenfilter Dropdown (Direkt in der Gruppe) -->
                        <button class="btn btn-secondary dropdown-toggle rounded-end" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa-solid fa-bars"></i>
                        </button>

                        <!-- Dropdown-Menü außerhalb von btn-group -->
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="0" data-table-id="reportValueTable" checked>
                                    ID
                                </label>
                            </li>

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="1" data-table-id="reportValueTable" checked>
                                    Anforderung
                                </label>
                            </li>

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="2" data-table-id="reportValueTable" checked>
                                    Page ID
                                </label>
                            </li>

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="3" data-table-id="reportValueTable" checked>
                                    Seite
                                </label>
                            </li>

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="4" data-table-id="reportValueTable" checked>
                                    Inhalt
                                </label>
                            </li>

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="5" data-table-id="reportValueTable" checked>
                                    Unternehmen
                                </label>
                            </li>

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="6" data-table-id="reportValueTable" checked>
                                    Report
                                </label>
                            </li>

                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle"
                                           data-column="7" data-table-id="reportValueTable" checked>
                                    Job
                                </label>
                            </li>

                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Wert Suche" data-table-id="reportValueTable" aria-label="Search">

                    </div>
                </div>
            </div>

            <div id="valuesContent" <?= $pipelineActive ? 'style="display:none"' : '' ?>>
                <!-- Tabellenansicht -->
                <div class="card-body container-fluid" id="table-view">
                    <div class="table-responsive">
                        <table class="table table-hover table-border table-striped" id="reportValueTable" data-toggle="table">
                            <thead>
                                <tr>
                                    <th data-field="value_id" data-sortable="true">ID</th>
                                    <th data-field="requirement_code" data-sortable="true">Anforderung</th>
                                    <th data-field="page_id" data-sortable="true">Page ID</th>
                                    <th data-field="page" data-sortable="true">Seite</th>
                                    <th data-field="text" data-sortable="true">Inhalt</th>
                                    <th data-field="company_name" data-sortable="true">Unternehmen</th>
                                    <th data-field="report_id" data-sortable="true">Report</th>
                                    <th data-field="job_id" data-sortable="true">Job</th>
                                </tr>
                            </thead>
                            <tbody id="reportValuesBody">
                                <?php if (!empty($report_values)): ?>
                                    <?php foreach ($report_values as $value): ?>
                                        <tr>
                                            <td><?= esc($value['value_id']) ?></td>
                                            <td><?= esc($value['requirement_code']) ?></td>
                                            <td><?= esc($value['page_id']) ?></td>
                                            <td><?= esc($value['page']) ?></td>
                                            <td><?= esc($value['text']) ?></td>
                                            <td><?= esc($value['company_name']) ?></td>
                                            <td><?= esc($value['report_id']) ?></td>
                                            <td><?= esc($value['job_id']) ?></td>
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
    </div>
</div>

<?php if ($pipelineActive): ?>
    <div class="modal fade"
         id="pipelineProgressModal"
         data-bs-backdrop="static"
         data-bs-keyboard="false"
         tabindex="-1">

        <div class="modal-dialog modal-sm modal-dialog-centered">
            <div class="modal-content p-3">

                <h6 class="mb-3">Bericht wird verarbeitet</h6>

                <div class="progress">
                    <div id="pipelineProgressBar"
                         class="progress-bar progress-bar-striped progress-bar-animated"
                         style="width:0%">
                        0%
                    </div>
                </div>

                <small id="pipelineStatusText" class="text-muted mt-2 d-block">
                    Initialisierung …
                </small>

            </div>
        </div>
    </div>
<?php endif; ?>

<?php if ($pipelineActive): ?>
    <script>
        const PIPELINE_JOB_ID = "<?= esc($job_id) ?>";
        let pipelineModal = null;

        document.addEventListener('DOMContentLoaded', () => {

            const modalEl = document.getElementById('pipelineProgressModal');
            pipelineModal = new bootstrap.Modal(modalEl);
            pipelineModal.show();

            pollStatus();
        });

        function pollStatus() {

            fetch(`/esg-reports/pipelinestatus/${PIPELINE_JOB_ID}`, {
                headers: { 'Accept': 'application/json' }
            })
                .then(res => res.json())
                .then(data => {

                    const percent = Math.min(data.percent ?? 0, 100);

                    const bar  = document.getElementById('pipelineProgressBar');
                    const text = document.getElementById('pipelineStatusText');

                    bar.style.width = percent + '%';
                    bar.textContent = percent + '%';
                    text.textContent = data.message ?? 'Pipeline läuft …';

                    if (percent >= 100) {
                        pipelineModal.hide();

                        if (data.step === 'error') {
                            alert(data.message || 'Pipeline fehlgeschlagen');
                        } else {
                            loadReportValues();
                        }
                        return;
                    }
                    else {
                        setTimeout(pollStatus, 1500);
                    }
                })
                .catch(() => {
                    setTimeout(pollStatus, 3000);
                });
        }

        function loadReportValues() {
            fetch(`/esg-reports/value/<?= esc($currentReportId) ?>/values`)
                .then(res => res.text())
                .then(html => {
                    document.getElementById('reportValuesBody').innerHTML = html;
                    document.getElementById('valuesContent').style.display = 'block';
                })
                .catch(() => {
                    alert('Fehler beim Laden der Report-Werte');
                });
        }

    </script>
<?php endif; ?>
