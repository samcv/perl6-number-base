use v6;
use Test;
use lib 'lib';
use Number::Base;
is to-base(10, 1), '1111111111', '10.to-base(1)';
done-testing;