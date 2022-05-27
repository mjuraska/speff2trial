\name{speff}
\alias{speff}
\title{Semiparametric efficient estimation and testing for a two-sample treatment effect with a quantitative or dichotomous endpoint}
\description{\code{speff} conducts estimation and testing of the treatment effect in a 2-group randomized
clinical trial with a quantitative or dichotomous endpoint. The method is a special case of Robins, Rotnitzky, and 
Zhao (1994, JASA). It improves efficiency by leveraging baseline predictors of the endpoint. The method uses 
inverse probability weighting to provide unbiased estimation when the endpoint is missing at random.}
\usage{
speff(formula, endpoint=c("quantitative", "dichotomous"), data,
      postrandom=NULL, force.in=NULL, nvmax=9, 
      method=c("exhaustive", "forward", "backward"), 
      optimal=c("cp", "bic", "rsq"), trt.id, conf.level=0.95, 
      missCtrl=NULL, missTreat=NULL, endCtrlPre=NULL, 
      endTreatPre=NULL, endCtrlPost=NULL, endTreatPost=NULL)
}
\arguments{
  \item{formula}{a formula object with the response on the left of the \code{~} operator, and the linear
  predictor on the right. The linear predictor specifies baseline and postrandomization variables that are 
  considered for inclusion by the automated procedure for selecting the best models predicting the endpoint, 
  separately for each treatment group. Interactions and variable transformations might also be considered. If predicted 
  values for the endpoint are entered explicitly by the user, the formula can be of the form \code{response ~ 1}.}
  \item{endpoint}{a character string specifying the type of the response variable. The option "\code{quantitative}" 
  (default) classifies the response as quantitative, and the mean difference is the measure of the treatment effect,
  whereas "\code{dichotomous}" specifies a dichotomous response, and the log odds ratio is the measure of the treatment
  effect. Only the first character is necessary.}
  \item{data}{a data frame in which to interpret the variables named in the \code{formula}, \cr \code{postrandom}, and 
  \code{trt.id}.}
  \item{postrandom}{a character vector designating postrandomization covariates included in the formula 
  (this argument allows to distinguish baseline from postrandomiation covariates).}
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
  \code{\link{summary.speff}}.}
  \item{missCtrl}{estimated probabilities of observing the endpoint based on pre- and postrandomization information 
  in the control group}
  \item{missTreat}{estimated probabilities of observing the endpoint based on pre- and postrandomization information 
  in the treatment group}
  \item{endCtrlPre}{predicted values of the endpoint using baseline information in the control group only}
  \item{endTreatPre}{predicted values of the endpoint using baseline information in the treatment group only}
  \item{endCtrlPost}{predicted values of the endpoint using baseline and postrandomization information in the 
  control group}
  \item{endTreatPost}{predicted values of the endpoint using baseline and postrandomization information in the 
  treatment group}
}
\details{
The treatment effect is represented by the mean difference or the log odds ratio for a quantitative or dichotomous 
endpoint, respectively. Estimates of the treatment effect that ignore baseline covariates (naive) are included in the 
output.

Using the automated model selection procedure performed by \code{regsubsets}, four optimal regression models are 
developed for the study endpoint. Initially, all baseline and postrandomization covariates specified in the formula 
are considered for inclusion by the model selection procedure carried out separately in each treatment group. The 
optimal models are used to construct predicted values of the endpoint. Subsequently, in each treatment group, another 
regression model is fitted that includes only baseline covariates that were selected in the previous optimization. 
Then predicted values of the endpoint are computed based on these models. If missingness occurs in the endpoint 
variable, the model selection procedure is additionally used to determine the optimal models for predicting 
whether a subject has an observed endpoint, separately in each treatment group.

The function \code{regsubsets} conducts optimization of linear regression models only. The following modification 
in the model selection is adopted for a dichotomous variable: initially, a logistic regression model is fitted 
with all baseline and postrandomization covariates included in the formula. Subsequently, an optimal model is 
selected by using a weighted linear regression with weights from the last iteration of the IWLS algorithm. 
The optimal model is then refitted by logistic regression.

Besides using the built-in model selection algorithms, the user has the option to explicitly enter predicted 
values of the endpoint as well as estimated probabilities of observing the endpoint if it is missing at random.
}
\value{
\code{speff} returns an object of class "\code{speff}" which can be processed by 
\code{\link{summary.speff}} to obtain or print a summary of the results. An object of class "\code{speff}" 
is a list containing the following components:
\item{coef}{a matrix with estimates of treatment-specific mean responses and the treatment effect.}
\item{cov}{a list with components \code{naive} and \code{speff}, each storing the covariance matrix of the estimated 
treatment-specific mean responses.}
\item{varbeta}{a numeric vector of variance estimates of the naive and semiparametric treatment effect estimates.}
\item{formula}{a list with components \code{control} and \code{treatment} containing formula objects for the optimal 
selected regression models. Set to \code{NULL} if predicted values are entered explicitly.}
\item{rsq}{a numeric vector of the R-squared statistics for the optimal selected regression models predicting 
the study endpoint. Set to \code{NULL} if predicted values are entered by the user.}
\item{endpoint}{"\code{quantitative}" for a quantitative and "\code{dichotomous}" for a dichotomous response.}
\item{postrandom}{a character vector of postrandomization covariates considered for selection.}
\item{predicted}{a logical vector; if \code{TRUE}, the built-in model selection procedure was employed for 
prediction of the study endpoint in the control and treatment group, respectively.}
\item{conf.level}{confidence level of the confidence intervals reported by \code{\link{summary.speff}}.}
\item{method}{search technique employed in the model selection procedure.}
\item{n}{number of subjects in each treatment group.}
}
\seealso{\code{\link{summary.speff}}}
\references{
Robins JM, Rotnitzky A, Zhao LP. (1994), "Estimation of regression coefficients when some regressors are not always 
observed.", \emph{Journal of the American Statistical Association}, 89:846--66.

Tsiatis AA, Davidian M, Zhang M, Lu X. (2007), "Covariate adjustment for two-sample treatment comparisons in 
randomized clinical trials: A principled yet flexible approach.", \emph{Statistics in Medicine}, 27:4658--4677.

Zhang M, Tsiatis AA, Davidian M. (2008), "Improving efficiency of inferences in randomized clinical trials using 
auxiliary covariates.", \emph{Biometrics}, 64:707--715.

Davidian M, Tsiatis AA, Leon S. (2005), "Semiparametric estimation of treatment effect in a pretest-posttest study 
with missing data.", \emph{Statistical Science}, 20:261--301.

Zhang M, Gilbert P. (2009), "Increasing the efficiency of prevential trials by incorporating baseline
covariates.", manuscript.
}
\examples{
str(ACTG175)

### treatment effect estimation with a quantitative endpoint missing
### at random
fit1 <- speff(cd496 ~ age+wtkg+hemo+homo+drugs+karnof+oprior+preanti+
race+gender+str2+strat+symptom+cd40+cd420+cd80+cd820+offtrt, 
postrandom=c("cd420","cd820","offtrt"), data=ACTG175, trt.id="treat")

### 'fit2' adds quadratic effects of CD420 and CD820 and their 
### two-way interaction
fit2 <- speff(cd496 ~ age+wtkg+hemo+homo+drugs+karnof+oprior+preanti+
race+gender+str2+strat+symptom+cd40+cd420+I(cd420^2)+cd80+cd820+
I(cd820^2)+cd420:cd820+offtrt, postrandom=c("cd420","I(cd420^2)",
"cd820","I(cd820^2)","cd420:cd820","offtrt"), data=ACTG175, 
trt.id="treat")

### 'fit3' uses R-squared as the optimization criterion
fit3 <- speff(cd496 ~ age+wtkg+hemo+homo+drugs+karnof+oprior+preanti+
race+gender+str2+strat+symptom+cd40+cd420+cd80+cd820+offtrt, 
postrandom=c("cd420","cd820","offtrt"), data=ACTG175, trt.id="treat", 
optimal="rsq")

### a dichotomous response is created with missing values maintained
ACTG175$cd496bin <- ifelse(ACTG175$cd496 > 250, 1, 0)

### treatment effect estimation with a dichotomous endpoint missing
### at random
fit4 <- speff(cd496bin ~ age+wtkg+hemo+homo+drugs+karnof+oprior+preanti+
race+gender+str2+strat+symptom+cd40+cd420+cd80+cd820+offtrt, 
postrandom=c("cd420","cd820","offtrt"), data=ACTG175, trt.id="treat", 
endpoint="dichotomous")
}


