BEGIN;

-- ============================================================================
-- PART 8.5 : PM EXECUTION
-- ============================================================================

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_type
        WHERE typname = 'pm_execution_status_enum'
    ) THEN
        CREATE TYPE pm_execution_status_enum AS ENUM (
            'PENDING',
            'IN_PROGRESS',
            'PASSED',
            'FAILED',
            'PARTIAL',
            'CANCELLED'
        );
    END IF;
END $$;

CREATE TABLE pm_execution (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    pm_schedule_id UUID NOT NULL,

    work_order_id UUID NOT NULL,

    execution_status pm_execution_status_enum
        NOT NULL
        DEFAULT 'PENDING',

    started_at TIMESTAMPTZ,

    completed_at TIMESTAMPTZ,

    duration_minutes INTEGER,

    passed BOOLEAN,

    result_summary TEXT,

    finding TEXT,

    recommendation TEXT,

    executed_by UUID,

    verified_by UUID,

    verified_at TIMESTAMPTZ,

    next_due_date DATE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    created_by UUID,

    updated_by UUID,

    CONSTRAINT fk_pm_execution_schedule
        FOREIGN KEY (pm_schedule_id)
        REFERENCES pm_schedule(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_pm_execution_work_order
        FOREIGN KEY (work_order_id)
        REFERENCES work_order(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_pm_execution_executed_by
        FOREIGN KEY (executed_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_execution_verified_by
        FOREIGN KEY (verified_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_execution_created_by
        FOREIGN KEY (created_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_execution_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES user_profile(id),

    CONSTRAINT ck_pm_execution_duration
        CHECK (
            duration_minutes IS NULL
            OR duration_minutes >= 0
        ),

    CONSTRAINT ck_pm_execution_completed
        CHECK (
            started_at IS NULL
            OR completed_at IS NULL
            OR completed_at >= started_at
        )

);
COMMENT ON TABLE pm_execution IS
'Execution record for preventive maintenance schedules and related work orders';

COMMENT ON COLUMN pm_execution.id IS
'Primary key';

COMMENT ON COLUMN pm_execution.pm_schedule_id IS
'Related preventive maintenance schedule';

COMMENT ON COLUMN pm_execution.work_order_id IS
'Generated work order';

COMMENT ON COLUMN pm_execution.execution_status IS
'Execution status';

COMMENT ON COLUMN pm_execution.started_at IS
'Execution start datetime';

COMMENT ON COLUMN pm_execution.completed_at IS
'Execution completion datetime';

COMMENT ON COLUMN pm_execution.duration_minutes IS
'Execution duration in minutes';

COMMENT ON COLUMN pm_execution.passed IS
'Inspection result';

COMMENT ON COLUMN pm_execution.result_summary IS
'Summary of execution result';

COMMENT ON COLUMN pm_execution.finding IS
'Findings during preventive maintenance';

COMMENT ON COLUMN pm_execution.recommendation IS
'Recommendations after execution';

COMMENT ON COLUMN pm_execution.executed_by IS
'Technician who performed preventive maintenance';

COMMENT ON COLUMN pm_execution.verified_by IS
'Supervisor who verified execution';

COMMENT ON COLUMN pm_execution.verified_at IS
'Verification datetime';

COMMENT ON COLUMN pm_execution.next_due_date IS
'Calculated next preventive maintenance date';

COMMENT ON COLUMN pm_execution.created_at IS
'Audit created datetime';

COMMENT ON COLUMN pm_execution.updated_at IS
'Audit updated datetime';

COMMENT ON COLUMN pm_execution.deleted_at IS
'Soft delete datetime';

COMMENT ON COLUMN pm_execution.created_by IS
'Audit created by';

COMMENT ON COLUMN pm_execution.updated_by IS
'Audit updated by';

-- ============================================================================
-- INDEX
-- ============================================================================

CREATE INDEX idx_pm_execution_schedule
ON pm_execution(pm_schedule_id);

CREATE INDEX idx_pm_execution_work_order
ON pm_execution(work_order_id);

CREATE INDEX idx_pm_execution_status
ON pm_execution(execution_status);

CREATE INDEX idx_pm_execution_started_at
ON pm_execution(started_at);

CREATE INDEX idx_pm_execution_executed_by
ON pm_execution(executed_by);

CREATE INDEX idx_pm_execution_next_due_date
ON pm_execution(next_due_date);

-- ============================================================================
-- TRIGGER
-- ============================================================================

CREATE TRIGGER trg_pm_execution_updated_at
BEFORE UPDATE
ON pm_execution
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 8.5
-- ============================================================================

COMMIT;
