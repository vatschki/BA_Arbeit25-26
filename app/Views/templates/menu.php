    <header>
        <nav class="navbar navbar-expand-lg bg-body-tertiary shadow-sm">
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
                            <a class="nav-link active" aria-current="page" href="<?= base_url('/') ?>">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">What it is</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">How it Works</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Help</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>