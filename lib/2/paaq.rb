#fronta

class Paaq
  @elems
  
  def initialize
    @elems = Queue.new
  end
  
  def size
    @elems.size
  end
  
  def empty?
    @elems.empty?
  end
  
  def push(it)
    #if $v[it.get_key].nil?
      @elems.push(it) 
      #$v[it.get_key] = it
    #end
  end
  
  def pop()
    @elems.pop()
  end
  
end