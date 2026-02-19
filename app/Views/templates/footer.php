<footer class="footer mt-auto py-2 bg-body-tertiary">
  <div class="container">
    <div class="row align-items-center">
      <!-- Left side -->
      <div class="col text-start">
        <p class="mb-0 text-body-secondary">
          © Bachelorarbeit V. Christ 2025/2026
        </p>
      </div>
      <!-- Right side -->
      <div class="col text-end">
        <a class="text-decoration-none text-body-secondary" href="#">Impressum</a>
        <span class="mx-1 text-body-secondary">•</span>
        <a class="text-decoration-none text-body-secondary" href="#">Datenschutz</a>
        <span class="mx-1 text-body-secondary">•</span>
        <a class="text-decoration-none text-body-secondary" href="#">Kontakt</a>
      </div>
    </div>
  </div>
</footer>



<!-- Core JS-Dateien laden -->
<script src="<?= base_url('resources/js/core.js') ?>"></script>
<?php
    $uri = service('uri');
    $seg1 = $uri->getSegment(1) ?? '';
?>
<?php if ($seg1 === 'companies'): ?>
    <script src="<?= base_url('resources/js/company_form.js') ?>"></script>
    <script src="<?= base_url('resources/js/home_board.js') ?>"></script>
<?php endif; ?>
<?php if ($seg1 === 'esg-reports'): ?>
    <script src="<?= base_url('resources/js/esg_form.js') ?>"></script>
    <script src="<?= base_url('resources/js/home_board.js') ?>"></script>
<?php endif; ?>
<?php if ($seg1 === 'help'): ?>
    <script src="<?= base_url('resources/js/help_page.js') ?>"></script>
<?php endif; ?>
<?php if ($seg1 === 'config'): ?>
    <script src="<?= base_url('resources/js/config_forms.js') ?>"></script>
<?php endif; ?>





</body>
</html>