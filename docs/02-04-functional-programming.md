# Programming Paradigms #




## Reading ##

- Introductions to parts II and III of @WickhamAdvanced2014
- @ChambersObjectOrientedProgrammingFunctional2014

## Dependencies ##


```r
install.packages('sloop')
```

## Programming paradigms ##
Procedural or imperative
: Software is a series of instructions ("procedures"), which the computer carries out in order.  Special instructions (if-then, loops) are used to change the order based on inputs or other conditions.  
    - Examples: FORTRAN, BASIC, C, a calculator

Object-oriented
: Software is made up of objects, which have properties ("attributes," including other objects) and do things ("methods").  
    - Examples: Python, Java

Functional
: Software is made up of functions, which are run sequentially on the inputs.  
    - Examples: Lisp, Haskell

### R is both object-oriented *and* functional ###

- Object-oriented:  Everything that exists is an object
- Functional:  Everything that happens is a function call
    
## Object-oriented programming

- board game as OOP
- regression models as OOP

## The OOP you're used to ##

- Classes are defined by their elements and methods
- Changing/adding elements and methods requires changing the class definition
- For $x$ to be an $F$, $x$ must be created as an $F$


```python
## <https://vegibit.com/python-class-examples/>
class Vehicle:
    def __init__(self, brand, model, type):
        self.brand = brand
        self.model = model
        self.type = type
        self.gas_tank_size = 14
        self.fuel_level = 0

    def fuel_up(self):
        self.fuel_level = self.gas_tank_size
        print('Gas tank is now full.')

    def drive(self):
        if self.fuel_level > 0:
            print(f'The {self.model} is now driving.')
            self.fuel_level -= 1
        else:
            print(f'The {self.model} is out of gas!')

dhCar = Vehicle('Honda', 'Fit', 'Hatchback')
dhCar.gas_tank_size = 10
dhCar.fuel_up()
dhCar.drive()
```

---

## S3 is OOP, but weird

- S3 classes can be changed on the fly, with no attempt to validate any assumptions. 


```r
dh_car = list(brand = 'Honda', model = 'Fit', type = 'Hatchback')
class(dh_car)
class(dh_car) = c('vehicle', class(dh_car))
class(dh_car)
inherits(dh_car, 'vehicle')
```

```r
model = lm(log(mpg) ~ log(disp), data = mtcars)
class(model)
print(model)
class(model) = 'Date'
class(model)
try(print(model))
```

- Wickham discusses good practices to reduce this chaos in S3
    - write constructor, validator, and helper functions
- S4 and R6 provide more conventional OOP structure

---

- S3 uses **generic functions**


```r
reg_model = lm(log(mpg) ~ log(disp), data = mtcars)
aov_model = aov(log(mpg) ~ log(disp), data = mtcars)

class(reg_model)
class(aov_model)
inherits(aov_model, 'lm')

print(reg_model)
print(aov_model)

residuals(aov_model)
residuals(reg_model)
```

- Both `aov_model` and `reg_model` inherit from `lm`
- `print()` and `residuals()` are both generics
    - (There can be) different versions of each function for different classes
    - Different output for `print()`
    - Same output for `residuals()`

---

- `print()` is a generic; the call just passes us off using `UseMethod()`


```r
print
## function (x, ...) 
## UseMethod("print")
## <bytecode: 0x7ff7c347d288>
## <environment: namespace:base>
```

- `sloop` package is useful for understanding how S3 figures out which specific function to call


```r
library(sloop)
```

```r
s3_dispatch(print(reg_model))
s3_dispatch(print(aov_model))
```

- Note that the class-specific functions are often hidden

```r
try(print.lm)
s3_get_method(print.lm)
# stats:::print.lm
s3_get_method(print.aov)
# stats:::print.aov
```

- *Use `s3_dispatch()` to explain why the two models have the same output for `residuals()`.*

---

- `sloop::s3_methods_generic()` lists all class-specific versions of generics


