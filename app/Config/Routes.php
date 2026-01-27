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
    $routes->post('/companies/create', 'CompaniesController::createCompany');
    $routes->post('/companies/update/(:num)', 'CompaniesController::updateCompany/$1');
    $routes->post('/companies/delete/(:num)', 'CompaniesController::deleteCompany/$1');

    //API Key speichern
    $routes->get('/config/api-key', 'ConfigController::apikey');
    $routes->post('/config/api-key', 'ApiController::saveapikey');

    //ESG Reports
    $routes->post('/esg-reports/process', 'ApiController::process');
    $routes->get('/esg-reports/pipelinestatus/(:segment)','ApiController::pipelinestatus/$1');
    $routes->post('internal/pipeline/result', 'ApiResultController::store', ['filter' => 'forcehttps:off']);

    //Config Sektor
    $routes->get('/config/sector', 'ConfigSectorController::sector');
    $routes->post('/config/sector/create', 'ConfigSectorController::createSector');
    $routes->post('/config/sector/update/(:num)', 'ConfigSectorController::updateSector/$1');
    $routes->post('/config/sector/delete/(:num)', 'ConfigSectorController::deleteSector/$1');

    //Config Industrie
    $routes->get('/config/industry', 'ConfigIndustryController::industry');
    $routes->post('/config/industry/create', 'ConfigIndustryController::createIndustry');
    $routes->post('/config/industry/update/(:num)', 'ConfigIndustryController::updateIndustry/$1');
    $routes->post('/config/industry/delete/(:num)', 'ConfigIndustryController::deleteIndustry/$1');

    //Config Standard
    $routes->get('/config/standard', 'ConfigStandardController::standard');
    $routes->post('/config/standard/create', 'ConfigStandardController::createStandard');
    $routes->post('/config/standard/update/(:num)', 'ConfigStandardController::updateStandard/$1');
    $routes->post('/config/standard/delete/(:num)', 'ConfigStandardController::deleteStandard/$1');

    //Config Requirement
    $routes->get('/config/requirement', 'ConfigRequirementController::requirement');
    $routes->post('/config/requirement/create', 'ConfigRequirementController::createRequirement');
    $routes->post('/config/requirement/update/(:num)', 'ConfigRequirementController::updateRequirement/$1');
    $routes->post('/config/requirement/delete/(:num)', 'ConfigRequirementController::deleteRequirement/$1');

    //Config Country
    $routes->get('/config/country', 'ConfigCountryController::country');
    $routes->post('/config/country/create', 'ConfigCountryController::createCountry');
    $routes->post('/config/country/update/(:num)', 'ConfigCountryController::updateCountry/$1');
    $routes->post('/config/country/delete/(:num)', 'ConfigCountryController::deleteCountry/$1');

});

$routes->group('', ['filter' => 'permission:users.manage'], function($routes) {
    #muss in personen geändert werden
    $routes->get('/config/personen', 'ConfigController::personen');
});

service('auth')->routes($routes);


//$routes->get('/testDB', 'CompaniesController::testDb'); // Test database connection