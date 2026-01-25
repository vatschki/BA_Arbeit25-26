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

    public function createCompany(){

        if (! $this->validate('company')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openCompanyModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('company_name'),
            'country_id'  => $this->request->getPost('country_id'),
            'industry_id' => $this->request->getPost('industry_id'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->companyModel->createCompany($data);
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openCompanyModal', true)
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/companies')
            ->with('message', 'Unternehmen erfolgreich angelegt.');
    }

    public function updateCompany(int $companyId)
    {
        if (! $this->validate('company')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openCompanyModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('company_name'),
            'country_id'  => $this->request->getPost('country_id'),
            'industry_id' => $this->request->getPost('industry_id'),
            'description' => $this->request->getPost('description'),
        ];

        try {
            $this->companyModel->updateCompany($companyId, $data);
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openCompanyModal', true)
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/companies')
            ->with('message', 'Unternehmen erfolgreich aktualisiert.');
    }


    public function deleteCompany(int $companyId)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->companyModel->deleteCompany($companyId);
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/companies')
                ->with('message', $exception->getMessage());
        }

        return redirect()
            ->to('/companies')
            ->with('message', 'Unternehmen erfolgreich gelöscht.');
    }
}
