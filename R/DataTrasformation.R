#######################################################################################
#########     Read in PS3 data from step 1 with some Manual corection     #############
#########     Some columns are removed: (1) IGN reviews
#########                               (2) IGN consumer reviews
#########                               
#######################################################################################

rm(list = ls()) 
setwd("/Users/yuzhouliu/Desktop/dataset")
ps3 = read.csv("ps3.csv",header=T)

### Make index
start.ps3 = which(duplicated(ps3[,"Game"]) == F) 
period.ps3 = rep(0,length(start.ps3)) 
for (i in 1:length(start.ps3)){    
   period.ps3[i] = start.ps3[i+1] - start.ps3[i] 
} 
period.ps3[length(start.ps3)] = dim(ps3)[1] - start.ps3[length(start.ps3)]+1 
end.ps3 = start.ps3 + period.ps3 - 1 
N.game = length(unique(ps3[,"Game"]));N.game
ps3[,"Time"] = paste(ps3[,"Time"])
ps3[,"Company"] = paste(ps3[,"Company"])
ps3[,"Genre"] = paste(ps3[,"Genre"])
ps3[,"Game"] = paste(ps3[,"Game"])
###
meta = ps3[start.ps3,"Metacritic"]
Num_critic = ps3[start.ps3,"Num_critic"]
SD_critic = ps3[start.ps3,"SD_critic"]
gs = ps3[start.ps3,"GS_review"]
new = which(ps3[start.ps3,"Generation"]==0)
sequel = which(ps3[start.ps3,"Generation"]==1)


########################################################################################
#  Preparing for publisher information
########################################################################################
temp = cbind(ps3[,"No"],ps3[,"Game"],ps3[,"age"],ps3[,"Units"],ps3[,"Price"],ps3[,"Generation"],
             ps3[,"Adv.dollar"],ps3[,"Num_critic"],ps3[,"Metacritic"],ps3[,"SD_critic"],ps3[,"GS_review"],ps3[,"SD_review"],
             ps3[,"Num_review"],ps3[,"mkt"],ps3[,"new_hw"],ps3[,"total_entry"],ps3[,"holiday"],ps3[,"Post.days"],ps3[,"Days.in.Month"])

table(ps3[start.ps3,"Company"])

EA       =  rep(0,N.game)
Sony     =  rep(0,N.game)
T2       =  rep(0,N.game)
Blizd    =  rep(0,N.game)
Sega     =  rep(0,N.game)
Ubisoft  =  rep(0,N.game)
Square   =  rep(0,N.game)
Atlus    =  rep(0,N.game)
Warner   =  rep(0,N.game)
Capcom   =  rep(0,N.game)
THQ      =  rep(0,N.game)
MTV      =  rep(0,N.game)
Bethesda =  rep(0,N.game)

for(i in 1:N.game){
    if(ps3[start.ps3,"Company"][i]=="Electronic Arts"){
       EA[i]=1}
    else if(ps3[start.ps3,"Company"][i]=="Sony (Corp)"){
       Sony[i]=1}
    else if(ps3[start.ps3,"Company"][i]=="Take 2 Interactive (Corp)"){
       T2[i]=1}
    else if(ps3[start.ps3,"Company"][i]=="Activision Blizzard (Corp)"){
       Blizd[i]=1}
    else if(ps3[start.ps3,"Company"][i]=="Sega"){
       Sega[i]=1}
    else if(ps3[start.ps3,"Company"][i]=="Ubisoft"){
       Ubisoft[i]=1}
    else if(ps3[start.ps3,"Company"][i]=="Square Enix Inc (Corp)"){
       Square[i]=1}       
    else if(ps3[start.ps3,"Company"][i]=="Atlus"){
       Atlus[i]=1}       
    else if(ps3[start.ps3,"Company"][i]=="Warner Bros. Interactive"){
       Warner[i]=1}
    else if(ps3[start.ps3,"Company"][i]=="Capcom USA"){
       Capcom[i]=1}       
    else if(ps3[start.ps3,"Company"][i]=="THQ (Corp)"){
       THQ[i]=1}       
    else if(ps3[start.ps3,"Company"][i]=="MTV Games/Electronic Arts"){
       MTV[i]=1}       
    else if(ps3[start.ps3,"Company"][i]=="Bethesda Softworks"){
       Bethesda[i]=1}                   
}

########################################################################################
#  Preparing for Genre information
########################################################################################

table(ps3[start.ps3,"Genre"])
RPG     =  rep(0,N.game)
Shoot   =  rep(0,N.game)
Act     =  rep(0,N.game)
Advt    =  rep(0,N.game)
Sport   =  rep(0,N.game)
Racing  =  rep(0,N.game)
Other   =  rep(0,N.game)

for(i in 1:N.game){
    if(ps3[start.ps3,"Genre"][i]=="RPG"){
       RPG[i]=1}
    else if(ps3[start.ps3,"Genre"][i]=="1st Person Shooter"||ps3[start.ps3,"Genre"][i]=="Other Shooter"||ps3[start.ps3,"Genre"][i]=="Mechanized Shooter"){
       Shoot[i]=1}
    else if(ps3[start.ps3,"Genre"][i]=="General Action"||ps3[start.ps3,"Genre"][i]=="Squad Based Combat"||ps3[start.ps3,"Genre"][i]=="Action/Driving Hybrid"){
       Act[i]=1}
    else if(ps3[start.ps3,"Genre"][i]=="General Adventure"||ps3[start.ps3,"Genre"][i]=="Survival Horror"){
       Advt[i]=1}
    else if(ps3[start.ps3,"Genre"][i]=="Basketball"||ps3[start.ps3,"Genre"][i]=="Football"||ps3[start.ps3,"Genre"][i]=="Baseball"||ps3[start.ps3,"Genre"][i]=="Soccer"){
       Sport[i]=1}
    else if(ps3[start.ps3,"Genre"][i]=="Extreme Sports"||ps3[start.ps3,"Genre"][i]=="Golf"||ps3[start.ps3,"Genre"][i]=="Wrestling"||ps3[start.ps3,"Genre"][i]=="Boxing"||ps3[start.ps3,"Genre"][i]=="Hockey"){
       Sport[i]=1}
    else if(ps3[start.ps3,"Genre"][i]=="Action Oriented Racing"||ps3[start.ps3,"Genre"][i]=="Sports Oriented Racing"){
       Racing[i]=1}
    else{
       Other[i]=1}
}


out = cbind(EA,Sony,T2,Blizd,Sega,Ubisoft,Square,Atlus,Warner,Capcom,THQ,MTV,Bethesda,RPG,Shoot,Act,Advt,Sport,Racing,Other)
orginal_temp_col = dim(temp)[2]

temp = cbind(temp, matrix(0,dim(temp)[1], dim(out)[2]) )
for (i in 1:length(start.ps3)){
    for (j in start.ps3[i]:end.ps3[i]){
        temp[j, (orginal_temp_col +1): (orginal_temp_col +dim(out)[2]) ] = out[i,]
    }
}
temp[start.ps3,(orginal_temp_col +1): (orginal_temp_col +dim(out)[2])]==out

colnames(temp)=c("No","Game","Age","Units","Price","Sequel","Adv","Num","Meta","SD_Meta","GS","SD_GS","NUM_GS","MKT","Delta","ETY",
"Hld","post","m.days","EA","Sony","T2","Blizd","Sega","Ubisoft","Square","Atlus","Warner","Capcom","THQ","MTV","Bethesda",
"RPG","Shoot","Act","Advt","Sport","Racing","Other")

write.csv(temp, file="ps3_107_full.csv",row.names=F)















