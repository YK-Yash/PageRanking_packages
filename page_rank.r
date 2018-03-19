library(miniCRAN)
library(igraph)
library(magrittr)



MRAN <- "http://mran.revolutionanalytics.com/snapshot/2014-11-01/"

pdb <- MRAN %>%
  contrib.url(type = "source") %>%
  available.packages(type="source", filters = NULL)



g <- pdb[, "Package"] %>%
  makeDepGraph(availPkgs = pdb, suggests=FALSE, enhances=TRUE, includeBasePkgs = FALSE)



pr <- g %>%
  page.rank(directed = FALSE) %>%
  use_series("vector") %>%
  sort(decreasing = TRUE) %>%
  as.matrix %>%
  set_colnames("page.rank")



head(pr, 25)



set.seed(42)
pr %>%
  head(25) %>%
  rownames %>%
  makeDepGraph(pdb) %>%
  plot(main="Top packages by page rank", cex=0.5)