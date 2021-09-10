# Array Shift Performance

### Question

`Array` can be used as a queue/stack by using the pop/push/shift/unshift methods. But if these methods aren't O(1) then we shouldn't make a habbit of using Array as a queue/stack. As I was using a queue, I'm specifically interested in `shift` performance. If `shift` is implemented by moving all elements in the array down by one, then we should see `O(N)` performance.

### The benchmark

We set up a small, medium, and large array. For each array, push and shift several hundred thousand values to the array. We expect to see all values be roughly the same.

### Results

```
Rehearsal ------------------------------------------------
small array    0.044455   0.000738   0.045193 (  0.045413)
medium array   0.045567   0.005121   0.050688 (  0.050836)
big array      0.061847   0.013110   0.074957 (  0.075030)
--------------------------------------- total: 0.170838sec

                   user     system      total        real
small array    0.041377   0.000070   0.041447 (  0.041619)
medium array   0.042816   0.002448   0.045264 (  0.045388)
big array      0.042626   0.002496   0.045122 (  0.045286)
```

After rehersal, all size arrays perform roughly identically, so `Array#shift` is implemented in `O(1)`. I looked it up later and turns out `Array#shift` used to be `O(N)` until 2012 when someone fixed that up. https://stackoverflow.com/a/47683752