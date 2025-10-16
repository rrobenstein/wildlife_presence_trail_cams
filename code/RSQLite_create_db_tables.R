library(RSQLite)
library(DBI)

# create db for deadwood-wildlife and connect ####

dw_wlf_db <- dbConnect(drv = SQLite(),
                       "database/dw_wlf.db")

## list tables in db ####

dbListTables(dw_wlf_db)

# create tables in db ####

## surveyor ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE surveyor (
          surveyor_ID varchar(20) PRIMARY KEY NOT NULL UNIQUE,
          first_name varchar(20),
          last_name varchar(20)
          );")

## UIEF plot ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE UIEF_plot (
          plot_ID varchar(50) PRIMARY KEY NOT NULL UNIQUE,
          plot_ground_cover numeric(5, 2),
          primary_tree_sp varcar(30),
          plot_canopy_cover numeric(5, 2),
          plot_forest_mngmt varchar(20),
          plot_utm_x numeric(10, 10),
          plot_utm_y numeric(10, 10)
          );")

## plot section ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE plot_section (
          section_ID varchar(30) PRIMARY KEY NOT NULL UNIQUE,
          plot_ID  varchar(50),
          ground_cover numeric(5, 2),
          primary_tree_sp varchar(30),
          canopy_cover numeric(5, 2),
          forest_mngnt varchar(20),
          section_utm_x numeric(10, 10),
          section_utm_y numeric(10, 10),
          FOREIGN KEY (plot_ID) REFERENCES UIEF_plot(plot_id)
          );")

## deadwood site ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE deadwood_site (
          site_ID varchar(30) PRIMARY KEY NOT NULL UNIQUE,
          section_ID varchar(30),
          site_canopy_cover numeric(5, 2),
          dist_plot_center
          dist_section_center
          site_utm_x numeric(10, 10),
          site_utm_y numeric(10, 10),
          primary_veg_sp
          understory_veg_cover numeric(5, 2),
          FOREIGN KEY (section_ID) REFERENCES plot_section(section_ID)
          );")

## deadwood structure ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE deadwood_structure (
          deadwood_ID varchar(20) PRIMARY KEY NOT NULL UNIQUE,
          site_ID varchar(30),
          structure_type varchar(8) CHECK (structure_type IN ('snag',
                                                              'log')),
          decay_class numeric(1) CHECK (decay_class IN ('1',
                                                        '2',
                                                        '3',
                                                        '4',
                                                        '5')),
          dw_utm_x numeric(10, 10),
          dw_utm_y numeric(10, 10),
          height numeric(10, 10),
          DBH numeric(10, 10),
          FOREIGN KEY (site_ID) REFERENCES deadwood_site(site_ID)
          );")

## cameras ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE cameras (
          camera_ID varchar(10) PRIMARY KEY NOT NULL UNIQUE,
          site_ID varchar(30),
          cam_type varchar(20),
          sensitivity varchar(10) CHECK (sensitivity IN ('high',
                                                          'medium',
                                                          'low')),
          resolution varchar(10),
          delay varchar (10),
          trigger_speed varchar(10),
          flash varchar(10),
          FOREIGN KEY (site_ID) REFERENCES deadwood_site(site_ID)
          );")

## camera deployment ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE camera_deployment (
          cam_deploy_ID varchar(20) PRIMARY KEY NOT NULL UNIQUE,
          camera_ID varchar(10),
          camera_mode varchar(15) CHECK (camera_mode IN ('photo',
                                                          'video')),
          sd_card varchar(10),
          battery_check varchar(10),
          cable_lock_yn char(1) CHECK (cable_lock_yn IN ('y',
                                                          'n')),
          deploy_date_time text,
          retreival_date_time text,
          weather_conditions varchar(50),
          mounted_on varchar(5) CHECK (mounted_on IN ('tree',
                                                        'post')),
          height_above_ground numeric(10, 10),
          cardinal_direction varchar(5) CHECK (cardinal_direction IN ('N',
                                                                      'S',
                                                                      'E',
                                                                      'W',
                                                                      'NW',
                                                                      'NE',
                                                                      'SW',
                                                                      'SE'
                                                                      )),
          FOREIGN KEY (camera_ID) REFERENCES cameras(camera_ID)
          );")

