def count_merge_sort array
  return [0,array] if array.size <= 1

  mid = array.size/2

  left, right = array.take(mid), array.drop(mid)

  left_result = count_merge_sort(left)
  right_result = count_merge_sort(right)

  merge_result = merge_and_count(left_result[1], right_result[1])

  return [
    left_result[0] + right_result[0] + merge_result[0],
    merge_result[1]
  ]

end

def merge_and_count left_array, right_array

  inversions = 0
  merged = []
  i,j = 0,0

  while i < left_array.size and j < right_array.size
    if left_array[i] < right_array[j]
      merged << left_array[i]
      i += 1
    else
      merged << right_array[j]
      j += 1
      inversions += left_array.size - i
    end
  end

  # one of the array is empty,
  # so we have no more inversions
  merged += left_array[i...left_array.size] if i < left_array.size
  merged += right_array[j...left_array.size] if j < right_array.size

  return inversions, merged

end

a = [6,23,53,1,2,5,62,61,33,21,14,6,23]

p a

p count_merge_sort(a)
