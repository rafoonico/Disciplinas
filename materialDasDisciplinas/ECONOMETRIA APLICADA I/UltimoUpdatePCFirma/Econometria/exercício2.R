Base_2023_corrigida <- read_excel("Desktop/Mestrado Economia/Econometria Aplicada 1/exercício 2/Base_2023_corrigida.xlsx")

# Carregando os pacotes necessários
library(sandwich)
library(lmtest)
library(plm)


### Pooled OLS sem as dummies de setor e trimestre com os erros padrão robustos de White #####

            
modelo1 <- plm(alavancagem ~ nivel_de_gov + log_neper_tamanhoEmpresa + 
                            imobilizado + retornoSobreAtivo + qDeTobin + ROA, 
                          data = Base_2023_corrigida, model = "pooling", vcov = "HC0")
summary(modelo1)

### Pooled OLS com erros padrão robustos agrupados no nível do setor com dummies de trimestre ###

modelo2 <- plm(alavancagem ~ nivel_de_gov + log_neper_tamanhoEmpresa + 
                            imobilizado + retornoSobreAtivo + qDeTobin + ROA + factor(trim), 
                          data = Base_2023_corrigida, model = "pooling", effect = "individual", index = c("setoreconomtica", "trim"),
                          vcov = "HC1")
summary(modelo2)

#### Pooled OLS com erros padrão robustos agrupados no nível do setor com trimestre e dummies de setor####


modelo_3 <- plm(alavancagem ~ nivel_de_gov + log_neper_tamanhoEmpresa + 
                                 imobilizado + retornoSobreAtivo + qDeTobin + ROA + factor(setoreconomtica), 
                               data = Base_2023_corrigida, model = "pooling", effect = "twoways", index = c("setoreconomtica", "trim"),
                       vcov = "HC1")
summary(modelo_3)