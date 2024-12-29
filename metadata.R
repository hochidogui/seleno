
library(RSelenium)
library(wdman)
library(netstat)
library(tidyr)
library(crayon)
library(xml2)
library(tidyverse)
library(rvest)
library(writexl)
library(ascii)

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

toxtract<-data.frame(accounts=intersect(fers, fings))
dim(toxtract)


gefol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")
gefol$clickElement()


max_scroll_attempts <- 1000  # Maximum number of scrolls to attempt
scroll_attempts <- 0

df<-data.frame(matrix(NA, nrow = dim(toxtract)[1], ncol = 0))

t2<-system.time(while (scroll_attempts < max_scroll_attempts) {

 remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 750, 75),");")) # Scroll down to load more posts
 Sys.sleep(abs(rnorm(1, 2, 0.5)))
 gt<-try(name<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span"), silent = T)

 if (!inherits(gt, "try-error")) {
  
  mm<-try(remcli$mouseMoveToLocation(webElement = name), silent = T)
  Sys.sleep(abs(rnorm(1, 5, 0.5)))
  
  if (!inherits(mm, "try-error")) {

    gi<-try(llowers<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div"), silent = T)
       
     if (!inherits(gi, "try-error")) {
       text<-unlist(llowers$getElementText())
       print(text)

       nom<-names(unlist(sapply(fings, function(z) grep(z, text))))
       lower<-as.numeric(gsub("\\.", "", substr(text, regexpr("Beiträge\n", text)[1]+nchar("Beiträge\n"), (regexpr("\nFollower", text)[1]-1))))
       lowing<-as.numeric(gsub("\\.", "", substr(text, regexpr("Follower\n", text)[1]+nchar("Follower\n"), (regexpr("\nGefolgt", text)[1]-1))))
       osts<-as.numeric(gsub("[^0-9]", "", substr(text, regexpr("\nBeiträge", text)[1]-4, regexpr("\nBeiträge", text)[1]-1))) 

       nom
       osts
       lower
       lowing
       lower/lowing

       row<-c(nom, osts, lower, lowing, lower/lowing)

       df<-rbind(df, row)
       cat(blue(dim(df)[1], "\n"))
     } else {
       next
     } 
  } else {
    next
  }
  
 } else {
   next
 }
 scroll_attempts<-scroll_attempts+1
})



colnames(df)<-c("account", "posts", "follower", "following", "ratio")
head(df)

unique(df$account)

df1<-df[!duplicated(df$account),]

dim(df1)

df05<-df1[df1 %in% df1$ratio<=0.5,]


gsub("\\.", "", text)


class(regexpr("Beiträge\n", text))

nchar("Beiträge\n")

regexpr("Beiträge\n", text)[1]+nchar("Beiträge\n")

regexpr("\nFollower", text)[1]