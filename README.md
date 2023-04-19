# Shiny time series

[English version](README_English.md)

Shiny app para visualizar séries temporais.

<div>
 <img src="https://github.com/rstudio/hex-stickers/blob/master/PNG/RStudio.png" width="25"> 
 <img src="https://github.com/rstudio/shiny/blob/main/man/figures/logo.png" width="25"> 
</div>

O app utiliza a API do [Ipeadata](http://ipeadata.gov.br/) e do Sistema Gerenciador de Séries Temporais do Banco Central do Brasil ([SGS](https://www3.bcb.gov.br/sgspub/localizarseries/localizarSeries.do?method=prepararTelaLocalizarSeries)) para obter os dados e apresentar na tela.

## Utilização

Clone o repositório e execute o app com o seguinte comando no terminal.

```shell
git clone https://github.com/ajdavidl/shiny-time-series.git
cd shiny-time-series
R -e "shiny::runApp('.', port = 3838)"
```

Alternativamente, é possível usar o docker:
```shell
git clone https://github.com/ajdavidl/shiny-time-series.git
cd shiny-time-series
docker build -t shiny_time_series 
docker run --rm -p 3838:3838 shiny_time_series
```
Em seguida, abra um navegador e acesse o link [http://localhost:3838](http://localhost:3838)

## Imagens

### IBGE
<img src="img/fig1.png" alt="Menu IBGE" style="width: 600px"/>

### SGS
<img src="img/fig2.png" alt="Menu SGS" style="width: 600px"/>
