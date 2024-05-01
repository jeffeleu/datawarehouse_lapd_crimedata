CREATE  TABLE "public".dim_crime (
	crime_id             integer  NOT NULL  ,
	crm_cd_descr          varchar(1000)    ,
	CONSTRAINT pk_dim_crime PRIMARY KEY ( crime_id )
 );

CREATE  TABLE "public".dim_datetime (
	datetime_id          integer  NOT NULL  ,
	date_iso_format      timestamp    ,
	year_number          integer    ,
	month_number         integer    ,
	quarter_number       integer    ,
	day_number           integer    ,
	hour_number          integer    ,
	monthname            varchar(10)    ,
	dayname              varchar(10)    ,
	weekofyear           integer    ,
	weekofmonth          integer    ,
	CONSTRAINT pk_dim_datetime PRIMARY KEY ( datetime_id )
 );

CREATE  TABLE "public".dim_location (
	location_id          varchar(100)  NOT NULL  ,
	area_name            varchar(100)    ,
	location             varchar(100)    ,
	latitude             numeric(9,6)    ,
	longitude            numeric(9,6)    ,
	CONSTRAINT pk_dim_location PRIMARY KEY ( location_id )
 );

CREATE  TABLE "public".dim_premise (
	premis_id            integer  NOT NULL  ,
	premis_desc          varchar(1000)    ,
	CONSTRAINT pk_dim_premise PRIMARY KEY ( premis_id )
 );

CREATE  TABLE "public".dim_status (
	status_id            varchar(2)  NOT NULL  ,
	status_descr         varchar(20)    ,
	CONSTRAINT pk_dim_status PRIMARY KEY ( status_id )
 );

CREATE  TABLE "public".dim_victim (
	victim_id            integer  NOT NULL  ,
	vict_age             integer    ,
	vict_sex             varchar(1)    ,
	vict_descent         varchar(1)    ,
	CONSTRAINT pk_dim_victim PRIMARY KEY ( victim_id )
 );

CREATE  TABLE "public".facts_incident (
	fact_id              bigint  NOT NULL  ,
	crime_id             integer  NOT NULL  ,
	premis_id            integer    ,
	victim_id            integer  NOT NULL  ,
	location_id          varchar(100)  NOT NULL  ,
	status_id            varchar(2)  NOT NULL  ,
	datetime_occ         integer    ,
	CONSTRAINT pk_facts_incident PRIMARY KEY ( fact_id )
 );

ALTER TABLE "public".facts_incident ADD CONSTRAINT fk_facts_incident_dim_datetime_0 FOREIGN KEY ( datetime_occ ) REFERENCES "public".dim_datetime( datetime_id );
