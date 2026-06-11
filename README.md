# Econometría Aplicada con R
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/emmanuel-anguianopita/Econometria-Aplicada-con-R/HEAD)

## Descripción

Este repositorio contiene el material del curso *Econometría Aplicada con R*, un taller práctico de 11 sesiones (33 horas) diseñado para estudiantes de doctorado. El curso cubre desde la introducción al lenguaje R hasta modelos avanzados de variable dependiente discreta y limitada, con énfasis en la estimación, el diagnóstico y la interpretación de resultados usando datos reales de fuentes mexicanas e internacionales.

Cada sesión incluye una exposición teórica breve (20–30 min), programación en vivo en R (2 horas) y discusión de resultados (30 min).

---

## Estructura del repositorio

```
econometria-aplicada-r/
├── Datos/                  # Datasets utilizados en cada sesión
├── Diapositivas/
│   ├── sesion_01/          # Introducción a R y RStudio
│   ├── sesion_02/          # OLS, supuestos y capacidad predictiva
│   ├── sesion_03/          # Selección de modelos y variables dicotómicas
│   ├── sesion_04/          # Problemas clásicos del modelo MCO
│   ├── sesion_05/          # Modelos no lineales y dinámicos
│   ├── sesion_06/          # Introducción a series de tiempo
│   ├── sesion_07/          # Causalidad e inferencia en series de tiempo
│   ├── sesion_08/          # Datos en panel
│   ├── sesion_09/          # Sistemas de ecuaciones
│   ├── sesion_10/          # Variable dependiente discreta
│   └── sesion_11/          # Variable dependiente limitada y cierre
├── Código/         # Scripts visto en clase y funciones
└── README.md
```

---

## Programa de sesiones

### Bloque 0 — Introducción a R
| Sesión | Tema | Dataset |
|--------|------|---------|
| 1 | Introducción a R y RStudio: objetos, dplyr, ggplot2, importación y buenas prácticas | INEGI (datos abiertos) |

### Bloque I — Regresión Lineal Clásica
| Sesión | Tema | Dataset |
|--------|------|---------|
| 2 | OLS, supuestos de Gauss-Markov, medidas de bondad de ajuste y presentación de resultados | ENOE — Salarios y escolaridad |
| 3 | Prueba F, variables dummy, interacciones y análisis de brechas salariales | ENOE — Brecha salarial por género |

### Bloque II — Incumplimiento de Supuestos y Extensiones
| Sesión | Tema | Dataset |
|--------|------|---------|
| 4 | Heterocedasticidad, autocorrelación y errores estándar robustos | INEGI — PIB estatal |
| 5 | Modelos no lineales, transformaciones logarítmicas y modelos ADL | Banxico — Consumo e ingreso |

### Bloque III — Series de Tiempo
| Sesión | Tema | Dataset |
|--------|------|---------|
| 6 | Estacionariedad, ACF/PACF, pruebas ADF y Phillips-Perron | Banxico — Tipo de cambio MXN/USD |
| 7 | Cointegración, causalidad de Granger y procedimiento de Toda-Yamamoto | Banxico — Inflación y tipo de cambio |

### Bloque IV — Datos en Panel y Sistemas de Ecuaciones
| Sesión | Tema | Dataset |
|--------|------|---------|
| 8 | Efectos fijos, efectos aleatorios, prueba de Hausman y errores agrupados | Dataset Grunfeld (`plm`) |
| 9 | Sistemas SUR, ecuaciones simultáneas e identificación con 2SLS | ENOE / Dataset Klein |

### Bloque V — Variable Dependiente Discreta y Limitada
| Sesión | Tema | Dataset |
|--------|------|---------|
| 10 | MPL, Logit, Probit y efectos marginales | ENOE / Dataset `mroz` |
| 11 | Modelo Tobit, datos censurados y truncados, cierre del curso | ENIGH — Gasto en bienes no esenciales |

---

## Requisitos previos

- Curso de estadística o probabilidad a nivel licenciatura
- Conocimientos básicos de econometría (nivel Wooldridge introductorio)
- No se requiere experiencia previa en R — el Bloque 0 cubre la introducción

---

## Software

- [R](https://cran.r-project.org/) (versión más reciente)
- [RStudio](https://posit.co/download/rstudio-desktop/) (versión más reciente)

### Paquetes principales

```r
install.packages(c(
  "tidyverse",    # Manipulación y visualización
  "lmtest",       # Pruebas de hipótesis
  "sandwich",     # Errores robustos
  "car",          # Diagnósticos de regresión
  "plm",          # Datos en panel
  "systemfit",    # Sistemas de ecuaciones
  "vars",         # Modelos VAR
  "urca",         # Raíces unitarias
  "tseries",      # Series de tiempo
  "AER",          # Variables instrumentales
  "ivreg",        # MCO en dos etapas
  "margins",      # Efectos marginales
  "modelsummary", # Presentación de resultados
  "censReg",      # Modelos Tobit
  "wooldridge",   # Datasets de Wooldridge
  "broom",        # Tidying de modelos
  "haven",        # Importar Stata/SPSS
  "readxl"        # Importar Excel
))
```

---

## Evaluación

| Componente | Ponderación | Entrega |
|------------|-------------|---------|
| Participación activa en sesiones prácticas | 20% | Continua |
| Ejercicios de programación por bloque (5 tareas) | 40% | Semanal |
| Proyecto final: corrección de trabajos de investigación propios | 40% | Sesión 11 |

---

## Fuentes de datos

- [INEGI — Datos Abiertos](https://www.inegi.org.mx/datos/)
- [Banxico SIE](https://www.banxico.org.mx/SieInternet/)
- [CEPAL CEPALSTAT](https://estadisticas.cepal.org/)
- [OCDE Stats](https://data-explorer.oecd.org/)
- [Banco Mundial — WDI](https://databank.worldbank.org/source/world-development-indicators)
- [FRED — Federal Reserve](https://fred.stlouisfed.org/)

---

## Bibliografía

- Angrist, J. y Pischke, J-S. (2014). *Mastering Metrics*. Princeton University Press.
- Angrist, J. y Pischke, J-S. (2009). *Mostly Harmless Econometrics*. Princeton University Press.
- Cunningham, S. (2021). *Causal Inference: The Mixtape*. Yale University Press.
- Greene, W. H. (2018). *Econometric Analysis* (8ª ed.). Pearson.
- Heiss, F. (2020). *Using R for Introductory Econometrics* (2ª ed.).
- Kleiber, C. y Zeileis, A. (2008). *Applied Econometrics with R*. Springer.
- Stock, J. y Watson, M. W. (2018). *Introduction to Econometrics* (4ª ed.). Pearson.
- Wooldridge, J. M. (2019). *Introductory Econometrics: A Modern Approach* (7ª ed.). Cengage.

---

## Licencia

Material de uso académico. Para reutilización o adaptación, contactar al instructor.
