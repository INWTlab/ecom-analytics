## ecom-analytics: A Best Practice Example for Developing Shiny Dashboards as R Packages

This package shows an example of INWT's best practices for structuring shiny dashboards as r packages. 
The here provided code backs up INWT's preffered structure and workflow, when developing shiny apps. The accompanying blog article ["Best Practice: Development of Robust Shiny Dashboards as R Packages"](https://www.inwt-statistics.com/read-blog/best-practice-development-of-robust-shiny-dashboards-as-r-packages.html) provides extensive explanation on this matter. 

## Installation and Usage

The ecom-analytics package can be downloaded and installed by running the following
command from the R console:

```
devtools::install_github("INWTlab/ecom-analytics")
```

Afer downloading the package, it can be loaded with the `library()` command:

```
library(ecomAnalytics)
```

The shiny app can be started e.g. by running the following command:

```
shiny::runApp(system.file("app", package = "ecomAnalytics"))
```


## Feedback

The focus of this package is to provide a show case for a well-structured and roboust shiny app. 
If you would like to suggest improvements regarding best practices on building shiny dashboards as r packages, please open an issue or create a pull request. 
