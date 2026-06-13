# =============================================================================
# Sesión 5 — Modelos no lineales y dinámicos
# Bloques: Variables dicotómicas, Formas funcionales, RESET
# Dataset: wage1 (wooldridge)
# -----------------------------------------------------------------------------
# Descripción del dataset:
# - 526 trabajadores, Estados Unidos, 1976
# - wage:    salario por hora en dólares (1976)
# - educ:    años de escolaridad
# - exper:   años de experiencia laboral
# - tenure:  años con el empleador actual
# - female:  1 = mujer, 0 = hombre
# - nonwhite: 1 = no blanco, 0 = blanco
# - married: 1 = casado, 0 = soltero
# =============================================================================

library(tidyverse)
library(wooldridge)
library(lmtest)

data("wage1")
glimpse(wage1)

# =============================================================================
# BLOQUE 1 — VARIABLES DICOTÓMICAS
# =============================================================================

# -----------------------------------------------------------------------------
# 1.1 Modelo base con dummy de sexo
# -----------------------------------------------------------------------------

m_dummy <- lm(wage ~ female + educ + exper + tenure,
              data = wage1)

summary(m_dummy)

# ¿Cuánto gana menos una mujer en promedio, controlando por todo lo demás?
coef(m_dummy)["female"]


# -----------------------------------------------------------------------------
# 1.2 La trampa de la variable dicotómica
# -----------------------------------------------------------------------------

wage1 <- wage1 |>
  mutate(male = 1 - female)

# Incluimos ambas — ¿qué hace R?
m_trampa <- lm(wage ~ female + male + educ,
               data = wage1)

summary(m_trampa)$coefficients
# R elimina male automáticamente — multicolinealidad perfecta


# -----------------------------------------------------------------------------
# 1.3 Múltiples categorías con factor()
# -----------------------------------------------------------------------------

wage1 <- wage1 |>
  mutate(
    educ_cat = case_when(
      educ < 12  ~ "Sin_preparatoria",
      educ == 12 ~ "Preparatoria",
      educ > 12  ~ "Universidad"
    ),
    educ_cat = factor(educ_cat,
                      levels = c("Sin_preparatoria",
                                 "Preparatoria",
                                 "Universidad"))
  )

m_cat <- lm(wage ~ educ_cat + exper + tenure,
            data = wage1)

summary(m_cat)$coefficients
# Categoría de referencia: Sin_preparatoria


# -----------------------------------------------------------------------------
# 1.4 Interacción dummy × continua
# -----------------------------------------------------------------------------

m_interaccion <- lm(wage ~ female * educ + exper + tenure,
                    data = wage1)

summary(m_interaccion)$coefficients

# Retorno a la educación para hombres
coef(m_interaccion)["educ"]

# Retorno a la educación para mujeres
coef(m_interaccion)["educ"] + coef(m_interaccion)["female:educ"]

# Visualización
wage1 |>
  mutate(sexo = ifelse(female == 1, "Mujer", "Hombre")) |>
  ggplot(aes(x = educ, y = wage, color = sexo)) +
  geom_point(alpha = 0.25) +
  geom_smooth(method = "lm", se = TRUE, linewidth = 1.2) +
  scale_color_manual(values = c("Hombre" = "#1A5276",
                                "Mujer"  = "#E74C3C")) +
  labs(x = "Años de educación", y = "Salario (USD/hora)",
       color = NULL) +
  theme_minimal() +
  theme(legend.position = "top")


# =============================================================================
# BLOQUE 2 — FORMAS FUNCIONALES
# =============================================================================

# -----------------------------------------------------------------------------
# 2.1 Estimación log-log — primer intento
# -----------------------------------------------------------------------------

# Intentamos estimar directamente
m_loglog <- lm(log(wage) ~ log(educ), data = wage1)

summary(m_loglog)

# Diagnóstico: ¿hay ceros en educ?
wage1 |> count(educ == 0)

# log(0) = -Inf — R no puede estimar con valores infinitos


# -----------------------------------------------------------------------------
# 2.2 Dos soluciones posibles
# -----------------------------------------------------------------------------

