<?php if (!empty($report_values)): ?>
    <?php foreach ($report_values as $value): ?>
        <tr>
            <td><?= esc($value['value_id']) ?></td>
            <td><?= esc($value['requirement_code']) ?></td>
            <td><?= esc($value['page_id']) ?></td>
            <td><?= esc($value['page']) ?></td>
            <td><?= esc($value['text']) ?></td>
            <td><?= esc($value['company_name']) ?></td>
            <td><?= esc($value['report_id']) ?></td>
            <td><?= esc($value['job_id']) ?></td>
        </tr>
    <?php endforeach; ?>
<?php else: ?>
    <tr class="no-data-row">
        <td colspan="8">Keine Daten verfügbar.</td>
    </tr>
<?php endif; ?>
