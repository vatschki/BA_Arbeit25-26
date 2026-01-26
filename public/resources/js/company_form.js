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

            if (!button) {
                return;
            }

            // =========================
            // CREATE
            // =========================
            if (!button.classList.contains('edit-company-btn')) {

                form.action = createUrl;
                form.reset()

                $('#dynamicModalTitle').text('Unternehmen hinzufügen');

                $('.select2-country').val(null).trigger('change.select2');
                $('.select2-industry').val(null).trigger('change.select2');

                return;
            }

            // =========================
            // EDIT
            // =========================
            $('#dynamicModalTitle').text('Unternehmen bearbeiten');

            $('[name="company_name"]').val(button.dataset.name);
            $('[name="country_id"]').val(button.dataset.country).trigger('change');

            $('#industry_id')
                .val(button.dataset.industry)
                .trigger('change.select2');


            $('[name="description"]').val(button.dataset.description);

            form.action = updateUrl + '/' + button.dataset.id;
        });
    });

    $(window).on('load', function () {

        const trigger = document.getElementById('company-modal-trigger');
        if (!trigger || trigger.dataset.open !== '1') return;

        const modalEl = document.getElementById('createCompanyModal');
        if (!modalEl) return;

        const modal = new bootstrap.Modal(modalEl, {
            backdrop: 'static',
            keyboard: true
        });

        modal.show();
    });