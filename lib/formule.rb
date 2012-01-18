
class Formule
  
  attr_accessor :klauzule, :vahy
  
  def ohodnoceni(reseni)
    splneno = 0
    cnt = 0
    @klauzule.each do |k|
      if k.ohodnoceni(reseni)
        splneno += 1
        #print "1"
      else  
        #print "0"
      end
      cnt += 1
    end
    cena = 0
    for i in 0..19
      cena += @vahy[i] if reseni.promenne[i] == 1
    end
    #cena = -200 if splneno < cnt
    return [splneno, cnt, cena]
  end
  
  def vytvor_vahy
    @vahy = [88,16,72,67,62,25,52,87,34,47,25,42,19,62,62,32,79,19,94,25] 
    #Array.new
    for i in 0..19 do
        #@vahy[i] = rand(100)
    end
  end
  
  def initialize(klauzule)
    @klauzule = klauzule
    vytvor_vahy
  end
  
end
