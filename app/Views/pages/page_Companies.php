<!-- Darstellung des ausgewählten Menüs style="background-color: aliceblue !important; -->
<div id="main-content" class="container-card">
    <div class="container">
        <div class="card">
            <div class="card-body container-fluid">
                <div class="d-flex justify-content-between mb-3">
                    <!-- Left: "Neu" Button -->
                    <a href="<?= base_url('companies/create') ?>">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus-circle"></i> Neu
                        </button>
                    </a>

                    <!-- Right: Button Group mit Search Field -->
                    <div class="d-flex align-items-center">

                        <!-- Search Field mit kleinem Abstand -->
                        <input id="table-search" class="form-control w-75" type="search" placeholder="Search" aria-label="Search" style="margin-right: 10px;">

                        <!-- Button Group für bessere Verbindung -->
                        <div class="btn-group">
                            <!-- Ansicht umschalten Button -->
                            <button id="toggleView" class="btn btn-secondary rounded-start" type="button" name="toggle" aria-label="Show card view" title="Show card view">
                                <i class="fa-solid fa-wand-magic-sparkles"></i>
                            </button>

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
                                        <input type="checkbox" class="column-toggle" data-column="1" checked> Name
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Tabellenansicht -->
            <div class="card-body container-fluid" id="table-view">
                <div class="table-responsive">
                    <table class="table table-hover" id="boardTable" data-toggle="table">
                        <thead>
                        <tr>
                            <th data-field="id" data-sortable="true">ID</th>
                            <th data-field="name" data-sortable="true">Name</th>
                            <th data-field="name" data-sortable="true">Bericht</th>
                        </tr>
                        </thead>
                        <tbody>
                            <?php if (!empty($companies)): ?>
                                <?php foreach ($companies as $company): ?>
                                    <tr>
                                        <td><?= $company['id'] ?></td>
                                        <td><?= $company['name'] ?></td>
                                        <td><?= $company['bericht'] ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php else: ?>
                            <tr class="no-data-row">
                                <td colspan="3">Keine Daten verfügbar.</td>
                            </tr>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>
            </div>


            <!-- Kartenansicht als Tabelle -->
            <div class="d-none card-body container-fluid" id="card-view">
                <table class="table" id="cardTable">
                    <tbody>
                        <?php if (!empty($companies)): ?>
                            <?php foreach ($companies as $company): ?>
                                <tr class="card-table-row">
                                    <td colspan="2">
                                        <div class="card-entry"><strong>ID:</strong> <span><?= $company['id'] ?></span></div>
                                        <div class="card-entry"><strong>Name:</strong> <span><?= $company['name'] ?></span></div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                            <?php else: ?>
                                <tr class="no-data-row">
                                    <td colspan="2">Keine Daten verfügbar.</td>
                                </tr>
                            <?php endif; ?>
                    </tbody>
                </table>
            </div>
            <div id="no-results-message" class="text-center mt-3 text-danger d-none">
                Leider musst du das Board noch erstellen
            </div>
        </div>
    </div>
</div>


<script>

    // Suchfunktion
    document.getElementById("table-search").addEventListener("keyup", function () {
        let value = this.value.toLowerCase();
        let rows = document.querySelectorAll("#boardTable tbody tr");
        let visibleRows = 0;

        rows.forEach(row => {
            if (row.textContent.toLowerCase().includes(value)) {
                row.style.display = "table-row";
                visibleRows++;
            } else {
                row.style.display = "none";
            }
        });

        let cards = document.querySelectorAll("#cardTable tbody .card-table-row");
        let visibleCards = 0;

        cards.forEach(card => {
            if (card.textContent.toLowerCase().includes(value)) {
                card.style.display = "table-row";
                visibleCards++;
            } else {
                card.style.display = "none";
            }
        });

        let noResultsMessage = document.getElementById("no-results-message");

        if (visibleRows === 0 && visibleCards === 0) {
            noResultsMessage.classList.remove("d-none");
        } else {
            noResultsMessage.classList.add("d-none");
        }
    });

    //Dropdowns open
    document.querySelectorAll(".dropdown-menu").forEach(menu => {
        menu.addEventListener("click", function (event) {
            event.stopPropagation();
        });
    });

    // Spaltenfilter
    document.querySelectorAll(".column-toggle").forEach(checkbox => {
        checkbox.addEventListener("change", function () {
            let checkboxes = document.querySelectorAll(".column-toggle:checked");
            let columnIndex = this.getAttribute("data-column");
            let isChecked = this.checked;


            if (checkboxes.length === 0) {
                this.checked = true;
                return;
            }


            document.querySelectorAll("#boardTable tr").forEach(row => {
                let cells = row.querySelectorAll("th, td");
                if (cells[columnIndex]) {
                    cells[columnIndex].style.display = isChecked ? "" : "none";
                }
            });


            document.querySelectorAll("#cardTable .card-table-row").forEach(row => {
                let cardEntries = row.querySelectorAll(".card-entry");
                if (cardEntries[columnIndex]) {
                    cardEntries[columnIndex].style.display = isChecked ? "" : "none";
                }
            });


            checkboxes = document.querySelectorAll(".column-toggle:checked");


            document.querySelectorAll(".column-toggle").forEach(cb => {
                cb.disabled = false;
                cb.parentElement.classList.remove("disabled-option");
            });

            if (checkboxes.length === 1) {
                checkboxes[0].disabled = true;
                checkboxes[0].parentElement.classList.add("disabled-option");
            }
        });
    });

    // Ansicht umschalten
    document.getElementById("toggleView").addEventListener("click", function () {
        let tableView = document.getElementById("table-view");
        let cardView = document.getElementById("card-view");

        if (tableView.classList.contains("d-none")) {
            tableView.classList.remove("d-none");
            cardView.classList.add("d-none");
        } else {
            tableView.classList.add("d-none");
            cardView.classList.remove("d-none");
        }
    });

</script>