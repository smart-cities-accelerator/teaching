library(rmarkdown)

## ----------------------------------------------------------------
## Compile main pages
render("index.Rmd")
file.copy("website/html_output.yaml", paste0("info/_output.yaml"), overwrite=TRUE)
render("info/manual.Rmd", envir=new.env())
render("info/about.Rmd", envir=new.env())
## ----------------------------------------------------------------


## ----------------------------------------------------------------
## The pages to be included, just find all ".Rmd" files containing with "teachers" or "students"
langs <- c("sv","da")
pages <- character()
for(lang in langs){
    ## ------------------------------------
    pages <- dir(lang, pattern=paste0("\\.Rmd$"), full.names=TRUE)
    ## Copy the yaml
    file.copy("website/html_output.yaml", paste0(lang,"/_output.yaml"), overwrite=TRUE)
    ## ------------------------------------
    ## Compile the joined pages
    for(page in pages){
        render(page, envir=new.env())
    }
    ## ------------------------------------
    ## Compile all the instructions to pdfs
    for(page in pages){
        x <- scan(page, what="character", sep="\n")
        pattern <- ".*knitr\\:\\:knit_child\\('"
        x <- x[grep(pattern, x)]
        files <- sub("').*", "", sub(pattern, "", x))
        for(file in files){
            file <- paste0(lang,"/",file)
            ## Move the template setup files
            file.copy("website/pdf_output.yaml", paste0(dirname(file),"/_output.yaml"), overwrite=TRUE)
            file.copy("website/pdf_header.tex", paste0(dirname(file),"/_header.tex"), overwrite=TRUE)
            ## Fix the path to the header image files
            tmpfile <- paste0(dirname(file),"/_header.tex")
            x <- scan(tmpfile, what="character", sep="\n")
            x <- gsub("figures_pdf", paste0(paste0(rep("..", lengths(regmatches(file, gregexpr("/",file)))), collapse="/"), "/website/figures_pdf"), x)
            write.table(x, tmpfile, row.names=FALSE, col.names=FALSE, quote=FALSE)
            ## Compile the pdf file
            render(file, output_format="pdf_document", envir=new.env())
        }
    }
}
## ----------------------------------------------------------------


## ----------------------------------------------------------------
## MISC
## 
## ## Check a pdf
## ## Compile the pdf file
## lang <- "sv"
## page <- "teachers_GN.Rmd"
## file <- "sv/Omraade-Energikaellor/Solceller_GN_laerare.md"
## ## Run above
## system("evince sv/Omraade-Energikaellor/Solceller_GN_laerare.pdf &")

## Publish
## system("git add -A")
## system("git commit -m 'fix'")
## system("git push")
