# Things I googled
# ruby heredoc
# ruby drop
# ruby throw raise
# ruby fail
# ruby case switch
# ruby tail
# ruby return from do block
$ ruby stdin

BOARD = 0...5

LEFT = {
  "NORTH" => "WEST",
  "WEST"  => "SOUTH",
  "SOUTH" => "EAST",
  "EAST"  => "NORTH",
}

RIGHT = {
  "NORTH" => "EAST",
  "EAST"  => "SOUTH",
  "SOUTH" => "WEST",
  "WEST"  => "NORTH",
}

MOVE = {
  "NORTH" => [+0, +1],
  "SOUTH" => [+0, -1],
  "EAST"  => [+1, +0],
  "WEST"  => [-1, +0],
}

def run(input)
  input
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
      state[:f] = LEFT[state[:f]]
      state
    when "RIGHT"
      state[:f] = RIGHT[state[:f]]
      state
    when "MOVE"
      x_offset, y_offset = MOVE[state[:f]]
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
  end[:out]
    .join("\n")
end

## Test suite ##

A = <<-HERE
PLACE 0,0,NORTH
MOVE
REPORT
HERE

AO = "0,1,NORTH"

ar = run(A)
puts(ar)
puts(AO == ar)

B = <<-HERE
PLACE 0,0,NORTH
LEFT
REPORT
HERE

BO = "0,0,WEST"

b_out = run(B)
puts(b_out)
puts(b_out == BO)

C = <<-HERE
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
HERE

CO = "3,3,NORTH"

c_out = run(C)
puts(c_out)
puts(c_out == CO)

D = <<-HERE
PLACE 3,3,EAST
PLACE 5,5,EAST
MOVE
MOVE
MOVE
LEFT
MOVE
MOVE
REPORT
HERE

DO = "4,4,NORTH"

d_out = run(D)
puts(d_out)
puts(d_out == DO)
