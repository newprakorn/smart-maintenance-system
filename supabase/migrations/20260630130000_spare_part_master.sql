BEGIN;

-- ============================================================================
-- PART 9.1A
-- Spare Part Master
-- Set 1
-- ============================================================================

-- ============================================================================
-- Unit Master (เพิ่มเพื่อรองรับ unit_id)
-- ============================================================================

CREATE TABLE unit (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    unit_code VARCHAR(50) NOT NULL UNIQUE,
    unit_name VARCHAR(255) NOT NULL,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE unit IS 'Unit of measurement master';
COMMENT ON COLUMN unit.unit_code IS 'Unique unit code (e.g., PCS, KG, L)';
COMMENT ON COLUMN unit.unit_name IS 'Unit name (e.g., Piece, Kilogram, Liter)';
COMMENT ON COLUMN unit.description IS 'Unit description';
COMMENT ON COLUMN unit.is_active IS 'Active flag';

CREATE TRIGGER trg_unit_updated_at
BEFORE UPDATE ON unit
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- Spare Part Category
-- ============================================================================

CREATE TABLE spare_part_category (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    category_code VARCHAR(50) NOT NULL,

    category_name VARCHAR(255) NOT NULL,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_spare_part_category_code
        UNIQUE (category_code)

);

COMMENT ON TABLE spare_part_category IS
'Master table for spare part categories';

COMMENT ON COLUMN spare_part_category.category_code IS
'Unique spare part category code';

COMMENT ON COLUMN spare_part_category.category_name IS
'Spare part category name';

COMMENT ON COLUMN spare_part_category.description IS
'Category description';

COMMENT ON COLUMN spare_part_category.is_active IS
'Category active flag';

-- ============================================================================
-- Spare Part Master
-- ============================================================================

CREATE TABLE spare_part (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    part_code VARCHAR(50) NOT NULL,

    part_name VARCHAR(255) NOT NULL,

    category_id UUID NOT NULL,

    manufacturer_id UUID,

    unit_id UUID,

    specification TEXT,

    minimum_stock NUMERIC(12,2) NOT NULL DEFAULT 0,

    maximum_stock NUMERIC(12,2) NOT NULL DEFAULT 0,

    reorder_point NUMERIC(12,2) NOT NULL DEFAULT 0,

    lead_time_days INTEGER NOT NULL DEFAULT 0,

    standard_cost NUMERIC(18,2) NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_spare_part_code
        UNIQUE (part_code),

    CONSTRAINT fk_spare_part_category

        FOREIGN KEY (category_id)

        REFERENCES spare_part_category(id)

);

-- ============================================================================
-- Foreign Keys
-- ============================================================================

ALTER TABLE spare_part

ADD CONSTRAINT fk_spare_part_manufacturer

FOREIGN KEY (manufacturer_id)

REFERENCES manufacturer(id);

ALTER TABLE spare_part

ADD CONSTRAINT fk_spare_part_unit

FOREIGN KEY (unit_id)

REFERENCES unit(id);

-- ============================================================================
-- Comments
-- ============================================================================

COMMENT ON TABLE spare_part IS

'Master table for spare parts';

COMMENT ON COLUMN spare_part.part_code IS

'Unique spare part code';

COMMENT ON COLUMN spare_part.part_name IS

'Spare part name';

COMMENT ON COLUMN spare_part.category_id IS

'Reference to spare part category';

COMMENT ON COLUMN spare_part.manufacturer_id IS

'Reference to manufacturer';

COMMENT ON COLUMN spare_part.unit_id IS

'Reference to unit master';

COMMENT ON COLUMN spare_part.specification IS

'Technical specification';

COMMENT ON COLUMN spare_part.minimum_stock IS

'Minimum stock level';

COMMENT ON COLUMN spare_part.maximum_stock IS

'Maximum stock level';

COMMENT ON COLUMN spare_part.reorder_point IS

'Reorder point';

COMMENT ON COLUMN spare_part.lead_time_days IS

'Lead time in days';

COMMENT ON COLUMN spare_part.standard_cost IS

'Standard cost';

COMMENT ON COLUMN spare_part.is_active IS

'Active flag';

-- ============================================================================
-- Indexes
-- ============================================================================

CREATE INDEX idx_spare_part_category

ON spare_part(category_id);

CREATE INDEX idx_spare_part_manufacturer

ON spare_part(manufacturer_id);

CREATE INDEX idx_spare_part_unit

ON spare_part(unit_id);

CREATE INDEX idx_spare_part_name

ON spare_part(part_name);

CREATE INDEX idx_spare_part_active

ON spare_part(is_active);

-- ============================================================================
-- Triggers
-- ============================================================================

CREATE TRIGGER trg_spare_part_updated_at

BEFORE UPDATE

ON spare_part

FOR EACH ROW

EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER trg_spare_part_category_updated_at

BEFORE UPDATE

ON spare_part_category

FOR EACH ROW

EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- Example Query
-- ============================================================================

-- SELECT *
-- FROM spare_part;
--
-- SELECT *
-- FROM spare_part_category;

COMMIT;