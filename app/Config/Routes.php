<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'CompaniesController::index'); //home page
$routes->get('/companies', 'CompaniesController::index');
$routes->post('/companies/create', 'CompaniesController::create');

$routes->get('/esg-reports', 'EsgReportsController::index');
$routes->get('/esg-reports/company/(:num)', 'EsgReportsController::byCompany/$1');

$routes->post('/esg-reports/process', 'ReportsApiController::process');


$routes->get('/help', 'HelpController::index');

$routes->get('/config/general', 'ConfigController::general');
$routes->get('/config/api-key', 'ConfigController::apikey');
$routes->get('/config/standard', 'ConfigController::standard');
$routes->get('/config/requirement', 'ConfigController::requirement');

//$routes->get('/testDB', 'CompaniesController::testDb'); // Test database connection