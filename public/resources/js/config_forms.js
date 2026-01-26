document.addEventListener('DOMContentLoaded', function () {

    document.querySelectorAll('.config-modal').forEach(function (modal) {

        modal.addEventListener('show.bs.modal', function (event) {

            const button = event.relatedTarget;
            const form   = modal.querySelector('.config-form');

            if (!form) return;

            const createUrl = form.dataset.createUrl;
            const updateUrl = form.dataset.updateUrl;

            // ======================
            // CREATE
            // ======================
            if (!button || !button.classList.contains('edit-btn')) {

                form.action = createUrl;
                form.reset();

                modal.querySelector('.modal-title').innerText = 'Neu anlegen';

                // Select2 reset
                modal.querySelectorAll('select').forEach(sel => {
                    $(sel).val(null).trigger('change.select2');
                });

                return;
            }

            // ======================
            // EDIT
            // ======================
            modal.querySelector('.modal-title').innerText = 'Bearbeiten';

            // Alle data-* Attribute übernehmen
            Object.keys(button.dataset).forEach(function (key) {

                if (key === 'bsTarget' || key === 'bsToggle') return;

                const field = form.querySelector(`[name="${key}"]`);

                if (!field) return;

                if (field.tagName === 'SELECT') {
                    $(field).val(button.dataset[key]).trigger('change.select2');
                } else {
                    field.value = button.dataset[key];
                }
            });

            form.action = updateUrl + '/' + button.dataset.id;
        });
    });
});

window.addEventListener('load', function () {

    const trigger = document.getElementById('company-modal-trigger');
    if (!trigger || trigger.dataset.open !== '1') return;

    const modalEl = document.querySelector('.config-modal');
    if (!modalEl) return;

    const modal = new bootstrap.Modal(modalEl, {
        backdrop: 'static',
        keyboard: true
    });

    modal.show();
});
