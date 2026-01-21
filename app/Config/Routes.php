<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
#freie Seiten
$routes->get('/', 'CompaniesController::index'); //home page
$routes->get('/companies', 'CompaniesController::index');

$routes->get('/esg-reports', 'EsgReportsController::index');
$routes->get('/esg-reports/company/(:num)', 'EsgReportsController::byCompany/$1');
$routes->get('/esg-reports/value/(:num)', 'ValueController::index/$1');

$routes->get('esg-reports/value/(:num)/values', 'ValueController::valuesPartial/$1');

$routes->get('/help', 'HelpController::index');


#permission manage content Seiten
$routes->group('', ['filter' => 'permission:content.manage'], function($routes) {
    //Unternehmen
    $routes->post('/companies/create', 'CompaniesController::create');
    $routes->get('/companies/edit/(:num)', 'CompaniesController::edit/$1');
    $routes->post('/companies/update/(:num)', 'CompaniesController::update/$1');
    $routes->post('/companies/delete/(:num)', 'CompaniesController::delete/$1');
});

#permission admin access Seiten

#permission user management Seiten


$routes->get('/config/api-key', 'ConfigController::apikey');
$routes->post('/config/api-key', 'ApiController::saveapikey');
$routes->get('/config/sector', 'ConfigController::sector');
$routes->get('/config/industry', 'ConfigController::industry');
$routes->get('/config/standard', 'ConfigController::standard');
$routes->get('/config/requirement', 'ConfigController::requirement');
$routes->get('/config/country', 'ConfigController::country');

$routes->post('/esg-reports/process', 'ApiController::process');
$routes->get('/esg-reports/pipelinestatus/(:segment)','ApiController::pipelinestatus/$1');
$routes->post('internal/pipeline/result', 'ApiResultController::store', ['filter' => 'forcehttps:off']);



#admin Seiten

#muss in personen geändert werden
$routes->get('/config/general', 'ConfigController::general');
service('auth')->routes($routes);


//$routes->get('/testDB', 'CompaniesController::testDb'); // Test database connection