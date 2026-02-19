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

        // ===============================
        // Zentrale Tabellen-Filterlogik
        // ===============================

        function applyFilters(tableId) {

            const selectedCountries = Array.from(document.querySelectorAll('.country-filter-checkbox:checked')).map(cb => cb.value);
            const selectedSectors = Array.from(document.querySelectorAll('.sector-filter-checkbox:checked')).map(cb => cb.value);
            const selectedIndustries = Array.from(document.querySelectorAll('.industry-filter-checkbox:checked')).map(cb => cb.value);
            const selectedYears = Array.from(document.querySelectorAll('.year-filter-checkbox:checked')).map(cb => cb.value);

            const rows = document.querySelectorAll(`#${tableId} tbody tr:not(#no-search-result-row)`);

            let visibleCount = 0;

            rows.forEach(row => {

                const countryId = row.getAttribute('data-country-id');
                const sectorId = row.getAttribute('data-sector-id');
                const industryId = row.getAttribute('data-industry-id');
                const yearId = row.getAttribute('data-year-id');

                const matchCountry = selectedCountries.length === 0 || !countryId || selectedCountries.includes(countryId);
                const matchSector = selectedSectors.length === 0 || !sectorId || selectedSectors.includes(sectorId);
                const matchIndustry = selectedIndustries.length === 0 || !industryId || selectedIndustries.includes(industryId);
                const matchYear = selectedYears.length === 0 || !yearId || selectedYears.includes(yearId);

                if (matchCountry && matchSector && matchIndustry && matchYear) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            // No-Result-Row steuern
            const noResultRow = document.querySelector(`#${tableId} #no-search-result-row`);

            if (noResultRow) {
                if (visibleCount === 0) {
                    noResultRow.style.display = '';
                } else {
                    noResultRow.style.display = 'none';
                }
            }
        }

        // ===============================
        // Event Listener für alle Filter
        // ===============================

        const allFilterCheckboxes = document.querySelectorAll(
            '.country-filter-checkbox, .sector-filter-checkbox, .industry-filter-checkbox, .year-filter-checkbox'
        );

        allFilterCheckboxes.forEach(cb => {
            cb.addEventListener('change', function () {

                if (document.getElementById('companiesTable')) {
                    applyFilters('companiesTable');
                }

                if (document.getElementById('reportTable')) {
                    applyFilters('reportTable');
                }
            });
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

            let tableId = this.dataset.tableId;

            document.querySelectorAll(`#${tableId} tr`).forEach(row => {
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

        const allRequirementOptions = $requirement.find("option").clone();

        function filterRequirements() {
            const standardId = $standard.val();

            $requirement.empty();

            $requirement.append(
                `<option value="" disabled selected>ESRS-Anforderung auswählen</option>`
            );

            if (!standardId) {
                $requirement.trigger("change");
                return;
            }

            allRequirementOptions.each(function () {
                const reqStandardId = $(this).data("standard-id");

                if (reqStandardId == standardId) {
                    $requirement.append($(this).clone());
                }
            });

            $requirement.trigger("change");
        }

        $standard.on("change", filterRequirements);

        filterRequirements();
    });
