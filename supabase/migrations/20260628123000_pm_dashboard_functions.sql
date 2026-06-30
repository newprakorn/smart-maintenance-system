BEGIN;

-- ============================================================================
-- PM Dashboard Functions
-- Part 8.8B : Set 1
-- ============================================================================

-- ============================================================================
-- Dashboard Summary
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_pm_dashboard_summary()

RETURNS TABLE (

    total_pm_plan BIGINT,

    active_pm_plan BIGINT,

    total_schedule BIGINT,

    overdue_schedule BIGINT,

    today_schedule BIGINT,

    total_execution BIGINT,

    completed_execution BIGINT,

    failed_execution BIGINT

)

LANGUAGE SQL

STABLE

AS

$$

SELECT

    (SELECT COUNT(*) FROM pm_plan),

    (SELECT COUNT(*) FROM pm_plan WHERE is_active = TRUE),

    (SELECT COUNT(*) FROM pm_schedule),

    (

        SELECT COUNT(*)

        FROM pm_schedule

        WHERE next_due_date < CURRENT_DATE

    ),

    (

        SELECT COUNT(*)

        FROM pm_schedule

        WHERE next_due_date = CURRENT_DATE

    ),

    (SELECT COUNT(*) FROM pm_execution),

    (

        SELECT COUNT(*)

        FROM pm_execution

        WHERE execution_status = 'PASSED'

    ),

    (

        SELECT COUNT(*)

        FROM pm_execution

        WHERE execution_status = 'FAILED'

    );

$$;

-- ============================================================================
-- Today's PM Schedule
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_pm_today_schedule()

RETURNS TABLE (

    schedule_id UUID,

    plan_code VARCHAR,

    plan_name VARCHAR,

    machine_code VARCHAR,

    machine_name VARCHAR,

    next_due_date DATE

)

LANGUAGE SQL

STABLE

AS

$$

SELECT

    ps.id,

    pp.plan_code,

    pp.plan_name,

    m.machine_code,

    m.machine_name,

    ps.next_due_date

FROM pm_schedule ps

INNER JOIN pm_plan pp

ON pp.id = ps.pm_plan_id

INNER JOIN machine m

ON m.id = pp.machine_id

WHERE ps.next_due_date = CURRENT_DATE

ORDER BY

ps.next_due_date,

m.machine_code;

$$;

-- ============================================================================
-- Overdue PM
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_pm_overdue()

RETURNS TABLE (

    schedule_id UUID,

    plan_code VARCHAR,

    machine_code VARCHAR,

    machine_name VARCHAR,

    next_due_date DATE,

    overdue_days INTEGER

)

LANGUAGE SQL

STABLE

AS

$$

SELECT

    ps.id,

    pp.plan_code,

    m.machine_code,

    m.machine_name,

    ps.next_due_date,

    CURRENT_DATE - ps.next_due_date

FROM pm_schedule ps

INNER JOIN pm_plan pp

ON pp.id = ps.pm_plan_id

INNER JOIN machine m

ON m.id = pp.machine_id

WHERE

ps.next_due_date < CURRENT_DATE

ORDER BY

ps.next_due_date;

$$;

-- ============================================================================
-- Recent PM Execution
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_pm_recent_execution()

RETURNS TABLE (

    execution_id UUID,

    plan_code VARCHAR,

    plan_name VARCHAR,

    machine_code VARCHAR,

    machine_name VARCHAR,

    execution_status pm_execution_status_enum,

    completed_at TIMESTAMPTZ

)

LANGUAGE SQL

STABLE

AS

$$

SELECT

    pe.id,

    pp.plan_code,

    pp.plan_name,

    m.machine_code,

    m.machine_name,

    pe.execution_status,

    pe.completed_at

FROM pm_execution pe

INNER JOIN pm_schedule ps

ON ps.id = pe.pm_schedule_id

INNER JOIN pm_plan pp

ON pp.id = ps.pm_plan_id

INNER JOIN machine m

ON m.id = pp.machine_id

ORDER BY

pe.completed_at DESC NULLS LAST

LIMIT 20;

$$;

-- ============================================================================
-- Failed Checklist (แก้ไขแล้ว)
-- ============================================================================

CREATE OR REPLACE FUNCTION fn_pm_failed_checklist()

RETURNS TABLE (

    execution_id UUID,

    checklist_name VARCHAR,

    machine_code VARCHAR,

    machine_name VARCHAR,

    compliance_status pm_compliance_status_enum

)

LANGUAGE SQL

STABLE

AS

$$

SELECT

    pe.id,

    pc.checklist_item AS checklist_name,  -- ใช้ checklist_item แทน checklist_name

    m.machine_code,

    m.machine_name,

    c.compliance_status

FROM pm_compliance c

INNER JOIN pm_execution pe

ON pe.id = c.pm_execution_id

INNER JOIN pm_schedule ps

ON ps.id = pe.pm_schedule_id

INNER JOIN pm_plan pp

ON pp.id = ps.pm_plan_id

INNER JOIN machine m

ON m.id = pp.machine_id

INNER JOIN pm_plan_checklist ppc          -- JOIN ผ่าน pm_plan_checklist

ON ppc.id = c.pm_plan_checklist_id

INNER JOIN pm_checklist pc

ON pc.id = ppc.pm_checklist_id            -- ใช้ pm_checklist_id จาก pm_plan_checklist

WHERE

c.compliance_status = 'FAILED'

ORDER BY

pe.completed_at DESC NULLS LAST;

$$;

-- ============================================================================
-- Function Comments
-- ============================================================================

COMMENT ON FUNCTION fn_pm_dashboard_summary IS
'Returns dashboard summary KPIs for preventive maintenance';

COMMENT ON FUNCTION fn_pm_today_schedule IS
'Returns all preventive maintenance schedules due today';

COMMENT ON FUNCTION fn_pm_overdue IS
'Returns overdue preventive maintenance schedules';

COMMENT ON FUNCTION fn_pm_recent_execution IS
'Returns recent preventive maintenance executions';

COMMENT ON FUNCTION fn_pm_failed_checklist IS
'Returns failed preventive maintenance checklist items';

-- ============================================================================
-- Example Usage
-- ============================================================================

-- SELECT * FROM fn_pm_dashboard_summary();
-- SELECT * FROM fn_pm_today_schedule();
-- SELECT * FROM fn_pm_overdue();
-- SELECT * FROM fn_pm_recent_execution();
-- SELECT * FROM fn_pm_failed_checklist();

COMMIT;