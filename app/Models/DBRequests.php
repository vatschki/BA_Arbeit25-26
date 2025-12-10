<?php

namespace App\Models;

use CodeIgniter\Model;

class DBRequests extends Model {

    protected $companies;
    protected $industries;
    protected $countries;
    protected $sectors;

    public function __construct() {
        parent::__construct();

        $this->companies = $this->db->table("companies");
        $this->industries = $this->db->table("industries");
        $this->countries = $this->db->table("countries");
        $this->sectors = $this->db->table("sectors");
    }

    //--------------------------------------------------------------------
    // Get Funktionen für Companies
    //--------------------------------------------------------------------

    public function getCompanies(){
        $this->companies->select("
            companies.*,
            industries.name AS industry_name,
            countries.name_de AS country_name_de,
            countries.name_eng AS country_name_eng,
            sectors.name AS sector_name"
        );

        $this->companies->join("industries", "companies.industry_id = industries.id", "left");
        $this->companies->join("countries", "companies.country_id = countries.id", "left");
        $this->companies->join("sectors", "industries.sector_id = sectors.id", "left");

        $result = $this->companies->get();
        return $result->getResultArray();
    }

    public function createCompany()
    {

    }



    public function getCountries(){
        $result = $this->countries->get();
        return $result->getResultArray();

    }

    public function getSectors(){
        $result = $this->sectors->get();
        return $result->getResultArray();
    }

    public function getIndustries(){
        $result = $this->industries->get();
        return $result->getResultArray();
    }


}