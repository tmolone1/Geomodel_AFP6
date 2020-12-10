library(plotly)


#surface plot with modified vertical aspect ratio
z<-as.matrix(r73)
dim(z) <- c(233,215)

fig <- plot_ly(showscale = FALSE)
fig <- fig %>% add_surface(z = ~z)
fig <- fig %>% layout(
  scene = list(
    xaxis = list(nticks = 5),
    zaxis = list(nticks = 4),
    camera = list(eye = list(x = 0, y = -1, z = 0.5)),
    aspectratio = list(x = 1, y = 1, z = 0.2)))
fig

?plot_ly
