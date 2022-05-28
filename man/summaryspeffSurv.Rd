\name{summary.speffSurv}
\alias{summary.speffSurv}
\title{Summarizing results for semiparametric efficient estimation and testing for a two-sample treatment effect with a 
right-censored time-to-event endpoint}
\description{\code{summary} method for an object of class "\code{speffSurv}".}
\usage{
\method{summary}{speffSurv}(object,...)
}
\arguments{
  \item{object}{an object of class "\code{speffSurv}".}
  \item{\dots}{for other methods.}
}
\details{
\code{print.summary.speffSurv} prints a formatted summary of results. In the initial section, right-sided formulas 
defining the optimal selected functions in the randomization and censoring space are printed. Further, an inferential 
table is generated with point and interval estimates of the log hazard ratio, standard error estimates, and Wald test 
p-values using both the proportional hazards and covariate-adjusted estimation methods. At least five significant 
digits are printed.
}
\value{
A list with the following components:
\item{tab}{inferential table for the treatment effect.}
\item{method}{search technique employed in the model selection procedure.}
\item{formula}{a list with components \code{rndSpace} and \code{censSpace} containing formula objects for the optimal
selected linear regression models that characterize the optimal elements in the randomization and censoring space,
respectively. Set to \code{NULL} if \code{fixed=TRUE}.}
\item{fixed}{a logical value; if \code{TRUE}, the efficient estimator utilized all baseline covariates specified in the 
    formula. Otherwise, the automated selection procedure was used to identify covariates that ensure optimality.}
}
\seealso{\code{\link{speffSurv}}}
\examples{
### from the example for 'speffSurv':
data <- na.omit(ACTG175[ACTG175$arms==0 | ACTG175$arms==1, ])
data <- data[1:100, ]

fit1 <- speffSurv(Surv(days,cens) ~ cd40+cd80+age, 
                  data=data, trt.id="arms", fixed=TRUE)

summary(fit1)
}
