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

<?php
// URL-Segment bestimmen
$uri = service('uri');
$seg1 = $uri->getSegment(1) ?? '';
?>

<!-- Page-spezifische JS-Dateien laden -->
<?php if (in_array($seg1, ['companies', 'esg-reports'], true)): ?>
    <script src="<?= base_url('resources/js/home_board.js') ?>"></script>
<?php endif; ?>

</body>
</html>