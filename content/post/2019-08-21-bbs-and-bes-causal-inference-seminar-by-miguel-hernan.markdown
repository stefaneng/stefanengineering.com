---
title: BBS and BES Causal Inference Seminar - Learning What Works by Miguel Hernán
draft: true
author: Stefan Eng
date: '2019-08-21'
slug: bbs-bes-causal-inference-seminar-miguel-hernan
categories:
  - statistics
tags:
  - causal-inference
  - biostatistics
output:
  blogdown::html_page:
    toc: no
    fig_width: 5
    fig_height: 5
csl: ../../static/bibtex/acm-sig-proceedings.csl
---




## Introduction

> What is the (causal) question you are trying to answer?

On August 19-20, the [BES (Basel Epidemiology Seminar)](http://bes.ceb-institute.org/) hosted a causal inference seminar called "Learning What Works", by [Miguel Hernán](https://www.hsph.harvard.edu/miguel-hernan/) hosted at Hoffmann-La Roche.
The seminar was a fairly conceptual overview of causal inference with application to biostatistcs, epidemiology, and pharma.

## Requirements
 1. A well-defined causal question
 2. High-quality data
 3. Valid data analysis

## Causal Question
It was described that there are two steps to causal inference:
  1. Asking a causal question
  2. Answering the causal question
  
Asking the _right_ causal question can be hard.

## Target Trial
The concept of a target trial was repeated many times in the lectures.
The idea was that in an observational study we need to think of a ideal trial we would have like to run, had it been possible.
This mean specifying the protocol:
  - The eligibility criterion
  - Treatment
  - ...
  - Follow up?
  - Analysis plan
  
This is an iterative process. We need to check how many people in our data match the eligibility criterion of our target trial.
Do not look at the effects based on this selection, only if we have enough sample for answering the question.
How many are in each arm based on this selected eligibility criterion?


## Types of questions
  1. Descriptive
  2. Predictive
  3. Causal inference
    - All about _what if_? What if we changed a variable, what will happen?
    
## Notes
  - Target trial must be a pragmatic trial and cannot be blinded.
  - cannot emulate placebo controlled trial
  - cannot force adherence
  - cannot tightly monitor

## Defining "time-zero"
A big issue in observational studies is a lack of a well-defined time zero.
Time zero must be aligned on eligibility criterion and treatment assignment.
An issue in many studies is that assignment to treatment group is selected based on looking into the future.
This creates _immortal time bias_, in which the subject is guarenteed to survive at least the number of years from time zero to the time in which they are observed as a user.
If we look at many observational study they compared _prevelant users_ to _non users_.
This introduces bias.

Imagine you are in a RCT. You only meet a person once and get to decide if they are eligible for the trial or not.
If they are eligible, they are assigned to treatment or control.
No looking into the future.

## Simulating the trial
  - Can select a single eligibility time at random or pool together many.
  
Multiple:
"start" multiple trials at some time interval, say every week.
Each person in the sample can be eligibly for any number of trials.
If they met the criterion for a given week, and begin taking treatment, they are in the treatment group.
Otherwise, in the control group.
It does not matter what they do in the future for the ITT effect.
Since we have multiple people contributing to multiple trials we need to adjust our variance estimates using sandwich estimator, or similar.

If we compare those who are current users vs never users in an observational trial we are not answering the question of incident users vs non-users.

1. Ask a causal question
2. Answer the causal question

We want to specify and emulate the entire target trial that we want.
It is an iterative process.

Can't begein to talk about bias without a clear question in mind.

Random assignment:
  - "Adjusting for confounding" cannot know for sure if we have approximated a RCT
  - Matching, g-estimation, propensity scores, etc.
  - If you have enough data the method does not matter so much.

Causal contrasts:
  - ITT effect:
    - emulate trial follow those that were in the "treatment" group no matter what they do later. All that matters is which group they were assigned to at time zero.
    - E.g. cox model with confounders in baseline period
    - Adjustment cannnot help if we are looking at the wrong groups or asking the wrong question.

Good quality data is essential. Should take months sitting down with experts to understand large datasets:
  - Why are the data points in the data set?
  - What is missing?
  - What is implied?
  - Cross-dataset comparisions
  - validation
  - talk to experts
  
Target trial _compromise_:
  It is in iterative process. We specify the protocol, the eligibility criterion and see how many people match. Not enough? Make less restrictive. Trade off between larger target population and larger sample. How many are in each arm?

Problem: current users vs never users. Biased effects. Assigning something that will happen in the future is also biased. We don't have a crystal ball when doing a RCT.

Time-zero selection is critical. Eligibility critierion and treatment assignment need to match.

- Single eligibility criterion or multiple eligibility and then pool and estimate with sandwich estimator.

incident user design and new user design

If subject specific schedule choose a fixed time unit and emulate a new trial starting at each time unit.

Make a CONSORT flowchart like you would in a clinical trial.

Don't look into the future.

Per-protocol: Depends on what the subject does after randomization.

If something is good for a RCT it is probably good for an observational study (and visa versa).

Observational trial should show survival curves (cumulative incidence?) along with the hazard ratios.
  - Adjust absolute risk for confounding

Always show absolute risk + relative risk

Hazard ratios should include absolute risk (adjusted for confounding) (See the causal survival analysis section in book)

Cox proportional assumption: Almost never will hold. He claims: why would it be?
What matters is if the survival curves cross, not the hazard ratio cross.
Show absolute risk as well.

Medicare colonoscope on mortaility

adjusting means attempting to fix lack of randomization

THIN dataset

ITT depends on adherence
PP takes into account adherence

Immortal time bias

confounder data is often the limiting factor in causal inference
We could have no overlap in the data. E.g. those with hypertension are fundamentally different than those without hypertenssion (?)

Correlation is not causation is a _logical_ statement not a _scientific_ one. It can't be proved wrong
If someone says this, ask for what variables do they think are confounding? Need to be falsifiable. Because you didn't adjust for X.

Adjusting for confounding MEANS we are interested in a causal effect.
Need to be explicit about the goal: want to estimate a caual effect. We will do our best, and we might fail but it is the goal to estimate the causal effect.

Causal language is present in all sources except the papers themselves. Skirt around the causal language. "Association", "link", "relation",...

Not specifying the target trial will lead us to answer questions that are not relevant (such as prevelant users vs non-users.)

## Day 2

Dynamic strategies:
  - Treatment based on patient charateristics. E.g: Treat with asprin 150mg but stop when patient has a stroke or heart attack.
  - Strategy affect the choice of confounding method
  - sustained strategies
  - Treatment time varying implies time varying confounders.
    - Only G-methods have no bias (?)
    - Designed the handled treatment-confounder feedback.
    - do-calculus
  - Example: Statins are given in different doses depending on the patients LDL. Not a fixed dose.
  - Kaplan meier is a special case  of the G-formula.
  - Non-parameteric with other versions that are semi- and parametric
  - Inverse probability weighting Robins 1998
  - Doubly-robust methods: Do both IP weighting and G-formula. As long as one is not biased will work
  - The visit process should be modelled. E.g. does WHEN a person come in matter? Adverse events.
  - Continuous treatment makes analysis harder

Estimands:
  - Primary effect: ITT effect, point interventions. Time fixed.
  - PP-effect: need treatment over entire followup
   - Need to adjust for post-randomization confounding
  - Need to design completly new trial if looking for estimand other than ITT effect

Counterfactual theory is behind "target trial".
Target trial is useful terminology because it unites clinicians and statisticians

Statistics education:
  - Fisher and Pearson don't talk about causal inference.
  - Everyone is using stats for causal inference except the statisticians
  - Variable Selecting (forward/backward stepwise) into model
    - only if goal is _not_ causal
    - Will end up selecting colliders in the model. (Why?)
  - Make clear when the goal is causal, and when it is not
  
Align eligibility and treatment assignment.
  - Hard with sustained strategies
  - Don't look into the future.
  
Can't emulate a double-blind trial. Everyone knows that they are taking a drug.

How to emulate time varying treatment?
For the placebo group, we don't need to do anything.
  1. Clone
    - Make a copy of the group that started treatment at time zero. Assign one of the copies to the one year group and the other to the two year group.
    - Creates non-adherence
  2. Censoring
    - Censor individuals when they stop adhering to treatment
    - Creates bias (What kind?)
  3. Inverse probability weighting
    - Removes the bias
    
### Instrumental variables IV
This was a fairly funny section of the workshop as Miguel was presenting it like a decent option.
He then tried to get us to see the flaws in the method.
    
Example: Three arms: placebo, asprin for 1 year, asprin for 2 years. Looking at 2 year survival probability.
  
## Day 3: Causal Inference and Estimands
Day 3 was much different than the first two days.
Many different speakers presented their work
  - Miguel Hernán, Harvard
  - Christine Fletcher, Amgen
    - Discussed ICH E9 (Estimands)
  - Frank Pétavy, EMA
    - Discussed a regulators perspective
  - Valentine Jehl, Novartis
    - Case study on Adverse reactions confounded by prior medication
  - Thibaut Sanglier, Roche
    - Treatment sequencing and effectiveness
  - Nikolaos Sfikas
    - Principal stratification techniques in the context of regulatory decision making
    - Presented an drug for Relapsing-Remitting MS with FDA and EMA comments, principcal stratification used. Principal stratum was the group that did not have any attacks
  - Jack Bowden, University of Bristol
    - Estimating treatment effects in the pharmaceutical arena using instrumental variable methods: from “academic” causal inference to the Estimand Framework via the CANTOS study
  - Panel discussion
  
The language used differed quite a bit from Miguel's talks the previous days.
Today was the language of "estimands". Link to the [pdf EMA addendum](https://www.ema.europa.eu/en/documents/scientific-guideline/draft-ich-e9-r1-addendum-estimands-sensitivity-analysis-clinical-trials-guideline-statistical_en.pdf) as well as the [FDA addendum](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/e9r1-statistical-principles-clinical-trials-addendum-estimands-and-sensitivity-analysis-clinical).

### Going beyond ITT effect (Miguel Hernán)
The first talk felt like a connection between the past two days into this more estimand-focused day.
The main point was that the industry is so fixated on ITT effects that it ignores other effects.
There are a large variety of RCTs that are analyzed the same.
ITT analysis is the estimator, while ITT effects are the estimand. Often the primary estimand.
One argument for this is that "the null is preserved", which Miguel claimed was not correct.
The claim was that we do not know which direction the ITT effect is biased.

  - Adherence to the drug does not remain the same once it is released.
  - Claims that patients are interested in PP effects (per-protocol effects)
    - Example: Doctor tells patient that drug has a 22% increase chance of death estimated from ITT effects. Patient ask: What is my increased chance of death if I DO adhere to the treatment? Well the PP effect is 66% increase.
  - Need an effect measure (a causal estimand) that needs to be adjusted for factors
  - Loss to follow up can cause selection bias

Everything done after randomization is observational. Can have post-randomization confounding and need to adjust for these confounders (otherwise bias)

ITT effect: point interventions
PP-effect: sustained treatment strategies

Need to use G-methods to adjust for post-randomization confounders.
We cannot show that the PP effect is unbiased.
We need a LOT of data to adjust for post-randomization confounding.

In Miguel's language, the target trial is essentially the estimand.
The intercurrent events in the estimand can (and should) be specified in the treatment policy/strategy.
Not all of the intercurrent effects are part of the treatment policy though.

References:
  - [Hernán MA, Hernández-Díaz S. Beyond the intention to treat in comparative effectiveness research. Clinical Trials 2012; 9(1):48-55. PMCID: PMC3731071](http://journals.sagepub.com/doi/abs/10.1177/1740774511420743)

### Instrumental variables - Jack Bowden

> Assumptions are how we buy information

  - IV Regression
  - Randomization in the **double blinded** trial IS an instrumental variable
  - Principal stratum
  - Monotonicity, hetergenity
  - Compliers, always-takers, never-takers, defiers (Don't want defiers for monotonicity.)

### Other notes
  - Target trial <-> estimand
  - Need to be explicit about our assumptions
  - Estands are different for different stakeholders
  - Intercurrent events should not necessarily be treated as missing data.
  - Hazard ratio cause problems (why?)
    - [Hernán MA. The hazards of hazard ratios. Epidemiology 2010; 21:13-15.](http://journals.lww.com/epidem/Fulltext/2010/01000/The_Hazards_of_Hazard_Ratios.4.aspx)


### Topics to read about
  - Multilevel propensity score matching
  - Depletion of suceptibles bias
  - Platform trials
  - regression discontinuity  
  - Principal stratum estimand/analysis (PSA)
    - Non-identifiable population?
  - IV regression
  - Restricted mean survival model, causal version of cox model (?)
