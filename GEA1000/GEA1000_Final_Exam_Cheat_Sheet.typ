// Rebuilt from course_files_export.zip supplied by the user, reviewed 19 Nov 2026.
// Primary authority: GEA1000 lecture notes, dated 7 Aug 2026; Ch1–4 slides/solutions.
// E = Examplify Practice Paper; P1/P2 = Practice Sets 1/2 (with solutions).
// Coverage map (question references are revision provenance, not predictions):
// §1: Ch1 Q1–20; E1/E11; P1 Q2–3; P2 Q1–3.
// §2: Ch2 Q1–20; E12; P1 Q4/Q11; P2 Q7–10.
// §3: Ch3 Q1–10/Q19–20; E4/E7; P1 Q1/Q7/Q12; P2 Q2.
// §4: Ch3 Q11–20; E2/E6/E10; P1 Q5–6; P2 Q6/Q12.
// §5: E10/E12; P2 Q10 + supplied workbook; helper-column fallbacks added.
// §6: Ch4 Q1–10/Q18–19; E5/E8–9; P1 Q8–9; P2 Q4–5.
// §7–8: Ch4 Q11–20; E3/E8; P1 Q10; P2 Q11.
// Transfer drills are inferred variations of supplied questions, not exam promises.
// Circular 2 supersedes circular 1: 12 questions, 20 marks, 90 minutes, 21 Nov 2026.
// Follow course convention: reject only when p-value < alpha (equality: do not reject).
// Correct obvious source slips: zero-SD correlation undefined; Normal 95% uses ±1.96;
// count marginal/joint proportions by their actual conditioning, not a mistaken label.
// Keep original mathematical reasoning where answer keys contain typos.
// Compile: typst compile GEA1000_Final_Exam_Cheat_Sheet.typ
// Print layout: black ink on white, ruled headings, no coloured or shaded fills.

#set document(title: "GEA1000 · Course-based Final Exam Cheat Sheet")
#set page(paper: "a4", margin: (x: 6.5mm, top: 6mm, bottom: 7mm),
  footer: context text(size: 6pt, fill: black)[
    GEA1000 · AY26/27 · Supplied notes, chapter solutions & three practice papers
    #h(1fr) #counter(page).display() / 2
  ], footer-descent: 2.5mm)
#set text(font: "Libertinus Serif", size: 8.6pt, fill: black)
#set par(justify: false, leading: 0.32em, spacing: 4.2pt)
#show math.equation: set block(above: 2.5pt, below: 2.5pt)
#show raw: set text(font: "Consolas", size: 7.3pt)
#show raw.where(block: true): it => block(
  width: 100%, inset: 4pt, stroke: 0.4pt + black, breakable: false,
)[#it]
#set table(inset: 2pt, stroke: 0.4pt + black)
#show table.cell.where(y: 0): strong
#let section(title) = block(width: 100%, above: 6pt, below: 4pt,
  inset: (x: 0pt, y: 3pt), stroke: (top: 0.8pt + black, bottom: 0.35pt + black))[
  #text(font: "Arial", size: 9.3pt, weight: "bold", title)
]
#let banner(right) = [
  #text(size: 12pt, weight: "bold")[GEA1000 · FINAL] #h(1fr) #text(size: 8pt, right)
  #v(1pt) #line(length: 100%, stroke: 0.6pt) #v(1pt)
]

#banner[DESIGN · TABLES · NUMERICAL DATA]
#columns(3, gutter: 4mm)[
#section[1 · Sampling & study design]
*PPDAC:* Problem → Plan → Data → Analysis → Conclusion. Research question: estimate/test a population characteristic, compare groups, or investigate a relationship. EDA iteratively asks questions, plots/summarises, then reassesses.

*Population* = target group; *frame* = list/source from which recruitment is attempted; *sample* = observed participants. *Parameter* describes population; *statistic* describes sample. Frame is not automatically the respondents. All units included → census, *no sampling*; attempted census can have non-response.

