puts `cat a | ./small.rb` == "0,1,NORTH\n" &&
     `cat b | ./small.rb` == "0,0,WEST\n" &&
     `cat c | ./small.rb` == "3,3,NORTH\n" &&
     `cat d | ./small.rb` == "4,4,NORTH\n"
