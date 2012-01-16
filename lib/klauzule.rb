
class Klauzule
  
  attr_accessor :literaly
  
  def ohodnoceni(reseni)
    #pp reseni
    @literaly.each do |l|
      #pp l
      #pp l.ohodnoceni(reseni)
      return true if l.ohodnoceni(reseni) == 1 #soucty - true kdyz je true alespon jeden
    end
    return false
  end
  
  def initialize(literaly) #array
      @literaly = literaly
  end
  
end