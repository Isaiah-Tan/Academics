// Self-contained TI-84 Plus CE reference; no external Typst packages.
#set document(title: "TI-84 Plus CE — Eigenvalues & Gram–Schmidt Keypress Guide")
#set page(paper: "a4", margin: (x: 15mm, y: 13mm),
  footer: context align(center, text(size: 8pt)[TI-84 Plus CE · #counter(page).display()]))
#set text(font: "Libertinus Serif", size: 10pt)
#set par(leading: 0.5em, spacing: 0.6em)
#set heading(numbering: none)
#let tr = math.op("tr")
#set list(spacing: 4pt)
#set enum(spacing: 5pt)
#set table(inset: 5pt, stroke: 0.4pt)
#show raw: set text(size: 9pt)
#let note(body) = block(width: 100%, inset: 8pt, fill: luma(94%), radius: 3pt)[#body]
#let next(title) = [#pagebreak() #heading(level: 1, title)]

= TI-84 Plus CE: keypress guide
*MA1522 · Characteristic polynomials, eigenvalues, eigenvectors & Gram–Schmidt*

This is a numerical checking and computation guide. The stock TI-84 Plus CE has no computer algebra system: it does not symbolically expand determinants or return exact eigenvectors automatically. Write the mathematical argument separately when a question asks for working.

== 1. Read the keypress notation first
- `→` between key names means “then press”; `STO→` means the physical store key above `ON`.
- `2nd → x⁻¹` opens *MATRIX*. `2nd → STAT` opens *LIST*. `2nd → TRACE` opens *CALC*.
- `2nd → MODE` means *QUIT* to the home screen. `2nd → ENTER` recalls a previous entry for editing; repeat to go further back.
- `(-)` is the negative-sign key on the bottom row. Use it for a negative number; use the subtraction key between expressions.
- `X,T,θ,n` enters the graph variable `X`. Ordinary letter variables use `ALPHA` followed by the key with that letter printed above it.
- In a formula, `[A]` means the *matrix token*, not separately typed brackets and a letter. Insert it using `2nd → x⁻¹ → NAMES → 1:[A]`.
- `L1` through `L6` mean list tokens: `2nd → 1` through `2nd → 6`. Braces are `2nd → (` for `{` and `2nd → )` for `}`.
- Insert function names from their menus; typing the individual letters does not insert the command token. A selected command often includes its opening parenthesis already.

== 2. One-time setup and common commands
1. `MODE`: select *Normal*, *Float*, *Func*, *Real*. Move to each choice and press `ENTER`; finish with `2nd → MODE`.
2. For the literal command syntax used below, select *Classic* on the `MODE` page. If using MathPrint instead, fill its fields and use the right arrow to leave fractions, exponents and templates.
3. Before graphing: `Y=`; highlight old expressions and press `CLEAR`. Move to each active `Plot1`, `Plot2`, `Plot3` label at the top and press `ENTER` to turn it off.

#table(columns: (1fr, 2fr),
  table.header[*Command/token*][*Keypress route*],
  [`det(`], [`2nd → x⁻¹ → RIGHT` to MATH → `1`],
  [`identity(`], [MATRIX → MATH → `5`],
  [`rref(`], [MATRIX → MATH → scroll to `B:rref(` → `ENTER`],
  [`sum(`], [`2nd → STAT → RIGHT → RIGHT` to MATH → `5`],
  [`√(` / `Ans`], [`2nd → x²` / `2nd → (-)`],
  [Decimal to fraction], [`MATH → 1:►Frac`],
  [`Y1` token], [`VARS → RIGHT` to Y-VARS → `1:Function → 1:Y1`],
)
Menu *names* take priority if OS versions arrange items differently. To find an unfamiliar command: `2nd → 0` opens CATALOG; use its alphabet jump and arrows, then `ENTER`.

#next("3. Graph a determinant to find real eigenvalues")
For a square matrix, use the monic convention $p_A(x)=det(x I-A)$. Its roots are the eigenvalues. Using $det(A-x I)$ changes the polynomial by $(-1)^n$ and gives the same roots.

== A. Enter a matrix once
Use this example throughout sections 3–5:
$ A=mat(2,1,0;1,2,0;0,0,4). $
1. `2nd → x⁻¹ → RIGHT → RIGHT` selects MATRIX → EDIT.
2. `1:[A]`. Type `3 → ENTER → 3 → ENTER` for rows and columns.
3. Enter entries *row by row*, pressing `ENTER` after each:
   `2, 1, 0, 1, 2, 0, 0, 0, 4` (commas here separate entries; do not press the comma key in the editor).
4. `2nd → MODE` returns home. Editing an existing matrix overwrites its previous contents.

== B. Enter the determinant as a function
1. `Y= → CLEAR` on `Y1`.
2. Insert `det(`: `2nd → x⁻¹ → RIGHT → 1`.
3. Press `X,T,θ,n → ×`.
4. Insert `identity(`: `2nd → x⁻¹ → RIGHT → 5`; type `3 → )`.
5. Press subtraction; insert `[A]`: `2nd → x⁻¹ → 1`; close `)`.
6. Check that the expression is exactly:
   ```text
   Y1=det(X*identity(3)-[A])
   ```
   Use the actual matrix size in `identity(n)`. Subtracting `X` directly from `[A]` is not the same operation and causes a dimension/type error.
7. `WINDOW`: set `Xmin=-1`, `Xmax=5`, `Xscl=1`, `Ymin=-15`, `Ymax=10`, `Yscl=5`; leave other settings at their defaults. Enter negative bounds with `(-)`.
8. `GRAPH`. The curve crosses the axis near 1, 3 and 4. Determinants can graph slowly; this is normal.

== C. Use CALC → zero for each crossing
1. `2nd → TRACE → 2:zero`.
2. At *Left Bound?*, type `0 → ENTER`.
3. At *Right Bound?*, type `2 → ENTER`.
4. At *Guess?*, type `1 → ENTER`. Read `X≈1`.
5. Repeat with left/right/guess `2, 3.5, 3` to get 3; repeat with `3.5, 4.5, 4` to get 4.
6. To keep a computed root: return home and enter `X STO→ R ENTER`. Graph CALC updates `X`; store it before another graph calculation changes it.

#note[*What this does:* gives numerical real roots of the characteristic polynomial. It does *not* display its expanded coefficients. A graph window can hide roots; finding three crossings only completes the search here because the matrix is 3 × 3 and the roots are distinct.]

#next("4. Recover the characteristic polynomial")
== A. Fast exact formulas for small matrices
*2 × 2:* $p_A(x)=x^2-t x+d$, where $t=a_(11)+a_(22)$ and $d=det(A)$.

On home, enter `[A](1,1)+[A](2,2) STO→ T ENTER`, then `det([A]) STO→ D ENTER`. Each `[A]` comes from MATRIX → NAMES → 1. Read `T` and `D`; write the polynomial yourself. Use `X²-T*X+D` in `Y1` for faster graphing.

*3 × 3:* $p_A(x)=x^3-t x^2+s x-d$, with
$ t=tr(A), quad s=(t^2-tr(A^2))/2, quad d=det(A). $
No built-in trace command is needed:
1. `[A](1,1)+[A](2,2)+[A](3,3) STO→ T ENTER`.
2. `[A] x² STO→ [B] ENTER` computes the *matrix square*. This overwrites `[B]`.
3. `(T²-([B](1,1)+[B](2,2)+[B](3,3)))/2 STO→ S ENTER`.
4. `det([A]) STO→ D ENTER`.
5. For the example: `T=8`, `S=19`, `D=12`, hence
   $ p_A(x)=x^3-8x^2+19x-12=(x-1)(x-3)(x-4). $
6. Replace the determinant expression in `Y1` with `X^3-T*X²+S*X-D` to graph faster. Preserve the coefficients before reusing `T`, `S`, `D`.

For integer/rational inputs these formulas often recover simple exact coefficients; displayed decimals and floating-point arithmetic still require checking. Avoid claiming exactness solely from `►Frac`.

== B. Reconstruct a cubic using evaluations of the graph function
This is another way to obtain coefficients, using the fact that a 3 × 3 characteristic polynomial is monic. Leave `Y1=det(X*identity(3)-[A])`.
1. Home: `Y1(0) STO→ C ENTER`.
2. `Y1(1)-1-C STO→ U ENTER`.
3. `Y1(-1)+1-C STO→ V ENTER` (use `(-)` for −1).
4. `(U+V)/2 STO→ H ENTER`; `(U-V)/2 STO→ K ENTER`.
5. Then $p_A(x)=x^3+H x^2+K x+C$. For the example: `C=-12`, `U=11`, `V=-27`, `H=-8`, `K=19`.

Insert `Y1` through `VARS → RIGHT → 1 → 1`; do not type the letters Y and 1. This works because the polynomial is a *monic cubic*. It is not a formula for arbitrary matrix sizes, and sampling can amplify rounding errors.

== C. Essential sanity checks
- Leading coefficient is 1; coefficient of $x^(n-1)$ is $-tr(A)$; constant is $(-1)^n det(A)$.
- Sum of eigenvalues with multiplicity is $tr(A)$; product is $det(A)$.
- If $A$ is triangular, its diagonal entries are already its eigenvalues, with repetitions: $p_A(x)=product_i(x-a_(i i))$. No graphing needed.

#next("5. Repeated roots, complex roots & eigenvectors")
== A. A graph can miss eigenvalues
- *Even multiplicity:* for `diag(2,2,4)`, $p_A(x)=(x-2)^2(x-4)$. At 2 the curve touches the axis without changing sign. CALC → zero may fail because it cannot find a sign-changing bracket.
- Zoom around a suspected touching point. `2nd → TRACE → 3:minimum` or `4:maximum`, then choose left bound, right bound and guess. A near-zero extremum is a *candidate*, not proof of a repeated root. Verify the polynomial and its factorization algebraically.
- *Odd multiplicity greater than one:* the curve crosses but may be very flat. One visible crossing does not reveal multiplicity.
- *Complex eigenvalues:* a real graph cannot show them. For $mat(0,-1;1,0)$, $p_A(x)=x^2+1$ has no real zeros and eigenvalues $plus.minus i$. Changing to complex mode does not make the graph show complex roots.
- For a quadratic, compute $(t plus.minus sqrt(t^2-4d))/2$; use MODE → `a+bi` for a negative discriminant and return to Real for the remaining real-matrix workflows. Higher-degree complex roots require a suitable polynomial-root app/tool or algebra; they are not supplied by CALC → zero.

== B. Find an eigenspace after identifying an eigenvalue
For the running example, take the exact eigenvalue 3.
1. Home: `3 STO→ R ENTER`.
2. Insert `rref(`: `2nd → x⁻¹ → RIGHT`, scroll to `B:rref(`, `ENTER`.
3. Enter `[A]-R*identity(3))` to make:
   ```text
   rref([A]-R*identity(3))
   ```
4. `ENTER` gives rows `(1,-1,0)`, `(0,0,1)`, `(0,0,0)`.
5. Interpret the homogeneous equations: $x_1=x_2$, $x_3=0$. Set the free variable $x_2=1$: an eigenvector is $(1,1,0)^T$.
6. For each free variable, set it to 1 and the other free variables to 0. These special solutions form an eigenspace basis. Geometric multiplicity equals the number of free variables.

*Do not use an uncorrected decimal root in RREF to infer nullity.* If `R` is only approximately an eigenvalue, the matrix can appear invertible. For simple exact roots, verify and re-enter the exact value. For irrational roots, use algebra for the exact null space; numerical RREF is only a rough check and can give misleading pivots.

== C. Check an eigenpair or a diagonalisation
- Enter a candidate eigenvector as an $n times 1$ matrix `[B]`, and compute `[A]*[B]-R*[B]`. All components should be zero, or small relative to the input scale for approximate data. The candidate vector must be nonzero.
- For a proposed eigenvector matrix, use an available matrix name such as `[C]`: put eigenvectors in its *columns*. Put matching eigenvalues in diagonal matrix `[D]`. Check `[A]*[C]-[C]*[D]` and that `[C]` is invertible.
- The calculator has matrix names `[A]`–`[J]`. Diagonalisation requires enough independent eigenvectors, not merely a list of roots.

#next("6. Fast Gram–Schmidt with lists")
== A. Enter vectors and learn the three reusable operations
Store vector components as lists of the same length. For example,
$ v_1=(1,1,0)^T, quad v_2=(1,0,1)^T, quad v_3=(0,1,1)^T. $
On home, type the following, pressing `ENTER` after each line:
```text
{1,1,0}→L1
{1,0,1}→L2
{0,1,1}→L3
```
For the first line, actual keys are `2nd → ( → 1 → , → 1 → , → 0 → 2nd → ) → STO→ → 2nd → 1 → ENTER`. Substitute the other entries and destination lists for subsequent lines. Existing list contents are overwritten.

#table(columns: (1fr, 1.65fr),
  table.header[*Operation*][*Enter on home*],
  [Dot product $u dot v$], [`sum(L1*L2)`],
  [Squared norm $norm(u)^2$], [`sum(L1²)`],
  [Norm / normalization], [`√(sum(L1²))` / `L1/√(sum(L1²))`],
)
Insert `sum(` with `2nd → STAT → RIGHT → RIGHT → 5`. Multiplication of lists is component by component; `sum` turns those products into a dot product. List squaring is also component by component.

