## EDITINGNOTIVATIE
SUBSTITUTE ALGORITHM
<!-- Motivation
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-------------------------------------------------------------------------------- -->
I’ve never tried to skin a cat. I’m told there are several ways to do it. I’m sure some are
easier than others. So it is with algorithms. If I find a clearer way to do something, I
replace the complicated way with the clearer way. Refactoring can break down
something complex into simpler pieces, but sometimes I just reach the point at which I
have to remove the whole algorithm and replace it with something simpler. This occurs
as I learn more about the problem and realize that there’s an easier way to do it. It also
happens if I start using a library that supplies features that duplicate my code.
Sometimes, when I want to change the algorithm to work slightly differently, it’s easier
to start by replacing it with something that would make my change more
straightforward to make.
When I have to take this step, I have to be sure I’ve decomposed the method as much as
I can. Replacing a large, complex algorithm is very difficult; only by making it simple
can I make the substitution tractable.
<!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 --><!-- <!-- Mechanics
..........................................................................
..........................................................................
..........................................................................
..........................................................................
..........................................................................

 -->Arrange the code to be replaced so that it fills a complete function.
Prepare tests using this function only, to capture its behavior.
Prepare your alternative algorithm.
Run static checks.
Run tests to compare the output of the old algorithm to the new one. If they are the
same, you’re done. Otherwise, use the old algorithm for comparison in testing and
debugging.
Chapter 8
Moving Features
So far, the refactorings have been about creating, removing, and renaming program
elements. Another important part of refactoring is moving elements between contexts. I
use Move Function (198) to move functions between classes and other modules. Fields
can move too, with Move Field (207).
I also move individual statements around. I use Move Statements into Function (213)
and Move Statements to Callers (217) to move them in or out of functions, as well as
Slide Statements (223) to move them within a function. Sometimes, I can take some
statements that match an existing function and use Replace Inline Code with Function
Call (222) to remove the duplication.
Two refactorings I often do with loops are Split Loop (227), to ensure a loop does only
one thing, and Replace Loop with Pipeline (231) to get rid of a loop entirely.
And then there’s the favorite refactoring of many a fine programmer: Remove Dead
Code (237). Nothing is as satisfying as applying the digital flamethrower to superfluous
statements.
