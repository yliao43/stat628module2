#---Generating prediciton CSV

rm(list = ls())
load('/Users/tete/628data/prediction.RData')

for(i in index){
  pred <- append(pred, 4, after = i-1)
}

write.csv(data.frame(Id = 1:length(pred), Expected = pred), "submit.csv", row.names = F)
