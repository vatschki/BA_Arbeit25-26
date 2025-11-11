<div id="main-content" class="container">
    <!-- Toolbar -->
    <div class="card-body container-fluid">
        <div class="d-flex justify-content-between mb-3">

            <!-- Neu -->
            <a href="<?= base_url('companies/create') ?>">
                <button type="button" class="btn btn-primary">
                    <i class="fas fa-plus-circle"></i> Neu
                </button>
            </a>

            <!-- Suche + Dropdown -->
            <div class="d-flex align-items-center">

                <input id="table-search" class="form-control w-75" type="search"
                    placeholder="Search" aria-label="Search" style="margin-right:10px;">

                <div class="btn-group">

                    <!-- Spaltenfilter -->
                    <button class="btn btn-secondary dropdown-toggle rounded" type="button"
                            id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-bars"></i>
                    </button>

                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <li>
                            <label class="dropdown-item">
                                <input type="checkbox" class="column-toggle" data-column="1" checked> ID
                            </label>
                        </li>
                        <li>
                            <label class="dropdown-item">
                                <input type="checkbox" class="column-toggle" data-column="2" checked> Name
                            </label>
                        </li>
                        <li>
                            <label class="dropdown-item">
                                <input type="checkbox" class="column-toggle" data-column="3" checked> HQ
                            </label>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
  </div>

  <!-- Tabelle -->
    <div class="card-body container-fluid">
        <div class="table-responsive" id="tableWrapper">
            <table id="companiesTable" class="table table-hover">
                <thead>
                    <tr>
                        <th data-field="id" data-sortable="true">ID</th>
                        <th data-field="name" data-sortable="true">Name</th>
                        <th data-field="hq" data-sortable="true">HQ</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($companies)): ?>
                        <?php foreach ($companies as $company): ?>
                            <tr>
                                <td><?= htmlspecialchars($company['id']) ?></td>
                                <td><?= htmlspecialchars($company['name']) ?></td>
                                <td><?= htmlspecialchars($company['hq']) ?></td>
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
</div>

<script>
/* --- Suche --- */
document.getElementById('table-search').addEventListener('input', function () {
  const value = this.value.toLowerCase();
  const rows = document.querySelectorAll('#companiesTable tbody tr');

  rows.forEach(row => {
    if (row.classList.contains('no-data-row')) return;
    row.style.display = row.innerText.toLowerCase().includes(value) ? '' : 'none';
  });
});

/* --- Spalten Ein/Ausblenden --- */
const checks = document.querySelectorAll('.column-toggle');
checks.forEach(cb => {
  cb.addEventListener('change', function () {
    const colIndex = parseInt(this.dataset.column);

    const th = document.querySelector(`#companiesTable thead th:nth-child(${colIndex})`);
    const tds = document.querySelectorAll(`#companiesTable tbody td:nth-child(${colIndex})`);

    th.style.display = this.checked ? '' : 'none';
    tds.forEach(td => td.style.display = this.checked ? '' : 'none');
  });
});
</script>