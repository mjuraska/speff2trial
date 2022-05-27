\name{summary.speff}
\alias{summary.speff}
\title{Summarizing results for semiparametric efficient estimation and testing for a 2-sample treatment effect}
\description{\code{summary} method for an object of class "\code{speff}".}
\usage{
\method{summary}{speff}(object,...)
}
\arguments{
  \item{object}{an object of class "\code{speff}".}
  \item{\dots}{for other methods.}
}
\details{
\code{print.summary.speff} prints a formatted summary of results. In the initial section, formulas for the optimal 
selected regression models are printed with pertaining R-squared statistics for each treatment group. 
Further, an inferential table is produced with point and interval estimates of the treatment effect, 
standard error estimates, and Wald test p-values using both the naive and covariate-adjusted estimation methods. 
At least five significant digits are printed.
}
\value{
A list with the following components:
\item{tab}{inferential table for the treatment effect.}
\item{method}{search technique employed in the model selection procedure.}
\item{rsq}{a numeric vector of the R-squared statistics for the optimal selected regression models predicting 
the study endpoint.}
\item{formula}{a list with components \code{control} and \code{treatment} containing formula objects for 
the optimal selected regression models.}
\item{predicted}{a logical vector; if \code{TRUE}, the built-in model selection procedure was employed for 
prediction of the study endpoint in the control and treatment group, respectively.}
}
\seealso{\code{\link{speff}}}
\examples{
### from the example for 'speff':
fit1 <- speff(cd496 ~ age+wtkg+hemo+homo+drugs+karnof+oprior+preanti+
race+gender+str2+strat+symptom+cd40+cd420+cd80+cd820+offtrt,
postrandom=c("cd420","cd820","offtrt"), data=ACTG175, trt.id="treat")

summary(fit1)
}
