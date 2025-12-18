library(RSQLite)
library(DBI)

# create db for wildlife presence using trail cams and connect ####

wlf_cam_db <- dbConnect(drv = SQLite(),
                       "database/wlf_cam.db")

## list tables in db ####

dbListTables(wlf_cam_db)

# create tables in db ####

## project name ####

dbExecute(conn = wlf_cam_db,
          statement = "CREATE TABLE project_name (
          project_id varchar(10) PRIMARY KEY NOT NULL UNIQUE,
          project_name varchar(35),
          year numeric(4) CHECK (year IN 
                                          ('2019',
                                          '2020',
                                          '2021',
                                          '2022',
                                          '2023'))
          );")

## camera array ####

dbExecute(conn = wlf_cam_db,
          statement = "CREATE TABLE camera_array (
          array_name varchar(20) PRIMARY KEY NOT NULL UNIQUE,
          state varchar(2),
          years_surveyed numeric(1),
          ecoregion varchar(20),
          array_lat numeric(10, 10),
          array_long numeric(10, 10)
          );")

## site name ####

dbExecute(conn = wlf_cam_db,
          statement = "CREATE TABLE site_name (
          site_id varchar(50) PRIMARY KEY NOT NULL UNIQUE,
          array_name  varchar(50),
          development_level varchar(10) CHECK (development_level IN 
                                                                ('Wild',
                                                                'Rural',
                                                                'Urban',
                                                                'Suburban')),
          FOREIGN KEY (array_name) REFERENCES camera_array(array_name)
          );")

## deployment ####

dbExecute(conn = wlf_cam_db,
          statement = "CREATE TABLE deployment (
          deployment_id varchar(60) PRIMARY KEY NOT NULL UNIQUE,
          site_id varchar(50),
          project_id varchar(10),
          start_date text,
          end_date text,
          survey_nights numeric (3),
          latitude numeric(10, 10),
          longitude numeric(10, 10),
          habitat varchar(15),
          feature_type varchar(15),
          FOREIGN KEY (site_id) REFERENCES site_name(site_id)
          FOREIGN KEY (project_id) REFERENCES project_name(project_id)
          );")

## sequence ####

dbExecute(conn = wlf_cam_db,
          statement = "CREATE TABLE sequence (
          sequence_id varchar(15) PRIMARY KEY NOT NULL UNIQUE,
          deployment_id varchar(60),
          start_time text,
          end_time text,
          n_individuals numeric (2),
          FOREIGN KEY (deployment_id) REFERENCES deployment(deployment_id)
          );")

## detection ####

dbExecute(conn = wlf_cam_db,
          statement = "CREATE TABLE detection (
          detection_id varchar(15) PRIMARY KEY NOT NULL UNIQUE,
          sequence_id varchar(15),
          class varchar(15),
          'order' varchar(20),
          family varchar(20),
          genus varchar (15),
          species varchar(15),
          common_name varchar(30),
          age varchar(10),
          sex varchar(10),
          group_number numeric(2),
          FOREIGN KEY (sequence_id) REFERENCES sequence(sequence_id)
          );")
