
class Literal
  
  attr_accessor :promenna_index, :neg
  
  def ohodnoceni(reseni)
    if @neg
      if reseni.promenne[@promenna_index] == 1
        1
      else
        0
      end
    else
      reseni.promenne[@promenna_index]
    end
  end
  
  def initialize(cislo)
    @promenna_index = cislo.to_i.abs - 1
    if cislo < 0
      @neg = true
    else
      @neg = false
    end
  end
  
end