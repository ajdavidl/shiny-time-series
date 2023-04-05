#Sources:
#https://blog.sellorm.com/2021/04/25/shiny-app-in-docker/
#https://www.r-bloggers.com/2021/08/setting-up-a-transparent-reproducible-r-environment-with-docker-renv/
#https://rstudio.github.io/renv/articles/docker.html

# docker build -t shiny_time_series 
# docker run --rm -p 3838:3838 shiny_time_series

FROM rocker/shiny:4.2.3

RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev

RUN R -e 'install.packages(c(\
              "shiny", \
              "shinydashboard", \
              "ggplot2", \
              "DT", \
              "plotly", \
              "dplyr", \
              "lubridate", \
              "rjson", \
              "memoise", \
              "shinycssloaders" \
            ), \
            repos=c(CRAN = "https://cloud.r-project.org") \
          )'

EXPOSE 3838

COPY *.R ./
CMD ["Rscript", "app.R"]