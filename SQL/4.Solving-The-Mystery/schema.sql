CREATE TABLE promo_codes (
    code VARCHAR NOT NULL,
    description VARCHAR NULL,
    creation_time TIMESTAMP NULL,
    expiration_time TIMESTAMP NULL,
    rules JSONB NULL,
    CONSTRAINT promo_codes_pk PRIMARY KEY (code)
);

CREATE TABLE users (
    id UUID NOT NULL,
    city VARCHAR NOT NULL,
    name VARCHAR NULL,
    address VARCHAR NULL,
    credit_card VARCHAR NULL,
    CONSTRAINT users_pk PRIMARY KEY (id)
);
CREATE INDEX users_city_idx ON users(city); 

CREATE TABLE vehicles (
    id UUID NOT NULL,
    city VARCHAR NOT NULL,
    type VARCHAR NULL,
    owner_id UUID NULL,
    creation_time TIMESTAMP NULL,
    status VARCHAR NULL,
    current_location VARCHAR NULL,
    ext JSONB NULL,
    CONSTRAINT vehicles_pk PRIMARY KEY (id)
);
CREATE INDEX vehicles_auto_index_fk_owner_id_ref_users ON vehicles(owner_id);
CREATE INDEX vehicles_city_idx ON vehicles(city);


CREATE TABLE rides (
    id UUID NOT NULL,
    city VARCHAR NOT NULL,
    rider_id UUID NULL,
    vehicle_id UUID NULL,
    start_address VARCHAR NULL,
    end_address VARCHAR NULL,
    start_time TIMESTAMP NULL,
    end_time TIMESTAMP NULL,
    revenue DECIMAL(10,2) NULL,
    CONSTRAINT rides_pk PRIMARY KEY (id)
);
CREATE INDEX rides_auto_index_fk_rider_id_ref_users ON rides(rider_id);
CREATE INDEX rides_auto_index_fk_vehicle_id_ref_vehicles ON rides(vehicle_id);

CREATE TABLE user_promo_codes (
    city VARCHAR NOT NULL,
    user_id UUID NOT NULL,
    code VARCHAR NOT NULL,
    "timestamp" TIMESTAMP NULL,
    usage_count INT8 NULL,
    CONSTRAINT user_promo_codes_pk PRIMARY KEY (user_id, code)
);

CREATE TABLE vehicle_location_histories (
    city VARCHAR NOT NULL,
    ride_id UUID NOT NULL,
    "timestamp" TIMESTAMP NOT NULL,
    lat FLOAT8 NULL,
    long FLOAT8 NULL,
    CONSTRAINT vehicle_location_histories_pk PRIMARY KEY (ride_id, "timestamp")
);

ALTER TABLE vehicles ADD CONSTRAINT fk_owner_id_ref_users FOREIGN KEY (owner_id) REFERENCES users(id);
ALTER TABLE rides ADD CONSTRAINT fk_rider_id_ref_users FOREIGN KEY (rider_id) REFERENCES users(id);
ALTER TABLE rides ADD CONSTRAINT fk_vehicle_id_ref_vehicles FOREIGN KEY (vehicle_id) REFERENCES vehicles(id);
ALTER TABLE user_promo_codes ADD CONSTRAINT fk_user_id_ref_users FOREIGN KEY (user_id) REFERENCES users(id);

-- Validate foreign key constraints. These can fail if there was unvalidated data during the dump.
ALTER TABLE vehicles VALIDATE CONSTRAINT fk_owner_id_ref_users;
ALTER TABLE rides VALIDATE CONSTRAINT fk_rider_id_ref_users;
ALTER TABLE rides VALIDATE CONSTRAINT fk_vehicle_id_ref_vehicles;
ALTER TABLE user_promo_codes VALIDATE CONSTRAINT fk_user_id_ref_users;

