library(rjson)
library(memoise)

cd <- cache_filesystem("./r-memoise")


ipeadata <- function(sercodigo, tipodado) {
    if (!(tipodado %in% c("valores", "metadados"))) {
        stop(paste("Tipo de dado deve ser 'valores' ou  'metadados'!"))
    }

    url <- "http://www.ipeadata.gov.br/api/odata4/Metadados('"
    url_metadado <- paste0(url, sercodigo, "')")
    url_valores <- paste0(url_metadado, "/Valores")
    if (tipodado == "metadados") {
        print(url_metadado)
        metadados <- fromJSON(file = url_metadado)
        return(metadados)
    } else if (tipodado == "valores") {
        print(url_valores)
        valores <- fromJSON(file = url_valores)
        return(valores)
    }
    return(NULL)
}

ipeadatacache <- memoise(ipeadata, cache = cd)
