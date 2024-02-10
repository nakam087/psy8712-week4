# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim="-", col_names=c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl)
wide_tbl <- separate(import_tbl, col=5, into = c("q1", "q2", "q3", "q4","q5"))
sapply(wide_tbl[,5:9], as.integer)
wide_tbl[,4] <- mdy_hms(wide_tbl$datadate) #couldn't figure out using as.POSIXct
wide_tbl[,5:9] <- replace(wide_tbl[,5:9], wide_tbl[,5:9] == 0, values =NA)
wide_tbl <- drop_na(wide_tbl,6)
long_tbl <- pivot_longer(wide_tbl, 5:9, names_to = "Question answered", values_to = "Response given")