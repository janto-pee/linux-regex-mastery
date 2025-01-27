
INLINE VARIABLE
formerly: Inline Temp
inverse of: Extract Variable (119)
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
Variables provide names for expressions within a function, and as such they are usually
a Good Thing. But sometimes, the name doesn’t really communicate more than the
expression itself. At other times, you may find that a variable gets in the way of
refactoring the neighboring code. In these cases, it can be useful to inline the variable.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Check that the right­hand side of the assignment is free of side effects.
If the variable isn’t already declared immutable, do so and test.
This checks that it’s only assigned to once.
Find the first reference to the variable and replace it with the right­hand side of the
assignment.
Test.
Repeat replacing references to the variable until you’ve replaced all of them.
Remove the declaration and assignment of the variable.
Test.