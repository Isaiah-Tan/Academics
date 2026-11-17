// Self-contained: no external Typst packages required.
// Course listing (code/title): https://www.math.nus.edu.sg/modtt/modlist/
#set document(title: "MA1522 — Linear Algebra for Computing", author: "")
#set page(
  paper: "a4",
  margin: (x: 6mm, top: 5mm, bottom: 6mm),
  fill: white,
  footer: context align(center, text(size: 7pt)[MA1522 · #counter(page).display() / 2]),
)
#set text(font: "Libertinus Serif", size: 8pt, fill: black)
#set par(justify: false, leading: 0.5em, spacing: 0.3em)
#set list(indent: 8pt, body-indent: 3pt, spacing: 1.5pt)
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
  width: 100%, sticky: true, above: 0.8mm, below: 0.3mm,
  inset: (bottom: 0.4mm), stroke: (bottom: 0.5pt),
)[#text(size: 10pt, weight: "bold")[#number. #title]]
#let sub(title) = block(sticky: true, above: 0.7mm, below: 0.3mm)[
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
- Eliminate on $lr([A ∣ bold(b)])$ to REF/RREF; solve pivots bottom-up, leaving non-pivots as parameters. Pivots move right and zero rows go last; in RREF each pivot is $1$ and alone in its column.
- Allowed: $R_i arrow.l.r R_j$; $R_i arrow.l c R_i$ ($c != 0$); $R_i arrow.l R_i+c R_j$ ($i != j$).
#table(
  columns: (1fr, 1.45fr),
  table.header[*Solution type*][*Test for $A bold(x)=bold(b)$*],
  [No solution], [$rank(lr([A ∣ bold(b)]))>r$],
  [Unique solution], [Consistent and $r=n$],
  [Infinitely many], [Consistent and $r<n$; $n-r$ free variables],
)
- Consistent iff $rank([A ∣ bold(b)])=r$; every $bold(b)$ is consistent iff $r=m$. Rank $m$ of the augmented matrix alone does *not* guarantee consistency.
- Homogeneous $A bold(x)=bold(0)$ is always consistent; a nonzero solution exists iff $r<n$.
- General solution (if consistent):
  $ bold(x)=bold(x)_p+bold(x)_h, quad bold(x)_h in Null(A) $
  Set free variables to parameters; their coefficient vectors form a basis for $Null(A)$.
- With parameters: choose pivots that stay nonzero; split exceptional values before dividing, inspect residual rows for vanishing/proportionality, then use nullity $n-r$.

#sec(2, "Matrix algebra, inverses & LU")
- $A B$ exists for $A_(m times n),B_(n times p)$; $(A B)_(i j)=sum_(k=1)^n a_(i k)b_(k j)$. Usually $A B != B A$.
- $(A B)^T=B^T A^T$; $(A+B)^T=A^T+B^T$.
- For invertible factors: $(A B)^(-1)=B^(-1) A^(-1)$; $(A^T)^(-1)=(A^(-1))^T$.
- Inverse by elimination: $lr([A ∣ I]) arrow.r lr([I ∣ A^(-1)])$.
- $A X=B arrow.r X=A^(-1)B$; $X A=B arrow.r X=B A^(-1)$, when $A$ is invertible. Preserve multiplication order.
- Elementary $E$: apply one row operation to $I$; left multiplication performs it, $E^(-1)$ reverses it. If $E_k dots E_1 A=R$, then $A=E_1^(-1)dots E_k^(-1)R$. Swap is self-inverse; scaling $c$ reverses by $1/c$; adding $c R_j$ to $R_i$ reverses with $-c R_j$.
#sub("LU factorisation & solving")
- Rectangular $A_(m times n)$: $L,P$ are $m times m$, $U$ is $m times n$. Start $U=A$, $L=P=I_m$. Scan columns with pivot row $k$: skip if the remaining column is zero; otherwise swap a nonzero entry into row $k$ (swap rows of $P$ and entries in filled columns of $L$). At pivot column $j$, for each $i>k$ store $ell_(i k)=u_(i j)/u_(k j)$ in $L$, update $U_i arrow.l U_i-ell_(i k)U_k$; advance $k$. Then $P A=L U$.
- Solve: set $bold(c)=P bold(b)$; forward solve $y_i=c_i-sum_(j<i)ell_(i j)y_j$, then back solve $x_i=(y_i-sum_(j>i)u_(i j)x_j)/u_(i i)$ (square nonsingular case); rectangular: solve $U x=y$ for consistency and free variables.
- Since $L$ is invertible, $Null(A)=Null(U)$ and $rank(A)=rank(U)$. Pivot columns of $U$ select a basis from the *original columns of* $A$, not $U$.
- Reconstruct: write unknown unit lower-triangular $L$; from $A v_j=b_j$, use $L(U v_j)=b_j$ to solve its entries, then $A=L U$.

