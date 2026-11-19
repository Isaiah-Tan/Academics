// GEA1000 final exam reference: two A4 portrait pages.
// Self-contained; no packages, images, or external files are required.
// Requires Typst 0.13 or newer.
// Compile: typst compile GEA1000_Final_Exam_Cheat_Sheet.typ

#set document(title: "GEA1000 — Final Exam Cheat Sheet")
#set page(
  paper: "a4",
  margin: (x: 10mm, top: 10mm, bottom: 11mm),
  footer: context align(right)[
    #text(size: 6.5pt, fill: rgb("64748b"))[GEA1000 · #counter(page).display() / 2]
  ],
  footer-descent: 4mm,
)
#set text(font: "DejaVu Sans", size: 7.8pt, lang: "en")
#set par(justify: false, leading: 1.65pt, spacing: 3.4pt)
#set list(indent: 8pt, body-indent: 3pt, spacing: 1.7pt, tight: true)
#set table(inset: (x: 3pt, y: 3pt), stroke: 0.35pt + rgb("cbd5e1"))
#show math.equation: set text(font: "Latin Modern Math")
#show math.equation.where(block: true): set block(above: 2.5pt, below: 2.5pt)

#let ink = rgb("#000000")
#let pale = rgb("#ffffff")
#let section(title) = block(width: 100%, above: 5pt, below: 3pt, breakable: false)[
  #rect(width: 100%, fill: ink, stroke: none, inset: (x: 5pt, y: 3pt), radius: 2pt)[
    #text(size: 9pt, weight: "bold", fill: white)[#title]
  ]
]
#let eq(body) = block(width: 100%, fill: pale, inset: (x: 4pt, y: 2pt),
  above: 3pt, below: 3pt, radius: 2pt, breakable: false)[
  #text(size: 8.8pt)[#body]
]
#let label(body) = text(weight: "bold", fill: ink, body)
#let title(right) = [
  #grid(columns: (1fr, auto), align: (center),
    text(size: 14pt, weight: "bold", fill: ink)[GEA1000 · Final exam],
    text(size: 7.4pt, fill: ink)[#right],
  )
  #v(1pt)
  #line(length: 100%, stroke: 0.7pt + ink)
  #v(2pt)
]

// Fit both columns to the same font size on each page. All mathematics remains
// at 8.8 pt while the paragraph size is chosen to fit the available A4 height.
// The final scale is a safeguard for font substitutions on another computer.
#let fitted-page(left-body, right-body) = context {
  let column-width = 92mm
  let column-height = 260mm
  let styled(body, size) = [
    #set text(size: size)
    #set par(leading: 1.65pt * (size / 7.8pt))
    #body
  ]
  let chosen-size = 6.2pt
  for step in range(21) {
    let candidate = 8.2pt - step * 0.1pt
    let left-height = measure(styled(left-body, candidate), width: column-width).height
    let right-height = measure(styled(right-body, candidate), width: column-width).height
    if calc.max(left-height, right-height) <= column-height {
      chosen-size = candidate
      break
    }
  }
  let column(body) = block(width: column-width, breakable: false)[
    #styled(body, chosen-size)
  ]
  let left-column = column(left-body)
  let right-column = column(right-body)
  let max-height = calc.max(measure(left-column).height, measure(right-column).height)
  let factor = calc.min(1, column-height / max-height) * 100%
  grid(
    columns: (column-width, column-width), gutter: 6mm,
    scale(x: factor, y: factor, origin: top + left, reflow: true, left-column),
    scale(x: factor, y: factor, origin: top + left, reflow: true, right-column),
  )
}

