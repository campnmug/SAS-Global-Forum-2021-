# SAS-Global-Forum-2021-

This is the SAS code to accompany my paper for SAS Global Forum 2021
Paper 1184-2021
Haste Makes Waste: Don't Ruin Your Reputation with Hasty Regression
Steven C. Myers, Ph.D., The University of Akron
Pull quotes: 

Regression analysis is like a puddle in which a novice can wade, and an expert drown. 

How do you know when your data is lying to you?

Data alone can never solve questions of causality. 

Hasty regression should never be used. There I said it. 

If you are willing to let the data speak for itself without much or any human intervention, then why think at all? 

Checklist of the Pitfalls of Regression Practice

1	Understand why you are running the regression.	Regression can be used for explanation or prediction, but not both. Proper articulation of the problem being examined must be done before beginning. Regression is not for exploratory data analysis (EDA), and EDA is to be avoided in specifying your regression. 
2	Be a data skeptic and understand the data generating process.	Economists are said to be obsessed with the data generating process (DGP) and for good reason. This comes in large measure from having to use the data we have and not the data we want. The DGP, in actuality, will produce extreme values that challenge us to delete or transform. Important cofounders may be missing, and observations may be missing. What variables actually measure may differ from what the data owner says they measure. 
3	Examine your data before you regress.	It is critical that you fully understand your data. However, Exploratory Data Analysis has both benefits and costs, and you must learn the difference. One caution is that you do not build your model around correlations that you asked for and now cannot un-see. 
4	Examine your data after you regress. 	Examine both predictions and residuals to help gauge the model performance, noting that these and all statistical results in the regression are highly sensitive to model misspecification. Just as perturbations and patterns in the data may hint at a model specification, perturbations and patterns in the residuals can identify the failure of that model. 
5	Understand how to interpret regression results.	Nearly everyone gets this wrong at times. You must understand the use of calculus derivatives (for metrics) versus the difference in mathematical expectations for binary and categorical variables. For example, a dummy (binary) variable in a semi-log equation cannot be directly interpreted. 
6	Model both theory and data anomalies and to know the difference.	A variable may be correctly measured yet yield an anomalous result or match a theoretical hypothesis. Knowing the difference is not straightforward and often not the conclusion from a single test. Modeling theory means matching a pattern of statistical testing to the problem at hand while understanding that alternative specifications may seem near equally valid. The rest of this paper focuses primarily on this point.
7	Be ethical. 	(see Table 1: Ethics Rules in Applied Econometrics and Data Science) To be unethical does not require intent. Ignorance of ethics, just like ignorance of how a technique works, is not an excuse. You do have to have the intent and do what it takes to be ethical.
8	Provide proper statistical testing.	As mentioned in rule 6, the proper statistical test may not be a single test and likely requires a full-on testing strategy like the problem illustrated later in this paper.
9	Properly consider causal calculus.	Economists are especially attuned to causality, but their use of causal calculus is more recent. One must establish not only that if A occurs, then 'B' will occur, but that if 'B' occurs, then 'A' must have occurred. (See Pearl and Mackensie (2018) and Cunningham (2021) for more on the calculus of causality.) Asking causal questions require specific care in the answers.
10	Meet the assumptions of the classical linear model.	No list of pitfalls can be complete without the proper homage to the assumptions of the CLM. However, regression seems sometimes discarded because the linear model is too limiting. There are techniques to address each violation, and econometric research in particular has continually developed inference to address each of the assumptions. 
