
class Foo
  attr_accessor :id
    @@identifier = 0
  def initialize
    @id =  @@identifier
    @@identifier+= 1
  end
end

# stopwatch = StopWatch.new().start()
# maximize production strategy

# to maximize production we should minimize time spent selling
# we should focus on buying bots and upgrading them
# 1 questions must be answered :
# - depending on stopwatch.duration I should compute a method telling me when I should stop buying bots and launch upgrades



# upgrade strategy

# start with the step that takes the most time
# it is assemble time when Im 50% less than assemble time
# then we do it for bar mining
# then we do it for foo mining

#  si j'achetais 3 robots => 3 foobar en plus toutes les 8s 3/8

# avec un upgrade sur le step 3 qui prend 2s 2*1.7 =3.4 => 3.1
# je passe a 1.8s
# mon temps moyen de production passe a 7.7

# convertir le temps gagne par cycle en unite de production / s * nombre de robot
#0.34s/cycle dassemblage => foobar/s
#0.34*1/8u/cycle