#let data-left = [
  #section[1 · Data, sampling & study design]
  #label[PPDAC:] Problem → Plan → Data → Analysis → Conclusion.
  Define the question, population, variables and design; collect and analyse data; answer in context with limitations.

  #label[Population] = entire target group; #label[frame] = list/source from which units can be sampled; #label[sample] = observed units. A #label[parameter] describes a population; a #label[statistic] describes a sample. Rows are units; columns are variables.

  #label[Variables:] categorical = labels/groups (nominal or ordered); numerical = quantities (discrete counts or continuous measurements). A category coded by a number remains categorical. $X$ is explanatory/predictor; $Y$ is response/outcome.

  #label[Sampling methods]
  #table(
    columns: (0.8fr, 2fr),
    table.header([*Method*], [*How selected / key distinction*]),
    [Simple random], [Every subset of the specified size has equal chance.],
    [Systematic], [Random start in $1, dots, k$; then every $k$th unit. Periodic ordering is a risk.],
    [Stratified], [Randomly sample units from *every* stratum. Use population weights if needed.],
    [Cluster], [Randomly choose *some* clusters; include all their units. Clusters may differ.],
    [Convenience], [Choose the easiest available people.],
    [Volunteer], [People choose to participate (self-selection).],
  )
  Probability sampling gives each population unit a known, non-zero selection chance. For systematic sampling with step $10$, the random start must cover all $10$ positions; a six-sided die leaves some units unreachable.

  #label[Sample:] *Target population* = group of interest; *Sampling frame* = group that can be reached. A sample may be representative of the accessible population but not the target population.

  #label[Bias:] selection/undercoverage = frame or selection over-/underrepresents groups; non-response = respondents differ from those who do not respond; response/measurement = inaccurate answers or measurement. *Increasing sample size reduces random error; it does not remove bias.*

  #label[Study design:] a *controlled experiment* #underline[assigns] conditions; an *observational study* only observes existing exposures. Assignment by weekday, preference, etc. is not random assignment.

  #label[Random sampling] supports generalisation to the target population. #label[Random assignment] balances confounders on average and supports causal conclusions. A volunteer sample can be randomly assigned but still have limited generalisability. A placebo resembles active treatment; blinding reduces expectancy/assessment effects.

  #section[2 · Categorical data & confounding]
  #label[Read the denominator.] Joint proportion: count in both categories / all units. Conditional proportion: count in both / units in the *given* category. Compare within-group outcome rates when group sizes differ.

  #table(
    columns: (1.65fr, 1fr, 1fr), align: (left, center, center),
    table.header([], [*Outcome*], [*No outcome*]),
    [Exposed / treatment], [$a$], [$b$],
    [Baseline / control], [$c$], [$d$],
  )
  #eq[$
    p_E = frac(a, a+b), quad p_B = frac(c, c+d)
  $]
  #eq[$
    "RR" = frac(p_E, p_B), quad
    "OR" = frac(a/b, c/d) = frac(a d, b c)
  $]
  Risk = outcome / group total; odds = outcome / no outcome.
  RR or OR $=1$: no association; $>1$: higher risk/odds in exposed; $<1$: lower risk/odds. Reversing the baseline takes the reciprocal. RR $<1$ gives $(1-"RR") times 100%$ lower *risk*. RR $>1$ gives $("RR"-1) times 100%$ higher risk. OR describes *odds*, not risk.

  #label[Which measure?] Cohort/follow-up data permit risks and RR. Case-control studies select by outcome, so sample outcome proportions do not estimate population risks; use OR. For rare outcomes OR approximates RR.

  #label[Confounder:] a third variable associated with both $X$ and $Y$, potentially distorting their association. Show both associations with appropriate conditional proportions. Being associated with only one is insufficient.

  #label[Simpson’s paradox:] a pooled association disappears or reverses relative to the pattern within subgroups. Calculate subgroup and pooled rates; pooled rates are weighted by group sizes. Different subgroup composition can drive the result. Confounding need not produce Simpson’s paradox.
]

