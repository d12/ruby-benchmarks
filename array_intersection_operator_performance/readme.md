# Array Intersection Operator Performance

### Question

What is the time complexity of `Array#&`? The optimimal way to calculate array intersection is O(n), so hopefully `Array#&` hits that benchmark.

### The benchmark

We set up a number of values (100, 200, 400, etc) with them doubling each time. For each value we create 2 random arrays with that length. We'll then calculate the intersection for each values arrays 500 times.

If `Array#&` is implemented well, we should see the run time double for each value.

### Results

```
Rehearsal --------------------------------------------------
Array#&(100)     0.027226   0.000799   0.028025 (  0.028168)
Array#&(200)     0.055021   0.000690   0.055711 (  0.055937)
Array#&(400)     0.103034   0.002102   0.105136 (  0.105482)
Array#&(800)     0.199200   0.003372   0.202572 (  0.202955)
Array#&(1600)    0.398418   0.006327   0.404745 (  0.405151)
Array#&(3200)    0.796307   0.008081   0.804388 (  0.805396)
Array#&(6400)    1.633503   0.014384   1.647887 (  1.650046)
Array#&(12800)   3.461536   0.079345   3.540881 (  3.544757)
Array#&(25600)   7.454262   0.142767   7.597029 (  7.604529)
---------------------------------------- total: 14.386374sec

                     user     system      total        real
Array#&(100)     0.026960   0.000129   0.027089 (  0.027327)
Array#&(200)     0.051847   0.000224   0.052071 (  0.052239)
Array#&(400)     0.098342   0.000492   0.098834 (  0.099320)
Array#&(800)     0.203259   0.000530   0.203789 (  0.204343)
Array#&(1600)    0.397450   0.002185   0.399635 (  0.400319)
Array#&(3200)    0.793593   0.005331   0.798924 (  0.799929)
Array#&(6400)    1.628432   0.011965   1.640397 (  1.642390)
Array#&(12800)   3.416334   0.076464   3.492798 (  3.495721)
Array#&(25600)   7.378263   0.141823   7.520086 (  7.528228)
```

The runtime doubles per value, indicating that this function does have linear runtime and `Array#&` is implemented well.