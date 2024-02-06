# Seus pontos de dados
x <- c(0.5, 1, 25)
y <- c(0.0271,0.0469, 3.2918)*100

APR <- function(x,y){
  EAR <- ((1+y)^(1/x))-1
  numerador <- 1+EAR
  numerador2 <- numerador^x
  return((numerador2-1)/x)
}

w <- APR(x,y)*100


# Ajustar um modelo exponencial
modelo <- nls(y ~ a * exp(b * x), start = list(a = 4*100, b = -0.1))
modelo2 <- lm(w ~ poly(x, 5, raw = TRUE))#nls(w ~ a * exp(b * x), start = list(a = 14*100, b = -0.1))

# Gerar valores ao longo da curva ajustada
x_valores <- seq(min(x), max(x), length.out = 100)
y_valores <- predict(modelo, newdata = data.frame(x = x_valores))
w_valores <- predict(modelo2, newdata = data.frame(x = x_valores))

# Criar o gráfico
X11()
plot(x, y, pch = 19, col = "blue", xlim = c(0, 30), 
     main = "Taxa de retorno anualizada e APR em função do tempo \n (exemplo do livro)",
     ylim = c(-200, 14*100),xlab = "Tempo em anos (T)",ylab="Retorno efetivo rf(T) em vermelho e APR(T) em roxo")
lines(x_valores, y_valores, col = "red", lwd = 2)
lines(x_valores,w_valores, col="purple",lwd=2)



























