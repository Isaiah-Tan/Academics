#import "@preview/physica:0.9.8": *
#set page(
  paper: "a4",
  margin: (x: 8mm, y: 9mm),
)
#set text(size: 9.2pt)
#set par(justify: false)
#show math.equation.where(block: true): set block(above: 0.5em, below: 0.5em)
#let sec(title) = block(
  width: 100%, above: 2mm, below: 1mm, sticky: true,
  inset: (bottom: 0.8mm),
)[#text(size: 11pt, weight: "bold")[#title]]
#let ssec(title) = block(
  width: 100%, above: 1.5mm, below: 0.7mm, sticky: true,
  inset: (bottom: 0.8mm),
)[#text(size: 9.2pt, weight: "bold")[#title]]

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
- Dot product: $arrow(a) dot arrow(b) = norm(arrow(a)) norm(arrow(b)) cos theta$
- Cross product: $arrow(a) times arrow(b) = norm(arrow(a)) norm(arrow(b)) sin theta \, hat(n)$; $hat(n)$ follows the right-hand rule.
  $ arrow(a) times arrow(b) = ⟨a_2 b_3-a_3 b_2, a_3 b_1-a_1 b_3, a_1 b_2-a_2 b_1⟩ $
- Projection onto $arrow(b) != arrow(0)$: $frac(arrow(a) dot arrow(b), norm(arrow(b))^2) arrow(b)$
- Unit vector: $hat(u)=frac(arrow(u), norm(arrow(u)))$, $arrow(u) != arrow(0)$.

#ssec("Lines & planes")
$arrow(p)=⟨x_0,y_0,z_0⟩$, $arrow(r)=⟨x,y,z⟩$, $arrow(v)=⟨v_1,v_2,v_3⟩ != arrow(0)$.
- Line (vector): $arrow(r)=arrow(p)+t arrow(v)$, $t in RR$.
- Parametric: $x=x_0+t v_1$, $y=y_0+t v_2$, $z=z_0+t v_3$.
- Symmetric: $frac(x-x_0,v_1)=frac(y-y_0,v_2)=frac(z-z_0,v_3)$.
  If $v_i=0$, replace its fraction by the fixed coordinate.
- Plane (point-normal): $arrow(n) dot (arrow(r)-arrow(p))=0$, $arrow(n)=⟨A,B,C⟩ != arrow(0)$.
- Cartesian: $A x+B y+C z=D$, $D=arrow(n) dot arrow(p)$.
- Intercept: $frac(x,a)+frac(y,b)+frac(z,c)=1$ ($a b c != 0$).
- Parametric: $arrow(r)=arrow(p)+s arrow(u)+t arrow(v)$, $arrow(n)=arrow(u) times arrow(v) != arrow(0)$.
- Through $arrow(p),arrow(q),arrow(r)_0$: $arrow(n)=(arrow(q)-arrow(p)) times (arrow(r)_0-arrow(p))$,
  $arrow(n) dot (arrow(r)-arrow(p))=0$ ($arrow(n) != arrow(0)$).

#ssec("Useful trig values")
#table(
  columns: 6,
  align: center,
  inset: (x: 4pt, y: 5pt),
  table.header[$theta$][$0$][$pi/6$][$pi/4$][$pi/3$][$pi/2$],
  [$sin theta$], [0], [$1/2$], [$sqrt(2)/2$], [$sqrt(3)/2$], [1],
  [$cos theta$], [1], [$sqrt(3)/2$], [$sqrt(2)/2$], [$1/2$], [0],
  [$tan theta$], [0], [$1/sqrt(3)$], [1], [$sqrt(3)$], [undef.],
)

#sec("2. Limits & continuity")
$lim_(x -> a) f(x)=L$ means $f(x)$ is close to $L$ for $x$ near $a$.

- If $f$ is differentiable at $a$, then $f$ is continuous at $a$.
- L'Hôpital: for $0/0$ or $oo/oo$, $lim frac(f(x), g(x)) = lim frac(f'(x), g'(x))$ if $f,g$ are differentiable nearby, $g' != 0$, and the latter limit exists (possibly infinite).
- $lim_(x -> 0) (sin x/x)=1$, $lim_(x -> 0) (1+x)^(1/x)=e$
- $lim_(x -> oo) (1+1/x)^x = e$