#sec(3, "Determinants & invertibility")
For square $A in RR^(n times n)$:
- Cofactor $C_(i j)=(-1)^(i+j) det(M_(i j))$; expand along any row/column: $det A=sum_j a_(i j) C_(i j)$.
- Elimination: triangularise; multiply pivots, correcting for swaps (sign) and scalings (factor); row additions preserve determinant.
- If $det A != 0$, $adj(A)=(C_(i j))^T$ and $A^(-1)=adj(A)/(det A)$.
- $det(A B)=det A det B$; $det(A^T)=det A$; $det(c A)=c^n det A$; triangular $det A=product_i a_(i i)$. For $P A=L U$, $det A=det P product_i u_(i i)$.
#sub("Rectangular rank & one-sided inverses")
$rank(A)<=min(m,n)$; *full rank* means equality. Full column rank $r=n$ ($m>=n$): independent columns, $Null(A)={bold(0)}$, $A^T A$ invertible; left inverse $L A=I_n$, e.g. $L_0=(A^T A)^(-1)A^T$. Full row rank $r=m$ ($n>=m$): $Col(A)=RR^m$, $A x=b$ consistent for every $b$, $A A^T$ invertible; right inverse $A R=I_m$, e.g. $R_0=A^T(A A^T)^(-1)$.
- Two-sided inverse requires square full rank; nullity $0$ alone does not make a rectangular matrix invertible. Full-row-rank $A$: solve $A r_j=e_j$ for each column to find a right inverse; all are $R=R_0+N Z$, where columns of $N$ form a basis of $Null(A)$ and $Z in RR^((n-m) times m)$. Full-column-rank $A$: all left inverses are $L=L_0+Z N^T$, where columns of $N$ form a basis of $Null(A^T)$ and $Z in RR^(n times (m-n))$.
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
- $U+W=Span(U union W)$; $U inter W$ is a subspace. $U union W$ is a subspace iff one contains the other; an arbitrary set containing $0$ need not be a subspace.
- For column matrices $B,C$, $dim Span(B union C)=rank([B C])$. Product spaces: $Col(A B) subset.eq Col(A)$, $Null(B) subset.eq Null(A B)$.

#sec(5, "Bases, dimension & the four spaces")
*Basis:* independent and spanning; size $=dim$. In dimension $d$, $d$ independent or spanning vectors form a basis. Reduce spanning sets; extend independent sets with vectors outside their span.
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
- $Null(A)$ basis: set each free variable to $1$ in turn (others $0$), solve pivots, and collect special solutions. For $Col(A)$, use pivot columns of the original $A$.
- To select original rows forming a basis of $Row(A)$, find pivot-column indices of $rref(A^T)$ and select those rows of $A$; nonzero rows of $rref(A)$ need not be original rows.
- Row operations preserve row space, null space and rank; they generally *change column space*.
- $bold(b) in Col(A) iff A bold(x)=bold(b)$ is consistent.
- $dim(U+W)=dim U+dim W-dim(U inter W)$.
- Intersection: solve $B bold(s)=C bold(t)$ for basis matrices $B,C$; map to $B bold(s)$ and extract independent vectors.

#sec(6, "Coordinates & change of basis")
Let $B=[bold(b)_1 dots bold(b)_k] in RR^(m times k)$ be a basis matrix for $W subset.eq RR^m$. For $bold(x) in W$, solve $B bold(c)=bold(x)$; the unique solution is $[bold(x)]_cal(B)=bold(c)=(B^T B)^(-1)B^T bold(x)$ (do not invert rectangular $B$).
- If $B$ is orthogonal, $c_i=(bold(b)_i^T bold(x))/(bold(b)_i^T bold(b)_i)$. For $bold(x)=B bold(c), bold(y)=B bold(d)$, $bold(x)^T bold(y)=bold(c)^T(B^T B)bold(d)$. Coordinates preserve addition/scalars; dot products and lengths for all vectors iff the basis is orthonormal.
- For bases $B,C$ of the *same* $W$, solve $C K=B$ columnwise; then $[bold(x)]_cal(C)=K[bold(x)]_cal(B)$. If $C$ is square, $K=C^(-1)B$; if $C$ has orthonormal columns, $K=C^T B$.
- $B M$ is a basis of $W$ iff $M$ is an invertible $k times k$ matrix. For parameter-dependent candidates, first check membership in $W$, then independence and the required number of vectors.

