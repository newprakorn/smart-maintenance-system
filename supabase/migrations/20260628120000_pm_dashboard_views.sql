BEGIN;

-- ============================================================================
-- PART 8.8A : PM DASHBOARD VIEWS
-- ============================================================================

-- ============================================================================
-- Dashboard Summary (ใช้ Subquery แทน LEFT JOIN)
-- ============================================================================

CREATE OR REPLACE VIEW vw_pm_dashboard_summary AS
SELECT
    CURRENT_DATE AS snapshot_date,

    (SELECT COUNT(*) FROM pm_schedule WHERE next_due_date = CURRENT_DATE) AS today_pm,

    (SELECT COUNT(*) FROM pm_schedule WHERE next_due_date < CURRENT_DATE) AS overdue_pm,

    (SELECT COUNT(*) FROM pm_schedule 
     WHERE next_due_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 day') AS upcoming_7_days,

    (SELECT COUNT(*) FROM pm_execution) AS total_execution,

    (SELECT COUNT(*) FROM pm_execution WHERE execution_status = 'PASSED') AS passed_execution,

    (SELECT COUNT(*) FROM pm_execution WHERE execution_status = 'FAILED') AS failed_execution,

    (SELECT ROUND(AVG(duration_minutes), 2) FROM pm_execution) AS avg_execution_minutes;

COMMENT ON VIEW vw_pm_dashboard_summary IS 'Overall Preventive Maintenance Dashboard Summary';

-- ============================================================================
-- Today's Schedule (ใช้ machine และ work_order_no)
-- ============================================================================

CREATE OR REPLACE VIEW vw_pm_today_schedule AS
SELECT
    ps.id,
    ps.next_due_date,
    pp.plan_code,
    pp.plan_name,
    m.machine_code,
    m.machine_name,
    wo.work_order_no,     -- แก้เป็น work_order_no
    wo.status
FROM pm_schedule ps
INNER JOIN pm_plan pp ON pp.id = ps.pm_plan_id
INNER JOIN machine m ON m.id = pp.machine_id   -- ใช้ machine_id
LEFT JOIN pm_work_order pwo ON pwo.pm_schedule_id = ps.id
LEFT JOIN work_order wo ON wo.id = pwo.work_order_id
WHERE ps.next_due_date = CURRENT_DATE;

COMMENT ON VIEW vw_pm_today_schedule IS 'Preventive Maintenance scheduled for today';

-- ============================================================================
-- Overdue PM (ใช้ machine)
-- ============================================================================

CREATE OR REPLACE VIEW vw_pm_overdue AS
SELECT
    ps.id,
    pp.plan_code,
    pp.plan_name,
    m.machine_code,
    m.machine_name,
    ps.next_due_date,
    CURRENT_DATE - ps.next_due_date AS overdue_days
FROM pm_schedule ps
INNER JOIN pm_plan pp ON pp.id = ps.pm_plan_id
INNER JOIN machine m ON m.id = pp.machine_id
WHERE ps.next_due_date < CURRENT_DATE;

COMMENT ON VIEW vw_pm_overdue IS 'Overdue Preventive Maintenance tasks';

-- ============================================================================
-- Recent PM Execution (ใช้ machine และ concat first/last name)
-- ============================================================================

CREATE OR REPLACE VIEW vw_pm_recent_execution AS
SELECT
    pe.id,
    pe.started_at,
    pe.completed_at,
    pe.execution_status,
    pe.duration_minutes,
    m.machine_code,
    m.machine_name,
    pp.plan_code,
    pp.plan_name,
    up.first_name || ' ' || up.last_name AS executed_by   -- แทน full_name
FROM pm_execution pe
INNER JOIN pm_schedule ps ON ps.id = pe.pm_schedule_id
INNER JOIN pm_plan pp ON pp.id = ps.pm_plan_id
INNER JOIN machine m ON m.id = pp.machine_id
LEFT JOIN user_profile up ON up.id = pe.executed_by
ORDER BY pe.started_at DESC;

COMMENT ON VIEW vw_pm_recent_execution IS 'Recent preventive maintenance execution history';

-- ============================================================================
-- Most Failed Checklist (ใช้ checklist_item และ sequence_no)
-- ============================================================================

CREATE OR REPLACE VIEW vw_pm_failed_checklist AS
SELECT
    pc.sequence_no AS checklist_code,          -- ใช้ sequence_no แทนรหัส
    pc.checklist_item AS checklist_name,       -- ใช้ checklist_item แทนชื่อ
    COUNT(*) AS failed_count
FROM pm_compliance c
INNER JOIN pm_plan_checklist ppc ON ppc.id = c.pm_plan_checklist_id
INNER JOIN pm_checklist pc ON pc.id = ppc.pm_checklist_id
WHERE c.compliance_status = 'FAILED'
GROUP BY pc.sequence_no, pc.checklist_item
ORDER BY failed_count DESC;

COMMENT ON VIEW vw_pm_failed_checklist IS 'Top failed PM checklist items';

-- ============================================================================
-- Monthly KPI (ไม่เปลี่ยนแปลง)
-- ============================================================================

CREATE OR REPLACE VIEW vw_pm_monthly_kpi AS
SELECT
    snapshot_date,
    completion_rate,
    compliance_rate,
    pass_rate,
    failure_rate,
    avg_execution_minutes,
    scheduled_pm,
    completed_pm,
    overdue_pm
FROM pm_kpi_snapshot
WHERE period_type = 'MONTHLY'
ORDER BY snapshot_date;

COMMENT ON VIEW vw_pm_monthly_kpi IS 'Monthly PM KPI trend for dashboard';

-- ============================================================================
-- END PART 8.8A
-- ============================================================================

COMMIT;