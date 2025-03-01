
library(RSelenium)
library(wdman)
library(netstat)
library(tidyr)
library(crayon)
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
# open instagram

# Set up Firefox profile
fprof <- makeFirefoxProfile(list(
  "general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:94.0) Gecko/20100101 Firefox/94.0",  # Custom user-agent
  "dom.webdriver.enabled" = FALSE,  # Disable webdriver flag
  "useAutomationExtension" = FALSE  # Disable automation extension
))


remdri <- rsDriver(browser = "firefox",
                   chromever = NULL,
                   port = 4445L,
                   extraCapabilities = fprof,
                   verbose = F)

remcli <- remdri$client
#remcli$open()

remcli$navigate("https://www.instagram.com/")

Sys.sleep(runif(n=1, min=5, max=6))
remcli$setTimeout(type = "page load", milliseconds = 20000) 

# optional cookies only
oca<-remcli$findElement("xpath", '//button[contains(text(),"Optionale Cookies ablehnen")]')
oca$clickElement()

remcli$setTimeout(type = "page load", milliseconds = 20000) 
Sys.sleep(runif(n=1, min=5, max=6))

# username
uname<-remcli$findElement("name", "username")
uname$sendKeysToElement(list("hochidogui"))

Sys.sleep(runif(n=1, min=2, max=5))

# password
pword<-remcli$findElement("name", "password")
pword$sendKeysToElement(list("el~pira69Hh?ig"))

Sys.sleep(runif(n=1, min=2, max=5))

# enter
enter<-remcli$findElement("css selector", "button[type='submit']")
enter$clickElement()

remcli$setTimeout(type = "page load", milliseconds = 20000) 
Sys.sleep(runif(n=1, min=12, max=15))

# not now
nn<-remcli$findElement("xpath", '//div[contains(text(),"Jetzt nicht")]')
nn$clickElement()

remcli$setTimeout(type = "page load", milliseconds = 20000) 
Sys.sleep(runif(n=1, min=5, max=6))

#gefol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")
#gefol$clickElement()

# compare followers vs following

length(fers)
length(fings)

inter<-intersect(fers, fings)
length(inter)

toxtract<-data.frame(accounts=intersect(fers, fings))
dim(toxtract)

gefolgt<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")


gefol<-remcli$findElement("xpath", gefolgt) 
gefol$clickElement()


max_scroll_attempts <- 1000  # Maximum number of scrolls to attempt
scroll_attempts <- 0

df<-data.frame(matrix(NA, nrow = dim(toxtract)[1], ncol = 0))

hovername<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span")

hoverbox<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div |
                  /html/body/div[2]/div/div/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div")

t2<-system.time(while (scroll_attempts < max_scroll_attempts) {
  
  remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 750, 75),");")) # Scroll down to load more posts
  Sys.sleep(abs(rnorm(1, 2, 0.5)))
  gt<-try(name<-remcli$findElement("xpath", hovername), silent = T)
  remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(name))
                                            
  if (!inherits(gt, "try-error")) {
    
    mm<-try(remcli$mouseMoveToLocation(webElement = name), silent = T)
    Sys.sleep(abs(rnorm(1, 5, 0.5)))
    
    if (!inherits(mm, "try-error")) {
                                                   
      gi<-try(llowers<-remcli$findElement("xpath", hoverbox), silent = T)
      
      if (!inherits(gi, "try-error")) {
        text<-unlist(llowers$getElementText())
        utext<-unlist(strsplit(text, split = ""))
        nposis<-c()
        for(i in 1:length(utext)){
          if (utext[i] == "\n"){
            nposis<-append(nposis, i)
          }
        }
        
        print(text)
        length(nposis)
        nom<-substr(text, 1, nposis[1]-1)
        
        if(substr(text, nposis[3]+1, nposis[4]-1) == "Beiträge"){
          osts<-as.numeric(gsub("\\.", "", substr(text, nposis[2]+1, nposis[3]-1)))
          lower<-as.numeric(gsub("\\.", "", substr(text, nposis[4]+1, nposis[5]-1)))
          lowing<-as.numeric(gsub("\\.", "", substr(text, nposis[6]+1, nposis[7]-1)))
          
        } else if (substr(text, nposis[2]+1, nposis[3]-1) == "Beiträge"){
          osts<-as.numeric(gsub("\\.", "", substr(text, nposis[1]+1, nposis[2]-1)))
          lower<-as.numeric(gsub("\\.", "", substr(text, nposis[3]+1, nposis[4]-1)))
          lowing<-as.numeric(gsub("\\.", "", substr(text, nposis[5]+1, nposis[6]-1)))
        }     
             
        nom
        osts
        lower
        lowing
        lower/lowing
        
        row<-c(nom, osts, lower, lowing, lower/lowing)
        
        cat(blue(row, "\n"))
        
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

dim(df)

length(unique(df$account))

dim(unique(df))

df1<-df[!duplicated(df$account),]

dim(df1)

df05<-df1[df1 %in% df1$ratio<=0.5,]


remdri$server$stop()






