#---Import Packages

rm(list = ls())

library(tidyverse)
library(tidytext)
library(glmnet)
library(data.table)
print("library done")

#---Read and Clean Data

origin_dat <- fread('review_train.csv', header = T)
flag <- grep('[A-Za-z0-9]', origin_dat$text)
logi <- 1:nrow(origin_dat) %in% flag
dat <- origin_dat[logi, ]
dat <- dat[1:1000000, ]

test <- fread('review_test.csv', header = T)
flag <- grep('[A-Za-z0-9]', test$text)
logi <- 1:nrow(test) %in% flag
print(which(logi == 0))
test <- test[logi, ]

print("read done")

Y <- as.numeric(dat$stars)
train <- 1:nrow(dat)
ntest <- (nrow(dat)+1):(nrow(dat)+nrow(test))

df <- data.frame(text = c(dat$text, test$text), index = 1:(nrow(dat)+nrow(test)))
df$text <- as.character(df$text)

rm(origin_dat, dat, test)
print("clean done")

#---Obtain Frequency of Words

words <- df %>% unnest_tokens(word, text)
print("token done")

sparse <- cast_sparse(words, index, word)
table(df$index == as.numeric(row.names(sparse)))
print("sparse done")

amount <- colSums(sparse)
X <- sparse[, amount > 2000]
rm(words, sparse, df)
print("X done")

#---Construct Model

cvfit <- cv.glmnet(X, Y)
print(cvfit$lambda.min)
print(cvfit$lambda.1se)

model <- glmnet(X[train, ], Y, lambda = cvfit$lambda.min)
print("model done")

#---Prediction

pred <- predict.glmnet(model, X[ntest, ], s = model$lambda)
print("prediction done")

index <- which(logi == 0)
save(pred, index, file = "prediction.RData")




