# MeanReversionTest
## Check for cointegration between stochastic pairs using Augmented Dickey-Fuller Test
### Given 20 securities, should find that IGD and CYS are individually order of integration 1 and paired 0
#### 1
```r
adfData = lapply(data, function(x) {
  
  adf.test(x, k = 1)
})
```
```
$IGD

	Augmented Dickey-Fuller Test

data:  x
Dickey-Fuller = -3.304842, Lag order = 0, p-value = 0.0736374
alternative hypothesis: stationary


$CYS

	Augmented Dickey-Fuller Test

data:  x
Dickey-Fuller = -3.499912, Lag order = 0, p-value = 0.0451887
alternative hypothesis: stationary

```
#### 0
```r
model1 <- lm(IGD ~ CYS, data = data)
model2 <- lm(CYS ~ IGD, data = data)

adf.test(model1$residuals, k = 0)
adf.test(model2$residuals, k = 0)
```
```
Augmented Dickey-Fuller Test

data:  model1$residuals
Dickey-Fuller = -3.327829, Lag order = 0, p-value = 0.0698063
alternative hypothesis: stationary

Augmented Dickey-Fuller Test

data:  model2$residuals
Dickey-Fuller = -3.542106, Lag order = 0, p-value = 0.0413759
alternative hypothesis: stationary
```
