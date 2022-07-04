#!/usr/bin/env ruby

BOARD = 0...5

puts (ARGF.read
  .split("\n")
  .map{ |line| line.split(/[ ,]/) }
  .drop_while { |command| command.first != "PLACE" }
  .reduce({x: nil, y: nil, f: nil, out: []}) do |state, call|
  cmd, *args = call
  case cmd
  when "PLACE"
    x,y,f = args
    xi = x.to_i
    yi = y.to_i
    next state unless BOARD.include?(xi) and BOARD.include?(yi)
    state.merge({x: xi, y: yi, f: f})
  when "LEFT"
    state[:f] = {
      "NORTH" => "WEST",
      "WEST"  => "SOUTH",
      "SOUTH" => "EAST",
      "EAST"  => "NORTH",
}[state[:f]]
    state
  when "RIGHT"
    state[:f] = {
      "NORTH" => "EAST",
      "EAST"  => "SOUTH",
      "SOUTH" => "WEST",
      "WEST"  => "NORTH",
}[state[:f]]
    state
  when "MOVE"
    x_offset, y_offset = {
      "NORTH" => [+0, +1],
      "SOUTH" => [+0, -1],
      "EAST"  => [+1, +0],
      "WEST"  => [-1, +0],
}[state[:f]]
    new_x =state[:x] + x_offset
    new_y = state[:y] + y_offset
    next state unless BOARD.include?(new_x) and BOARD.include?(new_y)
    state.merge({x: new_x, y: new_y})
  when "REPORT"
    state[:out] << [state[:x], state[:y], state[:f]].join(',')
    state
  else
    fail "unknown command"
  end
end)[:out]
