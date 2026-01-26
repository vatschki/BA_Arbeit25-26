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

        'company_name' => [
            'rules'  => 'required|min_length[2]|max_length[255]',
            'errors' => [
                'required' => 'Pflichtfeld bitte ausfüllen',
            ],
        ],

        'country_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte ausfüllen',
            ],
        ],

        'industry_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte ausfüllen',
            ],
        ],
    ];

    public array $sector = [

        'sector_name' => [
            'rules'  => 'required|min_length[2]|max_length[255]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],
    ];

    public array $industry = [

        'sector_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte ausfüllen',
            ],
        ],

        'industry_name' => [
            'rules'  => 'required|min_length[2]|max_length[255]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],
    ];

    public array $standard = [

        'requirement_code' => [
            'rules'  => 'required|min_length[2]|max_length[100]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte ausfüllen',
                'min_length' => 'Der Code ist zu kurz',
                'max_length' => 'Der Code ist zu lang',
            ],
        ],

        'requirement_name' => [
            'rules'  => 'required|min_length[2]|max_length[500]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte ausfüllen',
                'min_length' => 'Der Name ist zu kurz',
                'max_length' => 'Der Name ist zu lang',
            ],
        ],

        'description' => [
            'rules'  => 'permit_empty|max_length[500]',
            'errors' => [
                'max_length' => 'Die Beschreibung ist zu lang',
            ],
        ],

        'description_eng' => [
            'rules'  => 'permit_empty|max_length[500]',
            'errors' => [
                'max_length' => 'Die englische Beschreibung ist zu lang',
            ],
        ],
    ];

    public array $requirement = [

        'standard_id' => [
            'rules'  => 'required|is_natural_no_zero',
            'errors' => [
                'required' => 'Pflichtfeld bitte ausfüllen',
            ],
        ],

        'requirement_code' => [
            'rules'  => 'required|min_length[2]|max_length[100]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte ausfüllen',
                'min_length' => 'Der Code ist zu kurz',
                'max_length' => 'Der Code ist zu lang',
            ],
        ],

        'disclosure_requirement' => [
            'rules'  => 'required|min_length[2]|max_length[50]',
            'errors' => [
                'required'   => 'Pflichtfeld bitte ausfüllen',
                'min_length' => 'Die Anforderung ist zu kurz',
                'max_length' => 'Die Anforderung ist zu lang',
            ],
        ],

        'requirement_paragraph' => [
            'rules'  => 'required|max_length[50]',
            'errors' => [
                'max_length' => 'Der Paragraph ist zu lang',
            ],
        ],

        'requirement_title' => [
            'rules'  => 'required|max_length[255]',
            'errors' => [
                'max_length' => 'Der Titel ist zu lang',
            ],
        ],

        'data_type' => [
            'rules'  => 'permit_empty|max_length[200]',
            'errors' => [
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
}