#sec(7, "Linear transformations")
- $T(alpha bold(u)+beta bold(v))=alpha T(bold(u))+beta T(bold(v))$; necessarily $T(bold(0))=bold(0)$.
- $T(bold(x))=A bold(x)+bold(d)$ is linear iff $bold(d)=bold(0)$; $T(0)=0$ alone does not prove linearity for an arbitrary formula. Maps equal on a spanning set are equal everywhere; agreement on an independent, nonspanning set is insufficient.
- For $T:RR^n arrow.r RR^m$, standard matrix:
  $ A=lr([T(bold(e)_1) quad dots quad T(bold(e)_n)]), quad T(bold(x))=A bold(x) $
- $ker T=Null(A)$; $"range" T=Col(A)$; $dim ker T+dim("range" T)=n$.
- Injective iff $ker T={bold(0)}$ iff $rank A=n$.
  Surjective iff $rank A=m$. Bijective iff both.
- $S compose T$ has matrix $A_S A_T$ (rightmost acts first); a bijective map has inverse matrix $A^(-1)$.
- If $bold(x)=sum_i c_i bold(b)_i$, then $T(bold(x))=lr([T(bold(b)_1) dots T(bold(b)_k)])[bold(x)]_cal(B)$; for a full domain basis $A=lr([T(bold(b)_1) dots T(bold(b)_n)])B^(-1)$.
- Fixed points solve $(A-I)bold(x)=bold(0)$; a preimage of $bold(y)$ solves $A bold(x)=bold(y)$, which may have no, one, or infinitely many solutions.
#sub("Matrix relative to domain/codomain bases")
$ [T]_(cal(C) <- cal(B))=lr([[T(bold(b)_1)]_cal(C) quad dots quad [T(bold(b)_n)]_cal(C)]) $
$ [T(bold(x))]_cal(C)=[T]_(cal(C) <- cal(B))[bold(x)]_cal(B) $
- For $M=[T]_(cal(C) <- cal(B))$ with full basis matrices $B,C$: $ker(T)={B bold(z):bold(z) in Null(M)}$, $"range" T={C bold(w):bold(w) in Col(M)}$. Null vectors are input *coordinates*; with standard codomain, $"range" T=Col(M)$.
For full bases with matrices $B,C$ and standard matrix $A$:
$ [T]_(cal(C) <- cal(B))=C^(-1)A B $
For an operator on one space: $[T]_cal(B)=B^(-1)A B$ (similarity).
]

#pagebreak()
#masthead("BACK", "Orthogonality · least squares · eigenvalues · diagonalisation · SVD · applications")
#columns(2, gutter: 5mm)[
#sec(8, "Orthogonality & projections")
$ bold(u) dot bold(v)=bold(u)^T bold(v), quad norm(bold(v))=sqrt(bold(v)^T bold(v)) $
- Orthogonal: $bold(u)^T bold(v)=0$. Pairwise orthogonal nonzero vectors are independent. Orthonormal: $bold(q)_i^T bold(q)_j=delta_(i j)$.
- $cos theta=frac(bold(u)^T bold(v),norm(bold(u)) norm(bold(v)))$ for nonzero vectors.
- $W^perp={bold(z):bold(z)^T bold(w)=0 " for all " bold(w) in W}$.
  $dim W+dim W^perp=n$; $(W^perp)^perp=W$; $W inter W^perp={bold(0)}$, $RR^n=W ⊕ W^perp$.
$ Row(A)^perp=Null(A), quad Col(A)^perp=Null(A^T) $
Hence $Row(A) inter Null(A)={bold(0)}$ (both lie in $RR^n$).
#sub("Projection of a vector onto a subspace")
- Onto a nonzero $bold(u)$:
  $ proj_bold(u) bold(b)=frac(bold(u)^T bold(b),bold(u)^T bold(u))bold(u) $
- For an orthogonal basis $bold(u)_1,dots,bold(u)_k$ of $W$:
  $ proj_W bold(b)=sum_(i=1)^k frac(bold(u)_i^T bold(b),bold(u)_i^T bold(u)_i)bold(u)_i $
- If $Q$ has orthonormal columns spanning $W$:
  $ proj_W bold(b)=Q Q^T bold(b), quad [proj_W bold(b)]_cal(Q)=Q^T bold(b) $
- For a full-column-rank basis matrix $B$:
  $ P_W=B(B^T B)^(-1)B^T, quad proj_W bold(b)=P_W bold(b) $
