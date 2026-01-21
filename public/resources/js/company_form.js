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

    document.addEventListener('DOMContentLoaded', function () {

        const modal = document.getElementById('createCompanyModal');
        const form  = document.getElementById('companyForm');

        modal.addEventListener('show.bs.modal', function (event) {

            const button = event.relatedTarget;

            const createUrl = form.dataset.createUrl;
            const updateUrl = form.dataset.updateUrl;

            // =========================
            // CREATE-MODUS
            // =========================
            if (!button || !button.classList.contains('edit-company-btn')) {
                form.action = createUrl;
                form.reset();

                document.getElementById('company_id').value = '';
                document.getElementById('dynamicModalTitle').innerText = 'Unternehmen hinzufügen';
                return;
            }

            // =========================
            // EDIT-MODUS
            // =========================
            document.getElementById('dynamicModalTitle').innerText = 'Unternehmen bearbeiten';

            document.querySelector('[name="company_name"]').value = button.dataset.name;
            document.querySelector('[name="country_id"]').value = button.dataset.country;
            document.querySelector('[name="industry_id"]').value = button.dataset.industry;
            document.querySelector('[name="description"]').value = button.dataset.description;

            document.getElementById('company_id').value = button.dataset.id;

            form.action = updateUrl + '/' + button.dataset.id;
        });
    });