## photos ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE photos (
          photo_ID numeric(20) PRIMARY KEY NOT NULL UNIQUE,
          cam_deploy_ID varchar(20),
          total_individuals numeric(3),
          date text,
          time text,
          photo_burst varchar(5),
          FOREIGN KEY (cam_deploy_ID) REFERENCES camera_deployment(cam_deploy_ID)
          );")

## photo detection ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE photo_detection (
          photo_detection_ID integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
          photo_ID numeric(20),
          species varchar(50),
          count numeric(3),
          other_frames_yn char(1) CHECK (other_frames_yn IN ('y',
                                                              'n')),
          observed_behavior varchar(50),
          FOREIGN KEY (photo_ID) REFERENCES photos(photo_ID)
          );")

## videos ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE videos (
          video_ID numeric(20) PRIMARY KEY NOT NULL UNIQUE,
          cam_deploy_ID varchar(20),
          video_length text,
          audio varchar(10),
          total_individuals numeric(3),
          date text,
          time text,
          FOREIGN KEY (cam_deploy_ID) REFERENCES camera_deployment(cam_deploy_ID)
          );")

## video detection ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE video_detection (
          video_detection_ID integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
          video_ID numeric(20),
          species varchar(50),
          count numeric(3),
          other_frames_yn char(1) CHECK (other_frames_yn IN ('y',
                                                              'n')),
          observed_behavior varchar(50),
          video_time text,
          FOREIGN KEY (video_ID) REFERENCES videos(video_ID)
          );")

## acoustic monitors ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE acoustic_monitors (
          acoustic_ID varchar(10) PRIMARY KEY NOT NULL UNIQUE,
          site_ID varchar(30),
          aru_type varchar(20),
          sample_rate varchar(10),
          gain varchar(10),
          FOREIGN KEY (site_ID) REFERENCES deadwood_site(site_ID)
          );")

## acoustic deployment ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE acoustic_deployment (
          aru_deploy_ID varchar(20) PRIMARY KEY NOT NULL UNIQUE,
          acoustic_ID varchar(10),
          filters varchar(20),
          channel_parameters varchar(20),
          scheduling varchar(20),
          sd_card varchar(10),
          battery_check varchar(10),
          cable_lock_yn char(1) CHECK (cable_lock_yn IN ('y',
                                                          'n')),
          deploy_date_time text,
          retreival_date_time text,
          weather_conditions varchar(50),
          mounted_on varchar(5) CHECK (mounted_on IN ('tree','post')),
          height_above_ground numeric(10, 10),
          cardinal_direction varchar(5) CHECK (cardinal_direction IN ('N',
                                                                      'S',
                                                                      'E',
                                                                      'W',
                                                                      'NW',
                                                                      'NE',
                                                                      'SW',
                                                                      'SE'
                                                                      )),
          FOREIGN KEY (acoustic_ID) REFERENCES acoustic_monitors(acoustic_ID)
          );")

## recordings ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE recordings (
          recording_ID numeric(20) PRIMARY KEY NOT NULL UNIQUE,
          aru_deploy_ID varchar(20),
          recording_length text,
          total_individuals numeric(3),
          date text,
          time text,
          FOREIGN KEY (aru_deploy_ID) REFERENCES acoustic_deployment(aru_deploy_ID)
          );")

## recording detection ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE recording_detection (
          aru_detection_ID integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
          recording_ID numeric(20),
          species varchar(50),
          count numeric(3),
          other_recordings_yn char(1) CHECK (other_recordings_yn IN ('y',
                                                                      'n')),
          observed_behavior varchar(50),
          recording_time text,
          FOREIGN KEY (recording_ID) REFERENCES recordings(recording_ID)
          );")

