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
- Solve: row-reduce $lr([A ∣ bold(b)])$ to RREF; check for a row $[0 dots 0 ∣ c]$, $c!=0$. If consistent, choose free variables and solve pivots bottom-up. For $Null(A)$, set each free variable to $1$ in turn (others $0$) and solve the homogeneous system.
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
  Leave free variables as parameters to get $bold(x)_p$; their coefficient vectors give a basis for $Null(A)$.
- With parameters: choose pivots that stay nonzero; split exceptional values before dividing, inspect residual rows for vanishing/proportionality, then use nullity $n-r$.

#sec(2, "Matrix algebra, inverses & LU")
- $A B$ exists for $A_(m times n),B_(n times p)$; $(A B)_(i j)=sum_(k=1)^n a_(i k)b_(k j)$. Usually $A B != B A$.
- $(A B)^T=B^T A^T$; $(A+B)^T=A^T+B^T$.
- For invertible factors: $(A B)^(-1)=B^(-1) A^(-1)$; $(A^T)^(-1)=(A^(-1))^T$.
- Inverse by elimination: $lr([A ∣ I]) arrow.r lr([I ∣ A^(-1)])$.
- $A X=B arrow.r X=A^(-1)B$; $X A=B arrow.r X=B A^(-1)$, when $A$ is invertible. Preserve multiplication order.
- Elementary $E$: apply one row operation to $I$; left multiplication performs it, $E^(-1)$ reverses it. If $E_k dots E_1 A=R$, then $A=E_1^(-1)dots E_k^(-1)R$. Swap is self-inverse; scaling $c$ reverses by $1/c$; adding $c R_j$ to $R_i$ reverses with $-c R_j$.
#sub("LU factorisation & solving")
- Rectangular $A_(m times n)$: initialize $U=A$, $L=P=I_m$. Scan columns $j$ with pivot row $k$: skip if $U_(k:m,j)=0$; otherwise swap a nonzero entry into row $k$ in $U,P$ and in the already-filled columns of $L$. For each $i>k$, store $ell_(i k)=u_(i j)/u_(k j)$ and update $U_i arrow.l U_i-ell_(i k)U_k$; advance $k$. Then $P A=L U$.
- Solve: compute $bold(c)=P bold(b)$; forward-solve $y_i=c_i-sum_(j<i)ell_(i j)y_j$, then back-solve $x_i=(y_i-sum_(j>i)u_(i j)x_j)/u_(i i)$. For rectangular $U$, check zero rows for consistency and leave non-pivots free.
- Since $L$ is invertible, $Null(A)=Null(U)$ and $rank(A)=rank(U)$. Pivot columns of $U$ select a basis from the *original columns of* $A$, not $U$.
- Reconstruct from $A v_j=b_j$: compute $w_j=U v_j$; use $L w_j=b_j$ for each $j$ to solve the subdiagonal entries of unit lower-triangular $L$, then verify $A=L U$.

#sec(3, "Determinants & invertibility")
For square $A in RR^(n times n)$:
- Cofactor $C_(i j)=(-1)^(i+j) det(M_(i j))$; expand along any row/column: $det A=sum_j a_(i j) C_(i j)$.
- Elimination: triangularise; multiply pivots, correcting for swaps (sign) and scalings (factor); row additions preserve determinant.
- If $det A != 0$, $adj(A)=(C_(i j))^T$ and $A^(-1)=adj(A)/(det A)$.
- $det(A B)=det A det B$; $det(A^T)=det A$; $det(c A)=c^n det A$; triangular $det A=product_i a_(i i)$. For $P A=L U$, $det A=det P product_i u_(i i)$.
#sub("Rectangular rank & one-sided inverses")
$rank(A)<=min(m,n)$. For $A in RR^(m times n)$, $A^T A$ is invertible iff $rank(A)=n$ (full column rank): $x^T A^T A x=norm(A x)^2$, so $Null(A^T A)=Null(A)$.
- *Find a left inverse:* check $rank(A)=n$; compute $G=A^T A$, then $L_0=G^(-1)A^T$. It satisfies $L_0 A=I_n$. This requires independent columns and $m>=n$.
- *Find a right inverse:* check $rank(A)=m$; compute $H=A A^T$, then $R_0=A^T H^(-1)$. It satisfies $A R_0=I_m$. This requires columns spanning $RR^m$ and $n>=m$.
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
- Intersection: find a basis of $Null([B -C])$; each null vector stacks $(bold(s),bold(t))$ with $B bold(s)=C bold(t)$. Map each to $B bold(s)$ and discard dependent images; the rest form a basis of $Col(B) inter Col(C)$.

