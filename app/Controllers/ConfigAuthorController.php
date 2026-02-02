<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\AuthorModel;
use App\Models\CountryModel;
use App\Models\IndustryModel;
use App\Models\RequirementModel;
use App\Models\SectorModel;
use App\Models\StandardModel;
use RuntimeException;

class ConfigAuthorController extends BaseController
{
    protected CountryModel $countryModel;
    protected IndustryModel $industryModel;
    protected SectorModel $sectorModel;
    protected StandardModel $standardModel;
    protected RequirementModel $requirementModel;
    protected AuthorModel $authorModel;

    public function __construct()
    {
        $this->countryModel = new CountryModel();
        $this->industryModel = new IndustryModel();
        $this->sectorModel = new SectorModel();
        $this->standardModel = new StandardModel();
        $this->requirementModel = new RequirementModel();
        $this->authorModel = new AuthorModel();
    }

    private function loadConfigData()
    {
        return [
            'industries' => $this->industryModel->getIndustries(),
            'sectors' => $this->sectorModel->getSectors(),
            'standards' => $this->standardModel->getStandards(),
            'requirements' => $this->requirementModel->getRequirements(),
            'countries' => $this->countryModel->getCountries(),
            'authors' => $this->authorModel->getAuthors(),
        ];
    }

    //--------------------
    // Author Methods
    //--------------------

    public function author()
    {
        $data = $this->loadConfigData();

        echo view('templates/header_home');
        echo view('templates/menu_home');
        echo view('pages/page_Config_author', $data);
        echo view('templates/footer');
    }

    public function createAuthor()
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('error', 'Keine Berechtigung.');
        }

        if (! $this->validate('author')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('errors', $this->validator->getErrors())
                ->with('openAuthorModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
            'type'        => $this->request->getPost('type'),
        ];

        try {
            $this->authorModel->createAuthor($data);

            return redirect()
                ->to('/config/author')
                ->with('success', 'Eintrag erfolgreich angelegt.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openAuthorModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    public function updateAuthor($author_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            return redirect()->back()->with('error', 'Keine Berechtigung.');
        }

        if (! $this->validate('author')) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openAuthorModal', true);
        }

        $data = [
            'name'        => $this->request->getPost('name'),
            'description' => $this->request->getPost('description'),
            'type'        => $this->request->getPost('type'),
        ];

        try {
            $this->authorModel->updateAuthor($author_id, $data);

            return redirect()
                ->to('/config/author')
                ->with('success', 'Eintrag erfolgreich aktualisiert.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->back()
                ->withInput()
                ->with('openAuthorModal', true)
                ->with('error', $exception->getMessage());
        }
    }

    public function deleteAuthor($author_id)
    {
        if (! auth()->loggedIn() || ! auth()->user()->can('content.manage')) {
            throw new \CodeIgniter\Exceptions\PageForbiddenException();
        }

        try {
            $this->authorModel->deleteAuthor($author_id);

            return redirect()
                ->to('/config/author')
                ->with('success', 'Eintrag erfolgreich gelöscht.');
        } catch (RuntimeException $exception) {
            return redirect()
                ->to('/config/author')
                ->with('error', $exception->getMessage());
        }
    }
}