#sec("3. Differentiation")
#ssec("General rules")
- $frac(dif, dif x) (f plus.minus g)=f' plus.minus g'$
- $frac(dif, dif x) (f g)=f' g + f g'$
- $frac(dif, dif x) (f/g)= frac(f'g - f g', g^2)$
- $frac(dif, dif x) f(g(x)) = f'(g(x)) g'(x)$
- $frac(dif, dif x) ln |u|=frac(u', u)$, $u != 0$.
- $frac(dif, dif x) e^u=e^u u'$
- Implicit differentiation: differentiate both sides and solve for $y'$.
- Log differentiation: $y=f(x)^(g(x))$, $f(x)>0$; use $ln y=g(x) ln f(x)$.

#ssec("Linearisation")
For single variable: $L(x)=f(a)+f'(a)(x-a)$.

For two variables: $L(x,y)=f(a,b)+f_x(a,b)(x-a)+f_y(a,b)(y-b)$.

#sec("4. Applications of derivatives")
- Critical points: interior points in the domain where $f'=0$ or $f'$ is undefined. Check endpoints for absolute extrema.
- Increasing if $f'(x)>0$, decreasing if $f'(x)<0$.
- At $f'(a)=0$: $f''(a)>0$ gives a local min; $f''(a)<0$ gives a local max; $f''(a)=0$ is inconclusive.
- Concave up if $f''(x)>0$, concave down if $f''(x)<0$.
- Inflection: $f$ is continuous and concavity changes; candidates have $f''=0$ or $f''$ undefined.
- Related rates: differentiate w.r.t. time.
- Tangent line: $y=f(a)+f'(a)(x-a)$

#sec("5. Integration basics")
#ssec("FTC + techniques")
$ integral f(x) dif x = F(x)+C <-> F'(x)=f(x) $

$ integral_a^b f(x) dif x = F(b)-F(a) $
for continuous $f$ with $F'=f$.

$ frac(dif, dif x) integral_a^(g(x)) f(t) dif t = f(g(x)) g'(x) $
for continuous $f$ and differentiable $g$.

- Substitution: $u=g(x)$, $dif u=g'(x) dif x$; change limits for definite integrals.
- Integration by parts: $integral u dif v = u v - integral v dif u$
- Partial fractions: decompose rational function into simpler terms.
- Divide first if $deg P >= deg Q$; include all powers of repeated factors and linear numerators for irreducible quadratic factors.
- Definite integrals give signed area; total area is $integral_a^b |f(x)| dif x$.

#ssec("Weierstrass substitution")
For rational functions of $sin x$ and $cos x$, set $t=tan(x/2)$:
$ sin x=frac(2t, 1+t^2), quad cos x=frac(1-t^2, 1+t^2) $
$ tan x=frac(2t, 1-t^2), quad dif x=frac(2, 1+t^2) dif t $
$x=2 arctan t+2k pi$, $k in ZZ$. Split definite integrals at $x=(2k+1)pi$ and use one-sided limits.

#sec("6. Functions of several variables")
For $z=f(x,y)$:
- Partial derivatives: $f_x=frac(partial f, partial x)$, $f_y=frac(partial f, partial y)$
- Gradient: $arrow(nabla) f = ⟨f_x, f_y⟩$; in 3D, $⟨f_x,f_y,f_z⟩$.
- Chain rule: $frac(dif z, dif t) = f_x x'(t) + f_y y'(t)$

#ssec("Directional derivatives")
$f in C^1$, $arrow(v) != arrow(0)$, $hat(u)=frac(arrow(v),norm(arrow(v)))$.
$ D_(hat(u)) f(P)=arrow(nabla) f(P) dot hat(u) $
$ D_(hat(u)) f = f_x u_1+f_y u_2 quad ("3D: add " f_z u_3) $
- Maximum: $norm(arrow(nabla) f(P))$, $hat(u)=frac(arrow(nabla) f(P),norm(arrow(nabla) f(P)))$.
- Minimum: $-norm(arrow(nabla) f(P))$, opposite direction.
Extremizing directions above require $arrow(nabla) f(P) != arrow(0)$; otherwise all directional derivatives are $0$.

#ssec("Tangents, normals & the gradient")
$F(P)=c$, $F in C^1$, $arrow(nabla) F(P) != arrow(0)$.
- *Normal vector:* $arrow(n)=arrow(nabla) F(P)$,
  $hat(n)=frac(arrow(nabla) F(P), norm(arrow(nabla) F(P)))$.
- *Tangent vector:* $arrow(nabla) F(P) dot arrow(v)=0$.
- *Tangent line* to $F(x,y)=c$, $P=(a,b)$:
  $ F_x(P)(x-a)+F_y(P)(y-b)=0 $
  $ arrow(v)=⟨-F_y(P),F_x(P)⟩, quad y'=-frac(F_x(P),F_y(P)) quad (F_y(P) != 0) $
- *Tangent plane* to $F(x,y,z)=c$, $P=(a,b,c_0)$:
  $ arrow(nabla) F(P) dot (arrow(r)-arrow(p))=0, quad arrow(p)=⟨a,b,c_0⟩ $
  $ F_x(P)(x-a)+F_y(P)(y-b)+F_z(P)(z-c_0)=0 $
- *Normal line:* $arrow(r)=arrow(p)+t arrow(nabla) F(P)$.
- *Graph normal* for $z=f(x,y)$:
  $ F(x,y,z)=f(x,y)-z, quad arrow(nabla) F=⟨f_x,f_y,-1⟩ $
- *Graph tangent plane* at $(a,b,f(a,b))$:
  $ z-f(a,b)=f_x(a,b)(x-a)+f_y(a,b)(y-b) $

]
#pagebreak()
#columns(2, gutter: 6mm)[
#ssec("Hessian & second-derivative test")
$f in C^2$, $P=(a,b)$, $arrow(nabla) f(P)=arrow(0)$; all derivatives below at $P$.
$ H_f = mat(f_(x x), f_(x y); f_(y x), f_(y y)), quad D=det H_f=f_(x x) f_(y y)-f_(x y)^2 $
#table(
  columns: (1fr, 1fr),
  inset: (x: 4pt, y: 4pt),
  table.header[Condition][Classification],
  [$D>0$, $f_(x x)>0$], [Strict local minimum],
  [$D>0$, $f_(x x)<0$], [Strict local maximum],
  [$D<0$], [Saddle point],
  [$D=0$], [Inconclusive],
)
In $n$ variables, at a stationary point: $H_f$ positive definite $arrow.r$ strict local min; negative definite $arrow.r$ strict local max; indefinite $arrow.r$ saddle. Semidefinite is inconclusive.

