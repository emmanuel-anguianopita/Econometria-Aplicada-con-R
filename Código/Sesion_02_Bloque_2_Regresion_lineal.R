# =============================================================================
# Sesión 02. Modelo de regresión lineal múltiple
# =============================================================================

library(wooldridge)
library(Hmisc)

# -----------------------------------------------------------------------------
# 1. CARGAR DATOS
# -----------------------------------------------------------------------------

data(wage1, package = "wooldridge")

# Inspeccionar los datos
head(wage1)
str(wage1)
summary(wage1[, c("wage", "educ", "exper", "tenure")])

# -----------------------------------------------------------------------------
# 2. MATRIZ DE DISPERSIÓN
# -----------------------------------------------------------------------------

pairs(
  wage1[, c("wage", "educ", "exper", "tenure")],
  labels = c("Salario", "Educación", "Experiencia", "Antigüedad"),
  pch    = 19,
  col    = adjustcolor("#2D3A8C", alpha.f = 0.3),
  main   = "Matriz de dispersión: wage1"
)

# -----------------------------------------------------------------------------
# 3. Estadística descriptiva 
# -----------------------------------------------------------------------------
library(modelsummary)
datos <- wage1[, c("wage", "educ", "exper", "tenure")]

datasummary(
  All(datos) ~ Mean + SD + Min + Max + N, 
  data = datos, 
  output = "gt"
)



# -----------------------------------------------------------------------------
# 4. CORRELACIONES DE PEARSON CON P-VALUES
# -----------------------------------------------------------------------------
library(correlation)

cor_mat <- correlation(
  datos, 
  method = "pearson"
)

datasummary_correlation(cor_mat,
                        stars = TRUE,
                        fmt = 4,
                        output = "gt")

# -----------------------------------------------------------------------------
# 5. REGRESIÓN LINEAL MÚLTIPLE
# -----------------------------------------------------------------------------

modelo <- lm(wage ~ educ + exper + tenure, data = wage1)

summary(modelo)

coef(modelo)       # coeficientes
confint(modelo)    # intervalos de confianza al 95%
fitted(modelo)     # valores ajustados
residuals(modelo)  # residuales


# -----------------------------------------------------------------------------
# 7. Comparación entre modelos (anidados)
# -----------------------------------------------------------------------------
modelo <- lm(wage ~ educ + exper + tenure, data = wage1)
modelo2 <- lm(log(wage)~ educ + exper + tenure, data = wage1)

# Extraer R2 y R2 ajustado
tabla_r2 <- data.frame(
  Modelo     = c("Niveles", "Logaritmo"),
  R2         = c(summary(modelo)$r.squared, 
                 summary(modelo2)$r.squared),
  R2_ajustado = c(summary(modelo)$adj.r.squared, 
                  summary(modelo2)$adj.r.squared)
)

tabla_r2


AIC(modelo, modelo2) #No es comparable con BIC
BIC(modelo, modelo2)


# Podemos hacer una tabla que compare los modelos 

options(scipen = 999)


modelsummary(
  list(modelo, modelo2),
  estimate  = "{estimate}{stars}",
  statistic = "({p.value})",
  fmt = fmt_decimal(4),
  output = "gt"
)

resultado <-  modelsummary(
              list(modelo, modelo2), 
              estimate = "{estimate}{stars}", 
              statistic = "({p.value})", 
              fmt = fmt_decimal(4),
              output = "data.frame"
)
  
#install.packages("pandoc")

resultado <-  modelsummary(
  list(modelo, modelo2), 
  estimate = "{estimate}{stars}", 
  statistic = "({p.value})", 
  fmt = fmt_decimal(4),
  output = "tabla_regresiones.docx"
)  
  


# -----------------------------------------------------------------------------
# 7. Pruebas de normalidad 
# -----------------------------------------------------------------------------

# Jarque-Bera test 
library(tseries)
jarque.bera.test(modelo$residuals)
jarque.bera.test(modelo2$residuals)

# Shapiro-Wilk
shapiro.test(modelo$residuals)
shapiro.test(modelo2$residuals)

# -----------------------------------------------------------------------------
# 8. Pruebas de Heterocedasticidad (Breusch-Pagan) 
# -----------------------------------------------------------------------------
library(lmtest)

# Diagnóstico visual 

plot(
  x = fitted(modelo),
  y = residuals(modelo),
  xlab = "Valores ajustados",
  ylab = "Residuales"
     )

plot(
  x = fitted(modelo2),
  y = residuals(modelo2),
  xlab = "Valores ajustados",
  ylab = "Residuales"
)



bptest(modelo)
bptest(modelo2)




# -----------------------------------------------------------------------------
# 8. Pruebas de autocorrelación serial 
# -----------------------------------------------------------------------------
library(lmtest)

bgtest(modelo2, order = 1)
bgtest(modelo2, order = 2)

bgtest(modelo2, order = 12)

## En datos transversales no podemos saber cuantos lags pero comunmente
# se usan uno o dos. 

