NAME Number::Base
=================

DESCRIPTION All of the number number bases nobody wants in Rakudo Core! Supports bases -10 to 1 in addition to allowing you to use bases 2-36 which are in core.
================================================================================================================================================================

### sub to-base

```
sub to-base(
    Int:D $Int, 
    Int:D $base
) returns Mu
```

Converts an Int to the requested base. Currently supports base -10 to base 36

### sub from-base

```
sub from-base(
    Str:D $Str, 
    Int:D $radix
) returns Mu
```

Converts a Str from the requested base to an Int. Currently supports base -10 to base 36
