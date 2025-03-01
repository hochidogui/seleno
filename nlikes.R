library(RSelenium)
library(wdman)
library(netstat)
library(tidyr)
library(crayon)


source("fuf.R")
length(tunfol)

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
hodog<-unlist(strsplit("hochidogui", split = ""))
for(i in 1:length(hodog)){
  uname<-remcli$findElement("name", "username")
  uname$sendKeysToElement(list(hodog[i]))
  Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
}
Sys.sleep(runif(n=1, min=2, max=5))

# password
elpir<-unlist(strsplit("el~pira69Hh?ig", split = ""))
for(i in 1:length(elpir)){
  pword<-remcli$findElement("name", "password")
  pword$sendKeysToElement(list(elpir[i]))
  Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
}
Sys.sleep(runif(n=1, min=2, max=5))

# enter
enter<-remcli$findElement("css selector", "button[type='submit']")
enter$clickElement()

remcli$setTimeout(type = "page load", milliseconds = 20000) 
Sys.sleep(runif(n=1, min=12, max=15))

# not now
#nn<-remcli$findElement("xpath", '//div[contains(text(),"Jetzt nicht")]')
#nn$clickElement()

#remcli$setTimeout(type = "page load", milliseconds = 20000) 
#Sys.sleep(runif(n=1, min=5, max=6))

#gefol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")
#gefol$clickElement()

####################################################################################

source("comments.R")

# comment genre: 
# genz, bronobro, boomer, victorian, bloodborne, lovecraft, hemingway,
# epic, norse, classics, ggm, borges, holt, basicpt 

(comments<-c(hemingway)) 

# Initialize variables
# Initialize variables
processed_posts <- 0
max_scroll_attempts <- 800  # Maximum number of scrolls to attempt
scroll_attempts <- 0
likes<-0
cc<-0
scrollps<-c()
megascroll_attempts<-0
mcscrolly<-0
fuge<-0
chopbloc<-1
countsame<-0
#remcli$navigate(tunfol[chopbloc])

prob.like <- 0.1
prob.comm <- 0.01
prob.unfol <- 0.125
#tunfol<-c()

source("xpaths.R")

df<-readRDS("output/metaD.Rds")             
dim(df)

