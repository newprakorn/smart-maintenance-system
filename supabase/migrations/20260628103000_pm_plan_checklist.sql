BEGIN;

-- ============================================================================
-- PART 8.5A : PM PLAN CHECKLIST MAPPING
-- ============================================================================

CREATE TABLE pm_plan_checklist (
    id UUID NOT NULL DEFAULT gen_random_uuid(),

    pm_plan_id UUID NOT NULL,
    pm_checklist_id UUID NOT NULL,

    sequence_no INTEGER NOT NULL DEFAULT 1,

    is_required BOOLEAN NOT NULL DEFAULT TRUE,

    standard_value TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT pk_pm_plan_checklist
        PRIMARY KEY (id),

    CONSTRAINT fk_pm_plan_checklist_plan
        FOREIGN KEY (pm_plan_id)
        REFERENCES pm_plan(id),

    CONSTRAINT fk_pm_plan_checklist_checklist
        FOREIGN KEY (pm_checklist_id)
        REFERENCES pm_checklist(id),

    CONSTRAINT fk_pm_plan_checklist_created_by
        FOREIGN KEY (created_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_pm_plan_checklist_updated_by
        FOREIGN KEY (updated_by)
        REFERENCES user_profile(id),

    CONSTRAINT uq_pm_plan_checklist
        UNIQUE (pm_plan_id, pm_checklist_id),

    CONSTRAINT ck_pm_plan_checklist_sequence
        CHECK (sequence_no > 0)
);

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE pm_plan_checklist IS
'Mapping between PM Plans and PM Checklists';

COMMENT ON COLUMN pm_plan_checklist.id IS
'Unique identifier';

COMMENT ON COLUMN pm_plan_checklist.pm_plan_id IS
'Preventive maintenance plan';

COMMENT ON COLUMN pm_plan_checklist.pm_checklist_id IS
'Checklist assigned to PM Plan';

COMMENT ON COLUMN pm_plan_checklist.sequence_no IS
'Display sequence';

COMMENT ON COLUMN pm_plan_checklist.is_required IS
'Indicates whether technician must complete this checklist';

COMMENT ON COLUMN pm_plan_checklist.standard_value IS
'Expected or standard value for inspection';

COMMENT ON COLUMN pm_plan_checklist.is_active IS
'Enable or disable checklist for this PM Plan';

COMMENT ON COLUMN pm_plan_checklist.created_at IS
'Creation timestamp';

COMMENT ON COLUMN pm_plan_checklist.updated_at IS
'Last update timestamp';

COMMENT ON COLUMN pm_plan_checklist.deleted_at IS
'Soft delete timestamp';

COMMENT ON COLUMN pm_plan_checklist.created_by IS
'User who created this mapping';

COMMENT ON COLUMN pm_plan_checklist.updated_by IS
'User who last updated this mapping';

-- ============================================================================
-- INDEXES
-- ============================================================================

CREATE INDEX idx_pm_plan_checklist_plan
ON pm_plan_checklist(pm_plan_id);

CREATE INDEX idx_pm_plan_checklist_checklist
ON pm_plan_checklist(pm_checklist_id);

CREATE INDEX idx_pm_plan_checklist_sequence
ON pm_plan_checklist(sequence_no);

CREATE INDEX idx_pm_plan_checklist_active
ON pm_plan_checklist(is_active);

-- ============================================================================
-- TRIGGER
-- ============================================================================

CREATE TRIGGER trg_pm_plan_checklist_updated_at
BEFORE UPDATE
ON pm_plan_checklist
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 8.5A
-- ============================================================================

COMMIT;