#ssec("Lagrange multipliers")
$ arrow(nabla) f = lambda arrow(nabla) g, quad g=0 quad (arrow(nabla) g != arrow(0)) $
Check singular constraint points separately; same equations in two or three variables.

#sec("7. Multiple integrals & coordinate transforms")
#ssec("Double / triple integrals")
- Double integral: $integral.double_R f(x,y) dif A$ over region $R$
- Triple integral: $integral.triple_E f(x,y,z) dif V$ over region $E$
- Reorder integration to match the region; use symmetry when possible.

#ssec("Transformations")
- Polar: $x = r cos theta$, $y = r sin theta$;
  $dif A = r dif r dif theta$, $r >= 0$.
- Cylindrical: use polar $x,y$ and retain $z$;
  $dif V = r dif r dif theta dif z$.
- Spherical: $x = rho sin(phi.alt) cos(theta)$,
  $y = rho sin(phi.alt) sin(theta)$, $z = rho cos(phi.alt)$;
  $dif V = rho^2 sin(phi.alt) dif rho dif phi.alt dif theta$.
  Here $rho >= 0$, $0 <= phi.alt <= pi$, $0 <= theta < 2pi$.

#ssec("Jacobian: choose the mapping direction")
For integration in $(u,v)$, starting from $dif A=dif x dif y$:
- *Given $x=x(u,v)$, $y=y(u,v)$:* use the direct Jacobian.
  $ J = frac(partial (x,y), partial (u,v)) = jmat(x, y; u, v; big: #true) $
  $ dif A=|det J| dif u dif v $
- *Given $u=u(x,y)$, $v=v(x,y)$:* invert the given Jacobian.
  $ K = frac(partial (u,v), partial (x,y)) = jmat(u, v; x, y; big: #true) $
  $ J=K^(-1), quad dif A=frac(1,|det K|) dif u dif v $
- 3D: $J=frac(partial (x,y,z),partial (u,v,w))$;
  $dif V=|det J| dif u dif v dif w$.
  If $(u,v,w)$ are given in terms of $(x,y,z)$, use the reciprocal absolute determinant instead.
Assume a smooth, one-to-one map with nonzero determinant; evaluate inverse formulas at corresponding points.

#ssec("Absolute extrema checklist")
- Continuous $f$ on a closed, bounded domain attains an absolute minimum and maximum.
- Interior: solve $arrow(nabla) f=arrow(0)$; include points where derivatives do not exist.
- Boundary: restrict $f$ to each edge/curve, or use Lagrange multipliers on regular constraints. Include endpoints, corners and singular constraint points.
- Compare $f$ at all candidates; smallest/largest values give absolute extrema. For open/unbounded domains, also check limits and whether bounds are attained.

#colbreak()

#sec("Extras: Sequences, series, power series")
- Sequence $a_n$ converges if $a_n -> L in RR$ as $n -> oo$.
- Geometric series: $sum_(n=0)^oo a r^n = a/(1-r)$ for $|r|<1$.
- Ratio test: $L=lim_(n -> oo) |a_(n+1)/a_n|$ (eventually $a_n != 0$).
- Root test: $L=limsup_(n -> oo) root(n, |a_n|)$.
- Either test: $L<1$ gives absolute convergence; $L>1$ gives divergence; $L=1$ is inconclusive.
- Power series: $sum_(n=0)^oo c_n (x-a)^n$
- Radius $R$ from ratio/root test; check each endpoint separately.
- Taylor:
  $ f(x)=sum_(n=0)^N frac(f^((n))(a), n!) (x-a)^n + R_N(x) $
  $ R_N(x)=frac(f^((N+1))(xi), (N+1)!) (x-a)^(N+1) $
  for some $xi$ between $a$ and $x$, assuming sufficient differentiability.
- Maclaurin: set $a=0$; equality with the infinite series requires $R_N(x) -> 0$ as $N -> oo$.

#ssec("Classic expansions")
$ e^x = sum_(n=0)^oo frac(x^n, n!) $
$ sin x = sum_(n=0)^oo frac((-1)^n x^(2n+1), (2n+1)!) $
$ cos x = sum_(n=0)^oo frac((-1)^n x^(2n), (2n)!) $
$ (1+x)^alpha = 1 + alpha x + frac(alpha(alpha-1), 2!) x^2 + dots $
for $|x|<1$ (all $x$ if $alpha$ is a nonnegative integer).
The exponential, sine and cosine series converge for all real $x$.
]