== B. Orthogonalise first; normalize only at the end
This keeps intermediate entries rational and makes hand transcription easier.
1. Keep `L1` unchanged: it is $u_1=v_1$.
2. Subtract the projection of $v_2$ onto $u_1$:
   ```text
   L2-sum(L1*L2)/sum(L1²)*L1→L2
   ```
   `ENTER` gives `L2={.5,-.5,1}`. The right side is evaluated using the old `L2` before storing the new list.
3. Subtract both projections from $v_3$ in one expression:
   ```text
   L3-sum(L1*L3)/sum(L1²)*L1
     -sum(L2*L3)/sum(L2²)*L2→L3
   ```
   Type this as *one continuous entry*. Result: `L3={-2/3,2/3,2/3}` numerically.
4. Check `sum(L1*L2)`, `sum(L1*L3)`, `sum(L2*L3)`: all should be zero, up to rounding.
5. For an *orthogonal* basis, stop here. For an *orthonormal* basis, do the next section only after finishing all projection subtractions.

#note[*Dependence check:* if a new residual has zero norm, skip it; it adds no basis vector. Never divide by zero. A tiny residual may indicate dependence or numerical cancellation; compare its norm to that of the original vector and check the exact algebra.]

#next("7. Gram–Schmidt normalization & checks")
== A. Optional rescaling and normalization
For the example, multiplying `L2` by 2 and `L3` by 3/2 gives a simpler orthogonal basis:
```text
2*L2→L2
3/2*L3→L3
```
Now the lists are `{1,1,0}`, `{1,-1,2}`, `{-1,1,1}`. Any nonzero rescaling preserves orthogonality and span. If you rescale before processing later vectors, always recompute the projection denominator `sum(Li²)`.

