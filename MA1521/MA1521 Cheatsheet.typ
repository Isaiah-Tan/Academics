#import "@preview/physica:0.9.8": * 
#set page(
  paper: "a4",
  margin: (x: 8mm, y: 9mm),
)
#set text(size: 9.2pt)
#set par(justify: true)
#let sec(title) = {
  box(width: 100%)[
    #text(size: 11pt, weight: "bold")[#title]
    #v(1.5mm)
  ]
}
#let ssec(title) = {
  box(width: 100%)[
    #text(size: 9.2pt, weight: "bold")[#title]
    #v(1mm)
  ]
}

#align(center)[
  #text(size: 18pt, weight: "bold")[MA1521]
  #linebreak()
  #text(size: 12pt)[Calculus for Computing]
  #linebreak()
  #text(size: 8pt, fill: gray)[AY26/27 syllabus · 2-page cheat sheet]
]
#v(3mm)

#columns(2, gutter: 6mm)[
#sec("1. Vectors & preliminaries")
#ssec("Vector operations")
- Dot product: $a dot b = |a||b| cos theta$
- Cross product: $a times b = |a||b| sin theta \, n$, #linebreak() with  $a times b = (a_2 b_3-a_3 b_2, a_3 b_1-a_1 b_3, a_1 b_2-a_2 b_1)$
- Projection: $((a dot b)/(|b|)^2) b$ (projection of $a$ onto $b$)
- Unit vector: $hat(u)=u/(|u|)$
- Line/plane forms in $RR^3$

#ssec("Useful trig values")
#table(
  columns: 6,
  table.header[$theta$][$0$][$pi/6$][$pi/4$][$pi/3$][$pi/2$],
  [$sin theta$], [0], [$1/2$], [$sqrt(2)/2$], [$sqrt(3)/2$], [1],
  [$cos theta$], [1], [$sqrt(3)/2$], [$sqrt(2)/2$], [$1/2$], [0],
  [$tan theta$], [0], [$1/sqrt(3)$], [1], [$sqrt(3)$], [undef.],
)

#sec("2. Limits & continuity")
$lim_(x -> a) f(x)=L$ means $f(x)$ is close to $L$ for $x$ near $a$.

- If $f$ is differentiable at $a$, then $f$ is continuous at $a$.
- $lim_(x -> a) f(x)/g(x)$ may use L'Hôpital if $0/0$ or $oo/oo$.
- $lim_(x -> 0) (sin x/x)=1$, $lim_(x -> 0) (1+x)^(1/x)=e$
- $lim_(x -> oo) (1+1/x)^x = e$

#sec("3. Differentiation")
#ssec("General rules")
- $frac(d, d x) (f plus.minus g)=f' plus.minus g'$
- $frac(d, d x) (f g)=f' g + f g'$
- $frac(d, d x) (f/g)= (f'g - f g')/g^2$
- $frac(d, d x) (f(g(x))) = f'(g(x)) g'(x)$
- $frac(d, d x) (ln u)=u'/u$
- $frac(d, d x) (e^u)=e^u u'$
- Implicit differentiation: differentiate both sides and solve for $y'$.
- Log differentiation: if $y=f(x)^(g(x))$, take $ln$ first.

#ssec("Linearisation")
For single variable: $L(x)=f(a)+f'(a)(x-a)$.

For two variables: $L(x,y)=f(a,b)+f_x(a,b)(x-a)+f_y(a,b)(y-b)$.

#sec("4. Applications of derivatives")
- Critical points: $f'(x)=0$ or undefined.
- Increasing if $f'(x)>0$, decreasing if $f'(x)<0$.
- Local max/min by 1st/2nd derivative test.
- Concave up if $f''(x)>0$, concave down if $f''(x)<0$.
- Point of inflection: $f''(x)=0$ and sign change.
- Related rates: differentiate w.r.t. time.
- Tangent line: $y=f(a)+f'(a)(x-a)$

#sec("5. Integration basics")
#ssec("FTC + techniques")
$integral f(x) d x = F(x)+C$ iff $F'(x)=f(x)$.
$integral_a^b f(x) d x = F(b)-F(a)$