#let data-right = [
  #section[3 · Numerical summaries & graphs]
  #label[Describe:] shape (peaks/skew), centre, spread, outliers. Right skew has a long right tail, usually mean $>$ median; left skew usually mean $<$ median. These orderings are tendencies, not universal rules. Use mean + SD for roughly symmetric data; median + IQR for skew/extremes.

  #eq[$
    bar(x) = frac(sum_(i=1)^n x_i, n), quad
    bar(x)_"pooled" = frac(sum_j n_j bar(x)_j, sum_j n_j)
  $]
  Total $= n bar(x)$. The pooled mean lies between subgroup means; simply averaging means requires equal group sizes. Subgroup medians and sizes generally do not determine the pooled median.

  #label[Median:] order data; take the middle value, or average the two middle values for even $n$. #label[Mode:] most frequent value; need not be unique.

  #eq[$
    s^2 = frac(sum_(i=1)^n (x_i-bar(x))^2, n-1), quad s = sqrt(s^2)
  $]
  SD is non-negative, equals zero iff all values are equal, and has the data’s units (variance has squared units). More mass far from the mean increases spread; range alone does not rank SD reliably. A high extreme pulls the mean upward; a low extreme pulls it downward.

  #eq[$
    "IQR" = Q_3-Q_1, quad "range" = x_"max"-x_"min"
  $]
  Outlier fences: $Q_1-1.5"IQR"$ and $Q_3+1.5"IQR"$; flag values strictly outside. Median and IQR are resistant, but can change when an outlier is removed. Quartile algorithms can differ for small samples.

  #eq[$ "CV" = frac(s, bar(x)) $]
  CV measures relative spread, is unitless, and is most meaningful for positive ratio-scale quantities; the mean must be non-zero.

  #label[Transform every value:] for $y_i = a+b x_i$,
  #eq[$
    bar(y)=a+b bar(x), quad s_y=abs(b)s_x
  $]
  Median transforms as $a+b times "median"(X)$; IQR and range multiply by $abs(b)$. Adding a constant leaves spread unchanged.

  #label[Choose a graph]
  #table(
    columns: (1fr, 1.7fr),
    [*Data / purpose*], [*Graph / what it shows*],
    [One categorical], [Bar chart: counts or proportions.],
    [Two categorical], [Segmented bars: conditional proportions; compare matching segments.],
    [One numerical], [Histogram: shape, centre, spread; bin widths affect appearance.],
    [Numerical by group], [Side-by-side boxplots: median, quartiles, spread, flagged outliers.],
    [Two numerical], [Scatterplot: direction, form, strength, unusual points.],
  )
  Standard boxplots do *not* show the mean. Whiskers usually end at the most extreme non-outliers; separately plotted points may be the true minimum/maximum. Match histograms to boxplots using median, IQR, tails and outliers.

  #section[4 · Correlation & linear regression]
  #eq[$
    r = frac(1, n-1) sum_(i=1)^n
      lr((frac(x_i-bar(x), s_x))) lr((frac(y_i-bar(y), s_y)))
  $]
  $-1 <= r <= 1$. $r$ measures *linear* association. Sign = direction; $abs(r)$ = strength. $r=0$ allows a nonlinear relationship; $r=plus.minus 1$ means all points lie on a straight line (with non-zero SDs). Correlation is unitless, unchanged by swapping $X,Y$, shifts, or positive rescaling; negative rescaling of one variable flips its sign. Outliers can strongly change $r$.

  #eq[$
    hat(y)=a+b x, quad b=r frac(s_y,s_x), quad a=bar(y)-b bar(x)
  $]
  #eq[$
    hat(y)=bar(y)+r frac(s_y,s_x)(x-bar(x)), quad e=y-hat(y)
  $]
  Slope $b$: predicted change in $Y$ for each unit increase in $X$. Intercept $a$: prediction at $X=0$, if meaningful. The line passes through $(bar(x),bar(y))$. Residual $e$ is observed minus predicted. Use interpolation; extrapolation beyond observed $X$ can fail. Reversing axes generally gives a different regression.

  #label[Paired before/after plot:] with $x=$ before and $y=$ after, above $y=x$ means increase; below means decrease; vertical distance is the change $y-x$. Correlation describes association, not amount of improvement or causation. Even without a programme effect, individual changes can occur naturally.

  #label[Fallacies:] ecological = group-level association applied to individuals; atomistic = individual-level association applied to groups. Aggregating groups can change/reverse $r$; subgroup slopes alone do not determine the pooled correlation. Association alone does not establish causation.

]

