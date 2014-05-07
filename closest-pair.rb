# https://github.com/acmeism/RosettaCodeData/blob/master/Task/Closest-pair-problem/Ruby/closest-pair-problem.rb

Point = Struct.new(:x, :y)

def distance(p1, p2)
  Math.hypot(p1.x - p2.x, p1.y - p2.y)
end



def closest(points)

  mindist, minpts = Float::MAX, []
  points.size.times do |i|

    ((i+1)...(points.size)).each do |j|
      dist = distance(points[i], points[j])
      if dist < mindist
        mindist = dist
        minpts = [points[i], points[j]]
      end
    end
  end

  [mindist, minpts]
end


def closest_recursive(points)

  return closest(points) if points.size <= 3 #?

  xP = points.sort_by {|p| p.x}

  mid = points.size/2
  pL, pR = xP.take(mid), xP.drop(mid)

  dL, pairL = closest_recursive(pL)
  dR, pairR = closest_recursive(pR)

  if dL < dR
    dmin, dpair = dL, pairL
  else
    dmin, dpair = dR, pairR
  end

  # Now find if closest is actually in a split pair
  # That is, not found by the recursive call to pL, pR above

  #
  yP = xP.find_all {|p| (pL[-1].x - p.x).abs < dmin}.sort_by {|p| p.y}

  closest = Float::MAX
  closestPair = []
  0.upto(yP.length - 2) do |i|

    # this inner loop should be at most (8-1) [or] to the end
    # this removes n-based traversal in an inner loop
    range = [ yP.length-1, 7 ].min

    # start at i+1 because we want to check
    # the current yP[i] (outer loop) with the
    # subsequent 7 or less points (range)
    (i+1).upto(range) do |k|

      # we know we can have at most 7 subsequent points to check,
      # but we may have less. We check this by seeing if the y distance
      # from our current point to the next point is greater than our delta
      break if (yP[k].y - yP[i].y) >= dmin # skip this pair and the rest as they cannot be possible

      dist = distance(yP[i], yP[k])
      if dist < closest
        closest = dist
        closestPair = [yP[i], yP[k]]
      end
    end
  end

  if closest < dmin
    [closest, closestPair]
  else
    [dmin, dpair]
  end
  
end

require 'benchmark'

points = Array.new(100) {|i|
  Point.new(
  rand(0..100)*(i+1),
  rand(0..100)*(i+1)
  )
}

puts closest_recursive(points)

Benchmark.bm(10) do |r|
  r.report ("Simple:") {ans = closest_recursive(points)}
end