#table(columns: (0.85fr, 2.05fr),
  [*Method*], [*Recognition / trap*],
  [SRS], [Every sample of fixed size equally likely; not merely equal individual chances.],
  [Systematic], [Random start in $1,…,k$, then every $k$th; start must cover *all* $k$ positions.],
  [Stratified], [Randomly sample within *every* stratum.],
  [Cluster], [Randomly choose some clusters, include all their members.],
)
Probability sampling gives every unit a known, nonzero selection chance. For $N=1000,n=100$: choose start 1–10 then every 10th. Six-sided die misses starts 7–10; every 6th but stopping at 100 misses the list’s tail. Both fail. Fixed starting point is not random. Watch periodicity.

*Non-probability:* convenience = available/first arrivals; volunteer = opt in; purposive = researcher chooses. Random invitations followed by low response remain probability sampling *with non-response*. “All were asked” does not mean all responded. Stratified with replacement can repeat units; each stratum still represented.

*Bias answer:* identify excluded/nonresponding group → why its outcome may differ → sample not representative. *Selection:* frame/availability misses people (target 15–65, frame 21+). *Non-response:* invited people decline/cannot be reached. *Response:* wording, memory, interview/instrument error. Full frame does not cure non-response. Large $n$ reduces random error, not bias.

*Experiment:* researcher assigns treatment, even by preference/weekend/surname; those rules are *not random assignment*. Observational = measures existing exposures. *Random assignment* uses chance, balances confounders on average, supports causation; *random sampling* supports generalisation. Unequal group sizes do not themselves bias rate comparisons. Expected subgroup count in treatment = subgroup total × treatment fraction.

*Placebo:* inactive lookalike, helps blind subjects. *Double-blind:* subjects and relevant researchers/assessors unaware of allocation. Control group enables comparison. Before/after improvement alone is not causal: natural change, time or other factors may explain it.

*Cohort:* classify exposure → follow outcomes; can estimate incidence/RR and several outcomes; costly, slow, loss to follow-up. *Case-control:* select cases/noncases → investigate past exposure; quicker, useful for rare/slow outcomes, recall/selection bias; use OR. Both observational; neither automatically causal. Stratification can address measured confounders in either.

#section[Exam format & revision priorities]
*Latest circular (2):* 21 Nov 2026, 90 minutes; 10×1-mark short questions + 2×5-mark longer questions, possibly spreadsheets/open-ended. One A4 sheet, both sides. Pivot tables/charts unavailable in provided spreadsheet practice. Submit *answers in text boxes*; spreadsheet workings alone are not graded. Check whether MRQ asks for *true* or *false* statements; distinguish “must” from “can”; obey % vs probability and rounding instructions.

*Combinations:* $binom(n,k)=n!/(k!(n-k)!)$; $0!=1$. Calculator: nCr. Counts all arrangements of k successes in n trials (binomial formula on page 2).

#colbreak()
#section[2 · Proportions, RR, OR & confounding]
“A *among* B” = $P(A|B)$; denominator is B. Fix *outcome, baseline, subgroup* before calculating.
#table(columns: (1.25fr, 1fr, 1fr),
  [], [Outcome +], [Outcome −],
  [Exposed $E$], [$a$], [$b$],
  [Baseline $B$], [$c$], [$d$],
)
For $N=a+b+c+d$: joint $P(E inter O)=a/N$; marginal $P(O)=(a+c)/N$; conditional $P(O|E)=a/(a+b)$. Missing cells: subtract known counts from row/column totals; a given proportion × its denominator supplies a count.

$ p_E=a/(a+b), quad p_B=c/(c+d) $
$ "RR"=p_E/p_B, quad "OR"=(a/b)/(c/d)=(a d)/(b c) $
*Risk* = successes / all; *odds* = successes / failures = $p/(1-p)$. Conversely $p="odds"/(1+"odds")$. RR/OR > 1, = 1, < 1 → positive, no, negative association for the named exposure/outcome. OR describes *times the odds*, not times as likely. Case-control sample proportions cannot directly estimate incidence/RR.

