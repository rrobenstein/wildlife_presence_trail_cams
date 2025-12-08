library(DBI)
library(RSQLite)

# connect to db for deadwood-wildlife####

wlf_cam_db <- dbConnect(drv = SQLite(),
                       "database/wlf_cam.db")

## list tables in db ####

dbListTables(wlf_cam_db)

# populate database ####

## project name ####

project_name_csv <- read.csv("processed_data/project_name.csv")

colnames(project_name_csv)
dbListFields(wlf_cam_db, "project_name")

dbWriteTable(conn = wlf_cam_db,
             name = "project_name",
             value = project_name_csv,
             append = TRUE)

## camera_array ####

camera_array_csv <- read.csv("processed_data/camera_array.csv")

colnames(camera_array_csv)
dbListFields(wlf_cam_db, "camera_array")

dbWriteTable(conn = wlf_cam_db,
             name = "camera_array",
             value = camera_array_csv,
             append = TRUE)

## site name ####

site_name_csv <- read.csv("processed_data/site_name.csv")

colnames(site_name_csv)
dbListFields(wlf_cam_db, "site_name")

dbWriteTable(conn = wlf_cam_db,
             name = "site_name",
             value = site_name_csv,
             append = TRUE)

## deployment ####

deployment_csv <- read.csv("processed_data/deployment.csv")

colnames(deployment_csv)
dbListFields(wlf_cam_db, "deployment")

dbWriteTable(conn = wlf_cam_db,
             name = "deployment",
             value = deployment_csv,
             append = TRUE)

## sequence ####

sequence_csv <- read.csv("processed_data/sequence.csv")

colnames(sequence_csv)
dbListFields(wlf_cam_db, "sequence")

dbWriteTable(conn = wlf_cam_db,
             name = "sequence",
             value = sequence_csv,
             append = TRUE)

## detection ####

detection_csv <- read.csv("processed_data/detection.csv")

colnames(detection_csv)
dbListFields(wlf_cam_db, "detection")

dbWriteTable(conn = wlf_cam_db,
             name = "detection",
             value = detection_csv,
             append = TRUE)
