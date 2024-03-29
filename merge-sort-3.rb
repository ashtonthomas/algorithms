# https://gist.github.com/aspyct/3433278

def merge_sort(array)
  if array.count <= 1
      # Array of length 1 or less is always sorted
      return array
  end

  # Apply "Divide & Conquer" strategy

  # 1. Divide
  mid = array.count / 2
  part_a = merge_sort array.slice(0, mid)
  part_b = merge_sort array.slice(mid, array.count - mid)

  # 2. Conquer
  array = []
  offset_a = 0
  offset_b = 0

  while offset_a < part_a.count && offset_b < part_b.count
    a = part_a[offset_a]
    b = part_b[offset_b]

    # Take the smallest of the two, and push it on our array
    if a <= b
        array << a
        offset_a += 1
    else
        array << b
        offset_b += 1
    end
  end

  # There is at least one element left in either part_a or part_b (not both)
  while offset_a < part_a.count
    array << part_a[offset_a]
    offset_a += 1
  end

  while offset_b < part_b.count
    array << part_b[offset_b]
    offset_b += 1
  end

  return array
end


a = [6,23,53,1,2,5,62,61,33,21,14,6,23,34,23].shuffle

p a

p merge_sort(a)