RR = 0.4 → 40% *of* baseline risk, 60% lower risk. Relative increase = $("RR"-1)100%$; reduction = $(1-"RR")100%$. Absolute change = $(p_E-p_B)100$ *percentage points*. 20% vs 10%: twice the risk, 100% higher, +10 points.

*Reverse questions:* baseline risk = exposed risk / RR; count = risk × group total. Swap reference → reciprocal RR/OR. Complement the *outcome* → OR reciprocal, but new RR = $(1-p_E)/(1-p_B)$, generally not old RR’s reciprocal.

*Association proof:* compare the *same outcome* across complementary explanatory groups, e.g. $P(O|E)$ vs $P(O|E^c)$. Comparing $P(O|E)$ with $P(O^c|E)$ proves nothing about association. Larger percentage need not mean larger count; group totals needed. If $P(A|B)=P(A)$, then also $P(A|B^c)=P(A)$ (positive group sizes).

*Confounder test for Z (course rule):* show *both* $Z$–$X$ and $Z$–$Y$ associations. Sufficient evidence:
$ P(Z|X) != P(Z|X^c) $
$ P(Y|Z) != P(Y|Z^c) $
Write both numerical pairs then conclude. Association with only one fails. Re-evaluate when which variable is the candidate changes. Example: age vs teaching hours $7/12 != 1/4$; poor sleep vs age $7/8 != 2/8$ → age is a confounder.

*Simpson:* common subgroup trend reverses or *disappears* when pooled. Sum cell counts first, then divide; never average rates or ORs unweighted. Different subgroup weights explain reversal. Confounder does *not* guarantee Simpson; no Simpson does *not* exclude confounding. In course questions, Simpson by slicing Z implies Z is a confounder.

*Unclassified records:* subtract male + female cell counts from overall to recover unknowns; unknown % = unknown total / original total. If asked to pool *classified only*, exclude unknowns from *both* numerator and denominator. P1: drug $50/105<50/90$ control although drug better within each sex.

*Unknown-count Simpson questions:* express subgroup and pooled rates in x; impose *both* common subgroup direction and opposite/no pooled association, then intersect with feasible integer counts. Ch2 Q15: subgroup RR $8/x<1$ and pooled RR $82/(19+x)>=1$ give $8<x<=63$, so integers 9–63. Subgroup RR/ORs alone do not determine pooled association without group counts.

*Sources:* 7 Aug 2026 lecture notes, chapter 1–4 slides/solutions. E = Examplify Practice Paper; P1/P2 = Practice Sets 1/2, with solutions and P2 workbook. Examples come from these; procedures apply to changed numbers.

*Transfer drills (inferred, not confirmed questions):* change baseline/outcome; recover missing cells; solve unknown count for Simpson; alter recoding boundary; compare individual/group correlations; reverse diagnostic table; recover CI endpoints; infer p-value bounds from decisions at two significance levels.

#colbreak()
#section[3 · Numerical data & graph traps]
Categorical: *nominal* (yes/no, sex, postcode/phone labels); *ordinal* (age bands, satisfaction 1–5). Numerical: counts/discrete or measurements/continuous. Age measured numerically differs from age categories. A *percentage per country* is numerical; it need not rank absolute counts. Follow how a score is treated in the analysis. $ln(X)=15.71$ means $X=e^15.71$, not 15.71.

$ overline(x)=(sum x_i)/n, quad s^2=(sum (x_i-overline(x))^2)/(n-1) $
$ s=sqrt(s^2), quad overline(x)_"pool"=(sum n_j overline(x)_j)/(sum n_j) $
Median = middle sorted observation (mean of middle pair for even $n$); mode = most frequent. Pooled mean between subgroup means; average means only if group sizes equal. Subgroup medians do not determine pooled median. Below mean ≠ below half the class; mean above pass mark ≠ everyone passed.

