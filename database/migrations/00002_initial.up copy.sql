BEGIN;

-- Restaurants Table
CREATE TABLE IF NOT EXISTS restaurants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    address VARCHAR(30) CHECK (address ~ '^[a-zA-Z0-9\s]*$'),
    state VARCHAR(16) CHECK (state ~ '^[a-zA-Z\s]*$'),
    city VARCHAR(20) CHECK (city ~ '^[a-zA-Z\s]*$'),
    pin_code CHAR(6) CHECK (pin_code ~ '^[0-9]*$'),
    lat DOUBLE PRECISION NOT NULL CHECK (lat BETWEEN -90 AND 90),
    lng DOUBLE PRECISION NOT NULL CHECK (lng BETWEEN -180 AND 180),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at TIMESTAMP WITH TIME ZONE
);
CREATE UNIQUE INDEX IF NOT EXISTS active_restaurant ON restaurants(TRIM(LOWER(email)),lat,lng) WHERE archived_at IS NULL;

-- Restaurant Menu Table
CREATE TABLE IF NOT EXISTS dishes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    restaurants_id UUID REFERENCES restaurants(id) NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    quantity NUMERIC NOT NULL,
    price NUMERIC NOT NULL,
    discount INT CHECK (discount BETWEEN 0 AND 100),
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at TIMESTAMP WITH TIME ZONE
);

COMMIT;