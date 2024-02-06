# 0) Exemplo utilizado na introdução --------------------------------------
# Primeira situacao: quebra não tão visível

n = 100
t = seq(1,n)

# Antes da quebra: vetor de coeficientes é [1 0]. 
# Depois da quebra, vetor de coeficientes é [1 1].
beta = matrix(c(rep(1,n), c(rep(0,n/2),rep(1,n/2))), ncol=2)

x = matrix(c(rep(1,n),t/n), ncol=2)
set.seed(123); e = rnorm(n)
y = e
for(i in 1:n) y[i] = x[i,]%*%beta[i,]+e[i]

par(mar=c(3,3,1,1),mgp=c(1.6,.6,0))
plot(t,y, col=c(rep("red",n/2),rep("blue",n/2)), pch=19, type="l")


# Segunda situacao: quebra visível

# Antes da quebra: vetor de coeficientes é [1 0]. 
# Depois da quebra, vetor de coeficientes é [1 10].

beta_2=matrix(c(rep(1,n), c(rep(0,n/2),rep(10,n/2))), ncol=2)

y = e
for(i in 1:n) y[i] = x[i,]%*%beta_2[i,]+e[i]

par(mar=c(3,3,1,1),mgp=c(1.6,.6,0))
plot(t,y, col=c(rep("red",n/2),rep("blue",n/2)), pch=19, type="l")