*Spread:* range = max − min; IQR = $Q_3-Q_1$; $"CV"=s/overline(x)$ (×100% if requested). SD has original units, variance squared units; SD = 0 iff all equal. Same mean: more mass far from mean → larger SD. For positive means, lower SD plus larger mean guarantees lower CV.

*Transform* $W=u+v X$: mean/median follow transformation; SD, IQR, range × $abs(v)$; variance × $v^2$. Shift leaves spread unchanged. Negative scaling reverses order ($Q_1(W)=u+v Q_3(X)$). SD doubling allows $v=±2$, not only +2. Positive pure scaling leaves CV unchanged; negative pure scaling flips signed CV; adding a constant generally changes CV.

*Five-number summary:* min, $Q_1$, median, $Q_3$, max. Fences $Q_1-1.5"IQR"$, $Q_3+1.5"IQR"$; values *strictly beyond* flagged. Modified whiskers reach extreme non-outlier observations, not fences or necessarily min/max. Ties mean “at least” rather than exactly 25%/50%. Median need not equal $(Q_1+Q_3)/2$ (mid-hinge). Mid-range = (min + max)/2. Mid-range = max implies all values equal.

*Quartiles by hand (course method):* sort values; find median; split into lower/upper halves. For odd n, *exclude* the overall median from both halves. $Q_1$ = median of lower half; $Q_3$ = median of upper half. Software conventions may differ.

*Remove a single extreme outlier:* mean moves away from it, range/SD decrease in the supplied question’s setting; median can change; IQR can increase/decrease/stay. Resistant ≠ invariant. Removing an arbitrary observation need not decrease SD.

*Shape:* right skew = long right tail, mean often > median; left skew converse. Not a universal mean/median theorem. Mean + SD for symmetric data; median + IQR for skew/outliers.

*Graphs:* bar = categories; histogram = numerical distribution; scatter = paired numerical values; boxplot = quartiles/spread/outliers. Boxplot alone gives no exact mean, SD, modes or $n$. Same boxplot ≠ same data/SD/pass rate. Frequency histograms on common scales can compare distributions *and counts*; density/percentage histograms hide $n$. Unequal histogram bins: frequency ∝ *area*. Match histogram/boxplot by median, IQR, tails, range and outliers, not appearance alone.

*Small-data reasoning:* 3 values, unique mode, mean < mode → $(a,b,b)$ with $a<b$. Then $a<(a+2b)/3<b=$ median = mode. Drawing strictly below any of the three summaries wins only on $a$: probability $1/3$.

#section[Tail lookups · if numerical p is requested]
Normal/t null CDF F: lower p = F(statistic); upper = 1−F(statistic); two-sided = $2[1-F(abs("statistic"))]$. Lower CDFs: `=NORM.S.DIST(Z2,TRUE)` or `=T.DIST(T2,D2,TRUE)` (D2 = df). Chi-squared upper p: `=CHISQ.DIST.RT(X2,D2)`.

Binomial K2 successes, N2 trials, P2 null chance: lower p `=BINOM.DIST(K2,N2,P2,TRUE)`; upper p `=1-BINOM.DIST(K2-1,N2,P2,TRUE)`. Calculator/table equivalents also work. Exact binomial two-sided p follows the specified test convention; do not automatically double a one-sided p.
]

#pagebreak()
#banner[REGRESSION · SPREADSHEETS · PROBABILITY · INFERENCE]
#columns(3, gutter: 4mm)[
#section[4 · Correlation & regression]
Pearson $r$ measures *linear* association; $-1<=r<=1$. Use $abs(r)$ for strength: course guide ≈ 0–0.3 weak, 0.3–0.7 moderate, 0.7–1 strong. $r=0$ allows nonlinear association. $r=±1$ means all points on a nonhorizontal/nonvertical line; zero SD → undefined.

