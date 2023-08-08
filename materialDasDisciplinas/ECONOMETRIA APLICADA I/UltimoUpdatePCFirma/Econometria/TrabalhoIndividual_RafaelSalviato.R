setwd("~/Documentos/UFPR/Mestrado - PPGEcon/Disciplinas/ECONOMETRIA APLICADA I/UltimoUpdatePCFirma/Econometria")
library(mice)
df=readODS::read_ods("IPARDES_dataset.ods", sheet="dados")
#df=readODS::read_ods("IPARDES_dataset.ods", sheet="dadosRGInt")
df$DespMunSegPub=df$DespMunSegPub|>as.numeric()
df$PropEmpRAISRemu_ate_4SM <- df$PropEmpRAISRemuFaixa1+
                              df$PropEmpRAISRemuFaixa2+
                              df$PropEmpRAISRemuFaixa3+
                              df$PropEmpRAISRemuFaixa4+
                              df$PropEmpRAISRemuFaixa5+
                              df$PropEmpRAISRemuFaixa6

df$PropEmpRAISRemu_acima_de_4SM <- df$PropEmpRAISRemuFaixa7+
                              df$PropEmpRAISRemuFaixa8+
                              df$PropEmpRAISRemuFaixa9+
                              df$PropEmpRAISRemuFaixa10+
                              df$PropEmpRAISRemuFaixa11+
                              df$PropEmpRAISRemuFaixa12
df <- df[,c("Localidade","Ano","CrimeTotal","DensDemog","DespMunSegPub")]#|>na.omit()
df[df==0]=NA
df <- complete(mice(df,m=5,method="rf"));View(df)
formula_dos_modelos=CrimeTotal~DensDemog+DespMunSegPub

## Análise exploratória

summary(df)

## Pooled OLS

### Básico
# Pooled OLS
pooled1=lm(formula_dos_modelos, data=df)
pooled1|>summary() # depois, sem ROA e sem receita
X11()
par(mfrow=c(2,2))
pooled1|>plot() # os resiudos fogem da normalidade, ponto de influencia, mas o R2 tá bom.
# Verificando multicolinearidade
par(mfrow=c(1,1))
x11();pooled1$residuals|>density()|>plot()
car::vif(pooled1)

## Variando estruturas de covariâncias
library(plm)
pdata <- pdata.frame(df, index = c("Localidade", "Ano"))
# # Ajustar o modelo para dados em painel com diferentes estruturas de covariância
# modelo_uniforme <- plm(formula_dos_modelos,data=pdata, model = "pooling", vcov = "iid")
# modelo_AR1 <- plm(formula_dos_modelos,data=pdata, model = "pooling", vcov = "AR1")
# modelo_ARMA11 <- plm(formula_dos_modelos,data=pdata, model = "pooling", vcov = "ARMA11")
# modelo_antedep1 <- plm(formula_dos_modelos,data=pdata, model = "pooling", vcov = "arellano")
# modelo_espacial_markov <- plm(formula_dos_modelos,data=pdata, model = "pooling", vcov = "fixed", effect = "twoways", vcov = "spatial")
# modelo_toeplitz <- plm(formula_dos_modelos,data=pdata, model = "pooling", vcov = "fixed", effect = "twoways", vcov = "toeplitz")
# modelo_ARH <- plm(formula_dos_modelos,data=pdata, model = "pooling", vcov = "fixed", effect = "twoways", vcov = "ARH1")
# 
# ### Uniforme
# summary(modelo_uniforme)
# 
# ### AR(1)
# summary(modelo_AR1)
# 
# ### ARMA(1,1)
# summary(modelo_ARMA11)
# 
# ### Antedependência de ordem 1
# summary(modelo_antedep1)
# 
# ### Markov ou espacial
# summary(modelo_espacial_markov)
# 
# ### Toeplitz
# summary(modelo_toeplitz)
# 
# ### ARH(1,1)
# summary(modelo_ARH)

## Efeitos aleatorios
RE1=plm(formula_dos_modelos, data=pdata, model="random", effect = "individual",vcov = "HC1")
summary(RE1)

## Efeitos fixos
FE1=plm(formula_dos_modelos,data=pdata, model="within", effect = "individual",vcov = "HC0")
summary(FE1)

## Efeitos fixos - Modelo Poisson
library(pglm)
FEP1 <- pglm(formula_dos_modelos, family = poisson(),data=pdata, model = "within")
summary(FEP1)
#Pseudo R2:
1-logLik(FEP1)[1]/{
  pdata$nulo=1
  logLik(pglm(CrimeTotal~nulo, 
              family = poisson(),
              data=pdata,
              model = "within"))[1]
}

## Efeitos aleatórios - Modelo Poisson
library(pglm)
REP1 <- pglm(formula_dos_modelos, family = poisson(),data=pdata, model = "random")
summary(REP1)
#Pseudo R2:
1-logLik(REP1)[1]/{
  pdata$nulo=1
  logLik(pglm(CrimeTotal~nulo, 
              family = poisson(),
              data=pdata,
              model = "random"))[1]
}



# ## Efeitos fixos - Modelo Gamma
# library(pglm)
# FEG1 <- pglm(formula_dos_modelos, family = gamma(),data=pdata, model = "within")
# summary(FEG1)
# #Pseudo R2:
#   pdata$nulo=1
#   logLik(pglm(CrimeTotal~nulo, 
#               family = gamma(),
#               data=pdata,
#               model = "within"))[1]
# }
# 
# ## Efeitos aleatórios - Modelo Poisson
# library(pglm)
# REG1 <- pglm(formula_dos_modelos, family = gamma(),data=pdata, model = "random")
# summary(REG1)
# #Pseudo R2:
# 1-logLik(REG1)[1]/{
#   pdata$nulo=1
#   logLik(pglm(CrimeTotal~nulo, 
#               family = gamma(),
#               data=pdata,
#               model = "random"))[1]
# }
# 
# RE1 vs Pooled

phtest(RE1,pooled1)
