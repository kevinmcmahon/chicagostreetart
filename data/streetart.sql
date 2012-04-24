--- This adds the Google (900913) SRID to the spacial reference table in the database.
INSERT INTO spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) VALUES (900913, 'EPSG', 900913, 'PROJCS["unnamed",GEOGCS["unnamed ellipse",DATUM["unknown",SPHEROID["unnamed",6378137,0]], PRIMEM["Greenwich",0],UNIT["degree",0.0174532925199433]], PROJECTION["Mercator_2SP"],PARAMETER["standard_parallel_1",0],PARAMETER["central_meridian",0],PARAMETER["false_easting",0], PARAMETER["false_northing",0],UNIT["Meter",1],EXTENSION["PROJ4","+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"]]', '+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs');

--- Create the photos table with a geometry column.
CREATE TABLE photos (
	id serial NOT NULL,
	photo_id text,
	title text,
	description text,
	url text,
	latitude double precision,
	longitude double precision,
	geom geometry,
	CONSTRAINT photos_pkey PRIMARY KEY (id),
	CONSTRAINT enforce_dims_geom CHECK (st_ndims(geom) = 2),
	CONSTRAINT enforce_geotype_geom CHECK (geometrytype(geom) = 'POINT'::text OR geom IS NULL),
	CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 4326)
);

--- Create an index of the geom column
CREATE INDEX idx_photos_geom
ON photos USING gist(geom);

--- Once the raw data from flickr is added to the database run this command to PostGIS-ize the data.
UPDATE photos
SET geom = ST_GeomFromText('POINT(' || longitude || ' ' || latitude || ')',4326);