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
-- ============================================================================
-- PART 5.1 : ASSET CATEGORY
-- ============================================================================

CREATE TABLE asset_category (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    category_code VARCHAR(50) NOT NULL UNIQUE,
    category_name VARCHAR(255) NOT NULL,
    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID
);

CREATE TRIGGER trg_asset_category_updated_at
BEFORE UPDATE ON asset_category
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- PART 5.2 : ASSET TYPE
-- ============================================================================

CREATE TABLE asset_type (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    category_id UUID NOT NULL,

    type_code VARCHAR(50) NOT NULL,
    type_name VARCHAR(255) NOT NULL,
    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_asset_type_category
        FOREIGN KEY (category_id)
        REFERENCES asset_category(id),

    CONSTRAINT uq_asset_type_code
        UNIQUE(category_id, type_code)
);

CREATE TRIGGER trg_asset_type_updated_at
BEFORE UPDATE ON asset_type
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- PART 5.3 : MANUFACTURER
-- ============================================================================

CREATE TABLE manufacturer (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    manufacturer_code VARCHAR(50) NOT NULL UNIQUE,
    manufacturer_name VARCHAR(255) NOT NULL,

    country VARCHAR(100),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID
);

CREATE TRIGGER trg_manufacturer_updated_at
BEFORE UPDATE ON manufacturer
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 5.1 - 5.3
-- ============================================================================
-- ============================================================================
-- PART 5.4 : MODEL
-- ============================================================================

CREATE TABLE model (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    manufacturer_id UUID NOT NULL,

    model_code VARCHAR(100) NOT NULL,
    model_name VARCHAR(255) NOT NULL,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_model_manufacturer
        FOREIGN KEY (manufacturer_id)
        REFERENCES manufacturer(id),

    CONSTRAINT uq_model_code
        UNIQUE (manufacturer_id, model_code)
);

CREATE TRIGGER trg_model_updated_at
BEFORE UPDATE ON model
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- PART 5.5 : LOCATION
-- ============================================================================

CREATE TABLE location (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    plant_id UUID NOT NULL,

    location_code VARCHAR(50) NOT NULL,
    location_name VARCHAR(255) NOT NULL,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_location_plant
        FOREIGN KEY (plant_id)
        REFERENCES plant(id),

    CONSTRAINT uq_location_code
        UNIQUE (plant_id, location_code)
);

CREATE TRIGGER trg_location_updated_at
BEFORE UPDATE ON location
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 5.4 - 5.5
-- ============================================================================
-- ============================================================================
-- PART 5.6 : MACHINE
-- ============================================================================

CREATE TABLE machine (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    asset_type_id UUID NOT NULL,
    manufacturer_id UUID,
    model_id UUID,
    location_id UUID NOT NULL,

    machine_code VARCHAR(50) NOT NULL UNIQUE,
    machine_name VARCHAR(255) NOT NULL,

    serial_number VARCHAR(100),

    installation_date DATE,

    status machine_status_enum NOT NULL DEFAULT 'ACTIVE',

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_machine_asset_type
        FOREIGN KEY (asset_type_id)
        REFERENCES asset_type(id),

    CONSTRAINT fk_machine_manufacturer
        FOREIGN KEY (manufacturer_id)
        REFERENCES manufacturer(id),

    CONSTRAINT fk_machine_model
        FOREIGN KEY (model_id)
        REFERENCES model(id),

    CONSTRAINT fk_machine_location
        FOREIGN KEY (location_id)
        REFERENCES location(id)
);

COMMENT ON TABLE machine IS 'Machine master record';

CREATE TRIGGER trg_machine_updated_at
BEFORE UPDATE ON machine
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 5.6
-- ============================================================================
-- ============================================================================
-- PART 5.7 : MACHINE COMPONENT
-- ============================================================================

CREATE TABLE machine_component (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    machine_id UUID NOT NULL,

    component_code VARCHAR(50) NOT NULL,
    component_name VARCHAR(255) NOT NULL,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_machine_component_machine
        FOREIGN KEY (machine_id)
        REFERENCES machine(id),

    CONSTRAINT uq_machine_component_code
        UNIQUE(machine_id, component_code)
);

CREATE TRIGGER trg_machine_component_updated_at
BEFORE UPDATE ON machine_component
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- PART 5.8 : MACHINE METER
-- ============================================================================

