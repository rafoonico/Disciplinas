library(ggplot2)
library(geobr)

# Carregar os dados geográficos dos municípios do Paraná
pr_municipios <- read_municipality(year = 2020, states = "PR")

# Seus dados com nome do município e variável desejada
seus_dados <- data.frame(municipio_nome = c("Curitiba", "Londrina", "Maringá"),
                         variavel = c(10, 15, 20))

# Merge dos dados geográficos e seus dados usando o nome do município
dados_completos <- merge(pr_municipios, seus_dados, by.x = "name_muni", by.y = "municipio_nome")

# Criar o mapa coroplético
ggplot() +
  geom_polygon(data = dados_completos, aes(x = long, y = lat, group = group, fill = variavel), color = "black") +
  coord_map() +
  theme_void()
