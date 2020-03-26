## ## Was 5396x1064
## orwidth <- 5396
## orheight <- 1064
## width <- 3000
## heightscale <- 0.8
## (height <- width * (heightscale*orheight)/orwidth)
## system(paste0("convert climate-KIC-header-2-fullres.png -resize ",width,"x",height,"\\! -quality 80% -flatten climate-KIC-header.jpg"))
## ## Was 5321x1121
## orwidth <- 5321
## orheight <- 1121
## (height <- width * (heightscale*orheight)/orwidth)
## system(paste0("convert climate-KIC-footer-2-fullres.png -resize ",width,"x",height,"\\! -quality 80% -flatten climate-KIC-footer.jpg"))


## Was 5396x1064
orwidth <- 5396
orheight <- 1064
width <- 3000
heightscale <- 0.8
(height <- width * (heightscale*orheight)/orwidth)
system(paste0("convert climate-KIC-header-3.jpg -resize ",width,"x",height,"\\! -quality 75% -flatten climate-KIC-header.jpg"))
## Was 5321x1121
orwidth <- 5321
orheight <- 1121
(height <- width * (heightscale*orheight)/orwidth)
system(paste0("convert climate-KIC-footer-3.jpg -resize ",width,"x",height,"\\! -quality 75% -flatten climate-KIC-footer.jpg"))

