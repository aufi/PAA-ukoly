
class Problem
  
  attr_accessor :buckets, :depth, :id
  
  def final_state?
    ok = true
    @buckets.each { |i|
      ok = false if !i.complete?
    }
    return ok
  end
  
  def get_key
    k = ''
    @buckets.each{ |e| k += e.state.to_s+";" }
    return k
  end
  
  #heuristicka funkce
  def get_price
    x = 500
    @buckets.each{ |e|
      d = e.finalstate.to_i - e.state.to_i 
      x -= d.abs
      x += 50 if e.finalstate.to_i == e.state.to_i
    }
    return x
  end
  
  def step
    
    #self.print_state

    if self.final_state?
      puts "hotovo!! hloubka: "+@depth.to_s+", stavu: "+$v.count.to_s
      #self.print_state
      #$v.each { |key,val| puts key }
      #exit
    end
    problems = Array.new
    @buckets.each_with_index { |e,index|
      #return sam sebe se zmenenym kyblem
      problems.push(self.next_problem(index, 'fill'))
      problems.push(self.next_problem(index, 'empty'))
      @buckets.each_with_index { |dest,destindex| 
        #if !i.index.to_i.equal?(e.index.to_i)
          problems.push(self.next_problem(index, 'move', destindex))
        #end
      }
    }
    ##puts "problemu v hladine "+@depth.to_s+": "+problems.count.to_s
    #problems.each { |e| e.step }
    return problems
  end
  
  def next_problem(index, op, destindex = nil)
    problem = Marshal.load(Marshal.dump(self))  #deep copy
    #pp problem
    problem.buckets[index].fill() if (op.eql?('fill'))
    problem.buckets[index].empty() if (op.eql?('empty'))
    problem.buckets[index].move(problem.buckets[destindex]) if (op.eql?('move'))
    problem.depth = self.depth + 1
    #puts "novy problem:"
    #problem.print_state
    #pp problem
    return problem
  end
  
  def initialize(buckets, depth = 0, id = '')
    @buckets = buckets
    @depth = depth
    @id = id
  end  
  
  def print_state
    print @depth.to_s+": "
    @buckets.each { |i| print i.state.to_s," " } 
    print "\n"
    puts "stavu: "+$v.count.to_s
  end
  
end