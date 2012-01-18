
class Reseni
  
  attr_accessor :promenne
  
  # cnt-krat invertuje bit na nahodnem miste
  def mutate(cnt = 1)
    for i in 0..cnt do
      j = rand(@promenne.size)
      if (@promenne[j] == 0)
        @promenne[j] = 1
      else
        @promenne[j] = 0
      end
    end
    self
  end
  
  #vezme dva a projde bity tak, ze je nahoda 50:50, jestli je bit po mame nebo tatovi
  def kriz(druhej)
    for i in (0..@promenne.size-1) do
      if (rand(10) > 4)
        @promenne[i] = @promenne[i]
      else
        @promenne[i] = druhej.promenne[i]
      end
    end
    self
  end
  
  def randomfill
    for i in 0..(@promenne.size-1) do
      if (rand(10) > 4)
        @promenne[i] = 1
      else
        @promenne[i] = 0
      end
    end
  end
  
  def initialize
    @promenne = Array.new(20)
    self.randomfill
  end
  
end