# Opción 1 — log(educ + 1): evita el problema sin perder observaciones,
#            pero altera la escala de TODA la variable, no solo en cero.
#            El coeficiente ya no es una elasticidad limpia. NO RECOMENDADA.
#
# Opción 2 — filter(educ > 0): elimina 1-2 observaciones con educ = 0.
#            Preserva la interpretación del modelo. RECOMENDADA.


# Opción 1 — filtrar las observaciones con educ = 0
wage1_sin_ceros <- wage1 |>
  filter(educ > 0)

m_loglog_op1 <- lm(log(wage) ~ log(educ), data = wage1_sin_ceros)

# Opción 2 — transformación log(educ + 1) sin perder observaciones
m_loglog_op2 <- lm(log(wage) ~ log(educ + 1), data = wage1)


# ¿Los coeficientes son iguales? 
summary(m_loglog_op1)$coefficients
summary(m_loglog_op2)$coefficients

# NO lo son. 

# -----------------------------------------------------------------------------
# 2.3 Estimación de todas las formas funcionales
# -----------------------------------------------------------------------------

# Lineal: un año más de educ → salario sube β1 dólares/hora
m_lineal <- lm(wage ~ educ, data = wage1)

# Log-log: un 1% más de educ → salario sube β1% (elasticidad)
m_loglog <- lm(log(wage) ~ log(educ), data = wage1_sin_ceros)

# Log-lin: un año más de educ → salario sube β1 × 100% (semielasticidad)
m_loglin <- lm(log(wage) ~ educ, data = wage1)

# Lin-log: un 1% más de educ → salario sube β1/100 dólares/hora
m_linlog <- lm(wage ~ log(educ), data = wage1_sin_ceros)

# Comparar coeficientes de educación en cada modelo
cat("Lineal  — β_educ:      ", round(coef(m_lineal)["educ"], 4), "\n")
cat("Log-log — β_log(educ): ", round(coef(m_loglog)["log(educ)"], 4), "\n")
cat("Log-lin — β_educ:      ", round(coef(m_loglin)["educ"], 4), "\n")
cat("Lin-log — β_log(educ): ", round(coef(m_linlog)["log(educ)"], 4), "\n")


# -----------------------------------------------------------------------------
# 2.4 Modelo cuadrático — efecto no lineal de experiencia
# -----------------------------------------------------------------------------

m_cuad <- lm(wage ~ exper + I(exper^2), data = wage1)

summary(m_cuad)$coefficients

# Punto de máximo: -β1 / (2*β2)
b1 <- coef(m_cuad)["exper"]
b2 <- coef(m_cuad)["I(exper^2)"]

maximo <- -b1 / (2 * b2)
cat("El salario alcanza su máximo a los", round(maximo, 1),
    "años de experiencia\n")

# Visualización del efecto cuadrático
ggplot(wage1, aes(x = exper, y = wage)) +
  geom_point(alpha = 0.2, color = "#AED6F1") +
  geom_smooth(method = "lm", formula = y ~ x + I(x^2),
              color = "#1A5276", se = TRUE, linewidth = 1.2) +
  geom_vline(xintercept = maximo, linetype = "dashed",
             color = "#E74C3C") +
  annotate("text", x = maximo + 2,
           y = max(wage1$wage) * 0.9,
           label = paste0("Máximo: ", round(maximo, 1), " años"),
           color = "#E74C3C", size = 3.5, hjust = 0) +
  labs(x = "Años de experiencia", y = "Salario (USD/hora)") +
  theme_minimal()


# =============================================================================
# BLOQUE 3 — PRUEBA RESET DE RAMSEY
# =============================================================================

# -----------------------------------------------------------------------------
# 3.1 Modelo base — especificación lineal
# -----------------------------------------------------------------------------

m_base <- lm(wage ~ educ + exper + tenure, data = wage1)

resettest(m_base, power = 2:3, type = "fitted")
# Si p < 0.05 → forma funcional incorrecta → considerar transformaciones


# -----------------------------------------------------------------------------
# 3.2 ¿Mejora con transformación logarítmica?
# -----------------------------------------------------------------------------

m_loglin_full <- lm(log(wage) ~ educ + exper + tenure, data = wage1)

