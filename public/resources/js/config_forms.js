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

                modal.querySelectorAll('select').forEach(sel => {
                    if (window.jQuery && $(sel).data('select2')) {
                        $(sel).val(null).trigger('change');
                    } else {
                        sel.value = '';
                    }
                });

                return;
            }

            // ======================
            // EDIT
            // ======================
            modal.querySelector('.modal-title').innerText = 'Bearbeiten';

            Array.from(button.attributes).forEach(attr => {

                if (!attr.name.startsWith('data-')) return;
                if (attr.name === 'data-bs-target' || attr.name === 'data-bs-toggle') return;

                const key = attr.name.replace('data-', '');

                const field = form.querySelector(`[name="${key}"]`);
                if (!field) return;

                if (field.tagName === 'SELECT') {
                    if (window.jQuery && $(field).data('select2')) {
                        $(field).val(attr.value).trigger('change');
                    } else {
                        field.value = attr.value;
                    }
                } else {
                    field.value = attr.value;
                }
            });

            // Action setzen
            const id = button.getAttribute('data-id');
            if (id) {
                form.action = updateUrl + '/' + id;
            }
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
