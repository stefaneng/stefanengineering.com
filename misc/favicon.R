library(hexSticker)
library(ggplot2)

cbPalette <- c(
  "#999999", "#E69F00", "#56B4E9", "#009E73",
  "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

x <- seq(-5, 5, length.out = 1000)
# Logistic function
y <- 1 / (1 + exp(-x))

y2 <- qnorm(x)

g <- ggplot(data.frame(x, y)) +
  geom_smooth(aes(x = x, y = y), size = 10, color = cbPalette[2]) +
  theme_void()

g

sticker(g, package = "", p_size=2, s_x=1, s_y=1, s_width=1.6, s_height=1.1,
        filename = "static/favicon.png",
        h_fill="#ffffff", h_color=cbPalette[3]
)

# library(survival)
# library(survminer)
#
# fit <- survfit(Surv(time, status) ~ x, data = aml)
# g <- ggsurvplot(fit, palette = cbPalette[-1],
#                 ggtheme = theme_void(),
#                 legend = "none",
#                 size = 5)
# g
# sticker(g$plot, package = "", p_size=2, s_x=1, s_y=1, s_width=1.6, s_height=1.1,
#                 filename = "static/favicon.png",
#                 h_fill="#ffffff", h_color=cbPalette[1]
#         )
