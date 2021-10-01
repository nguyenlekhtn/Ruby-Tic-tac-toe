# frozen_string_literal: true

def split_3(arr, result = [])
  return result if arr.nil? || arr.empty?

  a, b, c, *rest = arr
  split_3(rest, result << [a, b, c].compact)
end

p split_3([1, 2, 3, 4, 5, 6, 7])