Normalize each list, pressing `ENTER` after each:
```text
L1/√(sum(L1²))→L1
L2/√(sum(L2²))→L2
L3/√(sum(L3²))→L3
```
The exact orthonormal basis is
$ q_1=(1,1,0)^T/sqrt(2), quad q_2=(1,-1,2)^T/sqrt(6), quad q_3=(-1,1,1)^T/sqrt(3). $
Check squared norms are approximately 1 and pairwise dot products approximately 0. Keep the exact radical form in written answers; the lists contain decimal approximations.

== B. More than three vectors; better numerical behaviour
- For a fourth input in `L4`, use `L4-sum(L1*L4)/sum(L1²)*L1-sum(L2*L4)/sum(L2²)*L2-sum(L3*L4)/sum(L3²)*L3→L4` before normalization. Continue the pattern with more storage as needed.
- For vectors that are close to dependent, use *modified Gram–Schmidt*: store the working vector in `L4`, then evaluate and store `L4-sum(L1*L4)/sum(L1²)*L1→L4`; next do the same with `L2`, then `L3`. Each projection uses the updated residual. A second pass can reduce accumulated loss of orthogonality.
- Preserve originals in other lists/matrices before overwriting if you want to repeat the calculation.

*Storage and rounding:* keep full-precision lists while computing. Use `STO→` to preserve results; `Ans` changes after every calculation. `►Frac` is a rational approximation, not a guarantee of an exact answer. If you skip a dependent vector, later projections must use only the nonzero basis vectors retained so far.

#v(3pt)
#text(size: 8pt)[Reference: #link("https://education.ti.com/html/webhelp/EG_TI84PlusCE/EN/index.html")[Texas Instruments TI-84 Plus CE eGuide] (matrix commands, list operations and graph CALC). Menu labels are for the English TI-84 Plus CE OS.]
