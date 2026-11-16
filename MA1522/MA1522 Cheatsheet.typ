// Self-contained: no external Typst packages required.
// Course listing (code/title): https://www.math.nus.edu.sg/modtt/modlist/
#set document(title: "MA1522 — Linear Algebra for Computing", author: "")
#set page(
  paper: "a4",
  margin: (x: 9mm, top: 8mm, bottom: 10mm),
  fill: white,
  footer: context align(center, text(size: 7pt)[MA1522 · #counter(page).display() / 2]),
)
#set text(font: "Libertinus Serif", size: 8.5pt, fill: black)
#set par(justify: false, leading: 0.5em, spacing: 0.5em)
#set list(indent: 8pt, body-indent: 3pt, spacing: 1.8pt)
// Measure the full height of inline mathematics, including fractions/matrices.
#show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
#show math.equation.where(block: true): set block(above: 0.38em, below: 0.38em)
#set table(stroke: 0.4pt, inset: (x: 3pt, y: 2pt))
#let rank = math.op("rank")
#let rref = math.op("rref")
#let Col = math.op("Col")
#let Row = math.op("Row")
#let Null = math.op("Null")
#let Span = math.op("span")
#let tr = math.op("tr")
#let diag = math.op("diag")
#let adj = math.op("adj")
#let proj = math.op("proj")
#let iff = $⇔$
#let AM = math.op("AM")
#let GM = math.op("GM")
#let sec(number, title) = block(
  width: 100%, sticky: true, above: 1.8mm, below: 0.8mm,
  inset: (bottom: 0.6mm), stroke: (bottom: 0.5pt),
)[#text(size: 10pt, weight: "bold")[#number. #title]]
#let sub(title) = block(sticky: true, above: 1mm, below: 0.5mm)[
  #text(weight: "bold")[#title]
]
#let masthead(side, topics) = [
  #grid(columns: (1fr, auto), align: (left, right),
    [#text(size: 15pt, weight: "bold")[MA1522]#h(2mm)#text(size: 10pt)[Linear Algebra for Computing]],
    [#text(size: 8pt, weight: "bold")[#side]],
  )
  #text(size: 7.5pt)[#topics]
  #v(1mm)
]

#masthead("FRONT", "Systems · matrix algebra · determinants · vector spaces · linear maps")
#columns(2, gutter: 5mm)[
*Notation:* $A in RR^(m times n)$, $r=rank(A)$; $I=I_n$.
Vectors are columns; $bold(x)=⟨x_1,dots,x_n⟩$ lists components. $A^T$ denotes transpose. Matrices and scalars are real unless stated.

#sec(1, "Linear systems & elimination")
$ A bold(x)=bold(b) iff x_1 bold(a)_1+dots+x_n bold(a)_n=bold(b) $
- Augment $lr([A ∣ bold(b)])$; use row operations to reach REF/RREF. Pivots move right; zero rows go last. RREF pivots are $1$ and the only nonzero entries in their columns.
- Allowed: $R_i arrow.l.r R_j$; $R_i arrow.l c R_i$ ($c != 0$); $R_i arrow.l R_i+c R_j$ ($i != j$).
#table(
  columns: (1fr, 1.45fr),
  table.header[*Solution type*][*Test for $A bold(x)=bold(b)$*],
  [No solution], [$rank(lr([A ∣ bold(b)]))>r$],
  [Unique solution], [Consistent and $r=n$],
  [Infinitely many], [Consistent and $r<n$; $n-r$ free variables],
)
- Inconsistent row: $lr([0 quad dots quad 0 ∣ c])$, $c != 0$.
- Homogeneous $A bold(x)=bold(0)$ is always consistent; a nonzero solution exists iff $r<n$.
- General solution (if consistent):
  $ bold(x)=bold(x)_p+bold(x)_h, quad bold(x)_h in Null(A) $
  Set free variables to parameters, then collect their coefficient vectors to obtain a basis for $Null(A)$.
- With a parameter: isolate values that make a prospective pivot zero *before dividing*; test those cases separately.

