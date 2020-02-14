library(rmarkdown)

## Index
render("index.Rmd")


## Compile to pdf files
pages <- c("teachers_sv.Rmd","students_sv.Rmd",
           "teachers_da.Rmd","students_da.Rmd")

## Compile the joined pages
for(page in pages){
    render(page, envir=new.env())
}

## Compile all the instructions to pdfs
for(page in pages){
    x <- scan(page, what="character")
    pattern <- ".*knitr\\:\\:knit_child\\('"
    x <- x[grep(pattern, x)]
    files <- sub("').*", "", sub(pattern, "", x))
    for(file in files){
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


## Publish
## system("git add -A")
## system("git commit -m 'fix'")
## system("git push")
