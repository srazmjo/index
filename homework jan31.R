rm(list = ls(all = TRUE))

setwd("C:/Users/alyss/Desktop/my r script")



# x <- 1:100
x <- 1:1000
# y <- 1:100
y <- 1:1000

# east <- sample(x, size = 10, replace = TRUE)
east <- sample(x, size = 50, replace = TRUE)
# north <- sample(y, size = 10, replace = TRUE)
north <- sample(y, size = 50, replace = TRUE)

dwellings <- cbind.data.frame(id = 1:50, east, north)

symbols(east, north, squares = rep(8, 50), inches = FALSE, xlim = c(0,1000), ylim = c(1,1000))

symbols(sample(x, 50, replace = TRUE),
        sample(y, 50, replace = TRUE),
        circles = rep(8, 50),
        inches = FALSE,
        fg = "green1",
        bg = "purple",
        add = TRUE)

symbols(sample(x, 15, replace = TRUE),
        sample(y, 15, replace = TRUE),
        circles = rep(12, 15),
        inches = FALSE,
        fg = "green1",
        bg = "beige",
        add = TRUE)

locs <- sample(1:50, 7, replace = FALSE)

xspline(x = dwellings[locs, 2],
        y = dwellings[locs, 3],
        shape = -1,
        lty = 2)

# text(x = dwellings$east,
# y = dwellings$north + 60,
# labels = dwellings$id)

text(x = dwellings[locs, ]$east,
     y = dwellings[locs, ]$north + 35,
     labels = dwellings[locs, ]$id)

title(main = "Mailman's Journey")
