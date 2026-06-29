BEGIN;

-- ============================================================================
-- PART 8.7 : PM KPI
-- ============================================================================
-- KPI Definition + KPI Snapshot
-- ============================================================================

CREATE TYPE pm_kpi_period_enum AS ENUM (
    'DAILY',
    'WEEKLY',
    'MONTHLY',
    'YEARLY'
);

-- ============================================================================
-- KPI MASTER
-- ============================================================================

CREATE TABLE pm_kpi_definition (

    id UUID NOT NULL DEFAULT gen_random_uuid(),

    kpi_code VARCHAR(100) NOT NULL,

    kpi_name VARCHAR(255) NOT NULL,

    description TEXT,

    unit VARCHAR(30) NOT NULL,

    target_value NUMERIC(10,2),

    warning_value NUMERIC(10,2),

    critical_value NUMERIC(10,2),

    display_order INTEGER NOT NULL DEFAULT 1,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    created_by UUID,

    updated_by UUID,

    CONSTRAINT pk_pm_kpi_definition
        PRIMARY KEY(id),

    CONSTRAINT uq_pm_kpi_definition_code
        UNIQUE(kpi_code),

    CONSTRAINT fk_pm_kpi_definition_created_by
        FOREIGN KEY(created_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_kpi_definition_updated_by
        FOREIGN KEY(updated_by)
        REFERENCES user_profile(id)

);

-- ============================================================================
-- KPI SNAPSHOT
-- ============================================================================

CREATE TABLE pm_kpi_snapshot (

    id UUID NOT NULL DEFAULT gen_random_uuid(),

    snapshot_date DATE NOT NULL,

    period_type pm_kpi_period_enum NOT NULL,

    scheduled_pm INTEGER NOT NULL DEFAULT 0,

    completed_pm INTEGER NOT NULL DEFAULT 0,

    overdue_pm INTEGER NOT NULL DEFAULT 0,

    completion_rate NUMERIC(6,2),

    compliance_rate NUMERIC(6,2),

    pass_rate NUMERIC(6,2),

    failure_rate NUMERIC(6,2),

    avg_execution_minutes NUMERIC(10,2),

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    created_by UUID,

    updated_by UUID,

    CONSTRAINT pk_pm_kpi_snapshot
        PRIMARY KEY(id),

    CONSTRAINT uq_pm_kpi_snapshot
        UNIQUE(snapshot_date, period_type),

    CONSTRAINT fk_pm_kpi_snapshot_created_by
        FOREIGN KEY(created_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_kpi_snapshot_updated_by
        FOREIGN KEY(updated_by)
        REFERENCES user_profile(id),

    CONSTRAINT ck_pm_kpi_completion_rate
        CHECK (
            completion_rate IS NULL
            OR completion_rate BETWEEN 0 AND 100
        ),

    CONSTRAINT ck_pm_kpi_compliance_rate
        CHECK (
            compliance_rate IS NULL
            OR compliance_rate BETWEEN 0 AND 100
        ),

    CONSTRAINT ck_pm_kpi_pass_rate
        CHECK (
            pass_rate IS NULL
            OR pass_rate BETWEEN 0 AND 100
        ),

    CONSTRAINT ck_pm_kpi_failure_rate
        CHECK (
            failure_rate IS NULL
            OR failure_rate BETWEEN 0 AND 100
        )

);
-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE pm_kpi_definition IS
'Master definition of Preventive Maintenance KPIs';

COMMENT ON TABLE pm_kpi_snapshot IS
'Historical KPI snapshot used for dashboard and reporting';

COMMENT ON COLUMN pm_kpi_definition.kpi_code IS
'Unique KPI identifier';

COMMENT ON COLUMN pm_kpi_definition.kpi_name IS
'Display name of KPI';

COMMENT ON COLUMN pm_kpi_definition.description IS
'Description of KPI calculation';

COMMENT ON COLUMN pm_kpi_definition.unit IS
'Measurement unit (%, Minutes, Count)';

COMMENT ON COLUMN pm_kpi_definition.target_value IS
'Target KPI value';

COMMENT ON COLUMN pm_kpi_definition.warning_value IS
'Warning threshold';

COMMENT ON COLUMN pm_kpi_definition.critical_value IS
'Critical threshold';

COMMENT ON COLUMN pm_kpi_snapshot.snapshot_date IS
'Snapshot date';

COMMENT ON COLUMN pm_kpi_snapshot.period_type IS
'Snapshot period';

COMMENT ON COLUMN pm_kpi_snapshot.scheduled_pm IS
'Total scheduled PM';

COMMENT ON COLUMN pm_kpi_snapshot.completed_pm IS
'Completed PM';

COMMENT ON COLUMN pm_kpi_snapshot.overdue_pm IS
'Overdue PM';

COMMENT ON COLUMN pm_kpi_snapshot.completion_rate IS
'Completion percentage';

COMMENT ON COLUMN pm_kpi_snapshot.compliance_rate IS
'Compliance percentage';

COMMENT ON COLUMN pm_kpi_snapshot.pass_rate IS
'Checklist pass percentage';

COMMENT ON COLUMN pm_kpi_snapshot.failure_rate IS
'Checklist failure percentage';

COMMENT ON COLUMN pm_kpi_snapshot.avg_execution_minutes IS
'Average execution duration';

-- ============================================================================
-- INDEXES
-- ============================================================================

CREATE INDEX idx_pm_kpi_definition_active
ON pm_kpi_definition(is_active);

CREATE INDEX idx_pm_kpi_definition_display
ON pm_kpi_definition(display_order);

CREATE INDEX idx_pm_kpi_snapshot_date
ON pm_kpi_snapshot(snapshot_date);

CREATE INDEX idx_pm_kpi_snapshot_period
ON pm_kpi_snapshot(period_type);

-- ============================================================================
-- TRIGGERS
-- ============================================================================

CREATE TRIGGER trg_pm_kpi_definition_updated_at
BEFORE UPDATE
ON pm_kpi_definition
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_pm_kpi_snapshot_updated_at
BEFORE UPDATE
ON pm_kpi_snapshot
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- DEFAULT KPI DEFINITIONS
-- ============================================================================

INSERT INTO pm_kpi_definition
(
    kpi_code,
    kpi_name,
    description,
    unit,
    target_value,
    warning_value,
    critical_value,
    display_order
)
VALUES
(
    'PM_COMPLETION_RATE',
    'PM Completion Rate',
    'Completed PM / Scheduled PM',
    '%',
    95,
    90,
    80,
    1
),
(
    'PM_COMPLIANCE_RATE',
    'PM Compliance Rate',
    'Passed Checklist / Total Checklist',
    '%',
    98,
    95,
    90,
    2
),
(
    'PM_PASS_RATE',
    'Checklist Pass Rate',
    'Passed Checklist',
    '%',
    98,
    95,
    90,
    3
),
(
    'PM_FAILURE_RATE',
    'Checklist Failure Rate',
    'Failed Checklist',
    '%',
    2,
    5,
    10,
    4
),
(
    'PM_OVERDUE_RATE',
    'PM Overdue Rate',
    'Overdue PM',
    '%',
    0,
    3,
    5,
    5
),
(
    'PM_EXECUTION_DURATION',
    'Average Execution Duration',
    'Average execution time',
    'Minutes',
    60,
    90,
    120,
    6
);

-- ============================================================================
-- END PART 8.7
-- ============================================================================

COMMIT;


