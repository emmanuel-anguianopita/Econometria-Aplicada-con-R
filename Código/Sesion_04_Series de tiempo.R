# =============================================================================
# Sesión 04: Introducción a las series de tiempo
# Bases de datos: "DATOS_SERIES_TIEMPO.xlsx"
#
# =============================================================================

## Prueba de autocorrelación de Durbin y Watson -------------------------------

library(readxl)
# install.packages("lmtest")
library(lmtest)

datos <- read_excel("../Datos/DATOS_SERIES_TIEMPO.xlsx",
                    sheet = "Granger")

m_1 <- lm(log(INPC) ~ log(TC), data = datos)
summary(m_1)

dwtest(m_1)

plot(residuals(m_1), lag(residuals(m_1)))
# Existe una asociación positiva entre los residuales de la regresión 

# ------------------------------------------------------------------------------

# Descomposición de una serie de tiempo con `decompose` ------------------------

install.packages("datasets")
library(datasets)

data("AirPassengers")
str(AirPassengers)  #Nota que ya es una serie de tiempo 

plot(AirPassengers, type = "l") # Hay evidencia visual de estacionalidad 

desc <- decompose(AirPassengers)
plot(desc)


AirPassengers_des <- AirPassengers - desc$seasonal

plot(AirPassengers, type = "l")
lines(AirPassengers_des, col = "red")

# ------------------------------------------------------------------------------

# Detección de estacionalidad con variables dicotómicas ------------------------

# Ejercicio venta de refrigeradores en EE.UU. 
# Serie: Trimestral desde 1978-1985 

datos <- read.csv("../Datos/estacionalidad.csv")

datos <- datos |>
  mutate(
    Q1 = ifelse(quarter(date) == 1, 1, 0),
    Q2 = ifelse(quarter(date) == 2, 1, 0),
    Q3 = ifelse(quarter(date) == 3, 1, 0),
    Q4 = ifelse(quarter(date) == 4, 1, 0)
  )

m_estacional <- lm(sales ~ Q2 + Q3 + Q4, data = datos)
summary(m_estacional)

# Evaluar estadísticos t-Student y Prueba F como evidencia de 
# comportamiento estacional 


# Hacemos el ajuste estacional de la serie

comp_estacional <- fitted(m_estacional) - coef(m_estacional)[1]
sales_des <- datos$sales - comp_estacional


plot(datos$sales, type = "l")
lines(sales_des, col = "red")


# ------------------------------------------------------------------------------

# Procedimiento X-13 ARIMA para el Índice Mensual de la Actividad Industrial

library(seasonal)


datos <- read_excel("../Datos/DATOS_SERIES_TIEMPO.xlsx", 
                    sheet = "IMAI")


imai_ts <- ts(datos$IMAI, 
              start = c(1993, 1), 
              frequency = 12)

plot(imai_ts, type = "l")


# Estimar el modelo de desestacionalización
ajuste_imai <- seas(imai_ts)
summary(ajuste_imai)

# Extraer la serie desestacionalizada
imai_desest <- final(ajuste_imai)


# Gráficamos las series juntas

plot(imai_ts, type = "l")
lines(imai_desest, col = "red")


#-------------------------------------------------------------------------------
## Ejemplo regresión espuria 
datos <- read_excel("../Datos/DATOS_SERIES_TIEMPO.xlsx",
                    sheet = "Granger")

m_1 <- lm(log(INPC) ~ log(TC), data = datos)
summary(m_1)

dwtest(m_1)
plot(fitted(m_1), residuals(m_1))
lines(lowess(fitted(m_1), residuals(m_1)),
      color = "red")


#-------------------------------------------------------------------------------

# Pruebas de raíces unitarias ADF y KPSS (PIB de México)

library(readxl)
library(tseries)
library(urca)
library(tidyverse)

datos <- read_excel("../Datos/DATOS_SERIES_TIEMPO.xlsx", 
                    sheet = "PIB")


pib_ts <- ts(log(datos$PIB), start = c(1993, 1),
             frequency = 4)

plot(pib_ts)

# La serie visualmente tiene una tendencia
## Pruebas ADF

pib_adf <- ur.df(pib_ts, type = "trend", selectlags = "AIC")
summary(pib_adf)


# En esta prueba el primer estadístico es tau2 (el importante)
# El siguiente estadístico evalúa si la tendencia es distinta de cero
# El último es para la constante

adf.test(pib_ts, k = 1)

# Los resultados son idénticos pero adf.test() nos entrega el p-value


# Pruebas en primeras diferencias 

pib_dif <- na.omit(diff(pib_ts, k = 1)*100)

pib_dif_adf <- ur.df(pib_dif, type = "drift",
                     selectlags = "AIC")

summary(pib_dif_adf)

#-------------------------------------------------------------------------------

# Prueba KPSS
pib_kpss <- ur.kpss(pib_ts, type = "tau")
summary(pib_kpss)


pib_diff_kpss <- ur.kpss(pib_dif, type = "mu")
summary(pib_diff_kpss)

# Grafiquemos para estar seguros

# Serie en niveles
par(mfrow = c(1,2))
plot(pib_ts, type = "l", main = "Serie en niveles")
plot(pib_dif, type = "l", main = "Serie en primeras diferencias")

#-------------------------------------------------------------------------------
## Pruebas de causalidad de Granger

datos <- read_excel("../Datos/DATOS_SERIES_TIEMPO.xlsx", 
                    sheet ="Granger")

# Definimos series de tiempo 

tc_ts <- ts(log(datos$TC), 
            start = c(1995, 1), 
            frequency = 12)
inpc_ts <- ts(log(datos$INPC), 
              start = c(1995,1),
              frequency = 12)


plot(tc_ts, type = "l")
plot(inpc_ts, type = "l")

## Efectos estacionales en inpc_ts
library(seasonal)

ajuste <- seas(inpc_ts)
summary(ajuste)

inpc_sa <- final(ajuste)

plot(inpc_ts, type = "l")
lines(inpc_sa, col = "red")

plot(inpc_sa, type = "l")

# Pruebas de raíces unitarias 

summary(ur.df(tc_ts, type = "trend", selectlags = "AIC"))
summary(ur.df(diff(tc_ts), type = "drift", selectlags = "AIC"))

summary(ur.df(inpc_sa, type = "trend", selectlags = "AIC"))
summary(ur.df(diff(inpc_sa), type = "drift", selectlags = "AIC"))


# Trabajamos con primeras diferencias 

dif_tc <- diff(tc_ts, k = 1)*100
dif_inpc <- diff(inpc_sa, k = 1) * 100

par(mfrow = c(1, 2))
plot(dif_tc, type = "l")
plot(dif_inpc, type = "l")

# Definimos el orden de rezagos para estimar las pruebas de causalidad

#install.packages("vars")

datos_dif <- cbind(dif_tc, dif_inpc)

vars::VARselect(datos_dif, lag.max = 12,
                 type = "const")


# Usando la función grangertest() el orden es Y ~ X
?grangertest


# ¿El tipo de cambio afecta la inflación? 
grangertest(dif_inpc ~ dif_tc, order = 7)

# ¿La inflación afecta el tipo de cambio? 
grangertest(dif_tc ~ dif_inpc, order = 7)


# Se mantiene si usamos los rezagos de SBIC?
grangertest(dif_inpc ~ dif_tc, order = 3)
grangertest(dif_tc ~ dif_inpc, order = 3)

# El resultado  