#let inference-left = [
  #section[5 · Probability rules]
  $A^c$ is the complement; $inter$ means “and”; $union$ means “or”.
  $0 <= P(A) <= 1$; $P(S)=1$. For equally likely outcomes, probability = favourable outcomes / total outcomes. An intersection is a subset of either event, so $P(A inter B) <= P(A)$.

  #eq[$
    P(A^c)=1-P(A) \
    P(A union B)=P(A)+P(B)-P(A inter B)
  $]
  #label[Conditional probability:] restrict the denominator to what is given. Read $P(A mid(|) B)$ as “probability of $A$, given $B$”.
  #eq[$
    P(A mid(|) B)=frac(P(A inter B),P(B)), quad P(B)>0 \
    P(A inter B)=P(A mid(|) B)P(B)
  $]
  In a finite equally likely sample, $P(A mid(|) B)=frac("count"(A inter B),"count"(B))$. Translating “among those with $B$” means condition on $B$. Generally $P(A mid(|) B) != P(B mid(|) A)$.

  #label[Mutually exclusive:] events cannot occur together, so $P(A inter B)=0$ and their union probabilities add.

  #label[Independent:] knowing one event does not change the probability of the other.
  #eq[$
    P(A inter B)=P(A)P(B) \
    P(A mid(|) B)=P(A) quad (P(B)>0)
  $]
  Positive-probability mutually exclusive events are dependent. For independent events, intersections may be non-zero. Replacement with fresh random draws gives independence; without replacement, update the remaining counts. Conditional independence given $C$ means
  $P(A inter B mid(|) C)=P(A mid(|) C)P(B mid(|) C)$; it need not imply unconditional independence.

  #label[Total probability:] split into disjoint groups covering all outcomes.
  #eq[$
    P(A)=P(A mid(|) B)P(B)+P(A mid(|) B^c)P(B^c)
  $]
  For more groups, sum $P(A mid(|) B_j)P(B_j)$. This is a weighted average, not an unweighted average of the conditional probabilities.

  #label[Bayes’ rule:] reverse the conditional using the base rates.
  #eq[$
    P(B mid(|) A)=frac(P(A mid(|) B)P(B),P(A))
  $]
  #label[Base rate fallacy:] ignoring the prevalence of the condition. #label[Prosecutor’s fallacy:] confusing $P("evidence" mid(|) "innocent")$ with $P("innocent" mid(|) "evidence")$.

  #section[6 · Diagnostic tests]
  Let $D$ = disease, $+$ = positive test, $-$ = negative test, and $pi=P(D)$ = prevalence.
  #table(
    columns: (1.2fr, 1.35fr, 1.15fr),
    table.header([*Rate*], [*Condition / denominator*], [*Complement*]),
    [Sensitivity], [$P(+ mid(|) D)$], [False negative: $1-"Se"$],
    [Specificity], [$P(- mid(|) D^c)$], [False positive: $1-"Sp"$],
  )
  #eq[$
    P(D mid(|) +)=frac("Se" times pi,
      "Se" times pi+(1-"Sp")(1-pi))
  $]
  #eq[$
    P(D mid(|) -)=frac((1-"Se")pi,
      (1-"Se")pi+"Sp"(1-pi))
  $]
  Sensitivity/specificity alone do not give the probability of disease after a result. *Frequency method:* choose a large total, split by prevalence, apply sensitivity to diseased people and specificity to non-diseased people, then divide by the relevant test-result total.

  #section[7 · Counts & tail events]
  For $n$ independent trials with constant success chance $p$,
  #eq[$
    P(X=k)=binom(n,k)p^k(1-p)^(n-k)
  $]
  $binom(n,k)=frac(n!,k!(n-k)!)$ counts arrangements. “At least $k$” includes $k,k+1,dots,n$; “at most $k$” includes $0,dots,k$. For “at least one”, use $1-P(X=0)$. Continuous probabilities are areas; any exact single value has probability zero.
]

