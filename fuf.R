library(xml2)
library(tidyverse)
library(rvest)
library(writexl)

# unpack
downloads_path <- file.path(Sys.getenv("USERPROFILE"), "Downloads")
files<-list.files(downloads_path, full.names = T)

(fuf_dl<-files[which.max(file.info(files)$mtime)])

winrar_path <- '"C:\\Program Files\\WinRAR\\WinRAR.exe"'

unzip(fuf_dl, list = TRUE)

folds <- unzip(fuf_dl, list = TRUE)$Name

fters <- folds[grepl(paste0("^", "connections/followers_and_following/followers_1.html"), folds)]
fting <- folds[grepl(paste0("^", "connections/followers_and_following/following.html"), folds)]

unzip(fuf_dl, files = fters, exdir = tempdir())
unzip(fuf_dl, files = fting, exdir = tempdir())

file.rename(file.path(tempdir(), fters), file.path("C:/Users/hugot/Documents/fff/input", basename(fters)))
file.rename(file.path(tempdir(), fting), file.path("C:/Users/hugot/Documents/fff/input", basename(fting)))

file.info(list.files("input", full.names = T))$mtime
# extract data from htmls

follers <- read_html("input/followers_1.html")

follers %>% html_structure()

folls<-follers %>% html_elements("a") %>% html_attr("href", default = "inactive")  

fers<-unlist(lapply(folls, function(z) substr(z, 27, nchar(z))))
fers

###################################################################################################
folling <- read_html("input/following.html")

folling %>% html_structure()

foing<-folling %>%  html_elements("a") %>% html_attr("href", default = "inactive")  

fings<-unlist(lapply(foing, function(z) substr(z, 27, nchar(z))))

fings

###################################################################################################

# compare followers vs following

length(fers)
length(fings)

inter<-intersect(fers, fings)
length(inter)

setdiff(fers, fings)
data.frame(setdiff(fings, fers))

length(setdiff(fings, fers))

tunfol<-paste0("https://www.instagram.com/", setdiff(fings, fers), "/")

print(length(tunfol))

print(file.info(list.files("input", full.names = T))$mtime)
#df<-data.frame(tunfol=tunfol)
#write_xlsx(df, "output/to_unfollow.xlsx")






















