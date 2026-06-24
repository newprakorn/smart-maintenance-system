-- ============================================================================
-- Smart Maintenance System (SMS)
-- Migration : 001_initial_schema.sql
-- Description : Initial Database Schema
-- Database : PostgreSQL 16+ (Supabase)
-- ============================================================================

BEGIN;

-- ============================================================================
-- PART 1 : EXTENSIONS
-- ============================================================================

-- UUID Generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Case-insensitive text
CREATE EXTENSION IF NOT EXISTS "citext";

-- ============================================================================
-- END PART 1
-- ============================================================================

-- ============================================================================
-- PART 2 : ENUM TYPES
-- ============================================================================

-- Machine Status
CREATE TYPE machine_status_enum AS ENUM (
    'ACTIVE',
    'INACTIVE',
    'BREAKDOWN',
    'MAINTENANCE',
    'RETIRED'
);

-- Work Request Status
CREATE TYPE work_request_status_enum AS ENUM (
    'OPEN',
    'APPROVED',
    'REJECTED',
    'IN_PROGRESS',
    'COMPLETED',
    'CANCELLED'
);

-- Work Order Status
CREATE TYPE work_order_status_enum AS ENUM (
    'OPEN',
    'ASSIGNED',
    'IN_PROGRESS',
    'COMPLETED',
    'CANCELLED'
);

-- Maintenance Type
CREATE TYPE maintenance_type_enum AS ENUM (
    'CORRECTIVE',
    'PREVENTIVE',
    'PREDICTIVE',
    'EMERGENCY'
);

-- Priority Level
CREATE TYPE priority_level_enum AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'CRITICAL'
);

-- ============================================================================
-- END PART 2
-- ============================================================================
-- PART 3 : AUDIT FUNCTIONS
-- ============================================================================

-- Automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS
$$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- ============================================================================
-- END PART 3
-- ============================================================================
-- ============================================================================
-- PART 4.1 : COMPANY
-- ============================================================================

CREATE TABLE company (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    company_code VARCHAR(20) NOT NULL UNIQUE,
    company_name VARCHAR(255) NOT NULL,
    company_name_th VARCHAR(255),

    tax_id VARCHAR(20),
    email CITEXT,
    phone VARCHAR(50),

    address TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID
);

COMMENT ON TABLE company IS 'Company master';

COMMENT ON COLUMN company.company_code IS 'Unique company code';
COMMENT ON COLUMN company.company_name IS 'Company name (English)';
COMMENT ON COLUMN company.company_name_th IS 'Company name (Thai)';

CREATE TRIGGER trg_company_updated_at
BEFORE UPDATE ON company
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 4.1
-- ============================================================================
-- ============================================================================
-- PART 4.2 : PLANT
-- ============================================================================

CREATE TABLE plant (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    company_id UUID NOT NULL,

    plant_code VARCHAR(20) NOT NULL,
    plant_name VARCHAR(255) NOT NULL,
    plant_name_th VARCHAR(255),

    email CITEXT,
    phone VARCHAR(50),
    address TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_plant_company
        FOREIGN KEY (company_id)
        REFERENCES company(id),

    CONSTRAINT uq_plant_company_code
        UNIQUE (company_id, plant_code)
);

COMMENT ON TABLE plant IS 'Plant / Factory master';

CREATE TRIGGER trg_plant_updated_at
BEFORE UPDATE ON plant
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 4.2
-- ============================================================================
-- ============================================================================
-- PART 4.3 : DEPARTMENT
-- ============================================================================

CREATE TABLE department (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    plant_id UUID NOT NULL,

    department_code VARCHAR(20) NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    department_name_th VARCHAR(255),

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_department_plant
        FOREIGN KEY (plant_id)
        REFERENCES plant(id),

    CONSTRAINT uq_department_plant_code
        UNIQUE (plant_id, department_code)
);

COMMENT ON TABLE department IS 'Department master';

CREATE TRIGGER trg_department_updated_at
BEFORE UPDATE ON department
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 4.3
-- ============================================================================
-- ============================================================================
-- PART 4.4 : ROLE
-- ============================================================================

CREATE TABLE role (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    role_code VARCHAR(50) NOT NULL UNIQUE,
    role_name VARCHAR(255) NOT NULL,
    role_description TEXT,

    is_system BOOLEAN NOT NULL DEFAULT FALSE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID
);

COMMENT ON TABLE role IS 'System role master';

CREATE TRIGGER trg_role_updated_at
BEFORE UPDATE ON role
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 4.4
-- ============================================================================
-- ============================================================================
-- PART 4.5 : USER PROFILE
-- ============================================================================

CREATE TABLE user_profile (
    id UUID PRIMARY KEY
        REFERENCES auth.users(id)
        ON DELETE CASCADE,

    department_id UUID NOT NULL,
    role_id UUID NOT NULL,

    employee_code VARCHAR(50) UNIQUE,

    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,

    phone VARCHAR(50),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_user_department
        FOREIGN KEY (department_id)
        REFERENCES department(id),

    CONSTRAINT fk_user_role
        FOREIGN KEY (role_id)
        REFERENCES role(id)
);

COMMENT ON TABLE user_profile IS 'Business profile for authenticated users';

CREATE TRIGGER trg_user_profile_updated_at
BEFORE UPDATE ON user_profile
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 4.5
-- ============================================================================