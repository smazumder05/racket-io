Notes on Racket
================
Racket started as PLT Scheme, a dialect of Scheme, which is in turn a dialect of Lisp, the world’s second oldest high-level programming language, after Fortran. Lisp, of course, is an acronym for “Lots of Irritating Silly Parenthesis”. See [here](http://xkcd.com/224/), here, here for more Lisp humour 
(Actually Lisp stands for “List Processing”).


#### Textbooks and other materials

- [How to Design Programs](http://www.ccs.neu.edu/home/matthias/HtDP2e/Draft/index.html) - on-line version of the MIT Press book. This is an introductory textbook for new programmers which uses Racket to teach programming
- [Programming Languages: Application and Interpretation](http://cs.brown.edu/~sk/Publications/Books/ProgLangs/2007-04-26/) - An advanced book on programming, which uses Racket
- Schemers.org - Is full of links to all kinds of materials. While its focussed on Scheme, it was actually started by the PLT group who are responsible for Racket
- [The Structure and Interpretation of Computer Programs (SCIP)](https://mitpress.mit.edu/sicp/full-text/book/book-Z-H-4.html) - The textbook to the classic MIT introductory course for Computer Science students. It uses Scheme, which is similiar to Racket. This is one of the greatest courses on computer science of all time!
- [MIT Open Courseware SCIP Course](http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/lecture-notes/) - All the of lectures and course materials. Note that the course is also availabl eon iTunes U.
- There is some support for SCIP in Racket [see:](http://www.neilvandyke.org/racket-sicp/)
- [Teach Yourself Scheme in Fixnum Days](http://ds26gte.github.io/tyscheme/index-Z-H-1.html#node_toc_start) - an excellent introduction to Scheme, which is similiar to (but not the same as) Racket
- [The Scheme Programming Language](http://www.scheme.com/tspl4/) - An excellent book for learning Scheme

#### General Racket Information
- Racket is Derived from Scheme

- Racket is a lexically scoped version of Lisp, very similiaer to Scheme. (It was called PLT Scheme until 2010 when is name was changed to Racket to allow it to further evolve in its own direction) The key differeces include:

    - In Racket, a lot of things are self-evaluating which would raise an error in R5RS Scheme
    - In Racket the empty list is treated differently
    - Racket is case sensitive, though R6RS Scheme is also case sensitive
    - Racket cons pairs and list are immutable, unlike Scheme. In Racket mcons is used to create mutable pairs and lists (So no set-car! and set-cdr! - you use set-mcar! and set-mcdr! etc instead).
    - if must have an else branch
    - What Racket calls letrec is called letrec* in R6RS and doesn’t exist in R5RS, what R5RS and R6RS call letrec doesn’t exist in Racket.
    - Racket treats ( ... ), { ... }, and [ ... ] as equivalent, R5RS does not, but R6RS does
    - Racket contains a structure system that is a bit cleaner than the R6RS record system. It has an object oriented class and object system. It has native support for design by contract. It has a unit system reminiscent of the ML module system, as well as a module system much like the R6RS module system.
    - Racket supports multiple languges using its #lang <language> pragma. There is a typed version of Racket, a version which does lazy evaluation, and several other languages, including standard scheme support.
        Both R5RS and R6RS versions of Scheme are supported
    - Racket is not standardized and is undegoing constant evolution … so its more of a “moving target”.