#sec(2, "Matrix algebra, inverses & LU")
- $A B$ exists for $A_(m times n),B_(n times p)$; $(A B)_(i j)=sum_(k=1)^n a_(i k)b_(k j)$. Usually $A B != B A$.
- $(A B)^T=B^T A^T$; $(A+B)^T=A^T+B^T$.
- For invertible factors: $(A B)^(-1)=B^(-1) A^(-1)$; $(A^T)^(-1)=(A^(-1))^T$.
- Inverse by elimination: $lr([A ∣ I]) arrow.r lr([I ∣ A^(-1)])$.
  For $2 times 2$ matrices:
  $ mat(a,b;c,d)^(-1)=frac(1,a d-b c) mat(d,-b;-c,a) $
  requires $a d-b c != 0$.
- $A X=B arrow.r X=A^(-1)B$; $X A=B arrow.r X=B A^(-1)$, when $A$ is invertible. Preserve multiplication order.
- Elementary row operations are left multiplication by invertible elementary matrices: $E_k dots E_1 A=R$.
#sub("LU factorisation & solving")
- If elimination needs no row swaps: $A=L U$; $L$ is unit lower triangular, $U$ is in upper echelon form.
- Eliminate by $R_i arrow.l R_i-ell_(i j)R_j$; record $ell_(i j)$ in $L$ (not its negative).
- With pivoting: $P A=L U$. Solve $L bold(y)=P bold(b)$ by forward substitution, then $U bold(x)=bold(y)$ by back substitution.
  When swapping pivot rows, also swap their previously computed entries in $L$.

#sec(3, "Determinants & invertibility")
For square $A in RR^(n times n)$:
- Cofactor $C_(i j)=(-1)^(i+j) det(M_(i j))$; expand along any row/column: $det A=sum_j a_(i j) C_(i j)$.
- $adj(A)=(C_(i j))^T$; $A adj(A)=(det A)I$.
  If $det A != 0$, $A^(-1)=adj(A)/(det A)$.
- $det(A B)=det A det B$; $det(A^T)=det A$;
  $det(c A)=c^n det A$; $det(A^(-1))=1/(det A)$.
- In general, $det(A+B)!=det A+det B$.
- Row swap: flip sign. Scale one row by $c$: multiply determinant by $c$. Add a multiple of another row: no change.
- Triangular matrix: $det A=product_(i=1)^n a_(i i)$.
  For $P A=L U$, $det A=det P product_i u_(i i)$.
- Cramer's rule: $x_i=det(A_i)/(det A)$; $A_i$ replaces column $i$ by $bold(b)$; requires $det A != 0$.
#sub("Invertible matrix theorem — square matrices only")
$ det A != 0 iff rank(A)=n iff rref(A)=I $
$ iff Null(A)={bold(0)} iff 0 " is not an eigenvalue" $
Also equivalent: columns form a basis of $RR^n$; $A bold(x)=bold(b)$ has exactly one solution for every $bold(b)$; the associated map is bijective.

#colbreak()
#sec(4, "Subspaces, span & independence")
- Subspace: $bold(0) in W$ and $alpha bold(u)+beta bold(v) in W$ for all $bold(u),bold(v) in W$, $alpha,beta in RR$.
- $Span{bold(v)_1,dots,bold(v)_k}$ is the set of all linear combinations. Membership: solve $lr([bold(v)_1 quad dots quad bold(v)_k])bold(c)=bold(w)$.
- Linear independence: $sum_i c_i bold(v)_i=bold(0)$ has only $c_i=0$. A zero vector, a repeated vector, or one vector in the span of the others implies dependence.
- $k$ vectors in $RR^n$: if $k>n$, dependent; if $k<n$, cannot span $RR^n$. Pairwise nonparallel does *not* imply independence for $k>=3$.
- For a column matrix $V$: independent iff every column has a pivot; spans $RR^n$ iff every row has a pivot.
- $U+W=Span(U union W)$; $U inter W$ is a subspace. $U union W$ need not be a subspace.

