<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'CompaniesController::index'); //home page
$routes->get('/companies', 'CompaniesController::index');
$routes->get('/esg-reports', 'EsgReportsController::index');
$routes->get('/what-it-is', 'WhatItIs::index');
$routes->get('/help', 'HelpController::index');