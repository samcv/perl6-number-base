use nqp;
sub to-base (Int:D $Int, Int:D $base) is export {
    return nqp::x('1', $Int) if $base == 1;
    if $base >= 2 && $base <= 36 {
        return $Int.base($base);
    }
    else {
        ...
    }
}
sub from-base (Str:D $Str, Int:D $radix) is export {
    if $radix == 1 {
        my int $chars = nqp::chars($Str);
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
    fail X::Syntax::Number::RadixOutOfRange.new(:$radix)
        unless 2 <= $radix <= 36; # (0..9,"a".."z").elems == 36
    return $Str.parse-base($radix);
}