#sec(5, "Bases, dimension & the four spaces")
A *basis* is an independent spanning set; its size is the dimension.
- In a $d$-dimensional space: any $d$ independent vectors form a basis; any $d$ spanning vectors form a basis.
- Reduce a spanning set by deleting redundant vectors; extend an independent set using vectors outside its span.
- For $A in RR^(m times n)$, $R=rref(A)$:
#table(
  columns: (0.8fr, 1.65fr, 0.45fr),
  table.header[*Space*][*How to find a basis*][*Dim.*],
  [$Col(A) subset.eq RR^m$], [Pivot columns of *original $A$*], [$r$],
  [$Row(A) subset.eq RR^n$], [Nonzero rows of $R$], [$r$],
  [$Null(A) subset.eq RR^n$], [Special solutions of $R bold(x)=bold(0)$], [$n-r$],
  [$Null(A^T) subset.eq RR^m$], [Solve $A^T bold(y)=bold(0)$], [$m-r$],
)
$ rank(A)+dim Null(A)=n quad ("rank–nullity") $
- Row operations preserve row space, null space and rank; they generally *change column space*.
- $bold(b) in Col(A) iff A bold(x)=bold(b)$ is consistent.
- $dim(U+W)=dim U+dim W-dim(U inter W)$.
- Intersection: solve $B bold(s)=C bold(t)$ for basis matrices $B,C$; map to $B bold(s)$ and extract independent vectors.
- Rank facts (compatible sizes):
  $rank(A B)<=min(rank A,rank B)$; invertible left/right factors preserve rank; $rank(A^T A)=rank A$.

#sec(6, "Coordinates & change of basis")
Ordered basis $cal(B)=(bold(b)_1,dots,bold(b)_n)$ of $RR^n$:
$ B=lr([bold(b)_1 quad dots quad bold(b)_n]), quad bold(x)=B [bold(x)]_cal(B) $
$ [bold(x)]_cal(B)=B^(-1)bold(x) $
- For another basis matrix $C$, the change *from $cal(B)$ to $cal(C)$* is
  $ [bold(x)]_cal(C)=P_(cal(C) <- cal(B))[bold(x)]_cal(B), quad P_(cal(C) <- cal(B))=C^(-1)B. $
- Columns of $P_(cal(C) <- cal(B))$ are $[bold(b)_i]_cal(C)$.
  Reverse change is its inverse; compute by reducing $lr([C ∣ B]) arrow.r lr([I ∣ C^(-1)B])$.

#sec(7, "Linear transformations")
- $T(alpha bold(u)+beta bold(v))=alpha T(bold(u))+beta T(bold(v))$; necessarily $T(bold(0))=bold(0)$.
- For $T:RR^n arrow.r RR^m$, standard matrix:
  $ A=lr([T(bold(e)_1) quad dots quad T(bold(e)_n)]), quad T(bold(x))=A bold(x) $
- $ker T=Null(A)$; $"range" T=Col(A)$; $dim ker T+dim("range" T)=n$.
- Injective iff $ker T={bold(0)}$ iff $rank A=n$.
  Surjective iff $rank A=m$. Bijective iff both.
- $S compose T$ has matrix $A_S A_T$ (rightmost acts first); a bijective map has inverse matrix $A^(-1)$.
- Given $T(bold(b)_i)$ and $bold(x)=sum_i c_i bold(b)_i$:
  $T(bold(x))=sum_i c_i T(bold(b)_i)$.
