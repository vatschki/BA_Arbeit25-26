<?php

namespace Config;

use CodeIgniter\Config\BaseConfig;
use CodeIgniter\Validation\StrictRules\CreditCardRules;
use CodeIgniter\Validation\StrictRules\FileRules;
use CodeIgniter\Validation\StrictRules\FormatRules;
use CodeIgniter\Validation\StrictRules\Rules;

class Validation extends BaseConfig
{
    // --------------------------------------------------------------------
    // Setup
    // --------------------------------------------------------------------

    /**
     * Stores the classes that contain the
     * rules that are available.
     *
     * @var list<string>
     */
    public array $ruleSets = [
        Rules::class,
        FormatRules::class,
        FileRules::class,
        CreditCardRules::class,
    ];

    /**
     * Specifies the views that are used to display the
     * errors.
     *
     * @var array<string, string>
     */
    public array $templates = [
        'list'   => 'CodeIgniter\Validation\Views\list',
        'single' => 'CodeIgniter\Validation\Views\single',
    ];

    // --------------------------------------------------------------------
    // Rules
    // --------------------------------------------------------------------
    public array $company = [

        'name' => [
            'rules'  => 'required|min_length[2]|max_length[255]',
            'errors' => [
                'required' => 'Pflichtfeld bitte Namen ausfüllen',
            ],
        ],

        'country_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte Land auswählen',
            ],
        ],

        'industry_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte Industrie angeben',
            ],
        ],
    ];

    public array $sector = [

        'name' => [
            'rules'  => 'required|min_length[2]|max_length[255]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Namen ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],
    ];

    public array $industry = [

        'sector_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte Sector angeben',
            ],
        ],

        'name' => [
            'rules'  => 'required|min_length[2]|max_length[255]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Namen ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],
    ];

    public array $standard = [

        'code' => [
            'rules'  => 'required|min_length[2]|max_length[100]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Code ausfüllen',
                'min_length' => 'Der Code ist zu kurz',
                'max_length' => 'Der Code ist zu lang',
            ],
        ],

        'name' => [
            'rules'  => 'required|min_length[2]|max_length[500]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Namen ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],

        'description' => [
            'rules'  => 'required|max_length[500]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Beschreibung ausfüllen',
                'max_length' => 'Die Beschreibung ist zu lang',
            ],
        ],

        'description_eng' => [
            'rules'  => 'required|max_length[500]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte englische Beschreibung ausfüllen',
                'max_length' => 'Die englische Beschreibung ist zu lang',
            ],
        ],
    ];

    public array $requirement = [

        'standard_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte Standard angeben',
            ],
        ],

        'code' => [
            'rules'  => 'required|min_length[2]|max_length[100]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Code ausfüllen',
                'min_length' => 'Der Code ist zu kurz',
                'max_length' => 'Der Code ist zu lang',
            ],
        ],

        'disclosure_requirement' => [
            'rules'  => 'required|min_length[2]|max_length[50]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte DR ausfüllen',
                'min_length' => 'Die Anforderung ist zu kurz',
                'max_length' => 'Die Anforderung ist zu lang',
            ],
        ],

        'paragraph' => [
            'rules'  => 'required|max_length[50]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Paragraph ausfüllen',
                'max_length' => 'Der Paragraph ist zu lang',
            ],
        ],

        'title' => [
            'rules'  => 'required|max_length[255]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Titel ausfüllen',
                'max_length' => 'Der Titel ist zu lang',
            ],
        ],

        'data_type' => [
            'rules'  => 'permit_empty|max_length[200]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Datentyp ausfüllen',
                'max_length' => 'Der Datentyp ist zu lang',
            ],
        ],

        'conditional_alternative_disclosure_requirement' => [
            'rules'  => 'permit_empty|max_length[50]',
            'errors' => [
                'max_length' => 'Die alternative Anforderung ist zu lang',
            ],
        ],
    ];

    public array $country = [

        'code' => [
            'rules'  => 'required|min_length[3]|max_length[100]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Ländercode ausfüllen',
                'min_length' => 'Der Code ist zu kurz',
                'max_length' => 'Der Code ist zu lang',
            ],
        ],

        'name_de' => [
            'rules'  => 'required|min_length[3]|max_length[200]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Namen auf deutsch ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],

        'name_eng' => [
            'rules'  => 'required|min_length[3]|max_length[200]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Namen auf englisch ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],

        'region' => [
            'rules'  => 'required|min_length[3]|max_length[200]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte Region ausfüllen',
                'min_length' => 'Die Region ist zu kurz',
                'max_length' => 'Die Region ist zu lang',
            ],
        ],

        'eu_member' => [
            'rules' => 'required|in_list[0,1]',
        ],
    ];
}