- Substitution: $integral f(g(x)) g'(x) d x = integral f(u) d u$
- Integration by parts: $integral u d v = u v - integral v d u$
- Partial fractions: decompose rational function into simpler terms.
- Decompose $P(x)/Q(x)$ by factoring denominator and solving coefficients.
- Definite integrals: area under curve; use symmetry where possible.

#sec("6. Sequences, series, power series")
- Sequence $a_n$ converges if $a_n -> L$.
- Geometric series: $sum_(n=0)^oo a r^n = a/(1-r)$ for $|r|<1$.
- Ratio test: $lim |a_(n+1)/a_n|<1$ implies convergence.
- Root test: $lim root(n, |a_n|)<1$ implies convergence.
- Power series: $sum_(n=0)^oo c_n (x-a)^n$
- Radius of convergence $R$ from ratio/root test.
- Maclaurin: $f(x)=sum_(n=0)^oo f^(n)(0)x^n/n!$

#ssec("Classic expansions")
$e^x = sum_(n=0)^oo x^n/n!$
$sin x = sum_(n=0)^oo (-1)^n x^(2n+1)/(2n+1)!$
$cos x = sum_(n=0)^oo (-1)^n x^(2n)/(2n)!$
$(1+x)^alpha = 1 + alpha x + alpha(alpha-1)x^2/2! + dots$

#sec("7. Functions of several variables")
For $z=f(x,y)$:
- Partial derivatives: $f_x=(∂f)/(∂x)$, $f_y=(∂f)/(∂y)$
- Gradient: $nabla f = (f_x, f_y)$
- Jacobian matrix for $F(x,y)=(u,v)$:
  $J = jmat(u, v; x, y;big:#true)$
- Chain rule: $d z / d t = f_x x'(t) + f_y y'(t)$
- Directional derivative: $D_u f = nabla f dot u$ for unit $u$.
- Tangent plane at $P(a,b,f(a,b))$:
  $z = f(a,b)+f_x(a,b)(x-a)+f_y(a,b)(y-b)$
- Normal line / plane: $nabla f(P)$ is normal; tangent plane is
  $nabla f(P) dot ((x,y,z)-P)=0$
- Inverse Jacobian: if $(x,y)=T(u,v)$, then
  $jmat(u, v; x, y;big:#true) = (jmat(x, y; u, v;big:#true))^(-1)$,
  provided the inverse map exists.
  Use this to convert derivatives between coordinate systems.

#ssec("Lagrange multipliers")
Optimize $f(x,y,z)$ subject to $g(x,y,z)=0$ by solving
$nabla f = lambda nabla g$ and $g=0$.
For 2 vars: solve $nabla f = lambda nabla g$, $g(x,y)=0$.

#sec("8. Multiple integrals & coordinate transforms")
#ssec("Double / triple integrals")
- Double integral: $∬_R f(x,y) d A$ over region $R$
- Triple integral: $∭_E f(x,y,z) d V$ over region $E$
- Reorder integration to match the region; use symmetry when possible.

#ssec("Transformations")
- Polar: $x = r cos theta$, $y = r sin theta$, $d A = r d r d theta$
- Cylindrical: $x = r cos theta$, $y = r sin theta$, $z = z$, $d V = r d r d theta d z$
- Spherical: $x = rho sin(phi.alt) cos(theta)$, $y = rho sin(phi.alt) sin(theta)$, $z = rho cos(phi.alt)$, $d V = rho^2 sin(phi.alt) d rho d phi.alt d theta$
- Use Jacobian for general transformations: $d A = |det J| d u d v$, $d V = |det J| d u d v d w$
- Use inverse Jacobian when transforming from $(x,y)$ to $(u,v)$, e.g. $J_(u,v) = (J_(x,y))^(-1)$.

#ssec("Examples of Jacobian")
- For $T(u,v)=(x,y)$: $J = jmat(x, y; u, v;big:#true)$
- Then $d A = |det J| d u d v$.
#linebreak()
#sec("Quick summary")
- Vectors: dot/cross products, projections, unit vectors.
- Differentiation: slopes, rates, linearisation, optimization.
- Integration: antiderivatives, techniques, area/volume.
- Series: geometric, power series, Taylor/Maclaurin approximations.
- Multivariable calculus: gradients, directional derivatives, Jacobians, constrained optimization.
- Multiple integrals: switch coordinates (polar, cylindrical, spherical) using Jacobians.
]
