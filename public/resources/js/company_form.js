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

        if (!modal || !form) {
            console.error('Modal oder Formular nicht gefunden');
            return;
        }

        modal.addEventListener('show.bs.modal', function (event) {

            const button = event.relatedTarget;

            const createUrl = form.dataset.createUrl;
            const updateUrl = form.dataset.updateUrl;

            // =========================
            // CREATE
            // =========================
            if (!button || !button.classList.contains('edit-company-btn')) {

                form.action = createUrl;
                form.reset();

                $('#dynamicModalTitle').text('Unternehmen hinzufügen');

                $('.select2-country').val(null).trigger('change');
                $('.select2-industry').val(null).trigger('change');

                return;
            }

            // =========================
            // EDIT
            // =========================
            $('#dynamicModalTitle').text('Unternehmen bearbeiten');

            $('[name="company_name"]').val(button.dataset.name);
            $('[name="country_id"]').val(button.dataset.country).trigger('change');

            const industrySelect = document.querySelector('[name="industry_id"]');
            industrySelect.value = button.dataset.industry;
            industrySelect.dispatchEvent(new Event('change'));

            $('[name="description"]').val(button.dataset.description);

            form.action = updateUrl + '/' + button.dataset.id;
        });
    });


