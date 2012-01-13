
class Formule
  
  attr_accessor :klauzule
  
  def vaha
    
  end
  
  def ohodnoceni(stavy)
    @klauzule.each do |k|
      return false if !k.ohodnoceni
    end
    return true
  end
  
  def initialize(klauzule, promenne, vahy)
    @klauzule = klauzule
    @promenne = promenne
    @vahy = vahy
  end
  
end


class Klauzule
  
  attr_accessor :literaly
  
  def ohodnoceni
    @literaly.each do |l|
      return true if l.ohodnoceni
    end
    return false
  end
  
  def initialize(vyraz) #array
    vyraz.each do |l|
      @literaly << Literal.new(l)
    end
  end
  
end

class Literal
  
  attr_accessor :promenna, :neg
  
  def ohodnoceni(stav)
    if @neg
      if stav
        false
      else
        true
      end
    else
      stav
    end
  end
  
  def initialize(cislo)
    @promenna = cislo.to_i.abs
    if cislo < 0
      @neg = true
    else
      @neg = false
    end
  end
  
end