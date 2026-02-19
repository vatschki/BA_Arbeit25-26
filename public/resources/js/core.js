    // Suchfunktion tabelle
    document.getElementById("table-search").addEventListener("keyup", function () {
        const value = this.value.toLowerCase();
        const tableId = this.dataset.tableId;
        const rows = document.querySelectorAll(
            `#${tableId} tbody tr:not(#no-search-result-row)`
        );

        let visibleCount = 0;

        rows.forEach(row => {
            const match = row.textContent.toLowerCase().includes(value);
            row.style.display = match ? "" : "none";
            if (match) visibleCount++;
        });

        const noResultRow = document.getElementById("no-search-result-row");

        if (visibleCount === 0 && value.length > 0) {
            noResultRow.style.display = "";
        } else {
            noResultRow.style.display = "none";
        }
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