$ r=1/(n-1) sum ((x_i-overline(x))/s_x)((y_i-overline(y))/s_y) $
Unitless; swapping X/Y or shifting leaves $r$ unchanged. Positive scaling unchanged; negate one axis → sign flips, both → unchanged. Marginal dotplots/histograms do not preserve pairing, so cannot determine $r$. Adding/removing an outlier can strengthen, weaken or leave $r$ unchanged; if all remaining points lie on the same perfect line, $r$ stays ±1.

*Regression predicts Y from X:*
$ hat(y)=overline(y)+r(s_y/s_x)(x-overline(x))=a+b x $
$ b=r s_y/s_x, quad a=overline(y)-b overline(x) $
Slope = predicted Y change per X-unit; sign matches $r$. Intercept = predicted Y at X=0. Passes through $(overline(x),overline(y))$. Residual = actual − predicted. Use within observed X-range; outside is extrapolation. Prediction is not an exact observed value. Do not algebraically invert to predict X; reverse slope $r s_x/s_y$ (same sign), not generally $1/b$. Same regression line need not mean same $r$.

*Recode/transform:* $y=2^(x+1)-1=2X-1$ for $X=2^x$; linear in transformed X, not in original x. Undo log transforms with exponentials.

*Paired before/after plots:* read axis labels first. Above $y=x$ means Y > X; below means Y < X. With X=before,Y=after, above = gain; swapping axes reverses interpretation. Different vertical gaps = unequal changes. Equal-scale perpendicular distance = $abs(y-x)/sqrt(2)$. All points on one side, or nonoverlapping X/Y ranges, do not determine sign/strength of $r$. Four rectangle corners give $r=0$ despite all Y > X. Improvement alone does not establish treatment effect.

*Ecological:* group-mean relationship → individual claim. *Atomistic:* individual relationship → group claim. Compute correlation of grouped means separately from all paired rows. Negative subgroup slopes *alone* do not determine pooled $r$; *if Simpson explicitly given*, pooled $r>=0$ (positive subgroup trends → pooled $r<=0$).

#section[5 · Spreadsheet: numerical tasks]
Use formulas, not pivot tables/charts (unavailable in supplied Examplify practice). Preserve paired row order; exclude headings; use all individuals for individual correlation, *one mean per group* for ecological correlation. Combine disjoint group columns into two aligned columns first.

`=AVERAGE(B2:B16)`; `=STDEV.S(B2:B16)`
`=CORREL(B2:B16,C2:C16)`
`=MEDIAN(B2:B16)`; `=SQRT(D2)`

Grouped means: `=AVERAGEIF(A2:A16,"Hibiscus",B2:B16)`; fallback: calculate each group’s sum / count. E10: hibiscus mean 1.232; $r_"means"=0.89$ vs $r_"individual"=0.69$. Round at end, keep precision for intermediate calculations.

#section[8 · Test statistics & tails]
Mean: $t=(overline(x)-mu_0)/(s/sqrt(n))$, df $n-1$. Proportion: $z=(hat(p)-p_0)/sqrt(p_0(1-p_0)/n)$; test SE uses *null* $p_0$, CI uses $hat(p)$. Chi-squared expected cell count = row total × column total / N; $chi^2=sum (O-E)^2/E$, df = (rows−1)(columns−1).

*Binomial tails:* fixed n, independent binary trials, constant null $p_0$; $P(X=k)=binom(n,k)p_0^k(1-p_0)^(n-k)$. Greater → sum observed through n; less → 0 through observed. Include ties and *all arrangements*. Two blue in 3: BBR, BRB, RBB, BBB for upper tail. Four wins/5: 4 or 5 wins, equivalently 1 or 0 losses. Simulation p ≈ fraction of null simulations at least as extreme.

