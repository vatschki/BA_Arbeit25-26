    <body>
    <?php
        $uri = service('uri');
        $seg1 = $uri->getSegment(1) ?? '';
    ?>

        <header>
            <nav class="navbar_home navbar navbar-expand-lg bg-body-tertiary shadow-sm">
                <div class="container-fluid px-4">
                    <!-- Logo -->
                    <a class="navbar-brand d-flex align-items-center" href="<?= base_url('/') ?>">
                        <img src="<?= base_url('resources/images/Logo_Universitaet.svg') ?>" alt="Logo" width="180" class="me-2 mt-2 mb-2">
                    </a>

                    <!-- Hamburger icon for mobile -->
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu"
                            aria-controls="navbarMenu" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <!-- Menu -->
                    <div class="collapse navbar-collapse justify-content-end" id="navbarMenu">
                        <ul class="navbar-nav mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link <?= ($seg1 === '' || $seg1 === 'companies' || $seg1 === 'esg-reports') ? 'active' : '' ?>" aria-current="page" href="<?= base_url('/') ?>">
                                    Home
                                    <i class="fa-regular fa-house"></i>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <?= ($seg1 === 'help') ? 'active' : '' ?>" href="<?= base_url('help') ?>">
                                    Hilfe
                                    <i class="fa-regular fa-circle-question"></i>
                                </a>
                            </li>
                            <?php if (auth() -> loggedIn()): ?>
                                <li class="nav-item">
                                    <a class="nav-link <?= ($seg1 === 'config/general') ? 'active' : '' ?>" href="<?= base_url('config/api-key') ?>">
                                        <i class="fa-solid fa-gear"></i>
                                    </a>
                                </li>
                            <?php endif; ?>
                            <?php if (! auth()->loggedIn()): ?>
                                <li class="nav-item">
                                    <a class="nav-link" href="<?= base_url('login') ?>" title="Login">
                                        <i class="fa-solid fa-arrow-right-to-bracket"></i>
                                    </a>
                                </li>
                            <?php else: ?>
                                <li class="nav-item">
                                    <a class="nav-link" href="<?= base_url('logout') ?>" title="Logout">
                                        <i class="fa-solid fa-arrow-right-from-bracket"></i>
                                    </a>
                                </li>
                            <?php endif; ?>
                        </ul>
                    </div>
                </div>
            </nav>

            <?php if ($seg1 === '' || $seg1 === 'companies' || $seg1 === 'esg-reports') : ?>
                <nav class="subnav">
                    <div class="subnav-inner">
                        <ul class="subnav-menu">
                            <li>
                                <a class="nav-link <?= ($seg1 === '' || $seg1 === 'companies') ? 'active' : '' ?>" href="<?= base_url('companies') ?>">
                                    Unternehmen
                                </a>
                            </li>
                            <li>
                                <a class="nav-link <?= ($seg1 === 'esg-reports') ? 'active' : '' ?>" href="<?= base_url('esg-reports') ?>">
                                    ESG Berichte
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>
            <?php endif; ?>
        </header>