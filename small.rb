#!/usr/bin/env ruby

B = 0...5

puts (ARGF.read
  .split("\n")
  .map{ |l| l.split(/[ ,]/) }
  .drop_while { |c| c.first != "PLACE" }
  .reduce({x: nil, y: nil, f: nil, out: []}) do |s, l|
  n, *a = l
  case n
  when "PLACE"
    x,y,f = a
    z = x.to_i
    t = y.to_i
    next s unless B.include?(z) and B.include?(t)
    s.merge({x: z, y: t, f: f})
  when "LEFT"
    s[:f] = {
      "NORTH" => "WEST",
      "WEST"  => "SOUTH",
      "SOUTH" => "EAST",
      "EAST"  => "NORTH",
}[s[:f]]
    s
  when "RIGHT"
    s[:f] = {
      "NORTH" => "EAST",
      "EAST"  => "SOUTH",
      "SOUTH" => "WEST",
      "WEST"  => "NORTH",
}[s[:f]]
    s
  when "MOVE"
    z, t = {
      "NORTH" => [+0, +1],
      "SOUTH" => [+0, -1],
      "EAST"  => [+1, +0],
      "WEST"  => [-1, +0],
}[s[:f]]
    c =s[:x] + z
    u = s[:y] + t
    next s unless B.include?(c) and B.include?(u)
    s.merge({x: c, y: u})
  when "REPORT"
    s[:out] << [s[:x], s[:y], s[:f]].join(',')
    s
  else
    fail "unknown command"
  end
end)[:out]
