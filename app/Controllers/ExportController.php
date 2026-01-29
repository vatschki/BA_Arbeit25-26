<?php

namespace App\Controllers;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use App\Models\ReportValueModel;
use App\Models\ReportModel;

class ExportController extends BaseController
{
    public function values(int $report_id)
    {
        $valueModel  = new ReportValueModel();
        $reportModel = new ReportModel();

        // Daten holen (mit company_name aus Join)
        $data = $valueModel->getReportValues($report_id);

        if (empty($data)) {
            throw new \RuntimeException('Keine Daten für diesen Report gefunden.');
        }

        // Report-Meta
        $report = $reportModel->getReportById($report_id);

        $companyName = $data[0]['company_name'];
        $year        = $report['reporting_year'];

        $safeCompany = preg_replace('/[^a-zA-Z0-9_-]/', '_', $companyName);
        $filename = "{$safeCompany}_{$year}_values.xlsx";

        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        // Header
        $sheet->setCellValue('A1', 'ID');
        $sheet->setCellValue('B1', 'Requirement ID');
        $sheet->setCellValue('C1', 'Report ID');
        $sheet->setCellValue('D1', 'Job ID');
        $sheet->setCellValue('E1', 'Page ID');
        $sheet->setCellValue('F1', 'Page');
        $sheet->setCellValue('G1', 'Text');

        // Daten
        $row = 2;
        foreach ($data as $value) {
            $sheet->setCellValue('A' . $row, $value['value_id']);
            $sheet->setCellValue('B' . $row, $value['requirement_id']);
            $sheet->setCellValue('C' . $row, $value['report_id']);
            $sheet->setCellValue('D' . $row, $value['job_id']);
            $sheet->setCellValue('E' . $row, $value['page_id']);
            $sheet->setCellValue('F' . $row, $value['page']);
            $sheet->setCellValue('G' . $row, $value['text']);
            $row++;
        }

        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header("Content-Disposition: attachment; filename=\"$filename\"");
        header('Cache-Control: max-age=0');

        $writer = new Xlsx($spreadsheet);
        $writer->save('php://output');
        exit;
    }
}