#let inference-right = [
  #section[8 · Sampling distributions & Normal]
  A sampling distribution describes a statistic over repeated samples of fixed size. SD describes variation of individual values; *SE* describes sample-to-sample variation of an estimate.
  #eq[$
    E(bar(X))=mu, quad "SE"(bar(X))=frac(sigma,sqrt(n))
  $]
  Estimate the mean’s SE with $s/sqrt(n)$ when $sigma$ is unknown. For independent observations, the CLT makes $bar(X)$ approximately Normal for sufficiently large $n$, even if the population is not Normal. The *raw data* do not become Normal as $n$ grows.

  #eq[$
    z_"individual"=frac(x-mu,sigma), quad
    z_"mean"=frac(bar(x)-mu,sigma/sqrt(n))
  $]
  A $z$-score is signed distance in the relevant SD units; it is not a probability. For a Normal distribution, about 68%, 95%, 99.7% lie within 1, 2, 3 SDs of the mean. Use the relevant Normal tail/area for probability.

  #eq[$
    frac("SE"_2,"SE"_1)=sqrt(frac(n_1,n_2))
  $]
  Four times the sample size halves SE; to divide SE by $k$, multiply $n$ by $k^2$. These comparisons hold for unchanged underlying variability/design.

  #section[9 · Confidence intervals (CI)]
  #eq[$
    "CI" = "estimate" plus.minus "ME" \
    "ME" = "critical value" times "SE", quad "width"=2"ME"
  $]
  #table(
    columns: (1.35fr, 1.8fr),
    table.header([*Parameter / situation*], [*Confidence interval*]),
    [Mean, $sigma$ known], [$bar(x) plus.minus z^* frac(sigma,sqrt(n))$],
    [Mean, $sigma$ unknown], [$bar(x) plus.minus t^*_(n-1) frac(s,sqrt(n))$],
    [Proportion, large sample], [$hat(p) plus.minus z^* sqrt(frac(hat(p)(1-hat(p)),n))$],
  )
  $hat(p)$ is the sample proportion (notes use $p^*$). Mean $mu$ and population proportion $p$ are parameters. $t^*$ depends on confidence and degrees of freedom $n-1$.

  #table(
    columns: (1fr, 1fr, 1fr, 1fr), align: center,
    [*Confidence*], [90%], [95%], [99%],
    [$z^*$], [1.645], [1.960], [2.576],
  )
  Higher confidence → wider interval. Larger $n$ → narrower interval at fixed confidence and variability; CI quantifies random error, not bias. For symmetric interval $[L,U]$, centre $=(L+U)/2$ and ME $=(U-L)/2$; changing confidence for the same sample preserves the centre.

  #label[Interpretation:] “We are 95% confident that the population [parameter] is between $L$ and $U$.” In repeated sampling, about 95% of intervals made by this procedure contain the fixed parameter. A realised interval either covers it or does not; 95% is not the probability assigned to that fixed interval. CI does not give the population’s data range or the percentage of individuals inside it.

  #section[10 · Hypothesis tests]
  Define the population parameter. State equality in $H_0$ and choose $H_a$ from the research claim *before* seeing results:
  #eq[$
    H_0: mu=mu_0 \
    H_a: mu>mu_0, quad mu<mu_0, quad "or" quad mu != mu_0
  $]
  #label[p-value:] probability, *assuming $H_0$*, of a statistic as extreme as or more extreme than observed in the direction(s) of $H_a$. It is neither $P(H_0 " is true")$ nor effect size. Choose the tail(s) from $H_a$; include the observed value for discrete data.

  #eq[$
    t=frac(bar(x)-mu_0,s/sqrt(n)), quad "df"=n-1
  $]
  For an upper-tailed test, include observed and larger values; for a lower-tailed test, observed and smaller values. Two-sided tests include extremes in both directions under the chosen test.

  #table(
    columns: (0.75fr, 2fr),
    [$p_"value" <= alpha$], [*Reject* $H_0$; sufficient evidence for $H_a$.],
    [$p_"value" > alpha$], [*Fail to reject* $H_0$; insufficient evidence for $H_a$.],
  )
  Failure to reject does not prove $H_0$: sampling variation or limited power can hide a real difference. Example: failing to reject $mu=6$ against $mu>6$ means insufficient evidence that the mean exceeds 6; it does not show the mean is exactly 6.

  #label[Errors:] Type I = reject a true $H_0$ (controlled by $alpha$); Type II = fail to reject a false $H_0$ (probability $beta$); power $=1-beta$. Smaller $alpha$ generally raises Type II risk at fixed design; larger $n$ generally increases power.

  #label[Finish every answer:] identify the denominator/baseline, give units and requested rounding, state the conclusion in context, and match generalisation/causation claims to the sampling and study design.

]

#title[Data & analysis]
#fitted-page(data-left, data-right)

#pagebreak()
#title[Probability & inference]
#fitted-page(inference-left, inference-right)