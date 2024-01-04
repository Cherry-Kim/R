#install.packages("VennDiagram")
library(VennDiagram)

file1 <- readLines("bismark.out")
file2 <- readLines("biscuit.out")
file3 <- readLines("bwameth.out")

set1 <- as.character(file1)
set2 <- as.character(file2)
set3 <- as.character(file3)

venn_list <- list(Set1 = set1, Set2 = set2, Set3 = set3)

# Creating the Venn diagram (using the code from the previous example)
library(VennDiagram)

venn.plot <- venn.diagram(
  x = venn_list,
  category.names = NULL, filename = NULL   #category.names = c("bismark", "biscuit", "bwameth")
)

# Modify the colors of the circle names
grid.text("bismark\n37085294", x = unit(0.3, "npc"), y = unit(0.9, "npc"), gp = gpar(col = "red"))
grid.text("biscuit\n16464454", x = unit(0.7, "npc"), y = unit(0.9, "npc"), gp = gpar(col = "blue"))
grid.text("bwameth\n#17808522", x = unit(0.5, "npc"), y = unit(0.1, "npc"), gp = gpar(col = "green"))

# Display the modified Venn diagram
grid.draw(venn.plot)