# Loop through posts dynamically
t1<-system.time(while (scroll_attempts < max_scroll_attempts) {
  # Find all posts currently loaded
  posts <- remcli$findElements(using = 'xpath', "//article")
  
  # If there are no new posts, scroll to load more
  if (processed_posts >= length(posts)) {
    ############################################################################
    # look if post is ad or video ##############################################
    ############################################################################
    anz<-try(remcli$findElement("xpath", regpost), silent = T)
                                        
    if (inherits(anz, "try-error") & mcscrolly <=7) {
      cat(silver("McS =", mcscrolly), blue(scroll_attempts, "\n"))
      Sys.sleep(abs(rnorm(1, 1, 1)))
      remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 500, 100),");"))
      mcscrolly<-mcscrolly+1
      next
    } else if(mcscrolly>5){
      home<-remcli$findElement("xpath", "//a[@href='/']")
      home$clickElement()
      Sys.sleep(abs(rnorm(1, 5, 1)))
      if((fuge %% 2) == 0){
        gefol<-remcli$findElement("xpath", gefolgt)
        gefol$clickElement()               
      } 
      fuge<-fuge+1
      mcscrolly<-0
    }
    mcscrolly<-0
    ############################################################################
    # scrolls ##################################################################
    ############################################################################
    (scrollp <- unlist(remcli$executeScript("return window.scrollY;")))
    scrollps<-append(scrollps, scrollp)
    
    if(length(scrollps)>= 4){
      if (abs(scrollps[length(scrollps)] - scrollps[length(scrollps)-1])<300 |
          abs(scrollps[length(scrollps)] - scrollps[length(scrollps)-2])<300 |
          abs(scrollps[length(scrollps)] - scrollps[length(scrollps)-3])<300){
        remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 2200, 220),");"))
        megascroll_attempts<-megascroll_attempts+1
        cat(silver("MSC =", megascroll_attempts), blue(scroll_attempts, "\n"))
        if(megascroll_attempts==5){
          cat(magenta("MEGASCROOOOLL!! in 5 secs\n"))
          Sys.sleep(abs(rnorm(1, 5, 2)))
          home<-remcli$findElement("xpath", "//a[@href='/']")
          home$clickElement()
          remcli$setTimeout(type = "page load", milliseconds = 20000)
          Sys.sleep(abs(rnorm(1, 5, 1)))
          if((fuge %% 2) == 0){
            gefol<-remcli$findElement("xpath", gefolgt)
            gefol$clickElement()
          } 
          megascroll_attempts<-0
          fuge<-fuge+1
          next
        }
      } else if (abs(scrollps[length(scrollps)] - scrollps[length(scrollps)-1])>300 & megascroll_attempts>=1){megascroll_attempts<-0}
    }
    #megascroll_attempts<-0
    
    # up and down mini scrolls
    remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 950, 75),");")) # Scroll down to load more posts
    Sys.sleep(abs(rnorm(1, 0.5, 0.5)))
    nms<-round(abs(rnorm(1, 2, 0.5)))
    mscrolls<-rep(c(paste0("window.scrollBy(0, ", rnorm(1, -100, 10),");"), paste0("window.scrollBy(0, ", rnorm(1, 50, 7),");")),nms)
    for(i in 1:nms){
      
      remcli$executeScript(mscrolls[i])
      Sys.sleep(abs(rnorm(1, 0.6, 0.5)))
      #remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 50, 7),");"))
      #Sys.sleep(abs(rnorm(1, 0.6, 0.5)))    
      
    }
    
    # center post
    pp<-try(center<-remcli$findElement("xpath", regpost), silent = T)
    if (!inherits(pp, "try-error")) {
      remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(center))
      Sys.sleep(abs(rnorm(1, 0.5, 0.5)))
      remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 169, 6.9),");"))
    } else {
      next
    }
    ############################################################################
    # give a like! #############################################################
    ############################################################################
    Sys.sleep(abs(rnorm(1, 3, 2)))  # Wait for new posts to load
    scroll_attempts <- scroll_attempts + 1
    nval1<-rnorm(1)
    pval1<-pnorm(nval1)
    cat("prob. like:", 
        "\np-value =", round(pval1, 4), "; number = ", round(nval1, 4),
        "\n")
    if(pval1 < prob.like){
      cat(green("Mikey Likey!\n"))
      likes<-likes+1
      like<-remcli$findElement("xpath", mlike)
      like$clickElement()               
      Sys.sleep(abs(rnorm(1, 1, 0.5)))
      
    }
    ############################################################################
    # give a comment ###########################################################
    ############################################################################
    if(pnorm(rnorm(1))<prob.comm){
      
      cat(green("INCOMING COMMENT!!", 
                "\n"))
      
      emj<-jis[sample(1:length(jis), sample(1:3, 1))]
      pemj<-paste0(emj[length(emj)], emj[length(emj)-1], emj[length(emj)-2])
      (whichComment<-paste0(comments[sample(1:length(comments), 1)], pemj))
      print(whichComment)
      
      lbyl<-unlist(strsplit(whichComment, split = ""))
      octrta<-try(Thecomment<-remcli$findElement("xpath", onecommenttorulethemall), silent = F)
                                                     
      if (!inherits(octrta, "try-error")) {
        remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(Thecomment))
        for(i in 1:length(lbyl)){
          Thecomment<-remcli$findElement("xpath", onecommenttorulethemall)
          Thecomment$sendKeysToElement(list(lbyl[i]))
          Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
        }
        Sys.sleep(abs(rnorm(1, 0.2, 0.1)))
        Thecomment$sendKeysToElement(list(key="enter"))
        Sys.sleep(abs(rnorm(1, 0.5, 0.1)))
        like<-remcli$findElement("xpath", mlike)
        like$clickElement()
        Sys.sleep(abs(rnorm(1, 0.5, 0.1)))
        
      } 
      cc<-cc+1
    }
    ############################################################################
    # unfollow heretics ########################################################
    ############################################################################
    if(pnorm(rnorm(1))<prob.unfol & chopbloc <= length(tunfol)){
      
      cat(red("CHOP BLOCKING TIME!!!\n"))
      cat(blue(chopbloc, "\n"))
      
      Sys.sleep(abs(rnorm(1, 1, 1)))
      remcli$navigate(tunfol[chopbloc])
      Sys.sleep(abs(rnorm(1, 10, 1)))
      exist<-try(butfol<-remcli$findElement("xpath", buttfolg), silent = T)
      if (inherits(exist, "try-error")) {                
        Sys.sleep(abs(rnorm(1, 10, 1)))
        try(butfol<-remcli$findElement("xpath", buttfolg))
        #chopbloc<-chopbloc+1
      }
      
      Sys.sleep(abs(rnorm(1, 0.5, 0.1)))
      try(butfol$clickElement())
      Sys.sleep(abs(rnorm(1, 3, 1)))
      
      try(nmf<-remcli$findElement("xpath", nomoref), silent = T)
      Sys.sleep(abs(rnorm(1, 0.5, 0.1)))  
      try(nmf$clickElement())
      Sys.sleep(abs(rnorm(1, 5, 1)))
      
      chopbloc<-chopbloc+1
      
      #remcli$goBack()
      
      # come home
      home<-remcli$findElement("xpath", "//a[@href='/']")
      home$clickElement()
      remcli$setTimeout(type = "page load", milliseconds = 20000)
      Sys.sleep(abs(rnorm(1, 3, 1)))
      if((fuge %% 2) == 0){
        gefol<-remcli$findElement("xpath", gefolgt)
        gefol$clickElement()
      }
      
      fuge<-fuge+1
    }
    ############################################################################
    # harvest data #############################################################
    ############################################################################
    if((fuge %% 2) != 0){
    cat(red("HARVEST TIME!!!\n"))
    gt<-try(name<-remcli$findElement("xpath", hovername), silent = T)
    if(name$getElementText() == df$account[dim(df)[1]] | 
       name$getElementText() == df$account[dim(df)[1]-1] |
       name$getElementText() == df$account[dim(df)[1]-2] |
       name$getElementText() == df$account[dim(df)[1]-3]){
      cat(green("same, same, but different, but still the same!\n"))
      remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 950, 75),");")) # Scroll down to load more posts
      countsame<-countsame+1
      cat(yellow(paste0(countsame, " same shit different day!\n")))
      if(countsame == 3){
        cat(magenta(paste0(countsame, " ah shit, here we go again...\n")))
        remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 5000, 200),");"))
        countsame<-0
      }
      next
    } else {
    countsame<-0  
    remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(name))  
    Sys.sleep(abs(rnorm(1, 3, 0.5)))
    if (!inherits(gt, "try-error")) {
      
      mm<-try(remcli$mouseMoveToLocation(webElement = name), silent = T)
      Sys.sleep(abs(rnorm(1, 3, 0.5)))
      
      if (!inherits(mm, "try-error")) {
        
        gi<-try(llowers<-remcli$findElement("xpath", hoverbox), silent = T)
        
        if (!inherits(gi, "try-error")){ 
          if(nchar(unlist(llowers$getElementText())) >= 10) {  
          (text<-unlist(llowers$getElementText()))
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
          } else if (substr(text, nposis[4]+1, nposis[5]-1) == "Beiträge"){
            osts<-as.numeric(gsub("\\.", "", substr(text, nposis[3]+1, nposis[4]-1)))
            lower<-as.numeric(gsub("\\.", "", substr(text, nposis[5]+1, nposis[6]-1)))
            lowing<-as.numeric(gsub("\\.", "", substr(text, nposis[7]+1, nposis[8]-1)))
          }      
          
          nom
          osts
          lower
          lowing
          lower/lowing
          
          row<-c(nom, osts, lower, lowing, lower/lowing)
          
          cat(blue(row, "\n"))
          
          df<-rbind(df, row)
          cat(blue(paste0("harvest rows: ", dim(df)[1], "\n")))
          } else {
            next
          }
        } else {
          next
        } 
      } else {
        next
      }
      
    } else {
      next
    }}
    }
    
    next
  }
  # Interact with the next unprocessed post
  current_post <- posts[[processed_posts + 1]]
  
  # Scroll the current post to the center of the viewport
  remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(current_post))
  Sys.sleep(rnorm(1, 10, 2)) # Pause for stability
  
  # Optionally interact with the post (like, save, etc.)
  # current_post$clickElement()
  
  # Mark the current post as processed
  processed_posts <- processed_posts + 1
})

dim(df)
df<-df[!duplicated(df$account),]
dim(df)
rownames(df)<-NULL

saveRDS(df, "output/metaD.Rds")



df$ratio<-as.numeric(df$ratio)

threshold<-0.75

df[df$ratio<threshold,]; dim(df[df$ratio<threshold,])[1]

(dim(df[df$ratio<threshold,])[1]/dim(df)[1])*100

hist(df$ratio, freq = F)

(t1[3]/60)/60

(likes*100)/scroll_attempts

(cc*100)/scroll_attempts

scroll_attempts
likes
cc
chopbloc

tunfol


remdri$server$stop()


###################################################################################################
###################################################################################################