#sec(6, "Coordinates & change of basis")
Let $B=[bold(b)_1 dots bold(b)_k] in RR^(m times k)$ be a basis matrix for $W subset.eq RR^m$. For $bold(x) in W$, solve $B bold(c)=bold(x)$; the unique solution is $[bold(x)]_cal(B)=bold(c)=(B^T B)^(-1)B^T bold(x)$ (do not invert rectangular $B$).
- If $B$ is orthogonal, $c_i=(bold(b)_i^T bold(x))/(bold(b)_i^T bold(b)_i)$. For $bold(x)=B bold(c), bold(y)=B bold(d)$, $bold(x)^T bold(y)=bold(c)^T(B^T B)bold(d)$. Coordinates preserve addition/scalars; dot products and lengths for all vectors iff the basis is orthonormal.
- *Transition from $B$ to $C$* (same $W$): $K_(C<-B)=lr([[bold(b)_1]_cal(C) quad dots quad [bold(b)_k]_cal(C)])$; its columns are the vectors of basis $B$ written in $C$-coordinates, so $[bold(x)]_cal(C)=K_(C<-B)[bold(x)]_cal(B)$.
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
- Projection recipe: orthonormalise a basis of $W$ to get $Q$; compute coordinates $bold(c)=Q^T bold(b)$, projection $Q bold(c)$, and residual $bold(b)-Q bold(c)$.
- Hyperplane $W={bold(x):bold(n)^T bold(x)=0}$: $proj_W bold(x)=bold(x)-bold(n)(bold(n)^T bold(x))/(bold(n)^T bold(n))$, $bold(n)!=bold(0)$.
- $P_W^2=P_W$, $P_W^T=P_W$; $I-P_W$ projects onto $W^perp$.
  Residual $bold(b)-proj_W bold(b) in W^perp$;
  $"dist"(bold(b),W)=norm(bold(b)-proj_W bold(b))$.
#sub("Gram–Schmidt & QR")
For full-column-rank $A=[bold(a)_1 dots bold(a)_k]$, repeat for $j=1,...,k$:
1. Start $bold(w)=bold(a)_j$.
2. For $i=1,...,j-1$, compute $r_(i j)=bold(q)_i^T bold(a)_j$ and update $bold(w) arrow.l bold(w)-r_(i j)bold(q)_i$.
3. Set $r_(j j)=norm(bold(w))$ and $bold(q)_j=bold(w)/r_(j j)$.
Assemble $Q=[bold(q)_1 dots bold(q)_k]$ and upper-triangular $R=(r_(i j))$ (zeros below diagonal); then $A=Q R$, $Q^T Q=I_k$. A zero $bold(w)$ flags dependent columns; do not divide by zero.
- Square orthogonal $Q$: $Q^(-1)=Q^T$, $det Q=plus.minus 1$; preserves lengths and dot products. Rectangular $Q^T Q=I$ does *not* imply $Q Q^T=I$.

