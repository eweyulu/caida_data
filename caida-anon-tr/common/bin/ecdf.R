#!/usr/bin/env Rscript

library(getopt)


# Force to print in decimal notation.
options(scipen=10)

# Number of decimal digits to retain in the output.
ECDF.PRECISION <- 4


spec <- matrix(c(
    'help',    'h', 0, "logical",   "Show help menu",
    'verbose', 'v', 0, "logical",   "Enable verbose output",
    'cdfcol',  'c', 1, "integer",   "(1-based) Index of column for ECDF",
    'freqcol', 'f', 1, "integer",   "(1-based) Index of 'frequency' column",
    'infile',  'i', 1, "character", "Input file",
    'outfile', 'o', 1, "character", "Output file"
), byrow=TRUE, ncol=5)
opt <- getopt(spec)

showhelp <- function(s) {
    cat(getopt(spec, usage=TRUE));
    q(status=s);
}

if (!is.null(opt$help)) {
    showhelp(0)
}

# Default arguments.
if (is.null(opt$verbose)) {
    opt$verbose = F
}
if (is.null(opt$cdfcol)) {
    opt$cdfcol = 1
}
if (is.null(opt$freqcol)) {
    opt$freqcol = 0
}
if (is.null(opt$outfile)) {
    opt$outfile = stdout()
}

if (is.null(opt$infile)) {
    showhelp(1)
}


compute.ecdf <- function (in.file, ecdf.col, freq.col=0) {
    raw.data <- read.table(in.file, header=F)
    if (freq.col == 0) {
        df <- within(data.frame(x=raw.data[, ecdf.col]), {
            ecdf <- round(ecdf(x)(x), digits=ECDF.PRECISION)
        })
        df <- df[with(df, order(x)), ]
        # Output: <x> <ECDF>
        # Output is sorted by 'x'.
    } else {
        df <- data.frame(raw.data[, c(ecdf.col, freq.col)])
        names(df) <- c('x', 'f')
        df <- df[with(df, order(x)), ]
        df <- within(df, {
            ecdf <- round(cumsum(f)/sum(f), digits=ECDF.PRECISION)
        })
        # Output: <x> <frequency of 'x'> <ECDF>
        # Output is sorted by 'x'.
    }
    rm(raw.data)
    return(unique(df))
}


write.table(compute.ecdf(opt$infile, opt$cdfcol, opt$freqcol), file=opt$outfile,
            row.names=F, col.names=F, quote=F)