CREATE TABLE machine_meter (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    machine_id UUID NOT NULL,

    meter_code VARCHAR(50) NOT NULL,
    meter_name VARCHAR(255) NOT NULL,

    meter_unit VARCHAR(50) NOT NULL,

    current_value NUMERIC(18,2) DEFAULT 0,

    description TEXT,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_machine_meter_machine
        FOREIGN KEY (machine_id)
        REFERENCES machine(id),

    CONSTRAINT uq_machine_meter_code
        UNIQUE(machine_id, meter_code)
);

CREATE TRIGGER trg_machine_meter_updated_at
BEFORE UPDATE ON machine_meter
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 5.7 - 5.8
-- ============================================================================
-- ============================================================================
-- PART 7.1 : WORK REQUEST
-- ============================================================================

CREATE TABLE work_request (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    request_no VARCHAR(50) NOT NULL UNIQUE,

    machine_id UUID NOT NULL,

    requested_by UUID NOT NULL,

    title VARCHAR(255) NOT NULL,

    description TEXT,

    priority priority_level_enum
        NOT NULL DEFAULT 'MEDIUM',

    status work_request_status_enum
        NOT NULL DEFAULT 'OPEN',

    requested_at TIMESTAMPTZ
        NOT NULL DEFAULT NOW(),

    approved_at TIMESTAMPTZ,

    approved_by UUID,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_work_request_machine
        FOREIGN KEY (machine_id)
        REFERENCES machine(id),

    CONSTRAINT fk_work_request_requested_by
        FOREIGN KEY (requested_by)
        REFERENCES user_profile(id),

    CONSTRAINT fk_work_request_approved_by
        FOREIGN KEY (approved_by)
        REFERENCES user_profile(id)
);

COMMENT ON TABLE work_request IS 'Maintenance work request';

CREATE TRIGGER trg_work_request_updated_at
BEFORE UPDATE ON work_request
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 7.1
-- ============================================================================
-- ============================================================================
-- PART 7.2 : WORK ORDER
-- ============================================================================

CREATE TABLE work_order (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    work_order_no VARCHAR(50) NOT NULL UNIQUE,

    work_request_id UUID,

    machine_id UUID NOT NULL,

    assigned_to UUID,

    maintenance_type maintenance_type_enum
        NOT NULL DEFAULT 'CORRECTIVE',

    priority priority_level_enum
        NOT NULL DEFAULT 'MEDIUM',

    status work_order_status_enum
        NOT NULL DEFAULT 'OPEN',

    title VARCHAR(255) NOT NULL,

    description TEXT,

    planned_start TIMESTAMPTZ,
    planned_finish TIMESTAMPTZ,

    actual_start TIMESTAMPTZ,
    actual_finish TIMESTAMPTZ,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_work_order_request
        FOREIGN KEY (work_request_id)
        REFERENCES work_request(id),

    CONSTRAINT fk_work_order_machine
        FOREIGN KEY (machine_id)
        REFERENCES machine(id),

    CONSTRAINT fk_work_order_assigned_to
        FOREIGN KEY (assigned_to)
        REFERENCES user_profile(id)
);

COMMENT ON TABLE work_order IS 'Maintenance work order';

CREATE TRIGGER trg_work_order_updated_at
BEFORE UPDATE ON work_order
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 7.2
-- ============================================================================
-- ============================================================================
-- PART 7.3 : WORK ORDER TASK
-- ============================================================================

CREATE TABLE work_order_task (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    work_order_id UUID NOT NULL,

    task_no INTEGER NOT NULL,

    task_name VARCHAR(255) NOT NULL,

    description TEXT,

    assigned_to UUID,

    status work_order_status_enum
        NOT NULL DEFAULT 'OPEN',

    planned_start TIMESTAMPTZ,
    planned_finish TIMESTAMPTZ,

    actual_start TIMESTAMPTZ,
    actual_finish TIMESTAMPTZ,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,

    created_by UUID,
    updated_by UUID,

    CONSTRAINT fk_work_order_task_work_order
        FOREIGN KEY (work_order_id)
        REFERENCES work_order(id),

    CONSTRAINT fk_work_order_task_assigned_to
        FOREIGN KEY (assigned_to)
        REFERENCES user_profile(id),

    CONSTRAINT uq_work_order_task_no
        UNIQUE(work_order_id, task_no)
);

COMMENT ON TABLE work_order_task IS 'Individual task within a work order';

CREATE TRIGGER trg_work_order_task_updated_at
BEFORE UPDATE ON work_order_task
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- END PART 7.3
-- ============================================================================





COMMIT;