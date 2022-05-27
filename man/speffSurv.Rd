\name{speffSurv}
\alias{speffSurv}
\title{Semiparametric efficient estimation and testing for a two-sample treatment effect with a right-censored 
time-to-event endpoint}
\description{\code{speffSurv} conducts estimation and testing of the treatment effect in a two-group randomized
clinical trial with a right-censored time-to-event endpoint. It improves efficiency by leveraging baseline predictors 
of the endpoint.}
\usage{
speffSurv(formula, data, force.in=NULL, nvmax=9,
          method=c("exhaustive", "forward", "backward"), 
          optimal=c("cp", "bic", "rsq"), trt.id, 
          conf.level=0.95, fixed=FALSE)
}
\arguments{
  \item{formula}{a formula object with the response variable on the left of the \code{~} operator and the linear 
  predictor on the right. The response is a survival object of class \code{Surv}. The linear predictor specifies 
  baseline variables that are considered for inclusion by the automated procedure for selecting the best models 
  predicting the endpoint. Interactions and variable transformations might also be considered.}
  \item{data}{a data frame in which to interpret the variables named in the \code{formula} and \code{trt.id}.}
  \item{force.in}{a vector of indices to columns of the design matrix that should be included in each regression model.}
  \item{nvmax}{the maximum number of covariates considered for inclusion in a model. The default is 9.}
  \item{method}{specifies the type of search technique used in the model selection procedure carried out by the
  \code{regsubsets} function. "\code{exhaustive}" (default) performs the all-subsets selection, whereas
  "\code{forward}" and "\code{backward}" execute a forward or backward step-wise selection, respectively.}
  \item{optimal}{specifies the optimization criterion for model selection. The default is "\code{cp}", Mallow's Cp,
  which is equivalent to AIC. The other options are "\code{bic}" for BIC and "\code{rsq}" for R-squared.}
  \item{trt.id}{a character string specifying the name of the treatment indicator which can be a character or a
  numeric vector. The control and treatment group is defined by the alphanumeric order of labels used in the treatment
  indicator.}
  \item{conf.level}{the confidence level to be used for confidence intervals reported by \cr
  \code{\link{summary.speffSurv}}.}
  \item{fixed}{logical value; if \code{FALSE} (default), automated selection procedure is used for predicting the 
  endpoint. Otherwise, \emph{all} baseline variables specified in the formula are used.}
}
\details{
The treatment effect is represented by the (unadjusted) log hazard ratio for the treatment versus control group. 
The estimate of the treatment effect using the (unadjusted) proportional hazards model is included in the output.

Using the automated model selection procedure performed by \code{regsubsets}, two optimal linear regression models 
are developed to characterize the influence function of an estimator that is more efficient
than the maximum partial likelihood estimator. The "efficient" influence function is searched in the space of 
influence functions that determine all regular and asymptotically linear estimators for the treatment effect 
(for definitions see, for example, Tsiatis, 2006). The space of influence functions has three components: the 
estimation space that characterizes all regular and asymptotically linear estimators that do not use baseline 
covariates. The other two subspaces, the randomization and censoring space, use baseline covariates to improve 
the efficiency in the estimation of the treatment effect (Lu, 2008). The automated model selection procedure is 
used to identify functions in the randomization and censoring space that satisfy a prespecified optimality criterion 
and that lead to efficiency gain by using baseline predictors of the outcome.

The user has the option to avoid the automated variable selection and, instead, use all variables specified in the
formula for the estimation of the treatment effect. This is achieved by setting \code{fixed=TRUE}.

\code{speffSurv} does not allow missing values in the data.
}
\value{
\code{speffSurv} returns an object of class "\code{speffSurv}" which can be processed by \cr
\code{\link{summary.speffSurv}} to obtain or print a summary of the results. An object of class "\code{speffSurv}"
is a list containing the following components:
\item{beta}{a numeric vector with estimates of the treatment effect from the unadjusted proportional hazards model and 
the semiparametric efficient model using baseline covariates, respectively.}
\item{varbeta}{a numeric vector of variance estimates for the treatment effect estimates in \code{beta}.}
\item{formula}{a list with components \code{rndSpace} and \code{censSpace} containing formula objects for the optimal
selected linear regression models that characterize the optimal elements in the randomization and censoring space,
respectively. Set to \code{NULL} if \code{fixed=TRUE}.}
\item{fixed}{a logical value; if \code{TRUE}, the efficient estimator utilizes all baseline covariates specified in the
formula. Otherwise, the automated selection procedure is used to identify covariates that ensure optimality.}
\item{conf.level}{confidence level of the confidence intervals reported by \code{\link{summary.speffSurv}}.}
\item{method}{search technique employed in the model selection procedure.}
\item{n}{number of subjects in each treatment group.}
}
\seealso{\code{\link{summary.speffSurv}}}
\references{
Lu X, Tsiatis AA. (2008), "Improving the efficiency of the log-rank test using auxiliary covariates.", 
\emph{Biometrika}, 95:679--694.

Tsiatis AA. (2006), \emph{Semiparametric Theory and Missing Data.}, New York: Springer.
}
\examples{
str(ACTG175)

data <- na.omit(ACTG175[ACTG175$arms==0 | ACTG175$arms==1,])

### efficiency-improved estimation of log hazard ratio using
### baseline covariates
fit1 <- speffSurv(Surv(days,cens) ~ cd40+cd80+age+wtkg+drugs+karnof+z30+
preanti+symptom, data=data, trt.id="arms")

### 'fit2' coerces the use of all specified baseline covariates;
### automated selection procedure is skipped
fit2 <- speffSurv(Surv(days,cens) ~ cd40+cd80+age+wtkg+drugs+karnof+z30+
preanti+symptom, data=data, trt.id="arms", fixed=TRUE)
}


