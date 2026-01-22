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
    $routes->post('/companies/update/(:num)', 'CompaniesController::update/$1');
    $routes->post('/companies/delete/(:num)', 'CompaniesController::delete/$1');

    //API Key speichern
    $routes->get('/config/api-key', 'ConfigController::apikey');
    $routes->post('/config/api-key', 'ApiController::saveapikey');

    //ESG Reports
    $routes->post('/esg-reports/process', 'ApiController::process');
    $routes->get('/esg-reports/pipelinestatus/(:segment)','ApiController::pipelinestatus/$1');
    $routes->post('internal/pipeline/result', 'ApiResultController::store', ['filter' => 'forcehttps:off']);

    //Config Sektor
    $routes->get('/config/sector', 'ConfigController::sector');

    //Config Industrie
    $routes->get('/config/industry', 'ConfigController::industry');

    //Config Standard
    $routes->get('/config/standard', 'ConfigController::standard');

    //Config Requirement
    $routes->get('/config/requirement', 'ConfigController::requirement');

    //Config Country
    $routes->get('/config/country', 'ConfigController::country');

});

$routes->group('', ['filter' => 'permission:users.manage'], function($routes) {
    #muss in personen geändert werden
    $routes->get('/config/general', 'ConfigController::general');
});

service('auth')->routes($routes);


//$routes->get('/testDB', 'CompaniesController::testDb'); // Test database connection