#colbreak()
#section[5 · Spreadsheet: recode & cross-tab]
P2 workbook columns: A = ID, B = Dinner_Group, C = Improved_Control, D = sleep hours; rows 2–31. B labels are “Early dinner” / “Late dinner”. Adapt ranges/labels for other datasets.

*New E2, copy down:*
`=IF(D2<7,"Short","Adequate")`
Exactly 7 is *Adequate*. For “at least 12” use `>=12`; “more than 12” uses `>12`.

*Early/Yes cell count:*
```text
=COUNTIFS(B$2:B$31,"Early dinner",
 C$2:C$31,"Yes")
```
Change labels for other cells. For a stratum, add its range/criterion pair. If a function is unavailable, use helper F2 and copy down:
```text
=IF(AND(B2="Early dinner",
 C2="Yes"),1,0)
```
Then `=SUM(F2:F31)`. One-condition count:
`=COUNTIF(B2:B31,"Early dinner")`
Use `$` to fix ranges when copying; numeric thresholds/text criteria in COUNTIF(S) use quotes, e.g. `"<7"`.

Build 2×2 counts → calculate RR/OR → build Z–X and Z–Y tables → compare conditional rates. For P2 Q10: Early Yes/No = 8/7, Late = 6/9; OR = $(8/7)/(6/9)=1.71$. Sleep–dinner: $8/15 != 9/15$ adequate; sleep–outcome: $7/14 != 10/16$ adequate → confounder. *Show both pairs*, not just “rates differ”.

#section[6 · Probability & diagnostic tables]
Outcome = one possible result; event = collection of outcomes (singleton also an event). Equally likely only: favourable / total. $P(A^c)=1-P(A)$.

$ P(A union B)=P(A)+P(B)-P(A inter B) $
$ P(A|B)=P(A inter B)/P(B) quad (P(B)>0) $
$ P(A inter B)=P(A|B)P(B) $
*Independent:* intersection = product, equivalently conditional = marginal. *Exclusive:* intersection = 0. With both probabilities positive, exclusive ⇒ dependent. $P(A)+P(B)>1$ rules out exclusivity; sum ≤ 1 does not establish it. If $A subset B$: union B, intersection A, $P(A)<=P(B)$.

Replacement → usual independent draws; without → update counts, but the unconditional second-draw colour probability remains its initial proportion in a random draw. For dice/coins enumerate *ordered* outcomes; conditions shrink sample space. “At least one” = 1 − none; independent trials: $1-(1-p)^n$.

*Mixtures / Bayes:*
$ P(A)=P(A|B)P(B)+P(A|B^c)P(B^c) $
$ P(B|A)=P(A|B)P(B)/P(A) $
Solve unknown mixture weight: $q=w q_1+(1-w)q_0$ ⇒ $w=(q-q_0)/(q_1-q_0)$. P2: $0.25=w(0.02)+(1-w)0.4$ ⇒ vaccinated 39.47%.

*Diagnostic table:* rows disease/no disease, columns +/−: TP/FN; FP/TN. Sensitivity = TP/(TP+FN); specificity = TN/(TN+FP); FNR = 1−sensitivity; FPR = 1−specificity. PPV = TP/(TP+FP); NPV = TN/(TN+FN). Prevalence = (TP+FN)/N. Pick convenient $N$, fill totals and work backwards when predictive value is given. Do not swap conditional directions.

*Bayes test formula:* prevalence $pi$, sensitivity $s_e$, specificity $s_p$:
$ P(D|+)=(s_e pi)/(s_e pi+(1-s_p)(1-pi)) $
*Reverse base rate:* PPV .60, sensitivity .90, specificity .99. Set 1000 positive: TP600, FP400. Diseased total $600/.9$; healthy total $400/.01$. Prevalence ≈1.64%, not 60%. A negative result uses FN/(FN+TN) for disease probability.

*Fallacies:* prosecutor = confuse $P(E|"innocent")$ with $P("innocent"|E)$; base rate = ignore prevalence; conjunction = think $P(A inter B)>P(A)$ or $P(B)$.

