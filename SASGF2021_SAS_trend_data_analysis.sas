
/* modified for SASGF 2021 paper
Title of Paper is Paper 1184-2021
Haste Makes Waste: Don't Ruin Your Reputation with Hasty Regression
*/

/* assign dir directory for ods output  */
%let dir= ;

/* Original Code for SCSUG 2019 paper 
Title of paper is
DO YOU KNOW WHEN YOUR DATA IS LYING TO YOU? 
THE HOW OF REGRESSION ANALYSIS WITH QUANTITATIVE AND QUALITATIVE VARIABLES
Invited paper by Kirk Paul Lafler for SCSUG.
*/

/*Code blocks from version 3 of the paper, May 20, 2021 */

/* Page 8 */
Data Y;	
	/* read Y variable. The @@ allows reading multiple data from the same line */
	input Y @@; 
	datalines;  
	12.35  13.71  16.00  17.94  20.76  21.11  24.63
	27.56  32.88  35.16  39.26  44.28  47.27  51.55
;
run;

Proc means data=Y mean std maxdec=4;
	Title1 'Verify you entered the data correctly by matching proc means results. ';
	Title2 'The correct mean of Y is 28.8900 and the standard deviation of Y is 12.9719'; run; title1;


Data work.trdata;
	/* 	Problem articulation: Explain the trend in variable Y.						*/
	/* 		H0: An intervention that begins in T=8 has no effect on the trend line 	*/
	/* 		H1: An intervention at T=8 changes the trend line 						*/
	/*  Alternative problem: 														*/
	/*		The actual equation is simply nonlinear in variables such as y = T TSQ	*/
	set Y;
	T=_N_; 					/* 1. Create time variable T. */
	TSQ = T*T;				/* 2. Create time-squared value. */
	D=0; if T>=8 then D=1;	/* 3. Create binary variable for the intervention. */
	DT = D*T;				/* 4. Create interaction of D and T. */
run;

/* page 9 */

proc reg data=work.trdata;
	 model_1: model y = t;
	 model_2: model y = t tsq;
	 model_3: model y = t d;
	 model_3A: model y = t tsq d;
	 title1 'Regression Specifications - full sample' ;
     title2 'Full Sample, T=1,..., 14';
	 run;

/* page 14 */

proc reg data=work.trdata;
	 Model_3:  Model Y = T D;
			   Test_3: Test D=0;
	 Model_3A: Model Y = T TSQ D;
			   Test_3A: Test D=0;
	 title1 'Regression Specifications - full sample' ;
     title2 'Full Sample, T=1,..., 14';
	 run;

/* page 16 */
Proc reg data=work.trdata;
	 model_4: model y = T D DT;
		test_4:  test D=DT=0;
		title1 'Regression Specifications - full sample' ;
         	title2 'Full Sample, T=1,..., 14';
		run;


*ods pdf file="&dir/Myers_SASGF2021_paper_visual_results.pdf" ;

/* A VISUAL APPROACH USING PROC SGPLOT, reg and loess plots. */

/* page 17 */
ods graphics on / noborder width=5in;
%let xref = %str(xaxis values=(1 to 14 by 1); refline 7.5 / 
	 axis=x label="<-- Policy change" labelloc=inside labelpos=min ;);

title1 'Model 1: Y follows a Linear Trend.';
title2 'PROC SGPLOT with REG Statement.';
PROC SGPLOT data=trdata ;
	reg x=T y=Y / CLM CLI ;
	&xref;
	run;
	
/* Page 18 */

title1 'Model 2: Y follows a Quadratic Trend.';
title2 'PROC SGPLOT with REG Statement.';
PROC SGPLOT data=trdata ;
	reg x=T y=Y / degree=2 CLM CLI ;
	&xref;
	run;

/* Page 20 */

title1 'Nonparametric Local Regression LOESS Model.';
title2 'Tracing out the points with LOESS and comparing to the Linear Trend.';
PROC SGPLOT data=trData;
	reg x=T y=Y / degree=1 CLM CLI CLMTRANSPARENCY=.5;
	loess x=T y=Y /interpolation=linear degree=2;  
	&xref;
run;

/* Page 21 */

title1 'Model 4: Structural Break with Linear Trend by Group=D';
title2 'Separate linear regressions before and after policy change';
PROC SGPLOT data=trdata;
	reg x=T y=Y / CLM CLI CLMTRANSPARENCY=.5;
	reg x=T y=Y / CLM CLI CLMTRANSPARENCY=.25 group=D 
				  markerattrs=(symbol=circlefilled color=black size=10px) ;
	&xref;
run;

/* Page 22 */

