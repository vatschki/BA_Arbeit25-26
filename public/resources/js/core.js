    // Suchfunktion tabelle
    document.getElementById("table-search").addEventListener("keyup", function () {
        const value = this.value.toLowerCase();
        const tableId = this.dataset.tableId; // übergabe Tabellen ID
        const rows = document.querySelectorAll(`#${tableId} tbody tr`);

        rows.forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(value)
                ? ""
                : "none";
        });
    });


    // Spaltenfilter
    document.querySelectorAll(".column-toggle").forEach(cb => {
        cb.addEventListener("change", function () {

            const tableId = this.dataset.tableId;   // übergabe Tabellen ID
            const columnIndex = this.dataset.column;
            const table = document.getElementById(tableId);

            const checked = document.querySelectorAll(
                `.column-toggle[data-table-id="${tableId}"]:checked`
            );

            if (checked.length === 0) {
                this.checked = true;
                return;
            }

            table.querySelectorAll("tr").forEach(row => {
                const cells = row.querySelectorAll("th, td");
                if (cells[columnIndex]) {
                    cells[columnIndex].style.display = this.checked ? "" : "none";
                }
            });

            document
                .querySelectorAll(`.column-toggle[data-table-id="${tableId}"]`)
                .forEach(c => c.disabled = false);

            if (checked.length === 1) {
                checked[0].disabled = true;
            }
        });
    });
