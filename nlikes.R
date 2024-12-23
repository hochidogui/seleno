
library(RSelenium)
library(wdman)
library(netstat)
library(tidyr)
library(crayon)


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
pword$sendKeysToElement(list("Lavacolas69Hh?ig"))

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

####################################################################################

source("comments.R")

# comment genre: 
# genz, bronobro, boomer, victorian, bloodborne, lovecraft, hemingway,
# epic, norse, classics 

(comments<-bloodborne) 

# Initialize variables
# Initialize variables
processed_posts <- 0
max_scroll_attempts <- 500  # Maximum number of scrolls to attempt
scroll_attempts <- 0
likes<-0
cc<-0
scrollps<-c()
megascroll_attempts<-0
mcscrolly<-0
fuge<-0
chopbloc<-1

# Loop through posts dynamically
t1<-system.time(while (scroll_attempts < max_scroll_attempts) {
  # Find all posts currently loaded
  posts <- remcli$findElements(using = 'xpath', "//article")
  
  # If there are no new posts, scroll to load more
  if (processed_posts >= length(posts)) {
    
    # look if post is ad or video
    anz<-try(remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div[1]/div/div[3]/div/div[1]/div/article[5]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2]"), silent = T)
    
    if (inherits(anz, "try-error") & mcscrolly <=5) {
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
        gefol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")
        gefol$clickElement()
      } 
      fuge<-fuge+1
      mcscrolly<-0
    }
    mcscrolly<-0
    
    # scrolls

    (scrollp <- unlist(remcli$executeScript("return window.scrollY;")))
    scrollps<-append(scrollps, scrollp)
    
    if(length(scrollps)>= 2){
    if (abs(scrollps[length(scrollps)] - scrollps[length(scrollps)-1])<200){
      remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 1500, 100),");"))
      megascroll_attempts<-megascroll_attempts+1
      cat(silver("MSC =", megascroll_attempts), blue(scroll_attempts, "\n"))
      if(megascroll_attempts==3){
        cat(magenta("MEGASCROOOOLL!! in 2 mins\n"))
        Sys.sleep(abs(rnorm(1, 120, 10)))
        home<-remcli$findElement("xpath", "//a[@href='/']")
        home$clickElement()
        remcli$setTimeout(type = "page load", milliseconds = 20000)
        Sys.sleep(abs(rnorm(1, 5, 1)))
        if((fuge %% 2) == 0){
        gefol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")
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
    remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 750, 75),");")) # Scroll down to load more posts
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
    pp<-try(center<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div[1]/div/div[3]/div/div[1]/div/article[5]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2]"), silent = T)
    if (!inherits(pp, "try-error")) {
      remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(center))
      Sys.sleep(abs(rnorm(1, 0.5, 0.5)))
      remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 99, 6.9),");"))
    } else {
      next
    }
    
    # give a like!
    Sys.sleep(rnorm(1, 9, 2))  # Wait for new posts to load
    scroll_attempts <- scroll_attempts + 1
    nval1<-rnorm(1)
    pval1<-pnorm(nval1)
    cat("prob. like:", 
              "\np-value =", round(pval1, 4), "; number = ", round(nval1, 4),
              "\n")
    if(pval1<0.2){
      cat(green("Mikey Likey!\n"))
      likes<-likes+1
      like<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div[1]/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div")
      like$clickElement()
      Sys.sleep(abs(rnorm(1, 1, 0.5)))
      
      # give a comment
      nval2<-rnorm(1)
      pval2<-pnorm(nval2)
      cat(green("prob. comment:", 
                "\np-value =", round(pval2, 4), "; number =", round(nval2, 4),
                "\n"))
      
      if(pval2<0.05){
        
        emj<-jis[sample(1:length(jis), sample(1:3, 1))]
        pemj<-paste0(emj[length(emj)], emj[length(emj)-1], emj[length(emj)-2])
        (whichComment<-paste0(comments[sample(1:length(comments), 1)], pemj))
        print(whichComment)
        
        lbyl<-unlist(strsplit(whichComment, split = ""))
        cm1<-try(comment1<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[3]/section/div/form/div/textarea"), silent = F)
        cm2<-try(comment2<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[4]/section/div/form/div/textarea"), silent = F)
        cm3<-try(comment3<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[2]/section/div/form/div/textarea"), silent = F)
        
        if (!inherits(cm1, "try-error")) {
          for(i in 1:length(lbyl)){
            comment1<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[3]/section/div/form/div/textarea")
            comment1$sendKeysToElement(list(lbyl[i]))
            Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
          }
          #comment1$sendKeysToElement(list(key="enter"))
          Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
        } else if (!inherits(cm2, "try-error")) {
            for(i in 1:length(lbyl)){
              comment2<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[4]/section/div/form/div/textarea")
              comment2$sendKeysToElement(list(lbyl[i]))
              Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
            }
            Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
            #comment2$sendKeysToElement(list(key="enter"))
            Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
        } else if (!inherits(cm3, "try-error")) {
          for(i in 1:length(lbyl)){
            comment3<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[2]/section/div/form/div/textarea")
            comment3$sendKeysToElement(list(lbyl[i]))
            Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
          }
          Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
          #comment3$sendKeysToElement(list(key="enter"))
          Sys.sleep(abs(rnorm(1, 0.1, 0.1)))
          
          
        } 
        cc<-cc+1
      }
      
    }
    
    # if(pnorm(rnorm(1))<0.1 & chopbloc <= length(tunfol)){
    #   
    #   cat(red("CHOP BLOCKING TIME!!!\n"))
    #   cat(blue(chopbloc, "\n"))
    #   
    #   Sys.sleep(abs(rnorm(1, 1, 1)))
    #   remcli$navigate(tunfol[chopbloc])
    #   Sys.sleep(abs(rnorm(1, 5, 1)))
    #   exist<-try(butfol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[2]/div/div[1]/section/main/div/header/section[2]/div/div/div[2]/div/div[1]/button"), silent = T)
    #   if (inherits(exist, "try-error")) {
    #     chopbloc<-chopbloc+1
    #     next
    #   }
    #   
    #   Sys.sleep(abs(rnorm(1, 0.5, 0.1)))
    #   butfol$clickElement()
    #   Sys.sleep(abs(rnorm(1, 3, 1)))
    #   
    #   nmf<-remcli$findElement("xpath", "/html/body/div[5]/div[2]/div/div/div[1]/div/div[2]/div/div/div/div/div[2]/div/div/div/div[8]/div[1]")
    #   Sys.sleep(abs(rnorm(1, 0.5, 0.1)))
    #   nmf$clickElement()
    #   Sys.sleep(abs(rnorm(1, 5, 1)))
    #   
    #   chopbloc<-chopbloc+1
    #   
    #   # come home
    #   home<-remcli$findElement("xpath", "//a[@href='/']")
    #   home$clickElement()
    #   remcli$setTimeout(type = "page load", milliseconds = 20000)
    #   Sys.sleep(abs(rnorm(1, 5, 1)))
    #   if((fuge %% 2) == 0){
    #     gefol<-remcli$findElement("xpath", "/html/body/div[2]/div/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")
    #     gefol$clickElement()
    #   } 
    #   
    #   fuge<-fuge+1
    # }
    
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


