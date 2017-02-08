setwd("C:/Users/claire.GMFMC/Desktop/R (2)/R/EFHwGit/EFHApp2/EFHApp")
a<-read.csv("maplayers.csv")

a$hex <- rep(NA,nrow(a))

a[a$lifestage == "eggs",][,"hex"] <- "#F781BF"
a[a$lifestage == "larvae",][,"hex"] <- "#E41A1C"
a[a$lifestage == "postLarvae",][,"hex"] <- "#4DAF4A"
a[a$lifestage == "earlyJuvenile",][,"hex"] <- "#984EA3"
a[a$lifestage == "lateJuvenile",][,"hex"] <- "#FF7F00"
a[a$lifestage == "adult",][,"hex"] <- "#ffff33"
a[a$lifestage == "spawningAdult",][,"hex"] <- "#a65628"
a[a$lifestage == "fertilizedEgg",][,"hex"] <- "#F781BF"
a[a$lifestage == "nonSpawningAdult",][,"hex"] <- "#ffff33"
a[a$lifestage == "subAdult",][,"hex"] <- "#FF7F00"
a[a$lifestage == "juvenile",][,"hex"] <- "#FF7F00"
a[a$lifestage == "latePostlarvaeJuvenile",][,"hex"] <- "#984EA3"
a[a$lifestage == "puerulusPostlarvae",][,"hex"] <- "#4DAF4A"

a[253,6] <- "#ffff33"

a$rgb <- rep(NA,nrow(a))
a[a$lifestage == "eggs",][,"rgb"] <- "rgb(247,129,191)"
a[a$lifestage == "larvae",][,"rgb"] <- "rgb(228,26,28)"
a[a$lifestage == "postLarvae",][,"rgb"] <- "rgb(77,175,74)"
a[a$lifestage == "earlyJuvenile",][,"rgb"] <- "rgb(152,78,163)"
a[a$lifestage == "lateJuvenile",][,"rgb"] <- "rgb(255,127,0)"
a[a$lifestage == "adult",][,"rgb"] <- "rgb(255,255,51)"
a[a$lifestage == "spawningAdult",][,"rgb"] <- "rgb(166,86,40)"
a[a$lifestage == "fertilizedEgg",][,"rgb"] <- "rgb(247,129,191)"
a[a$lifestage == "nonSpawningAdult",][,"rgb"] <- "rgb(255,255,51)"
a[a$lifestage == "subAdult",][,"rgb"] <- "rgb(255,127,0)"
a[a$lifestage == "juvenile",][,"rgb"] <- "rgb(255,127,0)"
a[a$lifestage == "latePostlarvaeJuvenile",][,"rgb"] <- "rgb(152,78,163)"
a[a$lifestage == "puerulusPostlarvae",][,"rgb"] <- "rgb(77,175,74)"

a[253,7] <- "rgb(255,255,51)"

write.csv(a,"maplayersColor2.csv")
