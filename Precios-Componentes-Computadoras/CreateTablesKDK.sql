-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-06-03 08:39:23 BOT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE dim_cpu_prod (
    id_          INTEGER NOT NULL,
    manufacturer VARCHAR2(50),
    series       VARCHAR2(50),
    cpu_prod     VARCHAR2(50),
    cores        VARCHAR2(30),
    sockets      VARCHAR2(50)
);

ALTER TABLE dim_cpu_prod ADD CONSTRAINT dim_cpu_prod_pk PRIMARY KEY ( id_ );

CREATE TABLE dim_crypto (
    id_      INTEGER NOT NULL,
    code     VARCHAR2(10),
    crypto   VARCHAR2(30),
    mineable VARCHAR2(30)
);

ALTER TABLE dim_crypto ADD CONSTRAINT dim_crypto_pk PRIMARY KEY ( id_ );

CREATE TABLE dim_gpu_prod (
    id_                  INTEGER NOT NULL,
    process_manufacturer VARCHAR2(50),
    processor            VARCHAR2(50),
    gpu_manufacturer     VARCHAR2(50),
    memory_capacity      VARCHAR2(50),
    memory_type          VARCHAR2(50)
);

ALTER TABLE dim_gpu_prod ADD CONSTRAINT dim_gpu_prod_pk PRIMARY KEY ( id_ );

CREATE TABLE dim_merchant (
    id_      INTEGER NOT NULL,
    merchant VARCHAR2(60)
);
ALTER TABLE dim_merchant ADD CONSTRAINT dim_merchant_pk PRIMARY KEY ( id_ );

CREATE TABLE dim_region (
    id_    INTEGER NOT NULL,
    code   VARCHAR2(10),
    region VARCHAR2(10)
);

ALTER TABLE dim_region ADD CONSTRAINT dim_region_pk PRIMARY KEY ( id_ );

CREATE TABLE dim_time (
    id_   INTEGER NOT NULL,
    year  INTEGER,
    month INTEGER,
    week  INTEGER,
    day   INTEGER
);

ALTER TABLE dim_time ADD CONSTRAINT dim_time_pk PRIMARY KEY ( id_ );

CREATE TABLE fact_crypto_rate (
    time_id   INTEGER NOT NULL,
    crypto_id INTEGER NOT NULL,
    open      NUMBER(10, 4),
    close     NUMBER(10, 4),
    high      NUMBER(10, 4),
    down      NUMBER(10, 4)
);

ALTER TABLE fact_crypto_rate ADD CONSTRAINT fact_crypto_rate_pk PRIMARY KEY ( time_id,
                                                                              crypto_id );

CREATE TABLE fact_price_cpu (
    cpu_prod_id    INTEGER NOT NULL,
    region_id      INTEGER NOT NULL,
    merchant_id    INTEGER NOT NULL,
    time_id        INTEGER NOT NULL,
    current_price  NUMBER(10, 4),
    original_price NUMBER(10, 4)
);

ALTER TABLE fact_price_cpu
    ADD CONSTRAINT fact_price_cpu_pk PRIMARY KEY ( cpu_prod_id,
                                                   region_id,
                                                   merchant_id,
                                                   time_id );

ALTER TABLE fact_crypto_rate
    ADD CONSTRAINT f_c_rate_d_c_fk FOREIGN KEY ( crypto_id )
        REFERENCES dim_crypto ( id_ );

ALTER TABLE fact_crypto_rate
    ADD CONSTRAINT f_c_rate_d_t_fk FOREIGN KEY ( time_id )
        REFERENCES dim_time ( id_ );

ALTER TABLE fact_price_cpu
    ADD CONSTRAINT f_p_cpu_d_cpu_p_fk FOREIGN KEY ( cpu_prod_id )
        REFERENCES dim_cpu_prod ( id_ );

ALTER TABLE fact_price_cpu
    ADD CONSTRAINT f_p_cpu_d_m_fk FOREIGN KEY ( merchant_id )
        REFERENCES dim_merchant ( id_ );

ALTER TABLE fact_price_cpu
    ADD CONSTRAINT f_p_cpu_d_r_fk FOREIGN KEY ( region_id )
        REFERENCES dim_region ( id_ );

ALTER TABLE fact_price_cpu
    ADD CONSTRAINT f_p_cpu_d_t_fk FOREIGN KEY ( time_id )
        REFERENCES dim_time ( id_ );