title1 'Local regression by group=D';
title2 'Separate LOESS regressions before and after policy change';
PROC SGPLOT data=trData;
	reg x=T y=Y / CLM CLI CLMTRANSPARENCY=.5;
	loess x=T y=Y / group=D 
		interpolation=linear degree=1 
		markerattrs=(symbol=circlefilled color=black size=10px) 
		CLMTRANSPARENCY=.25;  
		/* CUBIC or LINEAR, 1 or 2 */
	&xref;
run;


title1 'Model 3a: Structural Break with Quadratic Trend by Group=D';
title2 'Separate linear regressions before and after policy change';
PROC SGPLOT data=trdata;
	reg x=T y=Y / CLM CLI CLMTRANSPARENCY=.5;
	reg x=T y=Y / degree=2 CLM CLI group=D markerattrs=(symbol=circlefilled color=black size=10px) CLMTRANSPARENCY=.25;
	&xref;
run;

/* end of visual code plocks from the paper */
ods graphics off;
*ods pdf close;

/****************************************************************************/

*ods pdf file="&dir/Myers_SASGF2021_regression_results.pdf" ;


/* A STATISTICAL APPROACH USING PROC REG */

ods graphics on;

/* Page 25 */

Title1 'Statistical models';
proc reg data=work.trdata;
		model_1: model Y = T      ;		/* Linear Model     */
		model_2: model Y = T TSQ  ;		/* Quadratic Model  */
		model_3: model Y = T D    ;		/* Hasty model      */
		model_4: model Y = T D DT ;		/* Structural Break */
		title2 'Full Sample, T=1,..., 14';
		run;

/* Page 27 */

title2 'Testing the Quadratic Model against the Linear Model';
proc reg data=trdata;
	model_2:     model Y = T  TSQ;
	Quadratic:   test tsq=0;      
	run;
	title2 'Testing the Structural Break model against the Linear Model';
proc reg data=trdata;
	model_4:		model Y = T  D  DT;
	Structural_break:  test D=DT=0; 
	run;

/* Page 28 */

Title1 'Statistical models';
proc reg data=work.trdata;
		model_5: model Y = T      ;
		model_6: model Y = T TSQ  ;
		title2 'Partial Sample, T=1,...,7 Before';
		where D=0;;
		run;

proc reg data=work.trdata;
		model_7: model Y = T      ;
		model_8: model Y = T TSQ  ;
		title2 'Partial Sample, T=8,...,14 After';
		where D=1;
		run;

/* Page 30 */
Title1 'Automatic Selection';
Title2 ;
proc reg data=work.trdata;
	 model y = T Tsq D DT / Selection = adjRsq;
	 model y = T Tsq D DT / Selection = Stepwise;
	 model y = T Tsq D DT / Selection = Forward;
	 model y = T Tsq D DT / Selection = Backward;
	 model y = T Tsq D DT / Selection = maxR;
	 model y = T Tsq D DT / Selection = minR;
	 model y = T Tsq D DT / Selection = CP;
	 run;



/* Page 31 */

title 'SAS/ETS Proc Autoreg, Ramsey specification tests (RESET)';

proc autoreg data=trdata;
	model_1: model y = T  / reset;
	run;
proc autoreg data=trdata;
	model_2: model y = T TSQ/ reset;
run;
proc autoreg data=trdata;
	model_3: model y = T D / reset;
	run;
proc autoreg data=trdata;
	model_4: model y = T D DT/ reset ;
run;


/* Page 34 */
/* Non-nesting hypothesis tests */

Title1 'Non-nested hypothesis - J-test';
Proc reg data=trdata;
 		model_2: model Y = T TSQ  ;
		output out=Mquad p=Yquadhat;
		run;
Proc reg data=trdata;
 		model_4: model Y = T D DT  ;
		output out=Minter p=Ybreakhat;
		run;
Proc reg data=Mquad;
		model_4A: model Y = T D DT Yquadhat;
		run;
Proc reg data=Minter;
 		model_2A: model Y = T TSQ Ybreakhat ;
		run;

Title1 'Non-nested hypothesis test - super model, F-test';
Proc reg data=trdata;
		model_4A: model Y = T  TSQ D DT ;
		quad: test tsq = 0;
		interactive: test d =dt=0;
		run;
		quit;


/* Code not shown in Paper */

/* Code to generate the residual map in Model_1 */
Title1 'Regression Specifications - full sample' ;
Title2 'Examining the residuals to the linear trend model.';
PROC REG data=trdata;
	model_1R: model y = T;
	output out=TR r=residual;
	run;

PROC SGPLOT data=tr;
	reg x=T y=residual / degree=1 CLM CLI CLMTRANSPARENCY=.5;
	loess x=T y=residual /interpolation=linear degree=2;  
	&xref;
	run;


*ods pdf close;

