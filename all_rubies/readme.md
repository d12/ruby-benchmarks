# Benchmarks across (most) Rubies

Thanks to the [all-ruby](https://github.com/akr/all-ruby) project, it's fairly easy to run scripts against a large number of Rubies. I wanted to try running a few benchmarks to see how Ruby perf has changed over time.

# TLDR

Results are in experiments/results. You can also find the averaged data and graphs [here](https://docs.google.com/spreadsheets/d/1FdtU7Dt2-WbWBbc3TM5_txBk4SJb2tC0HTzKxYtOiEw/edit?usp=sharing). The Ruby scripts used to run the benchmarks are in experiments/.

# The process

## Setting up the VM

All-ruby was built to run on Debian. To run these benchmarks I spun up a DigitalOcean VM on Debian 10. I needed a 50GB disk to install all of the non-preview/rc versions of Ruby. You'd probably need at least 100GB to install them all.

You're supposed to be able to run `rake all` and all-ruby will install all versions, but it wasn't working properly for me and kept erroring out. I also only wanted the major/minor/patch releases and not the preview/rc releases. I ended up using `xargs -0 -n 1 rake < <(tr \\n \\0 <versions_to_install)` to install the versions of Ruby. `rake list` prints all versions of Ruby that all-ruby can install so you can use that to populate `versions_to_install`.

Note that this process takes a long time. It took around 6 hours on my VM.

## Writing the benchmarks

One of the biggest challenges in writing the benchmarks was trying to create benchmarks that would run on all versions of Ruby between 0.49 and 3.0.2. The language has changed a lot in this time! Some neat things I learned:

- `puts` didn't exist originally, so I had to use `print` and `printf`.
- Methods used to need to be invoked with parenthesis, even when there were no methods.
- Iterators and blocks didn't exist originally, so I iterated using a while loop.
- There wasn't a way (that I could find) to get ms-precise time in Ruby.

For the time point, I'm pretty sure I'm missing something since the `Time.now` method existed from 0.49, but `Time.now.to_f` returned an error with no information. Probably no `to_f` method on a time instance but it's difficult to debug since even basic things like `#methods` or `#class` didn't work in 0.49.

What I ended up doing was shelling out to the shell to print ms-precise time using `date`, and then reading that into Ruby. Backticks or any way to recieve stdout from the shell didn't exist in 0.49 so I wrote to a file and then read the file from Ruby. There's a small amount of overhead in this approach but I measured it to be neglible.

## Running the benchmarks

I wrote a `run_benchmarks.rb` script to run all of the benchmarks. It runs each benchmark 5 times and stores all the raw data. This script took several hours to finish running since the string_concat benchmark was very slow. I could've reduced the number of iterations there but I wanted to keep it consistent to make normalizing it easier.

From there, I wrote a `average_out_results.rb` script in the results/ dir which just averages each experiments results into a CSV which I could paste into Google Sheets.

# Learnings

- Ruby 0.49 was _really_ slow in most benchmarks, except string concat for some reason.
- Ruby 2.0.0 improved almost every benchmark by a huge amount. It was probably the single biggest perf upgrade Ruby has ever had.
- Reading from a large hash got almost 3x slower after 2.4.0 and hasn't recovered since. I'm planning on digging into this one some more. There was a big HashTable refactor in 2.4.0, but maybe there are some improvements we can make there to restore hash write performance.
- Hash read and class initialization perf has been slowly getting worse. It doesn't look significant due to Ruby 0/1 perf in the graphs, but class initialization for example was measured at around 90-110 ms for several versions in Ruby 2.x, but >125ms for 3.0.1 and 3.0.2 which amounts to a 25% slowdown in some cases. There may be a regression here that can be improved.

# Notes

- It's important to note that these experiments weren't as rigorous as they could have been. GC wasn't controlled for which could lead to some runs having to do a GC sweep due to garbage allocated in a previous run. The runs were also done on a cheap DigitalOcean instance with a shared CPU. Perf should be steady but isn't guaranteed. Each data point on the graph is averaged from 5 runs which will help smooth anomolies, but individual data points shouldn't be taken too seriously without further benchmarking.
- If you decide to run these benchmarks for yourself, I'd love to hear about your results. You can leave an issue or reach me at njwoodthorpe@gmail.com
- If you have more benchmarks that should be added to this list, please make an issue.
