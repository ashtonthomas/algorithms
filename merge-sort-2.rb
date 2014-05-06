# https://github.com/kanwei/algorithms/blob/master/lib/algorithms/sort.rb
# Mergesort: A stable divide-and-conquer sort that sorts small chunks of the container and then merges them together.
# Returns an array of the sorted elements.
# Requirements: Container should implement []
# Time Complexity: О(n log n) average and worst-case
# Space Complexity: О(n) auxiliary
# Stable: Yes
#
#   Algorithms::Sort.mergesort [5, 4, 3, 1, 2] => [1, 2, 3, 4, 5]
def merge_sort(container)
  return container if container.size <= 1
  mid   = container.size / 2

  # puts "Class of MID: #{mid.class} (#{container.size})"
  # puts "MATH: #{(15.fdiv(2)).round}"

  left, right  = container[0...mid], container[mid...container.size]

  # right = container[mid...container.size]

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  sorted = []
  until left.empty? or right.empty?
    left.first <= right.first ? sorted << left.shift : sorted << right.shift
  end
  sorted + left + right # one of these is empty
end

a = [6,23,53,1,2,5,62,61,33,21,14,6,23,34,23].shuffle

p a

p merge_sort(a)