#sub("Matrix relative to domain/codomain bases")
$ [T]_(cal(C) <- cal(B))=lr([[T(bold(b)_1)]_cal(C) quad dots quad [T(bold(b)_n)]_cal(C)]) $
$ [T(bold(x))]_cal(C)=[T]_(cal(C) <- cal(B))[bold(x)]_cal(B) $
For full bases with matrices $B,C$ and standard matrix $A$:
$ [T]_(cal(C) <- cal(B))=C^(-1)A B $
For an operator on one space: $[T]_cal(B)=B^(-1)A B$ (similarity).
#sub("Geometric transformations")
Positive $theta$: counterclockwise rotation.
$ R_theta=mat(cos theta,-sin theta;sin theta,cos theta), quad R_theta^(-1)=R_(-theta) $
- Reflection in $x$-axis: $diag(1,-1)$; in $y=x$: swap coordinates.
- Line projection: $P=hat(bold(u))hat(bold(u))^T$, $hat(bold(u))$ a unit direction; reflection in that line in $RR^2$: $2P-I_2$.
- Hyperplane reflection through origin: $I-2hat(bold(n))hat(bold(n))^T$, $hat(bold(n))$ a unit normal.
- Horizontal shear: $⟨x,y⟩ arrow.r ⟨x+k y,y⟩$; scaling: $diag(s_x,s_y)$. Nonzero translations are not linear.
]

#pagebreak()
#masthead("BACK", "Orthogonality · least squares · eigenvalues · diagonalisation · SVD · applications")
#columns(2, gutter: 5mm)[
#sec(8, "Orthogonality & projections")
$ bold(u) dot bold(v)=bold(u)^T bold(v), quad norm(bold(v))=sqrt(bold(v)^T bold(v)) $
- Orthogonal: $bold(u)^T bold(v)=0$. Pairwise orthogonal nonzero vectors are independent. Orthonormal: $bold(q)_i^T bold(q)_j=delta_(i j)$.
- $cos theta=frac(bold(u)^T bold(v),norm(bold(u)) norm(bold(v)))$ for nonzero vectors.
- $W^perp={bold(z):bold(z)^T bold(w)=0 " for all " bold(w) in W}$.
  $dim W+dim W^perp=n$; $(W^perp)^perp=W$.
$ Row(A)^perp=Null(A), quad Col(A)^perp=Null(A^T) $
#sub("Projection of a vector onto a subspace")
- Onto a nonzero $bold(u)$:
  $ proj_bold(u) bold(b)=frac(bold(u)^T bold(b),bold(u)^T bold(u))bold(u) $
- For an orthogonal basis $bold(u)_1,dots,bold(u)_k$ of $W$:
  $ proj_W bold(b)=sum_(i=1)^k frac(bold(u)_i^T bold(b),bold(u)_i^T bold(u)_i)bold(u)_i $
- If $Q$ has orthonormal columns spanning $W$:
  $ proj_W bold(b)=Q Q^T bold(b), quad [proj_W bold(b)]_cal(Q)=Q^T bold(b) $
- For a full-column-rank basis matrix $B$:
  $ P_W=B(B^T B)^(-1)B^T, quad proj_W bold(b)=P_W bold(b) $
- $P_W^2=P_W$, $P_W^T=P_W$; $I-P_W$ projects onto $W^perp$.
  Residual $bold(b)-proj_W bold(b) in W^perp$;
  $"dist"(bold(b),W)=norm(bold(b)-proj_W bold(b))$.
#sub("Gram–Schmidt & QR")
For independent columns $bold(a)_1,dots,bold(a)_k$:
$ bold(w)_j=bold(a)_j-sum_(i=1)^(j-1)(bold(q)_i^T bold(a)_j)bold(q)_i, quad bold(q)_j=frac(bold(w)_j,norm(bold(w)_j)) $
- $A=Q R$ (thin QR), $Q^T Q=I_k$, $R=Q^T A$ upper triangular with $r_(j j)=norm(bold(w)_j)>0$.
- If Gram–Schmidt gives $bold(w)_j=bold(0)$, that input vector is dependent; discard it when finding a span basis.
- Square orthogonal $Q$: $Q^(-1)=Q^T$, $det Q=plus.minus 1$; preserves lengths and dot products. Rectangular $Q^T Q=I$ does *not* imply $Q Q^T=I$.

