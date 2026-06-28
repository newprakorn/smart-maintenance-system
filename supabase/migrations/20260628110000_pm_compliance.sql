BEGIN;

-- ============================================================================
-- PART 8.6 : PM COMPLIANCE
-- ============================================================================
-- One record = One checklist inspection result
-- ============================================================================

CREATE TYPE pm_compliance_status_enum AS ENUM (
    'PENDING',
    'PASSED',
    'FAILED',
    'SKIPPED'
);

CREATE TABLE pm_compliance (

    id UUID NOT NULL DEFAULT gen_random_uuid(),

    -- ==========================================================
    -- References
    -- ==========================================================

    pm_execution_id UUID NOT NULL,

    pm_plan_checklist_id UUID NOT NULL,

    -- ==========================================================
    -- Inspection Result
    -- ==========================================================

    compliance_status pm_compliance_status_enum
        NOT NULL
        DEFAULT 'PENDING',

    passed BOOLEAN,

    -- ==========================================================
    -- Actual Values
    -- ==========================================================

    actual_numeric NUMERIC(18,4),

    actual_text TEXT,

    -- ==========================================================
    -- Technician Notes
    -- ==========================================================

    finding TEXT,

    recommendation TEXT,

    attachment_url TEXT,

    -- ==========================================================
    -- Performed
    -- ==========================================================

    performed_at TIMESTAMPTZ,

    performed_by UUID,

    -- ==========================================================
    -- Audit
    -- ==========================================================

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    created_by UUID,

    updated_by UUID,

    -- ==========================================================
    -- Constraints
    -- ==========================================================

    CONSTRAINT pk_pm_compliance
        PRIMARY KEY(id),

    CONSTRAINT fk_pm_compliance_execution
        FOREIGN KEY (pm_execution_id)
        REFERENCES pm_execution(id),

    CONSTRAINT fk_pm_compliance_plan_checklist
        FOREIGN KEY (pm_plan_checklist_id)
        REFERENCES pm_plan_checklist(id),

    CONSTRAINT fk_pm_compliance_performed_by
        FOREIGN KEY (performed_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_compliance_created_by
        FOREIGN KEY (created_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_compliance_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES user_profile(id),

    CONSTRAINT uq_pm_compliance_execution_checklist
        UNIQUE (
            pm_execution_id,
            pm_plan_checklist_id
        ),

    CONSTRAINT ck_pm_compliance_actual_numeric
        CHECK (
            actual_numeric IS NULL
            OR actual_numeric >= 0
        )
);

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE pm_compliance IS
'Stores inspection results for each preventive maintenance checklist item during a PM execution';

COMMENT ON COLUMN pm_compliance.id IS
'Unique identifier';

COMMENT ON COLUMN pm_compliance.pm_execution_id IS
'Reference to preventive maintenance execution';

COMMENT ON COLUMN pm_compliance.pm_plan_checklist_id IS
'Reference to PM Plan Checklist mapping';

COMMENT ON COLUMN pm_compliance.compliance_status IS
'Inspection status';

COMMENT ON COLUMN pm_compliance.passed IS
'TRUE when inspection passed';

COMMENT ON COLUMN pm_compliance.actual_numeric IS
'Measured numeric value';

COMMENT ON COLUMN pm_compliance.actual_text IS
'Measured text or visual inspection result';

COMMENT ON COLUMN pm_compliance.finding IS
'Technician findings';

COMMENT ON COLUMN pm_compliance.recommendation IS
'Recommended corrective action';

COMMENT ON COLUMN pm_compliance.attachment_url IS
'Evidence attachment';

COMMENT ON COLUMN pm_compliance.performed_at IS
'Inspection timestamp';

COMMENT ON COLUMN pm_compliance.performed_by IS
'Technician performing inspection';

COMMENT ON COLUMN pm_compliance.created_at IS
'Creation timestamp';

COMMENT ON COLUMN pm_compliance.updated_at IS
'Last update timestamp';

COMMENT ON COLUMN pm_compliance.deleted_at IS
'Soft delete timestamp';

COMMENT ON COLUMN pm_compliance.created_by IS
'Record creator';

COMMENT ON COLUMN pm_compliance.updated_by IS
'Last updater';

-- ============================================================================
-- INDEXES
-- ============================================================================

CREATE INDEX idx_pm_compliance_execution
ON pm_compliance(pm_execution_id);

CREATE INDEX idx_pm_compliance_plan_checklist
ON pm_compliance(pm_plan_checklist_id);

CREATE INDEX idx_pm_compliance_status
ON pm_compliance(compliance_status);

CREATE INDEX idx_pm_compliance_performed_by
ON pm_compliance(performed_by);

CREATE INDEX idx_pm_compliance_passed
ON pm_compliance(passed);

-- ============================================================================
-- TRIGGER
-- ============================================================================

CREATE TRIGGER trg_pm_compliance_updated_at
BEFORE UPDATE
ON pm_compliance
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 8.6
-- ============================================================================

COMMIT;


