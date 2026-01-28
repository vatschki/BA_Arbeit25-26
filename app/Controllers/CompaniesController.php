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

        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        if (! $this->validate('company')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openCompanyModal', true);
        }

        $name      = trim($this->request->getPost('name'));
        $countryId  = (int) $this->request->getPost('country_id');
        $industryId = (int) $this->request->getPost('industry_id');

        if (! $this->countryModel->exists($countryId)) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', ['country_id' => 'Dieses Land existiert nicht.'])
                ->with('openCompanyModal', true);
        }

        if (! $this->industryModel->exists($industryId)) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', ['industry_id' => 'Diese Branche existiert nicht.'])
                ->with('openCompanyModal', true);
        }

        if ($this->companyModel->existsByNameAndCountry($name, $countryId)) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', [
                    'name' => 'Dieses Unternehmen existiert in diesem Land bereits.'
                ])
                ->with('openCompanyModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
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
                ->with('error', $exception->getMessage());
        }

        return redirect()
            ->to('/companies')
            ->with('success', 'Unternehmen erfolgreich angelegt.');
    }

    public function updateCompany(int $companyId)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        if (! $this->validate('company')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openCompanyModal', true);
        }

        $name      = trim($this->request->getPost('name'));
        $countryId = (int) $this->request->getPost('country_id');

        if ($this->companyModel->existsByNameAndCountry($name, $countryId, $companyId)) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', [
                    'name' => 'Dieses Unternehmen existiert in diesem Land bereits.'
                ])
                ->with('openCompanyModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
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
                ->with('errors', $this->validator->getErrors())
                ->with('openCompanyModal', true);
        }

        return redirect()
            ->to('/companies')
            ->with('success', 'Unternehmen erfolgreich aktualisiert.');
    }


    public function deleteCompany(int $companyId)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->companyModel->deleteCompany($companyId);
            return redirect()
                ->to('/companies')
                ->with('success', 'Unternehmen erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/companies')
                ->with('error', $exception->getMessage());
        }
    }
}
