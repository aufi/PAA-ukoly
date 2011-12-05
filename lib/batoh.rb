# To change this template, choose Tools | Templates
# and open the template in the editor.

class Batoh

  attr_accessor :w, :p, :cap, :state, :depth

  #nahodne naplni batoh
  def randomfill
    for i in 0..(@state.size-1) do
      if (rand(10) > 4)
        @state[i] = 1
      else
        @state[i] = 0
      end
    end
  end
  
  # cnt-krat odebere nebo prida vec na nahodnem miste
  def mutate(cnt = 1)
    for i in 0..cnt do
      j = rand(@state.size)
      if (@state[j] == 0)
        @state[j] = 1
      else
        @state[j] = 0
      end
    end
    self
  end
  
  #vezme dva a projde bity tak, ze je nahoda, jestli je bit po mame nebo tatovi
  def kriz(druhej)
    for i in (0..@state.size-1) do
      if (rand(10) > 4)
        @state[i] = @state[i]
      else
        @state[i] = druhej.state[i]
      end
    end
    self
  end
  
  def fitness
    if self.over?
      return 0
    else
      return self.price+(@cap - self.weight)  #zlepseni - pridani volneho mista do fitness
    end
  end
  
  def price
    ps = 0
    for i in 0..@state.size do
      ps += @p[i] if @state[i] == 1
    end
    return ps
  end
  
  def weight
    ws = 0
    for i in 0..@state.size do
      ws += @w[i].to_i if @state[i].eql?(1)
    end
    return ws
  end
  
  def over?
    if (self.weight > @cap)
      return true
    else
      return false
    end
  end
  
  def initialize(w, p, cap, state, depth = 0)
    @w = w
    @p = p
    @cap = cap
    @state = state
    @depth = depth
  end
  
end
