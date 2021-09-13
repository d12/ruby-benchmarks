# Ruby Recursion Depth Limit

How deep will Ruby recurse before throwing an error? And is this limit some constant, or is it actually dependent on the size of our stack frames? Here's a little benchmark to find out.

### The benchmark

This script keeps an accumulator variable to track the recursion depth. I also wanted to see if allocating more memory per level would cause the recursion limit to change, so we're comparing a recursive method with one arg vs one with five args. We also try passing a few different types of args to see if that makes a difference, and try one method that doesn't use tailcall recursion to see if that makes a difference.

### Results

```
Recursing with one string arg:
  Depth: 10077

Recursing with one int arg:
  Depth: 10077

Recursing with one int arg and no tailcall:
  Depth: 10077

Recursing with one class arg:
  Depth: 10077

Recursing with 5 string args
  Depth: 7706

Recursing with 5 longer string args
  Depth: 7706
```

The findings from this are:
- The limit is around 10^4 deep with a single argument (on my machine at least)
- The type of arg does not matter. This makes sense since all ruby values are generally pointers.
- More arguments means a lower maximum recursion depth. This is because each stack frame requires more memory.
- The length of string arguments doesn't matter. Again this is because strings are passed as 'pointers'.
- Ruby does not use any tail call recursion optimizations by default. It is available as an optional feature though. See https://nithinbekal.com/posts/ruby-tco/ for info.

After running this I did a bit of research and found that you can set the `RUBY_THREAD_VM_STACK_SIZE` env variable to modify your Ruby stack size. So running the script again with RUBY_THREAD_VM_STACK_SIZE=5000000:

```
Recursing with one string arg:
  Depth: 48084

Recursing with one int arg:
  Depth: 48084

Recursing with one int arg and no tailcall:
  Depth: 48084

Recursing with one class arg:
  Depth: 48084

Recursing with 5 string args
  Depth: 36769

Recursing with 5 longer string args
  Depth: 36769
```

So the `RUBY_THREAD_VM_STACK_SIZE` env variable does work as expected. This is handy, but most recursive programs can be re-written to be iterative and avoid this problem all together.