## point count transect ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE point_count_transect (
          transect_ID varchar(30) PRIMARY KEY NOT NULL UNIQUE,
          site_ID varchar(30),
          access_point_utm_x numeric(10, 10),
          access_point_utm_y numeric(10, 10),
          FOREIGN KEY (site_ID) REFERENCES deadwood_site(site_ID)
          );")

## point counts ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE point_counts (
          point_ID varchar(20) PRIMARY KEY NOT NULL UNIQUE,
          transect_ID varchar(30),
          surveyor_ID varchar(20),
          date text,
          start_time text,
          dom_veg varcar(30),
          point_utm_x numeric(10, 10),
          point_utm_y numeric(10, 10),
          temperature numeric(5, 2),
          cloud_cover numeric(5, 2),
          precipitation varchar(10) CHECK (precipitation IN ('rain',
                                                              'snow',
                                                              'sleet',
                                                              'hail',
                                                              'none')),
          FOREIGN KEY (transect_ID) REFERENCES point_count_transect(transect_ID)
          FOREIGN KEY (surveyor_ID) REFERENCES surveyor(surveyor_ID)
          );")

## point count detection ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE point_count_detection (
          pc_detection integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
          point_ID varchar (20),
          species varchar(50),
          count numeric(3),
          sex_age varchar(8),
          detect_type varchar(20),
          pc_minute numeric(2),
          dist_nearest_dw numeric(10, 10),
          dist_from_surveyor numeric(10, 10),
          cardinal_direction varchar(5) CHECK (cardinal_direction IN ('N',
                                                                      'S',
                                                                      'E',
                                                                      'W',
                                                                      'NW',
                                                                      'NE',
                                                                      'SW',
                                                                      'SE'
                                                                      )),
          observed_behavior varchar(50),
          FOREIGN KEY (point_ID) REFERENCES point_count(point_ID)
          );")

## area search ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE area_search (
          as_ID varchar(20) PRIMARY KEY NOT NULL UNIQUE,
          site_ID varchar(30),
          surveyor_ID varchar(20),
          total_individuals numeric(3),
          N_territories numeric (3),
          date text,
          start_time text,
          end_time text,
          center_utm_x numeric(10, 10),
          center_utm_y numeric(10, 10),
          temperature numeric(5, 2),
          cloud_cover numeric(5, 2),
          precipitation varchar(10) CHECK (precipitation IN ('rain',
                                                              'snow',
                                                              'sleet',
                                                              'hail',
                                                              'none')),
          FOREIGN KEY (site_ID) REFERENCES deadwood_site(site_ID)
          FOREIGN KEY (surveyor_ID) REFERENCES surveyor(surveyor_ID)
          );")

## area search detection ####

dbExecute(conn = dw_wlf_db,
          statement = "CREATE TABLE area_search_detection (
          as_detection_ID integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,
          as_ID varchar(20),
          species varchar(50),
          count numeric(3),
          sex_age varchar(8) CHECK (sex_age IN ('Male',
                                                'Female',
                                                'Juvenile',
                                                'Unknown')),
          detect_type varchar(20),
          mult_detect_indiv_yn char(1) CHECK (mult_detect_indiv_yn IN ('y',
                                                                        'n')),
          time text,
          dist_from_surveyor numeric(10, 10),
          dist_from_center numeric(10, 10),
          dist_nearest_dw numeric(10, 10),
          surveyor_utm_x numeric(10, 10),
          surveyor_utm_y numeric(10, 10),
          species_utm_x numeric(10, 10),
          species_utm_y numeric(10, 10),
          observed_behavior varchar(50),
          FOREIGN KEY (as_ID) REFERENCES area_search(as_ID)
          );")