#sec(9, "Least squares")
Minimise $norm(A bold(x)-bold(b))^2$. Normal equations:
$ A^T A hat(bold(x))=A^T bold(b) $
- Normal equations always consistent; fitted vector $A hat(bold(x))=proj_(Col(A)) bold(b)$ unique. Coefficients need not be unique.
- If $rank A=n$:
  $ hat(bold(x))=(A^T A)^(-1)A^T bold(b) $
  Or use thin QR: $R hat(bold(x))=Q^T bold(b)$.
- Residual $bold(e)=bold(b)-A hat(bold(x))$ satisfies $A^T bold(e)=bold(0)$.
- Fit $y=beta_0+beta_1 t$: row $i$ of $A$ is $(1,t_i)$, $bold(b)=⟨y_1,dots,y_m⟩$. For a degree-$d$ fit use $(1,t_i,dots,t_i^d)$.

#sec(10, "Eigenvalues & diagonalisation")
For $A in RR^(n times n)$:
$ A bold(v)=lambda bold(v), quad bold(v)!=bold(0), quad p_A(lambda)=det(lambda I-A) $
- Find eigenvalues from $p_A(lambda)=0$; then find a basis of $E_lambda=Null(A-lambda I)$.
- Algebraic multiplicity (AM): multiplicity as a root. Geometric multiplicity (GM): $dim E_lambda=n-rank(A-lambda I)$.
  $1<=GM<=AM$; eigenvectors for distinct eigenvalues are independent.
- $tr A=sum_i lambda_i$; $det A=product_i lambda_i$ (count AM); triangular matrices have diagonal eigenvalues.
- Over $RR$: diagonalizable iff all eigenvalues are real and $GM=AM$ for each. Over $CC$: require $GM=AM$ for each, allowing complex eigenvectors. Equivalently, $n$ independent eigenvectors over the chosen field.
- Construct $P,D$ in the *same eigenvector/eigenvalue order*:
  $ P=lr([bold(v)_1 quad dots quad bold(v)_n]), quad D=diag(lambda_1,dots,lambda_n) $
  $ A=P D P^(-1), quad A^k=P D^k P^(-1) $
  Check $A P=P D$. Negative $k$ requires invertible $A$.
- Distinct $n$ real eigenvalues $arrow.r$ diagonalizable over $RR$. Repeated eigenvalues alone do not decide diagonalizability.
- $f(A)bold(v)=f(lambda)bold(v)$ for polynomial $f$; $A^(-1)$ has eigenvalue $1/lambda$ if invertible.
- Similar matrices share characteristic polynomial, eigenvalues, rank, trace and determinant.

#colbreak()
#sec(11, "Symmetric matrices & quadratic forms")
*Spectral theorem:* real $A=A^T$ iff it is orthogonally diagonalizable:
$ A=Q D Q^T, quad Q^T Q=I, quad D=diag(lambda_1,dots,lambda_n) $
- Eigenvalues are real; distinct eigenspaces are orthogonal. Orthonormalise *within each repeated eigenspace*, then combine.
- $A=sum_i lambda_i bold(q)_i bold(q)_i^T$ (spectral decomposition).
- For $q(bold(x))=bold(x)^T A bold(x)$ with symmetric $A$, put $bold(x)=Q bold(y)$, $bold(y)=Q^T bold(x)$:
  $ q(bold(x))=sum_i lambda_i y_i^2 $
  A cross term $c x_i x_j$ gives $a_(i j)=a_(j i)=c/2$.
