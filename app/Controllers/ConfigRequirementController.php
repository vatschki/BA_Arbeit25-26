<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use RuntimeException;

class ConfigRequirementController extends BaseController
{
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;
    protected StandardModel $standardModel;
    protected RequirementModel $requirementModel;

    public function __construct()
    {
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->sectorModel = new SectorModel();
        $this->standardModel = new StandardModel();
        $this->requirementModel = new RequirementModel();
    }

    private function loadConfigData()
    {
        return [
            'industries' => $this->industryModel->getIndustries(),
            'sectors' => $this->sectorModel->getSectors(),
            'standards' => $this->standardModel->getStandards(),
            'requirements' => $this->requirementModel->getRequirements(),
            'countries' => $this->countryModel->getCountries(),
        ];
    }

    //--------------------
    // Requirement Methods
    //--------------------
    public function requirement()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_requirement', $data);
        echo view('templates/footer');
    }

    public function createRequirement()
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('message', 'Keine Berechtigung.');
        }

        if (! $this->validate('requirement')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openRequirementModal', true);
        }

        $data = [
            'standard_id'       => $this->request->getPost('standard_id'),
            'code'        => $this->request->getPost('code'),
            'disclosure_requirement'        => $this->request->getPost('disclosure_requirement'),
            'paragraph'        => $this->request->getPost('paragraph'),
            'title'        => $this->request->getPost('title'),
            'data_type'        => $this->request->getPost('data_type'),
            'conditional_alternative_disclosure_requirement'        => $this->request->getPost('conditional_alternative_disclosure_requirement'),
        ];

        try {
            $this->requirementModel->createRequirement($data);

            return redirect()
                ->to('/config/requirement')
                ->with('success', 'Anforderung erfolgreich angelegt.');
        } catch (\RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openRequirementModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    public function updateRequirement($requirement_id)
    {
        if (! $this->validate('requirement')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openRequirementModal', true);
        }

        $data = [
            'standard_id'       => $this->request->getPost('standard_id'),
            'code'        => $this->request->getPost('code'),
            'disclosure_requirement'        => $this->request->getPost('disclosure_requirement'),
            'paragraph'        => $this->request->getPost('paragraph'),
            'title'        => $this->request->getPost('title'),
            'data_type'        => $this->request->getPost('data_type'),
            'conditional_alternative_disclosure_requirement'        => $this->request->getPost('conditional_alternative_disclosure_requirement'),
        ];

        try {
            $this->requirementModel->updateRequirement($requirement_id, $data);

            return redirect()
                ->to('/config/requirement')
                ->with('success', 'Anforderung erfolgreich aktualisiert.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openRequirementModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    public function deleteRequirement($requirement_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->requirementModel->deleteRequirement($requirement_id);

            return redirect()
                ->to('/config/requirement')
                ->with('success', 'Anforderung erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/requirement')
                ->with('error', $exception->getMessage());
        }
    }
}