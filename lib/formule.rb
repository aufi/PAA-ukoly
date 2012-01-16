
class Formule
  
  attr_accessor :klauzule, :vahy
  
  def ohodnoceni(reseni)
    splneno = 0
    cnt = 0
    @klauzule.each do |k|
      if k.ohodnoceni(reseni)
        splneno += 1
        print "1"
      else  
        print "0"
      end
      cnt += 1
    end
    cena = 0
    for i in 0..19
      cena += @vahy[i] if reseni.promenne[i] == 1
    end
    return [splneno, cnt, cena]
  end
  
  def vytvor_vahy
    @vahy = Array.new
    for i in 0..19 do
        @vahy[i] = rand(100)
    end
  end
  
  def initialize(klauzule)
    @klauzule = klauzule
    vytvor_vahy
  end
  
end

class Reseni
  
  attr_accessor :promenne
  
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