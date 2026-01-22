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
}
