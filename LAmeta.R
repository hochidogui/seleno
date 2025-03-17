








handle<-remcli$findElement("xpath", '//span[contains(text(),"lililasolina")]')


remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(handle))



eldf<-data.frame(matrix(NA, nrow = length(st), ncol = 0))

#colnames(eldf)<-c("account", "posts", "follower", "following", "ratio")



scrollable_div <- remcli$findElement(using = "css selector", ".xyi19xy")


scrollable_div$executeScript("arguments[0].scrollTop += 300;", list(scrollable_div))


while (TRUE){

(nh <- scrollable_div$executeScript("return arguments[0].scrollHeight;", list(scrollable_div))[[1]])

scrollable_div$executeScript("arguments[0].scrollTop = arguments[0].scrollHeight;", list(scrollable_div))

Sys.sleep(abs(rnorm(1, 6, 0.5)))

(sh <- scrollable_div$executeScript("return arguments[0].scrollHeight;", list(scrollable_div))[[1]])

if(nh == sh){
  break
 } 
}



se<-remcli$findElements(using = "xpath", "//span[@class='_ap3a _aaco _aacw _aacx _aad7 _aade']")

st <- unlist(sapply(se, function(x) x$getElementText()))


st<-st[-c(1:7)]

head(st,11)
tail(st,10)

length(st)


st[2107]

#scrollable_div <- remcli$findElement(using = "css selector", ".xyi19xy")

#handle<-remcli$findElement("xpath", '//span[contains(text(),"mauritius_cordelli")]')

for(i in 2110:length(st)){

handle<-remcli$findElement("xpath", paste0('//span[contains(text(),"', st[i], '")]'))
handle$getElementText()

remcli$executeScript("arguments[0].scrollIntoView({block: 'center'});", list(handle))  

Sys.sleep(abs(rnorm(1, 2, 0.1)))

#remcli$mouseMoveToLocation(webElement = handle)

Sys.sleep(abs(rnorm(1, 2, 0.1)))

hbox<-remcli$findElement("xpath", "/html/body/div[6]/div[2]/div/div/div[1]/div/div[3]/div/div/div[1]/div[1]/div")


(text<-unlist(hbox$getElementText()))

utext<-unlist(strsplit(text, split = ""))
nposis<-c()
for(i in 1:length(utext)){
  if (utext[i] == "\n"){
    nposis<-append(nposis, i)
  }
}

print(text)
length(nposis)
(nom<-substr(text, 1, nposis[1]-1))

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

eldf<-rbind(eldf, row)


}



dim(eldf)

saveRDS(eldf, "output/LAmetaD.Rds")


# CHECK!
#silvastudio.e


###############################################################################
###############################################################################

lametad<-readRDS("output/LAmetaD.Rds")


dim(lametad)

head(lametad)

tail(lametad)


lametad<-lametad[!duplicated(lametad$account),]
dim(lametad)
rownames(df)<-NULL

sum(duplicated(lametad$account))

hist(as.numeric(lametad$ratio), breaks = 100)


lametad$posts<-as.numeric(lametad$posts)
lametad$follower<-as.numeric(lametad$follower)
lametad$following<-as.numeric(lametad$following)
lametad$ratio<-as.numeric(lametad$ratio)



m1<-lm(ratio~posts, data = lametad)

summary(m1)


plot(ratio~posts, data = lametad)

summary(lametad$ratio)
summary(lametad$posts)
summary(lametad$follower)

lametad[lametad$ratio > 15,]
lametad[lametad$follower > 60000,]



