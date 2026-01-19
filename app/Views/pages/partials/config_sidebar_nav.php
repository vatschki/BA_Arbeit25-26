<?php
$path = trim(service('request')->getUri()->getPath(), '/');
$path = preg_replace('#^index\.php/#', '', $path);
?>
<aside class="config-sidebar-nav">
    <a class="nav-link <?= $path === 'config/general' ? 'is-active' : '' ?>"
       href="<?= base_url('config/general') ?>">Allgemein</a>

    <a class="nav-link <?= $path === 'config/api-key' ? 'is-active' : '' ?>"
       href="<?= base_url('config/api-key') ?>">API-Key</a>

    <a class="nav-link <?= $path === 'config/country' ? 'is-active' : '' ?>"
       href="<?= base_url('config/country') ?>">Länder</a>

    <a class="nav-link <?= $path === 'config/sector' ? 'is-active' : '' ?>"
       href="<?= base_url('config/sector') ?>">Sektor</a>

    <a class="nav-link <?= $path === 'config/industry' ? 'is-active' : '' ?>"
       href="<?= base_url('config/industry') ?>">Industrie</a>

    <a class="nav-link <?= $path === 'config/standard' ? 'is-active' : '' ?>"
       href="<?= base_url('config/standard') ?>">ESRS-Standard</a>

    <a class="nav-link <?= $path === 'config/requirement' ? 'is-active' : '' ?>"
       href="<?= base_url('config/requirement') ?>">ESRS-Anforderung</a>
</aside>
