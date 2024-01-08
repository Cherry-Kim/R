chromosomes <- c( paste0("chr", 1:22), "chrX", "chrY", "chrMT")

for (chrom in chromosomes) {
    print(chrom)

    bismark <- read.table(paste0("bismark_", chrom, ".bed"), header = TRUE)
    bwameth <- read.table(paste0("bwameth_", chrom, ".bed"), header = TRUE)
    biscuit <- read.table(paste0("biscuit_", chrom, ".bed"), header = TRUE)

    merged_data <- merge(bismark, biscuit, by = "chr_st_ed")
    final_merged_data <- merge(merged_data, bwameth, by = "chr_st_ed")

    colnames(final_merged_data)[which(names(final_merged_data) == "methyl.x")] <- "bismark"
    colnames(final_merged_data)[which(names(final_merged_data) == "methyl.y")] <- "biscuit"
    colnames(final_merged_data)[which(names(final_merged_data) == "methyl")] <- "bwameth"

    output_file <- paste0("final_merged_", chrom, "_data.bed")
    write.table(final_merged_data, output_file, sep = "\t", quote = FALSE, row.names = FALSE)
}
