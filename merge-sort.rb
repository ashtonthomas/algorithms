# https://gist.github.com/nkpart/1286207

def merge_sort a
  return a if a.size <= 1
  l,r = split_array a
  combine(merge_sort(l),merge_sort(r))
end

def split_array a
  mid = a.size/2 # no need to round?
  [a.take(mid), a.drop(mid)]
end

def combine l,r
  return l.empty? ? r : l if l.empty? || r.empty?
  smallest = l.first <= r.first ? l.shift : r.shift
  combine(l,r).unshift(smallest)
end

a = [6,23,53,1,2,5,62,61,33,21,14,6,23].shuffle

p a

p merge_sort(a)


# round, take, drop, shift, unshift,
