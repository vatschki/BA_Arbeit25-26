<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'CompaniesController::index'); //home page
$routes->get('/companies', 'CompaniesController::index');
$routes->get('/esr-reports', 'EsrReportsController::index');