resettest(m_loglin_full, power = 2:3, type = "fitted")


# -----------------------------------------------------------------------------
# 3.3 Modelo más completo — log-lin con término cuadrático
# -----------------------------------------------------------------------------

m_3 <- lm(log(wage) ~ educ + exper + I(exper^2) + tenure,
                 data = wage1)

resettest(m_3, power = 2:3, type = "fitted")

summary(m_3)


# ¿Cuál de los tres modelos pasa la prueba RESET?
# Ningunao pasa la prueab 

# La eduación tiene un comportamiento no lineal con el salario
plot(wage1$educ, wage1$wage)


m6 <- lm(
  lwage ~ educ + I(educ^2) +
    exper + I(exper^2) ,
  data = wage1
)

resettest(m6, power = 2:3, type = "fitted")



# =============================================================================
# Sesión 3 — Modelos dinámicos
# Estimación del modelo ARDL para México
# Dataset: TMEC.xlsx
# -----------------------------------------------------------------------------
# Variable dependiente: CO2PC_MX — emisiones de CO₂ per cápita (log)
# Regresores:
#   PIB_MX   — PIB per cápita (log)
#   PIB2_MX  — PIB per cápita al cuadrado (log²) — hipótesis CAK
#   ENE_MX   — consumo de energía per cápita (log)
#   FDI_MX   — IED per cápita (log)
#   TRADE_MX — apertura comercial (log)
# Período: 1970-2023
# =============================================================================

library(tidyverse)
library(readxl)
library(ARDL)
library(dynlm)

# -----------------------------------------------------------------------------
# 1. CARGAR Y PREPARAR DATOS
# -----------------------------------------------------------------------------

datos <- read_xlsx("../Datos/TMEC.xlsx")

# Crear término cuadrático del PIB
datos <- datos |>
  mutate(PIB2_MX = PIB_MX^2)

# Convertir a serie de tiempo
datos_ts <- ts(datos, start = 1970)

glimpse(datos)


# -----------------------------------------------------------------------------
# 2. SELECCIÓN DE LA ESTRUCTURA DE REZAGOS ÓPTIMA
# -----------------------------------------------------------------------------

# auto_ardl prueba todas las combinaciones posibles de rezagos
# hasta el máximo especificado y selecciona la mejor según AIC

modelo_optimo <- auto_ardl(
  CO2PC_MX ~ PIB_MX +  ENE_MX + FDI_MX + TRADE_MX,
  data    = datos_ts,
  max_order = 4 , 
  selection = "AIC"          # máximo 4 rezagos por variable
)

# Ver el modelo seleccionado
modelo_optimo$best_model

# Ver el orden óptimo seleccionado
orden <- modelo_optimo$best_order


# -----------------------------------------------------------------------------
# 3. ESTIMACIÓN DEL MODELO ARDL
# -----------------------------------------------------------------------------

# Estimar el modelo con la estructura óptima
m_ardl <- ardl(
  CO2PC_MX ~ PIB_MX  + ENE_MX + FDI_MX + TRADE_MX,
  data  = datos_ts,
  order = orden
)

summary(m_ardl)


# -----------------------------------------------------------------------------
# 4. EFECTOS DE LARGO PLAZO
# -----------------------------------------------------------------------------

# multipliers() calcula los multiplicadores de largo plazo
# y sus errores estándar mediante el método delta

mlp <- multipliers(m_ardl, type = "lr")

print(mlp)

# Interpretación:
# Cada coeficiente es el efecto total acumulado de un cambio
# permanente de 1% en el regresor sobre CO2 en el largo plazo



# -----------------------------------------------------------------------------
# 5. DIAGNÓSTICOS DEL MODELO
# -----------------------------------------------------------------------------

# Autocorrelación en los residuales
library(lmtest)

bgtest(m_ardl, order = 2)
# H0: no hay autocorrelación — queremos no rechazar

# Heterocedasticidad
bptest(m_ardl)
# H0: homocedasticidad — queremos no rechazar

# Normalidad de residuales
library(tseries)

jarque.bera.test(residuals(m_ardl))
# H0: residuales normales