#sec(9, "Least squares")
Minimise $norm(A bold(x)-bold(b))^2$. Normal equations:
$ A^T A hat(bold(x))=A^T bold(b) $
- Normal equations always consistent; fitted vector $A hat(bold(x))=proj_(Col(A)) bold(b)$ unique. Coefficients need not be unique.
- If $rank A=n$:
  $ hat(bold(x))=(A^T A)^(-1)A^T bold(b) $
  Or, using the thin QR $A=Q R$: (1) compute $bold(c)=Q^T bold(b)$; (2) back-solve $R hat(bold(x))=bold(c)$, from $i=n$ down to $1$ using $hat(x)_i=(c_i-sum_(j=i+1)^n r_(i j)hat(x)_j)/r_(i i)$; (3) fitted vector $=Q bold(c)=Q Q^T bold(b)$, residual $=bold(b)-Q bold(c)$, and minimum squared error $=norm(bold(b)-Q bold(c))^2$. $Q^T bold(b)$ is coordinates, not the fitted vector or coefficients.
- Rank deficient: solve the normal equations for one solution $hat(bold(x))_0$ (set free variables to $0$); add any vector in $Null(A)$ to get all LS solutions. They are unique iff $rank A=n$; $Null(A^T A)=Null(A)$, and $A^+bold(b)$ is the minimum-norm one.
- Normal-equation residual check: $A^T(bold(b)-A hat(bold(x)))=bold(0)$.
- Fit $y=beta_0+beta_1 t$: row $i$ of $A$ is $(1,t_i)$, $bold(b)=⟨y_1,dots,y_m⟩$. For a degree-$d$ fit use $(1,t_i,dots,t_i^d)$.

#sec(10, "Eigenvalues & diagonalisation")
For $A in RR^(n times n)$:
$ A bold(v)=lambda bold(v), quad bold(v)!=bold(0), quad p_A(lambda)=det(lambda I-A) $
- *Eigenpairs:* find roots $λ$ of $p_A(λ)=det(λ I-A)$ (for integer coefficients, test $±p/q$, then synthetic-divide; use quadratic formula if needed). For each $λ$, row-reduce $A-λ I$; set free variables to obtain a basis of $E_λ=Null(A-λ I)$.
- AM = multiplicity as a root; GM $=dim E_λ=n-rank(A-λ I)$; $1<=GM<=AM$. Distinct-eigenvalue eigenvectors are independent; $tr A=sum_i λ_i$, $det A=product_i λ_i$ (with AM).
- *Quick checks over $RR$:* symmetric $A$ is orthogonally diagonalizable; $n$ distinct real eigenvalues guarantee diagonalizability; triangular matrices have their diagonal entries as eigenvalues (repeats still need a GM check). In general, over $RR$ require real eigenvalues and GM=AM for each; over $CC$, require GM=AM allowing complex eigenvectors.
- Parameters: find eigenvalues/AM; split coincident-root cases and compute GM in each; require sum GM=$n$. Example $mat(r,0,t;0,s,0;0,0,s)$ diagonalizable iff $r!=s$ or $t=0$.
- Consequences: diagonalizable with sole eigenvalue $λ$ implies $A=λ I$; $A^k=0$ has only eigenvalue $0$ and is diagonalizable iff $A=0$. Nonzero combinations in one eigenspace are eigenvectors; in an eigenbasis $x=sum c_i v_i$, this holds iff nonzero $c_i$ use one eigenvalue. If $A=P H P^(-1)$ and $H w=λ w$, then $P w$ is an eigenvector of $A$.
- Real $A$ is symmetric iff orthogonally diagonalizable; diagonalizable alone does not imply symmetry.
- Diagonalise: choose eigenvectors from the eigenspace bases; if they give $n$ independent vectors, put them in $P$ and their eigenvalues in matching diagonal positions of $D$. Then $A=P D P^(-1)$; verify $A P=P D$. Negative $k$ requires invertible $A$.
- For diagonalizable $A$, if $x=sum c_i v_i$, then $A^k x=sum c_i λ_i^k v_i$: $|λ_i|<1$ modes vanish, $λ_i=1$ persist, $λ_i=-1$ alternate, and $|λ_i|>1$ requires $c_i=0$ for convergence.
- If every $λ_i!=1$ has $|λ_i|<1$, then $lim_(k->oo) A^k x=P diag(d_i)P^(-1)x=sum_(λ_i=1)c_i v_i$ ($d_i=1$ for $λ_i=1$, else $0$). This need not be an orthogonal projection; if $dim E_1=1$, limits lie along its eigenvector.

