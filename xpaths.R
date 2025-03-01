################################################################################
# xpaths #######################################################################
################################################################################

regpost<-paste0("/html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] | 
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[3]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] |
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[3]/div/div[2]/div[1]/div/div/div[1]/div/div/div[2] | 
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[2]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/div/div/ul/li[2]/div/div/div/div/div[2] |
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[2]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/div/div/ul/li[2]/div/div/div/div/div[2] |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[2]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/div/div/ul/li[2]/div/div/div/div/div[2] |
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[2]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/div/div/ul/li[2]/div/div/div/div/div[2] |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[2]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/div/div/ul/li[2]/div/div/div/div/div[2] |
                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[2]/div[1]/div/div/div[1]/div/div[1]/div[2]/div/div/div/ul/li[2]/div/div/div/div/div[2] ")
                 
#anz<-try(remcli$findElement("xpath", ""), silent = T) #test                
#pp<-try(center<-remcli$findElement("xpath", regpost), silent = T)
#remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(center))
#remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 750, 75),");")) # Scroll down to load more posts


gefolgt<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span |
                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[1]/div/div[1]/div/div/div[2]/span/span/span")

#gefol<-remcli$findElement("xpath", gefolgt) #test

mlike<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[3]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div |
               /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[3]/div/div[3]/div/div/section[1]/div[1]/span[1]/div/div/div ")

#like<-remcli$findElement("xpath", mlike) #test

buttfolg<-paste0("/html/body/div[2]/div/div/div[2]/div/div/div[1]/div[2]/div/div[1]/section/main/div/header/section[2]/div/div/div[2]/div/div[1]/button |
                  /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[2]/div/div[1]/section/main/div/header/section[2]/div/div/div[2]/div/div[1]/button")

#exist<-try(butfol<-remcli$findElement("xpath", buttfolg), silent = T) #test

nomoref<-paste0("/html/body/div[5]/div[2]/div/div/div[1]/div/div[2]/div/div/div/div/div[2]/div/div/div/div[8]/div[1] |
                 /html/body/div[4]/div[2]/div/div/div[1]/div/div[2]/div/div/div/div/div[2]/div/div/div/div[8]/div[1]/div/div/div[1]/div/div |
                 /html/body/div[4]/div[2]/div/div/div[1]/div/div[2]/div/div/div/div/div[2]/div/div/div/div[8]/div[1]")

#try(nmf<-remcli$findElement("xpath", nomoref), silent = T) #test

onecommenttorulethemall<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[2]/section/div/form/div/textarea |
                                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[2]/section/div/form/div/textarea |
                                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[3]/section/div/form/div/textarea |
                                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[3]/section/div/form/div/textarea |
                                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[4]/section/div/form/div/textarea |
                                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div[4]/section/div/form/div/textarea |
                                 /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div/section/div/form/div/textarea |
                                 /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[3]/div/div/div/section/div/form/div/textarea")

#octrta<-try(Thecomment<-remcli$findElement("xpath", onecommenttorulethemall), silent = F) #test
#remcli$executeScript(paste0("window.scrollBy(0, ", rnorm(1, 750, 75),");")) # Scroll down to load more posts

hovername<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[4]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[1]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[1]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[2]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span |
                   /html/body/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div[1]/section/main/div[1]/div/div/div[3]/div/div[1]/div/article[5]/div/div[1]/div/div[2]/div/div[1]/div[1]/div/span/span/span/span/div/a/div/div/span")
                
#gt<-try(name<-remcli$findElement("xpath", hovername), silent = T)

hoverbox<-paste0("/html/body/div[1]/div/div/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div |
                  /html/body/div[2]/div/div/div[2]/div/div/div[2]/div/div/div[1]/div[1]/div")