#colbreak()
#section[7 · Sampling & confidence intervals]
Sample statistic = population parameter + bias + random error (conceptually). *SD* describes individual spread; *SE* is SD of sampling distribution of statistic. Repeated random samples give different statistics even without bias. Parameter fixed; sample estimate varies.

$ "SE"(overline(x))=sigma/sqrt(n) approx s/sqrt(n) $
Sampling distribution of mean: centre $mu$, SE $sigma/sqrt(n)$. CLT: approximately Normal for sufficiently large independent samples; raw data need not become Normal. Sample small relative to population; finite variance assumed. Normal population → sample mean Normal for any n under independent sampling. Four times n → half SE. More simulation repetitions improve precision of simulated distribution, not original data quality.

*CI* = estimate ± multiplier × SE. Mean unknown SD: $overline(x) ± t^"*" s/sqrt(n)$, df $n-1$; known SD use $z^"*" sigma/sqrt(n)$. Proportion:
$ hat(p) ± z^"*" sqrt(hat(p)(1-hat(p))/n) $
Independent/appropriate random sampling; proportion Normal approximation needs sufficient successes/failures (usual rule ≥10 each); mean needs Normal population or large enough n without dominant outliers. Two-sided $z^"*"$: 90% 1.645; 95% 1.960; 99% 2.576. Normal: about 68/95/99.7% within 1/2/3 SD. Individual $z=(x-mu)/sigma$; mean standardises using SE instead.

*Reverse CI:* centre $m=(L+U)/2$; ME = $(U-L)/2$. Same sample, same symmetric method → centre unchanged, other bound $=2m-$ given bound. P1: (14.25,14.55) centre14.40 → new lower14.20 gives upper14.60. *Do not assume RR/OR CIs are symmetric on original scale.*

Higher confidence → wider (same data); larger n → narrower if variability/estimate and confidence held fixed. New random sample may differ. Divide ME by k → roughly multiply n by $k^2$.

*Interpret:* “95% confident that the population [parameter in context] lies between L and U.” Repeating method gives about 95% intervals covering *fixed parameter*, not exactly 95/100, not covering the earlier interval. No 95% chance for fixed parameter in observed interval; no population min/max, no 95% of individuals. Estimate at centre already known to be included. CI quantifies random error, not bias.

#section[8 · Tests: choice, tails & conclusions]
*Choose:* mean → t-test; one proportion → proportion test; two categorical variables → chi-squared association test. $H_0$: population mean/proportion = claimed value, or *no population association*. $H_1$: >, <, ≠, or association. Hypotheses concern population, not sample; baseline value is claim, not observed mean.

*Course rule:* p-value $<alpha$ → reject $H_0$; p-value $>=alpha$ → do not reject. Equality belongs to *do not reject*. Changing alpha does not change p-value. E.g. p=.03: reject at 5%, not at 1%.

*p-value:* probability under $H_0$ of observed statistic or one more favourable to $H_1$. Greater → upper tail; less → lower; different → both (use given method). It assumes null truth; it does not give null’s probability. See extreme-outcome examples in left column.

*Infer p-value bounds:* not rejected at 1% → $p>=.01$; rejected at 5% → $p<.05$. If both hold: $.01<=p<.05$. No exact p-value follows from a decision alone. P2: sample mean 6.6, null mean6, no rejection at 1% ⇒ insufficient evidence mean >6, *not* proof mean =6.

*Open-ended:* “At [alpha]% significance, there is [sufficient/insufficient] evidence to reject [population claim] in favour of [alternative in context].” Never accept/prove $H_0$. Sample proportions may differ even when population test is nonsignificant. p-value ≠ probability $H_0$ true, effect size or causal proof. Type I: reject true null; Type II: fail to reject false null. CI excludes 1 for RR/OR → evidence of association; excludes 0 for a difference → evidence of difference (matching test/method).

]