#table(
  columns: (1fr, 1fr),
  table.header[*Type of symmetric $A$*][*Eigenvalue test*],
  [Positive definite], [All $lambda_i>0$],
  [Negative definite], [All $lambda_i<0$],
  [Positive semidefinite], [All $lambda_i>=0$],
  [Negative semidefinite], [All $lambda_i<=0$],
  [Indefinite], [Both positive and negative],
)
- On $norm(bold(x))=1$: $min q=lambda_min$, $max q=lambda_max$; attained on corresponding eigenspaces.
- Sylvester: positive definite iff all leading principal minors are positive. Symmetric $2 times 2$: $det A>0$ gives definite, with sign of $a_(1 1)$; $det A<0$ gives indefinite.
#sub("Conics & completing squares")
- For $a x^2+b x y+c y^2$: diagonal $a,c$, off-diagonal $b/2$. An orthonormal eigenbasis removes $x y$; choose eigenvector signs so $det Q=1$ for a rotation.
- For $bold(x)^T A bold(x)+2 bold(d)^T bold(x)+c_0=0$, $A=A^T$ invertible: set $bold(h)=-A^(-1)bold(d)$, $bold(x)=bold(h)+Q bold(y)$:
  $ sum_i lambda_i y_i^2=c_*, quad c_*=bold(d)^T A^(-1)bold(d)-c_0 $
- 2D: same-sign eigenvalues give ellipse/point/empty set; opposite signs give hyperbola ($c_*!=0$) or intersecting lines ($c_*=0$). Zero eigenvalue: inspect linear terms for parabola/degeneracy.

#sec(12, "Singular value decomposition (SVD)")
Every $A in RR^(m times n)$ has a full SVD:
$ A=U Sigma V^T, quad U^T U=I_m, quad V^T V=I_n $
$ Sigma in RR^(m times n), quad sigma_1>=dots>=sigma_r>0 $
Other diagonal entries are $0$; $r=rank A$.
- Take orthonormal eigenvectors $bold(v)_i$ of $A^T A$ in descending eigenvalue order; $sigma_i^2=lambda_i(A^T A)$, $sigma_i>=0$.
- For $sigma_i>0$, $bold(u)_i=A bold(v)_i sigma_i^(-1)$; complete to an orthonormal basis for full $U$. Never divide by $0$.
- $A bold(v)_i=sigma_i bold(u)_i$ and $A^T bold(u)_i=sigma_i bold(v)_i$ for positive singular values.
#table(
  columns: (1fr, 1fr),
  table.header[*Space*][*SVD basis vectors*],
  [$Col(A)$], [$bold(u)_1,dots,bold(u)_r$],
  [$Null(A^T)$], [$bold(u)_(r+1),dots,bold(u)_m$],
  [$Row(A)$], [$bold(v)_1,dots,bold(v)_r$],
  [$Null(A)$], [$bold(v)_(r+1),dots,bold(v)_n$],
)
- Reduced SVD: $A=U_r Sigma_r V_r^T$; keep the $r$ positive singular values and matching columns.
- Pseudoinverse: $A^+=V_r Sigma_r^(-1)U_r^T$; $A^+ bold(b)$ is the minimum-norm least-squares solution.
- A best rank-$k$ approximation ($0<=k<r$), with $E=A-A_k$:
  $ A_k=sum_(i=1)^k sigma_i bold(u)_i bold(v)_i^T $
  $ norm(E)_2=sigma_(k+1), quad norm(E)_F^2=sum_(i=k+1)^r sigma_i^2 $

#sec(13, "Stochastic matrices & long-run states")
*Column-stochastic:* $p_(i j)>=0$, $bold(1)^T P=bold(1)^T$; $bold(1)$ is the all-ones vector.
$ bold(x)_(k+1)=P bold(x)_k, quad bold(x)_k=P^k bold(x)_0 $
- Probability states have nonnegative entries summing to $1$; $p_(i j)$ is the probability *from $j$ to $i$*.
- Stationary: $(P-I)bold(pi)=bold(0)$, $bold(1)^T bold(pi)=1$, $pi_i>=0$.
- $1$ is an eigenvalue; all $|lambda|<=1$. Regular (some power strictly positive) $arrow.r$ unique stationary probability state and $P^k bold(x)_0 arrow.r bold(pi)$ for every probability state.
- *Row-stochastic:* use row states, $bold(x)_(k+1)^T=bold(x)_k^T P$.
]

// Fail compilation rather than silently exceeding the double-sided limit.
#context assert(counter(page).final().first() <= 2,
  message: "MA1522 cheatsheet must fit on at most two A4 pages.")

