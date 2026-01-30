<?php

namespace App\Models;

use App\Models\BaseModel;

use RuntimeException;

class JobModel extends BaseModel{

    protected $table      = 'jobs';
    protected $primaryKey = 'id';

    protected $allowedFields = [
        'job_id',
        'report_id',
        'standard_id',
        'requirements_all',
        'status',
    ];

    protected $useTimestamps = true;
    protected $updatedField  = 'updated_at';


    public function createJob(array $data): int
    {
        if (! $this->insert($data)) {
            throw new \RuntimeException('Job konnte nicht angelegt werden');
        }

        return (int) $this->getInsertID();
    }

    public function findByjob_id(string $job_id): ?array
    {
        return $this->where('job_id', $job_id)->first();
    }

    public function findRunningByReportId(int $reportId): ?array
    {
        return $this->where('report_id', $reportId)
            ->whereIn('status', ['pending', 'running'])
            ->first();
    }

    public function updateStatus(string $job_id, string $status): bool {
        return $this->where('job_id', $job_id)
            ->set(['status'     => $status])
            ->update();
    }

    public function bindReport(string $job_id, int $reportId): bool
    {
        return $this->where('job_id', $job_id)
            ->set([
                'report_id'  => $reportId,
                'updated_at' => date('Y-m-d H:i:s'),
            ])
            ->update();
    }

    public function markFinished(string $job_id, string $status = 'finished'): bool
    {
        return $this->where('job_id', $job_id)
            ->set([
                'status'     => $status,
                'updated_at' => date('Y-m-d H:i:s'),
            ])
            ->update();
    }

    public function findByReportId(int $reportId): ?array
    {
        return $this->where('report_id', $reportId)->first();
    }

}
