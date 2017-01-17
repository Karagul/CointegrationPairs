library(quantmod)
library(tseries)
library(MuMIn)
library(dtplyr)
library(tidyr)

options(na.action = "na.fail", digits = 9)


symbolList <- c('ROYT','SDR','ORIG','PDLI','GNRT','ANH', 'ATAX','NCZ','BKT','IGD','VRS','EDD', 'MFA','CYS','LEO','ADPT','PSEC','GAIN','TWO','LPG')


stockdata = lapply(symbolList, function (x) {
  
  getSymbols(x, auto.assign = FALSE)
})


data <- na.omit(data.frame(do.call(merge, stockdata)))
data <- data %>% select(contains('Adjusted'))
names(data) <- gsub("\\..*","",names(data))


adfData = lapply(data, function(x) {
  
  adf.test(x, k = 1)
})


adfFrame <- data.frame(unlist(adfData))
adfFrame <- adfFrame %>% 
  mutate(stat = rownames(adfFrame), p = as.numeric(as.character(unlist.adfData.))) %>% 
  select(stat, p) %>%
  filter(stat %like% 'value', p < .05)


adfList <- as.character(gsub("\\..*","",adfFrame$stat))

data <- data %>% select(one_of(adfList))


model1 <- lm(IGD ~ CYS, data = data)
model2 <- lm(CYS ~ IGD, data = data)

adf.test(model1$residuals, k=1)
adf.test(model2$residuals, k=1)


plot(model1$residuals, type = 'l', col = 'red')
par(new = T)
plot(model2$residuals, type = 'l', col = 'blue')
par(new = F)
