

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

    document.addEventListener("DOMContentLoaded", function () {
        const $standard = $("#standardSelect");
        const $requirement = $("#requirementSelect");

        // Originale Optionen sichern
        const allRequirementOptions = $requirement.find("option").clone();

        function filterRequirements() {
            const standardId = $standard.val();

            // Dropdown resetten
            $requirement.empty();

            // Placeholder wieder einfügen
            $requirement.append(
                `<option value="" disabled selected>ESRS-Anforderung auswählen</option>`
            );

            // Wenn kein Standard gewählt → keine Requirements anzeigen
            if (!standardId) {
                $requirement.trigger("change");
                return;
            }

            // Relevante Requirements herausfiltern und hinzufügen
            allRequirementOptions.each(function () {
                const reqStandardId = $(this).data("standard-id");

                if (reqStandardId == standardId) {
                    $requirement.append($(this).clone());
                }
            });

            // Select2 aktualisieren
            $requirement.trigger("change");
        }

        // Event Listener
        $standard.on("change", filterRequirements);

        // Falls old() Werte vorhanden → automatisch filtern
        filterRequirements();
    });

    // PDF Drag & Drop
    document.addEventListener("DOMContentLoaded", function () {

        const dropZone   = document.getElementById("pdf-drop-zone");
        const fileInput  = document.getElementById("pdf-input");
        const browseBtn  = document.getElementById("pdf-browse-btn");
        const fileListEl = document.getElementById("pdf-file-list");

        let selectedFile = null;

        function setFile(file) {
            if (!file) return;

            const isPdf = file.type === "application/pdf" || file.name.toLowerCase().endsWith(".pdf");
            if (!isPdf) {
                selectedFile = null;
                window.selectedPdfFile = null
                fileListEl.textContent = "Bitte eine gültige PDF-Datei auswählen.";
                return;
            }

            selectedFile = file;
            window.selectedPdfFile = selectedFile;
            fileListEl.innerHTML = `• ${file.name} (${Math.round(file.size / 1024)} KB)`;
        }

        // Click
        dropZone.addEventListener("click", () => fileInput.click());
        browseBtn.addEventListener("click", (e) => {
            e.stopPropagation();
            fileInput.click();
        });

        // File input
        fileInput.addEventListener("change", (e) => setFile(e.target.files?.[0]));

        // Drag Events
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
            setFile(e.dataTransfer.files?.[0]);
        });

        // Expose selectedFile to save button handler
        window.selectedPdfFile = selectedFile;
    });

    // Save Button - Pipeline starten
    document.addEventListener("DOMContentLoaded", function () {

        const saveBtn = document.getElementById("createSaveBtn");

        saveBtn.addEventListener("click", async () => {

            const file = window.selectedPdfFile;
            if (!file) {
                alert("Bitte eine PDF auswählen.");
                return;
            }

            const modal = document.getElementById("createReportModal");
            const companyId     = modal.querySelector('select[name="company_id"]').value;
            const year          = modal.querySelector('select[name="year"]').value;
            const standardId    = modal.querySelector('select[name="standard_id"]').value;
            const requirementId = modal.querySelector('select[name="requirement_id"]').value;

            const formData = new FormData();
            formData.append("report", file);
            formData.append("company_id", companyId);
            formData.append("year", year);
            formData.append("standard_id", standardId);
            formData.append("requirement_id", requirementId);

            saveBtn.disabled = true;
            saveBtn.textContent = "Wird gespeichert...";

            const res = await fetch("/esg-reports/process", {
                method: "POST",
                body: formData
            });

            const data = await res.json();

            saveBtn.disabled = false;
            saveBtn.textContent = "Speichern";

            if (!res.ok) {
                alert(data?.message ?? "Fehler beim Upload.");
                return;
            }

            alert("OK. Job-ID: " + data.job_id);
        });
    });

