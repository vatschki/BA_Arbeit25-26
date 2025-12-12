<?php

namespace App\Controllers;

use App\Models\CompanyModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\SectorModel;
use RuntimeException;

class CompaniesController extends BaseController
{
    protected CompanyModel $companyModel;
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;

    public function __construct()
    {
        $this->companyModel = new CompanyModel();
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->sectorModel = new SectorModel();
    }

    public function index()
    {

        $data = [
            'companies' => $this->companyModel->getCompanies(),
            'countries' => $this->countryModel->getCountries(),
            'sectors' => $this->sectorModel->getSectors(),
            'industries' => $this->industryModel->getIndustriesWithSectors()
        ];

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Companies', $data);
        echo view('templates/footer');
    }

    public function create(){

        $company_name = $this->request->getPost('company_name');
        $country_id = $this->request->getPost('country_id');
        $industry_id = $this->request->getPost('industry_id');
        $description = $this->request->getPost('description');

        $data = [
            'name' => $company_name,
            'country_id' => $country_id,
            'industry_id' => $industry_id,
            'description' => $description
        ];

        try{
            $this->companyModel->createCompany($data);
        }catch (RuntimeException $exception){
            return redirect()->back()
                ->withInput()
                ->with('errors', $this->companyModel->errors())
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/companies')
            ->with('message', 'Unternehmen erfolgreich angelegt.');
    }























    public function testDb()
    {
        $db = \Config\Database::connect();
        $query = $db->query("SHOW TABLES");
        $result = $query->getResult();

        return print_r($result);
    }
}
