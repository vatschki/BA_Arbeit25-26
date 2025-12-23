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
                                    <input type="checkbox" class="column-toggle" data-column="1" checked> Bericht
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="2" checked> Anforderung
                                </label>
                            </li>
                            <li>
                                <label class="dropdown-item">
                                    <input type="checkbox" class="column-toggle" data-column="3" checked> Inhalt
                                </label>
                            </li>
                        </ul>

                        <input id="table-search" class="form-control w-75" type="search" placeholder="Wert Suche" aria-label="Search">

                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body container-fluid" id="table-view">
                <div class="table-responsive">
                    <table class="table table-hover table-border table-striped" id="reportValueTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="id" data-sortable="true">ID</th>
                            <th data-field="value" data-sortable="true">Bericht</th>
                            <th data-field="value" data-sortable="true">Anforderung</th>
                            <th data-field="value" data-sortable="true">Inhalt</th>
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

<script>
    document.querySelectorAll(".column-toggle").forEach(checkbox => {
        checkbox.addEventListener("change", function () {

            let checkedBoxes = document.querySelectorAll(".column-toggle:checked");
            let columnIndex = parseInt(this.getAttribute("data-column"), 10);
            let isChecked = this.checked;

            // Mindestens eine Spalte sichtbar lassen
            if (checkedBoxes.length === 0) {
                this.checked = true;
                return;
            }

            document.querySelectorAll("#reportValueTable tr").forEach(row => {
                let cells = row.querySelectorAll("th, td");
                if (cells[columnIndex]) {
                    cells[columnIndex].style.display = isChecked ? "" : "none";
                }
            });

            checkedBoxes = document.querySelectorAll(".column-toggle:checked");

            // Alle Checkboxen wieder aktivieren
            document.querySelectorAll(".column-toggle").forEach(cb => {
                cb.disabled = false;
                cb.parentElement?.classList.remove("disabled-option");
            });

            // Letzte verbleibende Spalte sperren
            if (checkedBoxes.length === 1) {
                checkedBoxes[0].disabled = true;
                checkedBoxes[0].parentElement?.classList.add("disabled-option");
            }
        });
    });

    document.getElementById("table-search").addEventListener("keyup", function () {
        let value = this.value.toLowerCase();
        let rows = document.querySelectorAll("#reportValueTable tbody tr");
        let visibleRows = 0;

        rows.forEach(row => {
            if (row.textContent.toLowerCase().includes(value)) {
                row.style.display = "table-row";
                visibleRows++;
            } else {
                row.style.display = "none";
            }
        });
    });
</script>

