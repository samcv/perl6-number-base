use nqp;
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
    elsif $radix == -1 {
        if $Str eq nqp::x('1', $chars) {
            return $chars %% 2 ?? 0 !! 1;
        }
        else {
            die "Malformed base -1 string '$Str'";
        }
    }
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
say from-base('9482', -10);
