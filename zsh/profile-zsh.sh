#!/bin/zsh
# Profile zsh startup time
# Usage: ./profile-zsh.sh

echo "Profiling zsh startup time..."
echo "Running 10 iterations..."
echo ""

total=0
for i in {1..10}; do
  time_output=$( { time zsh -i -c exit } 2>&1 )
  real_time=$(echo "$time_output" | grep real | awk '{print $2}')
  echo "Iteration $i: $real_time"

  # Extract seconds (handle formats like 0m0.123s)
  seconds=$(echo "$real_time" | sed 's/.*m\([0-9.]*\)s/\1/')
  total=$(echo "$total + $seconds" | bc)
done

average=$(echo "scale=3; $total / 10" | bc)
echo ""
echo "Average startup time: ${average}s"
echo ""
echo "To find slow parts, run:"
echo "  zsh -xv 2>&1 | ts -i '%.s' | tee /tmp/zsh-profile.log"
echo "Or use zprof by adding 'zmodload zsh/zprof' at the top of .zshrc"
echo "and 'zprof' at the bottom, then run: zsh -i -c exit"
