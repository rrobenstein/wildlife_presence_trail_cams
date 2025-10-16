# # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # STOP! # # # # # # # # # # # # #
# # # # # # # # # DO NOT RUN SCRIPT # # # # # # # # # #
# AS OF 2025-10-16, NO FILES IN PROCESSED DATA FOLDER #
# # # # # # # # # # # # # # # # # # # # # # # # # # # #


library(RSQLite)
library(DBI)

# connect to db for deadwood-wildlife####

dw_wlf_db <- dbConnect(drv = SQLite(),
                       "database/dw_wlf.db")

## list tables in db ####

dbListTables(dw_wlf_db)

# populate database ####

## surveyor ####

surveyor_csv <- read.csv("../processed_data/surveyor.csv")

colnames(surveyor_csv)
dbListFields(dw_wlf_db, "surveyor")

dbWriteTable(conn = dw_wlf_db,
             name = "surveyor",
             value = surveyor_csv,
             append = TRUE)

## UIEF plot ####

UIEF_plot_csv <- read.csv("../processed_data/UIEF_plot.csv")

colnames(UIEF_plot_csv)
dbListFields(dw_wlf_db, "UIEF_plot")

dbWriteTable(conn = dw_wlf_db,
             name = "UIEF_plot",
             value = UIEF_plot_csv,
             append = TRUE)

## plot section ####

plot_section_csv <- read.csv("../processed_data/plot_section.csv")

colnames(plot_section_csv)
dbListFields(dw_wlf_db, "plot_section")

dbWriteTable(conn = dw_wlf_db,
             name = "plot_section",
             value = plot_section_csv,
             append = TRUE)

## deadwood site ####

deadwood_site_csv <- read.csv("../processed_data/deadwood_site.csv")

colnames(deadwood_site_csv)
dbListFields(dw_wlf_db, "deadwood_site")

dbWriteTable(conn = dw_wlf_db,
             name = "deadwood_site",
             value = deadwood_site_csv,
             append = TRUE)

## deadwood structure ####

deadwood_structure_csv <- read.csv("../processed_data/deadwood_structure.csv")

colnames(deadwood_structure_csv)
dbListFields(dw_wlf_db, "deadwood_structure")

dbWriteTable(conn = dw_wlf_db,
             name = "deadwood_structure",
             value = deadwood_structure_csv,
             append = TRUE)

## cameras ####

cameras_csv <- read.csv("../processed_data/cameras.csv")

colnames(cameras_csv)
dbListFields(dw_wlf_db, "cameras")

dbWriteTable(conn = dw_wlf_db,
             name = "cameras",
             value = cameras_csv,
             append = TRUE)

## camera deployment ####

camera_deployment_csv <- read.csv("../processed_data/camera_deployment.csv")

colnames(camera_deployment_csv)
dbListFields(dw_wlf_db, "camera_deployment")

dbWriteTable(conn = dw_wlf_db,
             name = "camera_deployment",
             value = camera_deployment_csv,
             append = TRUE)

## photos ####

photos_csv <- read.csv("../processed_data/photos.csv")

colnames(photos_csv)
dbListFields(dw_wlf_db, "photos")

dbWriteTable(conn = dw_wlf_db,
             name = "photos",
             value = photos_csv,
             append = TRUE)

## photo detection ####

photo_detection_csv <- read.csv("../processed_data/photo_detection.csv")

colnames(photo_detection_csv)
dbListFields(dw_wlf_db, "photo_detection")

dbWriteTable(conn = dw_wlf_db,
             name = "photo_detection",
             value = photo_detection_csv,
             append = TRUE)

## videos ####

videos_csv <- read.csv("../processed_data/videos.csv")

colnames(videos_csv)
dbListFields(dw_wlf_db, "videos")

dbWriteTable(conn = dw_wlf_db,
             name = "videos",
             value = videos_csv,
             append = TRUE)

## video detection ####

video_detection_csv <- read.csv("../processed_data/video_detection.csv")

colnames(video_detection_csv)
dbListFields(dw_wlf_db, "video_detection")

dbWriteTable(conn = dw_wlf_db,
             name = "video_detection",
             value = video_detection_csv,
             append = TRUE)

## acoustic monitors ####

acoustic_monitors_csv <- read.csv("../processed_data/acoustic_monitors.csv")

colnames(acoustic_monitors_csv)
dbListFields(dw_wlf_db, "acoustic_monitors")

dbWriteTable(conn = dw_wlf_db,
             name = "acoustic_monitors",
             value = acoustic_monitors_csv,
             append = TRUE)

## acoustic deployment ####

acoustic_deployment_csv <- read.csv("../processed_data/acoustic_deployment.csv")

colnames(acoustic_deployment_csv)
dbListFields(dw_wlf_db, "acoustic_deployment")

dbWriteTable(conn = dw_wlf_db,
             name = "acoustic_deployment",
             value = acoustic_deployment_csv,
             append = TRUE)

## recordings ####

recordings_csv <- read.csv("../processed_data/recordings.csv")

colnames(recordings_csv)
dbListFields(dw_wlf_db, "recordings")

dbWriteTable(conn = dw_wlf_db,
             name = "recordings",
             value = recordings_csv,
             append = TRUE)

## recording detection ####

recording_detection_csv <- read.csv("../processed_data/recording_detection.csv")

colnames(recording_detection_csv)
dbListFields(dw_wlf_db, "recording_detection")

dbWriteTable(conn = dw_wlf_db,
             name = "recording_detection",
             value = recording_detection_csv,
             append = TRUE)

## point count transect ####

point_count_transect_csv <- read.csv("../processed_data/point_count_transect.csv")

colnames(point_count_transect_csv)
dbListFields(dw_wlf_db, "point_count_transect")

dbWriteTable(conn = dw_wlf_db,
             name = "point_count_transect",
             value = point_count_transect_csv,
             append = TRUE)

## point counts ####

point_counts_csv <- read.csv("../processed_data/point_counts.csv")

colnames(point_counts_csv)
dbListFields(dw_wlf_db, "point_counts")

dbWriteTable(conn = dw_wlf_db,
             name = "point_counts",
             value = point_counts_csv,
             append = TRUE)

## point count detection ####

point_count_detection_csv <- read.csv("../processed_data/point_count_detection.csv")

colnames(point_count_detection_csv)
dbListFields(dw_wlf_db, "point_count_detection")

dbWriteTable(conn = dw_wlf_db,
             name = "point_count_detection",
             value = point_count_detection_csv,
             append = TRUE)

## area search ####

area_search_csv <- read.csv("../processed_data/area_search.csv")

colnames(area_search_csv)
dbListFields(dw_wlf_db, "area_search")

dbWriteTable(conn = dw_wlf_db,
             name = "area_search",
             value = area_search_csv,
             append = TRUE)

## area search detection ####

area_search_detection_csv <- read.csv("../processed_data/area_search_detection.csv")

colnames(area_search_detection_csv)
dbListFields(dw_wlf_db, "area_search_detection")

dbWriteTable(conn = dw_wlf_db,
             name = "area_search_detection",
             value = area_search_detection_csv,
             append = TRUE)