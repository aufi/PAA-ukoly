
class GA
  
  attr_accessor :res, :tmpg, :data
  
  #vytvorim prvni nahodnou generaci
  def initialize(data)
    @data = data
    @res = Paaqh.new
    for i in 1..$velikost_generace
      res = Reseni.new
      @res.push(res, @data.ohodnoceni(res)[2])
    end
    #pp @res
    #puts "--------------"
  end
  
  def vytvor
    #puts "prvku v @res: "+@res.size.to_s
    @tmpg = Paaqh.new
    i = 1
    #nejlepsi necham
    for i in 1..$zachovat_nejlepsich
      #print @res.size
      x = Marshal.load(Marshal.dump(@res.pop))
      #puts "->"+@res.size.to_s
      #pp x
      @tmpg.push(x, @data.ohodnoceni(x)[2])
    end
    #dalsi krizim s mutovanym jednim rodicem (protoze jsem je vybral za sebou, tak by jinak byli podobni)
    for j in i..($velikost_generace/2)
      break if (@res.empty?)  #pokud bych mel moc malou generaci
      #print @res.size
      a = Marshal.load(Marshal.dump(@res.pop))
      #puts "->"+@res.size.to_s
      #print @res.size
      b = Marshal.load(Marshal.dump(@res.pop.mutate($mutace_rodice)))
      #puts "->"+@res.size.to_s
      #deti
      d1 = Marshal.load(Marshal.dump(a)).kriz(b)
      d2 = Marshal.load(Marshal.dump(b)).kriz(a)
      #pridani rodice, trochu mutovaneho rodice a deti
      @tmpg.push(d1, @data.ohodnoceni(d2)[2])
      @tmpg.push(d2, @data.ohodnoceni(d1)[2])
      #@tmpg.push(b, @data.ohodnoceni(b)[2])
      #@tmpg.push(a, @data.ohodnoceni(a)[2])
      #puts " ->"+@tmpg.size.to_s
    end
    #zbytek nahodna mutace
    while (@tmpg.size < $velikost_generace)
      tmp = Marshal.load(Marshal.dump(@res.pop.mutate($mutace_ostatni)))
      @tmpg.push(tmp, @data.ohodnoceni(tmp)[2])
    end
    #puts "prvku v @tmpg "+@tmpg.size.to_s
  end
  
  def krok
    @res = @tmpg
  end
  
  def stats
    ttmpg = Paaqh.new
    sum = 0
    cnt = 0
    min = 9999
    max = 0
    for i in 1..$velikost_generace
      tmp = @res.pop
      score = @data.ohodnoceni(tmp)[2]
      sum += score
      min = score if score < min
      max = score if score > max
      cnt = i
      ttmpg.push(tmp, score)
    end
    @res = ttmpg
    nej = @data.ohodnoceni(self.nejlepsi)
    puts nej[0].to_s+'/'+nej[1].to_s+"  "+nej[2].to_s+"  "+min.to_s+"-"+max.to_s+"  "+sum.to_s
  end
  
  def stats1g
    ttmpg = Paaqh.new
    sum = 0
    cnt = 0
    min = 9999
    max = 0
    for i in 1..$velikost_generace
      tmp = @res.pop
      score = @data.ohodnoceni(tmp)[2]
      sum += score
      min = score if score < min
      max = score if score > max
      cnt = i
      ttmpg.push(tmp, score)
    end
    @res = ttmpg
    nej = @data.ohodnoceni(self.nejlepsi)
    max.to_i
  end
  
  def stats_maxcena
    ttmpg = Paaqh.new
    sum = 0
    cnt = 0
    min = 9999
    max = 0
    for i in 1..$velikost_generace
      tmp = @res.pop
      score = @data.ohodnoceni(tmp)[2]
      sum += score
      min = score if score < min
      max = score if score > max
      cnt = i
      ttmpg.push(tmp, score)
    end
    @res = ttmpg
    nej = @data.ohodnoceni(self.nejlepsi)
    puts max
  end
  
  def nejlepsi
    x = @res.pop
    @res.push(x, @data.ohodnoceni(x)[2])
    return x
  end
  
end