#sec(11, "Singular value decomposition (SVD)")
Every real or complex matrix has an SVD; complex case uses conjugate transpose throughout. Full: $A=U Sigma V^T$, with $U in RR^(m times m)$, $Sigma in RR^(m times n)$, $V in RR^(n times n)$; $U^ast U=I_m$, $V^ast V=I_n$ (over $CC$ for complex $A$). Diagonal: $σ_1>=dots>=σ_r>0$ then $0$; $r=rank A$.
- Alternative route (replace steps 1–4): diagonalise $A A^T$ to find orthonormal $u_i$ and eigenvalues $λ_i$; set $σ_i=sqrt(λ_i)$. For $σ_i>0$, compute $v_i=A^T u_i/σ_i$. Zero-eigenvalue vectors give $Null(A^T)$ and complete $U$; complete $V$ with an orthonormal basis of $Null(A)$. Then assemble as in step 5. Thus $A^T A$ finds $V$ first, while $A A^T$ finds $U$ first.
- (1) Form $G=A^T A$ and solve $det(G-λ I)=0$; its $n$ eigenvalues (with multiplicity) are nonnegative. The number of positive eigenvalues is $r=rank(A)$.
- (2) For each distinct $λ$, find a basis of $Null(G-λ I)$ by RREF; orthonormalise each basis, pair its vectors with $λ$, and order by decreasing $λ$. Set $σ_i=sqrt(λ_i)$.
- (3) Multiply once: $W=A V=[A v_1 dots A v_n]$. For $i=1,...,r$, divide column $w_i=A v_i$ by its $σ_i$ to get $u_i=w_i/σ_i$ (the first $r$ columns of $U$). Remaining $w_i=0$; never divide by $σ_i=0$. Keep the corresponding $v_i$ to complete $V$.
- (4) $U_r=[u_1 dots u_r]$ has $r$ columns; full $U$ needs $m$. Find $m-r$ more by solving $A^T u=0$ (RREF), orthonormalise, and append: $U=[U_r U_0]$. Reduced SVD stops at $U_r$.
- (5) Assemble $V=[v_1 dots v_n]$, $U=[u_1 dots u_m]$, and the $m times n$ matrix $Σ$ with $σ_1,...,σ_r$ on its diagonal and zeros elsewhere. Check $A=U Σ V^T$, $U^T U=I_m$, $V^T V=I_n$.
- The two Gram matrices have the same positive eigenvalues $σ_i^2$. Reconstruct $A=sum_(i=1)^r σ_i u_i v_i^T$; zero-singular-value completions do not affect $A$.
- Projectors: $proj_(Col(A))=U_r U_r^T$, $proj_(Row(A))=V_r V_r^T$. Keep $U,Σ,V$ ordered together and return $V^T$ last; sign-flip paired $u_i,v_i$ together.
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

#sec(12, "Stochastic matrices & long-run states")
*Column-stochastic:* $p_(i j)>=0$, $bold(1)^T P=bold(1)^T$; $bold(1)$ is the all-ones vector.
$ bold(x)_(k+1)=P bold(x)_k, quad bold(x)_k=P^k bold(x)_0 $
- Probability states have nonnegative entries summing to $1$; $p_(i j)$ is the probability *from $j$ to $i$*.
- Stationary state: find a basis of $Null(P-I)$ by RREF; choose a nonnegative vector $bold(z)$ in that nullspace and set $bold(pi)=bold(z)/(bold(1)^T bold(z))$. Verify $P bold(pi)=bold(pi)$.
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