```r
s3_methods_generic('print')
## # A tibble: 251 × 4
##    generic class   visible source             
##    <chr>   <chr>   <lgl>   <chr>              
##  1 print   acf     FALSE   registered S3method
##  2 print   AES     FALSE   registered S3method
##  3 print   anova   FALSE   registered S3method
##  4 print   aov     FALSE   registered S3method
##  5 print   aovlist FALSE   registered S3method
##  6 print   ar      FALSE   registered S3method
##  7 print   Arima   FALSE   registered S3method
##  8 print   arima0  FALSE   registered S3method
##  9 print   AsIs    TRUE    base               
## 10 print   aspell  FALSE   registered S3method
## # … with 241 more rows
```

- And similarly for all generics defined for a given class


```r
s3_methods_class('lm')
## # A tibble: 35 × 4
##    generic        class visible source             
##    <chr>          <chr> <lgl>   <chr>              
##  1 add1           lm    FALSE   registered S3method
##  2 alias          lm    FALSE   registered S3method
##  3 anova          lm    FALSE   registered S3method
##  4 case.names     lm    FALSE   registered S3method
##  5 confint        lm    TRUE    stats              
##  6 cooks.distance lm    FALSE   registered S3method
##  7 deviance       lm    FALSE   registered S3method
##  8 dfbeta         lm    FALSE   registered S3method
##  9 dfbetas        lm    FALSE   registered S3method
## 10 drop1          lm    FALSE   registered S3method
## # … with 25 more rows
```

## Functional programming

- board game as a series of functions? 
- regression models as a series of functions

## Common features of functional programming

First-class functions
:  Functions can be used like any other data type, including as inputs to and outputs from other functions

Determinism
:  Given a list of input values, a function always returns the same output value

No side effects
:  A function doesn't have any effects other than returning its output

Immutability
:  Once a variable is assigned a value, that value cannot be changed

These features make it much easier to reason about how a functional program works. 


## Breaking R: Everything that happens is a function ##

- This includes assignment

```
foo = 3
`<-` <- function(x, y) x + y
foo <- 5
foo = 7
```

- And brackets

```
`[` <- function(x, y) x * y
bar = data.frame(x = rep(1, 15),
                 y = rep(2, 15))
bar['x']
bar[2]
bar[18]
```

## Actually-useful functional R:  Pipes (and the tidyverse)

- Pipe syntax for function composition (`%>%` and `|>`)
- Tidyverse functions are designed to work with pipes


```r
library(dplyr)
```


```r
mtcars %>%
    filter(cyl > 4) %>% 
    lm(mpg ~ disp, data = .) %>% 
    summary()
## 
## Call:
## lm(formula = mpg ~ disp, data = .)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.4010 -1.5419 -0.5121  1.1408  4.9873 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 23.623520   1.463181  16.145 1.50e-12 ***
## disp        -0.023527   0.004682  -5.025 7.52e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.118 on 19 degrees of freedom
## Multiple R-squared:  0.5706,	Adjusted R-squared:  0.548 
## F-statistic: 25.25 on 1 and 19 DF,  p-value: 7.521e-05
```

- Using the new native pipes with the new native anonymous functions


```r
mtcars |>
    filter(cyl > 4) |>
    {\(d) lm(mpg ~ disp, data = d)}() |>
    summary()
## 
## Call:
## lm(formula = mpg ~ disp, data = d)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -2.4010 -1.5419 -0.5121  1.1408  4.9873 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 23.623520   1.463181  16.145 1.50e-12 ***
## disp        -0.023527   0.004682  -5.025 7.52e-05 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.118 on 19 degrees of freedom
## Multiple R-squared:  0.5706,	Adjusted R-squared:  0.548 
## F-statistic: 25.25 on 1 and 19 DF,  p-value: 7.521e-05
```

## Programming paradigms and data science

- OOP is most useful for developers
- Functional programming rules are really useful for data cleaning and analysis
    - "The analysis pipeline"
    - Reasoning about the state of our code
    - Ensuring reproducibility


<!--
## Lab:  Purrr
- palmerpenguins
- broom
- map() and list columns in dataframes
- microethics? 
-->

