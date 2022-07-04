#!/usr/bin/ruby
B = 0...5
N="NORTH"
S="SOUTH"
E="EAST"
W="WEST"
P="PLACE"
puts (ARGF.read
.split("\n")
.map{|l|l.split(/[ ,]/) }
.drop_while{|c|c.first!=P}
.reduce({x:nil,y:nil,f:nil,out:[]})do|s, l|
n,*a=l
case n
when P
x,y,f=a
z=x.to_i
t=y.to_i
next s unless B.include?(z)and B.include?(t)
s.merge({x:z,y:t,f:f})
when"LEFT"
s[:f]={
N=>W,
W=>S,
S=>E,
E=>N,
}[s[:f]]
s
when"RIGHT"
s[:f]={
N=>E,
E=>S,
S=>W,
W=>N,
}[s[:f]]
s
when"MOVE"
z,t={
N=>[+0,+1],
S=>[+0,-1],
E=>[+1,+0],
W=>[-1,+0],
}[s[:f]]
c=s[:x]+z
u=s[:y]+t
next s unless B.include?(c)and B.include?(u)
s.merge({x:c,y:u})
when"REPORT"
s[:out]<<[s[:x],s[:y],s[:f]].join(',')
s
else
fail
end
end)[:out]
