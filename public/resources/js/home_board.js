

    // Suchfunktion tabelle
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
    });

    // Suchfunktion Dropdown
    document.addEventListener('DOMContentLoaded', function () {

        const searchInputCountry = document.getElementById('searchCountryInput');
        const searchInputSector = document.getElementById('searchSectorInput');
        const searchInputIndustry = document.getElementById('searchIndustryInput');

        // Live-Suche im Dropdown von Ländern
        if (searchInputCountry) {
            searchInputCountry.addEventListener('input', function () {
                const value = this.value.toLowerCase().trim();

                const items = document.querySelectorAll('#countryDropdownMenu .filter-item-country');

                items.forEach(function (li) {
                    const nameSpan = li.querySelector('.filter-name-country');
                    if (!nameSpan) return;

                    const text = nameSpan.textContent.toLowerCase();
                    li.style.display = text.includes(value) ? '' : 'none';
                });
            });
        }

        // Live-Suche im Dropdown von Sector
        if (searchInputSector) {
            searchInputSector.addEventListener('input', function () {
                const value = this.value.toLowerCase().trim();

                const items = document.querySelectorAll('#sectorDropdownMenu .filter-item-sector');

                items.forEach(function (li) {
                    const nameSpan = li.querySelector('.filter-name-sector');
                    if (!nameSpan) return;

                    const text = nameSpan.textContent.toLowerCase();
                    li.style.display = text.includes(value) ? '' : 'none';
                });
            });
        }

        // Live-Suche im Dropdown von Industry
        if (searchInputIndustry) {
            searchInputIndustry.addEventListener('input', function () {
                const value = this.value.toLowerCase().trim();

                const items = document.querySelectorAll('#industryDropdownMenu .filter-item-industry');

                items.forEach(function (li) {
                    const nameSpan = li.querySelector('.filter-name-industry');
                    if (!nameSpan) return;

                    const text = nameSpan.textContent.toLowerCase();
                    li.style.display = text.includes(value) ? '' : 'none';
                });
            });
        }

        // Filter-Logik für Tabelle nach Ländern
        function filterTableByCountries() {
            // IDs der ausgewählten Länder
            const selected = Array.from(document.querySelectorAll('.country-filter-checkbox:checked'))
            .map(cb => cb.value);

            // Alle Tabellenzeilen jedes Mal frisch holen
            const rows = document.querySelectorAll('#boardTable tbody tr');

            rows.forEach(function (row) {
                const countryId = row.getAttribute('data-country-id');

                if (selected.length === 0 || selected.includes(countryId)) {
                    row.style.display = '';
                } else {
                row.style.display = 'none';
                }
            });
        }

        // Filter-Logik für Tabelle nach Sektoren
        function filterTableBySectors() {
            // IDs der ausgewählten Länder
            const selected = Array.from(document.querySelectorAll('.sector-filter-checkbox:checked'))
                .map(cb => cb.value);

            // Alle Tabellenzeilen jedes Mal frisch holen
            const rows = document.querySelectorAll('#boardTable tbody tr');

            rows.forEach(function (row) {
                const countryId = row.getAttribute('data-sector-id');

                if (selected.length === 0 || selected.includes(countryId)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Filter-Logik für Tabelle nach Industrien
        function filterTableByIndustries() {
            // IDs der ausgewählten Länder
            const selected = Array.from(document.querySelectorAll('.industry-filter-checkbox:checked'))
                .map(cb => cb.value);

            // Alle Tabellenzeilen jedes Mal frisch holen
            const rows = document.querySelectorAll('#boardTable tbody tr');

            rows.forEach(function (row) {
                const countryId = row.getAttribute('data-industry-id');

                if (selected.length === 0 || selected.includes(countryId)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }



        // Event-Listener für Checkboxen Country
        document.querySelectorAll('.country-filter-checkbox').forEach(function (cb) {
            cb.addEventListener('change', filterTableByCountries);
        });

        // Event-Listener für Checkboxen Sektoren
        document.querySelectorAll('.sector-filter-checkbox').forEach(function (cb) {
            cb.addEventListener('change', filterTableBySectors);
        });

        // Event-Listener für Checkboxen Industrien
        document.querySelectorAll('.industry-filter-checkbox').forEach(function (cb) {
            cb.addEventListener('change', filterTableByIndustries);
        });

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

    // Industrie zu Sektor automatisch setzen
    $(document).ready(function () {
        const $industrySelect = $('#industry_id');
        const $sectorInput = $('#sector_display');

        function updateSector() {
            const selectedOption = $industrySelect.find('option:selected');
            const sectorName = selectedOption.data('sector-name') || '';
            $sectorInput.val(sectorName);
        }

        // Select2 feuert ebenfalls ein 'change'-Event, daher reicht das
        $industrySelect.on('change', updateSector);

        // Initial setzen (falls ein Wert vorausgewählt ist)
        updateSector();
    });

    // PDF Drag & Drop
    document.addEventListener("DOMContentLoaded", function () {
        const dropZone   = document.getElementById("pdf-drop-zone");
        const fileInput  = document.getElementById("pdf-input");
        const browseBtn  = document.getElementById("pdf-browse-btn");
        const fileListEl = document.getElementById("pdf-file-list");
        const saveBtn    = document.getElementById("createSaveBtn");

        let selectedFiles = [];

        function setFiles(files) {
            selectedFiles = Array.from(files).filter(f =>
                f.type === "application/pdf" || f.name.toLowerCase().endsWith(".pdf")
            );

            if (selectedFiles.length === 0) {
                fileListEl.textContent = "Keine gültigen PDF-Dateien ausgewählt.";
                return;
            }

            fileListEl.innerHTML = selectedFiles
            .map(f => "• " + f.name + " (" + Math.round(f.size / 1024) + " KB)")
            .join("<br>");
        }

        // Klick auf Zone oder Button
        dropZone.addEventListener("click", () => fileInput.click());
        browseBtn.addEventListener("click", (e) => {
            e.stopPropagation();
            fileInput.click();
        });

        // Auswahl über Dialog
        fileInput.addEventListener("change", (e) => {
            setFiles(e.target.files);
        });

        // Drag & Drop
        dropZone.addEventListener("dragover", (e) => {
            e.preventDefault();
            dropZone.classList.add("dragover");
        });

        dropZone.addEventListener("dragleave", (e) => {
            e.preventDefault();
            dropZone.classList.remove("dragover");
        });

        dropZone.addEventListener("drop", (e) => {
            e.preventDefault();
            dropZone.classList.remove("dragover");
            if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
                setFiles(e.dataTransfer.files);
                e.dataTransfer.clearData();
            }
        });

        // Speichern-Button send PDF to Backend
        saveBtn.addEventListener("click", () => {
            // Beispiel: wenn du sicherstellen willst, dass ein Bericht hochgeladen ist
            // if (selectedFiles.length === 0) {
            //   alert("Bitte mindestens einen PDF-Bericht auswählen.");
            //   return;
            // }

            const formData = new FormData();
                selectedFiles.forEach((file, idx) => {
                formData.append("reports[]", file);
            });

            // TODO: hier deine URL eintragen
            // fetch("/api/company/create", {
            //   method: "POST",
            //   body: formData
            // });

            console.log("Ausgewählte PDFs:", selectedFiles);
        });
    });