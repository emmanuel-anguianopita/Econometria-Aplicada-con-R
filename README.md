# Econometría Aplicada con R
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/emmanuel-anguianopita/Econometria-Aplicada-con-R/HEAD?urlpath=rstudio)

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

### Sesión 1 — Introducción a R
| Bloque | Tema | Dataset |
|--------|------|---------|
| 1 | Introducción a R y buenas prácticas| [IMDB.csv](https://drive.google.com/file/d/1BCtE69SvyEYRsB_jxw-qBgWwqfWx_SbK/view?usp=drive_link) |
| 2 | Anatomía de los objetos en R  | - |
| 3 | Programación funcional |- |
| 4 | Flujo de trabajo para el análisis de datos | - |
| 5 | Librerías y paquetes en R | - | 

### Sesión II — Modelo de regresión lineal múltiple
| Bloque | Tema | Dataset |
|--------|------|---------|
| 1 |¿Qué es una regresión lineal? | - |
| 2 |  Estimacion e interpretación del MRLM| `Wooldridge - Wage1` |
| 3 | Diagnóstico y corrección de las violaciones a los supuestos de MCO | `Wooldridge - Wage1`| 

## Sesión III — Modelos no lineales y dinámicos 

| Bloque | Tema | Dataset | 
|--------|------|---------|
| 1      | Repaso de variables dicotómicas | `Wooldridge - Wage1` | 
| 2      | Formas funcionales | - | 
| 3      | Modelos dinámicos (ARDL) | [`Anguiano Pita (2026)`](https://docs.google.com/spreadsheets/d/1U-lIIFPHEggJ2ULVm-Rd3izdIc8e884h/edit?usp=drive_link&ouid=104575177132183230923&rtpof=true&sd=true) | 


### Sesión 4 — Series de Tiempo
| Bloque | Tema | Dataset |
|--------|------|---------|
| 1      | Autocorrelación en series de tiempo | [Datos](https://docs.google.com/spreadsheets/d/12g5O7KNWn95K_skAIzQgKh4JY5SzV0tu/edit?usp=drive_link&ouid=104575177132183230923&rtpof=true&sd=true) |
| 2      | Estacionalidad     | [Datos](https://drive.google.com/file/d/1RFgApomYnQ2DKFOgZGdn21dmROIhwGgl/view?usp=drive_link)| 
| 2.1    | Estacionalidad con IMAI-México | [Datos](https://drive.google.com/file/d/1RFgApomYnQ2DKFOgZGdn21dmROIhwGgl/view?usp=drive_link) |  
| 3      | Regresiones espurias           |[Datos](https://drive.google.com/file/d/1RFgApomYnQ2DKFOgZGdn21dmROIhwGgl/view?usp=drive_link)|
| 4      | Estacionariedad y raíces unitarias | 
| 4.1    | Pruebas de raíces unitarias ADF y KPSS | [Datos](https://drive.google.com/file/d/1RFgApomYnQ2DKFOgZGdn21dmROIhwGgl/view?usp=drive_link) |
| 5      | Causalidad de Granger | [Datos](https://drive.google.com/file/d/1RFgApomYnQ2DKFOgZGdn21dmROIhwGgl/view?usp=drive_link) | 

### Bloque IV — Sistemas de ecuaciones 
| Sesión | Tema | Dataset |
|--------|------|---------|


--- 
## Diapositivas

Las presentaciones están disponibles en línea — no requieren descarga:

| Sesión | Tema | Link |
|--------|------|------|
| 01 | Introducción a R y RStudio | [Ver presentación](https://emmanuel-anguianopita.github.io/Econometria-Aplicada-con-R/Diapositivas/01-Intro R-NA.html) |
| 02 | Modelo de regresión lineal múltiple | [Ver presentación](https://emmanuel-anguianopita.github.io/Econometria-Aplicada-con-R/Diapositivas/02-Regresion_Lineal.html) |
| 03 | Modelos no lineales y dinámicos | [Ver presentación](https://emmanuel-anguianopita.github.io/Econometria-Aplicada-con-R/Diapositivas/03-Modelos no lineales.html) |
| 04 | Introducción a series de tiempo | [Ver presentación](https://emmanuel-anguianopita.github.io/Econometria-Aplicada-con-R/Diapositivas/04-Introducción series de tiempo.html) |

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