- If the basis columns are not orthonormal, orthonormalise them to form $Q$ first; then project with $Q Q^T bold(b)$.
- Hyperplane $W={bold(x):bold(n)^T bold(x)=0}$: $proj_W bold(x)=bold(x)-bold(n)(bold(n)^T bold(x))/(bold(n)^T bold(n))$, $bold(n)!=bold(0)$.
- $P_W^2=P_W$, $P_W^T=P_W$; $I-P_W$ projects onto $W^perp$.
  Residual $bold(b)-proj_W bold(b) in W^perp$;
  $"dist"(bold(b),W)=norm(bold(b)-proj_W bold(b))$.
#sub("Gram–Schmidt & QR")
For full-column-rank $A=[bold(a)_1 dots bold(a)_k]$, for each $j$: start $bold(w)=bold(a)_j$; for $i<j$, compute $r_(i j)=bold(q)_i^T bold(a)_j$ and update $bold(w) arrow.l bold(w)-r_(i j)bold(q)_i$. Then set $r_(j j)=norm(bold(w))$, $bold(q)_j=bold(w)/r_(j j)$.
Assemble $Q=[bold(q)_1 dots bold(q)_k]$ and upper-triangular $R=(r_(i j))$ (zeros below diagonal); then $A=Q R$, $Q^T Q=I_k$. A zero $bold(w)$ flags dependent columns; do not divide by zero.
- Square orthogonal $Q$: $Q^(-1)=Q^T$, $det Q=plus.minus 1$; preserves lengths and dot products. Rectangular $Q^T Q=I$ does *not* imply $Q Q^T=I$.

#sec(9, "Least squares")
Minimise $norm(A bold(x)-bold(b))^2$. Normal equations:
$ A^T A hat(bold(x))=A^T bold(b) $
- Normal equations always consistent; fitted vector $A hat(bold(x))=proj_(Col(A)) bold(b)$ unique. Coefficients need not be unique.
- If $rank A=n$:
  $ hat(bold(x))=(A^T A)^(-1)A^T bold(b) $
  Or thin QR $A=Q R$: set $bold(c)=Q^T bold(b)$, back-solve $R hat(bold(x))=bold(c)$; then fitted $=Q bold(c)=Q Q^T bold(b)$ and residual $=bold(b)-Q Q^T bold(b)$. $Q^T bold(b)$ is coordinates, not the fitted vector or coefficients.
- For any one LS solution $hat(bold(x))_0$, *all* are $hat(bold(x))_0+Null(A)=A^+bold(b)+Null(A)$; they are unique iff $rank A=n$. Also $Null(A^T A)=Null(A)$.
- Normal-equation residual check: $A^T(bold(b)-A hat(bold(x)))=bold(0)$.
- Fit $y=beta_0+beta_1 t$: row $i$ of $A$ is $(1,t_i)$, $bold(b)=⟨y_1,dots,y_m⟩$. For a degree-$d$ fit use $(1,t_i,dots,t_i^d)$.

#sec(10, "Eigenvalues & diagonalisation")
For $A in RR^(n times n)$:
$ A bold(v)=lambda bold(v), quad bold(v)!=bold(0), quad p_A(lambda)=det(lambda I-A) $
- *Eigenpairs:* factor $p_A(λ)=det(λ I-A)=0$; for integer coefficients test $±p/q$ ($p$ divides constant, $q$ leading coefficient), then synthetic-divide; use quadratic formula if needed. For each root, solve $(A-λ I)bold(v)=0$ by RREF.
- AM = multiplicity as a root; GM $=dim E_λ=n-rank(A-λ I)$; $1<=GM<=AM$. Distinct-eigenvalue eigenvectors are independent; $tr A=sum_i λ_i$, $det A=product_i λ_i$ (with AM).
- Over $RR$, diagonalizable iff all eigenvalues are real and GM=AM for each; over $CC$, require GM=AM allowing complex eigenvectors (equiv. $n$ independent eigenvectors over the field).
- Parameters: find eigenvalues/AM; split coincident-root cases and compute GM in each; require sum GM=$n$. Example $mat(r,0,t;0,s,0;0,0,s)$ diagonalizable iff $r!=s$ or $t=0$.
- Consequences: diagonalizable with sole eigenvalue $λ$ implies $A=λ I$; $A^k=0$ has only eigenvalue $0$ and is diagonalizable iff $A=0$. Nonzero combinations in one eigenspace are eigenvectors; in an eigenbasis $x=sum c_i v_i$, this holds iff nonzero $c_i$ use one eigenvalue. If $A=P H P^(-1)$ and $H w=λ w$, then $P w$ is an eigenvector of $A$.
- Real $A$ is symmetric iff orthogonally diagonalizable; diagonalizable alone does not imply symmetry.
- Diagonalise: put $n$ independent eigenvectors in $P$ and matching eigenvalues in $D$; $A=P D P^(-1)$, $A^k=P D^k P^(-1)$; check $A P=P D$. Negative $k$ requires invertible $A$.
- For diagonalizable $A$, if $x=sum c_i v_i$, then $A^k x=sum c_i λ_i^k v_i$: $|λ_i|<1$ modes vanish, $λ_i=1$ persist, $λ_i=-1$ alternate, and $|λ_i|>1$ requires $c_i=0$ for convergence.
- If every $λ_i!=1$ has $|λ_i|<1$, then $lim_(k->oo) A^k x=P diag(d_i)P^(-1)x=sum_(λ_i=1)c_i v_i$ ($d_i=1$ for $λ_i=1$, else $0$). This need not be an orthogonal projection; if $dim E_1=1$, limits lie along its eigenvector.

