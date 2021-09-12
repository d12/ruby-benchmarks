# Hamming Weight Performance

The [Hamming Weight](https://en.wikipedia.org/wiki/Hamming_weight) of a number equals the number of 1 bits in it's binary representation. This comes up commonly in interviews and there's a lot of ways to calculate it. Let's find out which is most efficient for 32 bit integers.

# The benchmark

There are 3 methods I'm comparing here. First is the typical "Ruby" way to solve this problem which is to convert the string to a base 2 string and then count the ones. The code is simple and easy to read. Second is a strategy where you AND the number with each power of 32, and sum the ones that don't equal 0. If a power of 32 AND your number != 0, then there's a 1 in position. Last is some crazy bitwise magic solution I found online. You can read more about it here: https://newbedev.com/how-to-count-the-number-of-set-bits-in-a-32-bit-integer

# The results:

```
Rehearsal ------------------------------------------------
String count   0.313295   0.001916   0.315211 (  0.317650)
Bitmasks       1.682928   0.007263   1.690191 (  1.700307)
SWAR bithack   0.078918   0.000251   0.079169 (  0.079287)
--------------------------------------- total: 2.084571sec

                   user     system      total        real
String count   0.301757   0.000372   0.302129 (  0.302509)
Bitmasks       1.684875   0.006765   1.691640 (  1.701975)
SWAR bithack   0.085838   0.000397   0.086235 (  0.086793)
```

Unsurprisingly the fancy magic bithack was the fastest. But what surprises me is that counting the 1's in the binary string was significantly faster than performing 32 AND operations on the number. I assumed the string approach would be slow because strings have overhead and we need to build + iterate over this string. Turns out the string count approach is probably a good bet unless you really need performance. You'll probably annoy your code reviewers if you go with the last option though.