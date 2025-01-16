
#install.packages("tidyverse")
#install.packages("xml2")
#install.packages("rvest")
library(xml2)
library(tidyverse)
library(rvest)
library(writexl)


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

df<-data.frame(tunfol=tunfol)

write_xlsx(df, "output/to_unfollow.xlsx")









data.frame(setdiff(fings, fers))[102,]
remcli$navigate(tunfol[101])


butfol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[2]/div/div[1]/section/main/div/header/section[2]/div/div/div[2]/div/div[1]/button")
butfol$clickElement()
Sys.sleep(abs(rnorm(1, 3, 1)))
nmf<-remcli$findElement("xpath", "/html/body/div[5]/div[2]/div/div/div[1]/div/div[2]/div/div/div/div/div[2]/div/div/div/div[8]/div[1]")
nmf$clickElement()
Sys.sleep(abs(rnorm(1, 5, 1)))