#sec(11, "Singular value decomposition (SVD)")
Full SVD: $A=U Sigma V^T$, $U in RR^(m times m)$, $Sigma in RR^(m times n)$, $V in RR^(n times n)$; $U^T U=I_m$, $V^T V=I_n$. The diagonal entries are $σ_1>=dots>=σ_r>0$ then $0$; $r=rank A$.
- Steps: (1) Diagonalise $A^T A$ with an orthonormal eigenbasis $v_i$; orthonormalise within repeated eigenspaces. (2) Sort $λ_i$ decreasing, set $σ_i=sqrt(λ_i)$ ($λ_i>=0$). (3) For $σ_i>0$, set $u_i=A v_i/σ_i$. (4) Complete $U$ by an orthonormal basis of $Null(A^T)$; zero-eigenvalue $v_i$ form a basis of $Null(A)$ and complete $V$. Extra $U$ columns are needed when $m>n$, even at full column rank. (5) Form rectangular $Σ$ with $σ_i$ on its diagonal and zeros elsewhere; check $A=U Σ V^T$, $U^T U=I_m$, $V^T V=I_n$.
- $A^T A=V(Σ^T Σ)V^T$, $A A^T=U(Σ Σ^T)U^T$: positive eigenvalues agree ($σ_i^2$); zero counts may differ. Reconstruct $A=sum_(i=1)^r σ_i u_i v_i^T$; zero-singular-value completions do not affect $A$.
- Projectors: $proj_(Col(A))=U_r U_r^T$, $proj_(Row(A))=V_r V_r^T$. Keep $U,Σ,V$ ordered together; return $V^T$ as the last factor. For $σ_i>0$, sign-flip $u_i,v_i$ together.
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
- Rank-one $A=bold(a)bold(b)^T!=0$: $σ_1=norm(bold(a))norm(bold(b))$, $u_1=bold(a)/norm(bold(a))$, $v_1=bold(b)/norm(bold(b))$.

#sec(12, "Stochastic matrices & long-run states")
*Column-stochastic:* $p_(i j)>=0$, $bold(1)^T P=bold(1)^T$; $bold(1)$ is the all-ones vector.
$ bold(x)_(k+1)=P bold(x)_k, quad bold(x)_k=P^k bold(x)_0 $
- Probability states have nonnegative entries summing to $1$; $p_(i j)$ is the probability *from $j$ to $i$*.
- Stationary state: RREF $(P-I)bold(pi)=bold(0)$, then choose a nonnegative null vector and scale it so $bold(1)^T bold(pi)=1$; verify $P bold(pi)=bold(pi)$.
- $1$ is an eigenvalue; all $|lambda|<=1$. Regular (some power strictly positive) $arrow.r$ unique stationary probability state and $P^k bold(x)_0 arrow.r bold(pi)$ for every probability state.
- *Row-stochastic:* use row states, $bold(x)_(k+1)^T=bold(x)_k^T P$.
#sub("Geometric transformations")
Positive $theta$: counterclockwise rotation.
$ R_theta=mat(cos theta,-sin theta;sin theta,cos theta), quad R_theta^(-1)=R_(-theta) $
- Reflections: $x$-axis $diag(1,-1)$; $y=x$ swaps coordinates. Line projection $P=hat(bold(u))hat(bold(u))^T$; reflection in line $2P-I_2$.
- Hyperplane reflection $I-2hat(bold(n))hat(bold(n))^T$ (unit normal). Shear $(x,y) arrow.r (x+k y,y)$; scaling $diag(s_x,s_y)$; nonzero translations are not linear.
]

// Fail compilation rather than silently exceeding the double-sided limit.
#context assert(counter(page).final().first() <= 2,
  message: "MA1522 cheatsheet must fit on at most two A4 pages.")

