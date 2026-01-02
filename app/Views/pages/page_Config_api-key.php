<div id="main-content" class="container-card p-0">
    <div class="config-page">

        <div class="config-page__header">
            <h5 class="config-page__title mb-0">Einstellungen</h5>
        </div>

        <div class="config-page__body">
            <?= view('pages/partials/config_sidebar_nav') ?>

            <main class="config-content">

                <?php if (session()->getFlashdata('success')): ?>
                    <div class="alert alert-success">
                        <?= esc(session()->getFlashdata('success')) ?>
                    </div>
                <?php endif; ?>

                <?php if (session()->getFlashdata('error')): ?>
                    <div class="alert alert-danger">
                        <?= esc(session()->getFlashdata('error')) ?>
                    </div>
                <?php endif; ?>

                <form action="<?= site_url('config/api-key') ?>" method="post" class="config-form">

                    <?= csrf_field() ?>

                    <div class="form-group mb-3">
                        <label for="provider_name">Betreiber</label>
                        <input
                                type="text"
                                name="provider_name"
                                id="provider_name"
                                class="form-control"
                                placeholder="z. B. gemini"
                                value="<?= esc(session()->get('api_config')['provider_name'] ?? '') ?>"
                                required
                        >
                    </div>

                    <div class="form-group mb-3">
                        <label for="model_name">Modell</label>
                        <input
                                type="text"
                                name="model_name"
                                id="model_name"
                                class="form-control"
                                placeholder="z. B. models/gemini-1.5-pro"
                                value="<?= esc(session()->get('api_config')['model_name'] ?? '') ?>"
                                required
                        >
                    </div>

                    <div class="form-group mb-4">
                        <label for="api_key">API-Key</label>
                        <input
                                type="password"
                                name="api_key"
                                id="api_key"
                                class="form-control"
                                placeholder="API-Key eingeben"
                                required
                        >
                        <small class="form-text text-muted">
                            Der API-Key wird nur für diese Session gespeichert.
                        </small>
                    </div>

                    <div class="form-actions d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">
                            Speichern
                        </button>
                    </div>
                </form>
            </main>
        </div>

        <div class="config-page__footer">
            <span class="config-page__footer-spacer"></span>
        </div>

    </div>
</div>
