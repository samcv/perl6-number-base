=head1 NAME
Number::Base
=head1 DESCRIPTION
All of the number number bases nobody wants in Rakudo Core!
Supports bases -10 to 1 in addition to allowing you to use bases 2-36 which are
in core.

use nqp;
#| Converts an Int to the requested base. Currently supports base -10 to base 36
sub to-base (Int:D $Int, Int:D $base) is export {
    return nqp::x('1', $Int) if $base == 1;
    if $base == -1 {
        die "base -1 can only represent 0 and 1" if $Int != 0 && $Int != 1;
        return '11' if $Int == 0;
        return '1' if $Int == 1;
    }
    if $base >= 2 && $base <= 36 {
        return $Int.base($base);
    }
    else {
        ...
    }
}
#| Converts a Str from the requested base to an Int. Currently supports base -10
#| to base 36
sub from-base (Str:D $Str, Int:D $radix) is export {
    my int $chars = nqp::chars($Str);
    if $radix == 1 {
        if nqp::iseq_s($Str, nqp::x('1', $chars)) {
            return $chars;
        }
        else {
            my int $i = 0;
            while $i++ < $chars {
                last unless nqp::eqat($Str, '1', $i);
            }
            fail X::Str::Numeric.new(
                :source($Str),
                :pos($i),
                :reason("malformed base-$radix number"),
            )
        }
    }
    # Fast path for base -1
    elsif $radix == -1 {
        if $Str eq nqp::x('1', $chars) {
            return $chars %% 2 ?? 0 !! 1;
        }
        else {
            die "Malformed base -1 string '$Str'";
        }
    }
    # Standard path for bases -2 to -10
    elsif $radix <= -2 && $radix >= -10 {
        my $count = 0;
        my int $i = $chars;
        my int $iter = 0;
        while --$i >= 0 {
            $count += ($radix ** $iter++) *  $Str.substr($i, 1).Int;
        }
        return $count;
    }
    fail X::Syntax::Number::RadixOutOfRange.new(:$radix)
        unless 2 <= $radix <= 36; # (0..9,"a".."z").elems == 36
    return $Str.parse-base($radix);
}
