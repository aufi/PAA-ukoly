# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'algorithms'
require 'priority_queue'
require 'thread'
require 'pp'

require File.expand_path(File.join(File.dirname(__FILE__), 'formule.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), '2/paaqh.rb'))

puts "PAA 6.uloha 3SAT GA"

def load(dir)
  #nacteni souboru v adresari
  data = Array.new
  Dir.new(dir).entries.each do |filename|
    next if filename == '.' || filename == '..'
    #cteni dat ze souboru
    f = File.new(dir+'/'+filename, "r")
    while (line = f.gets())
      next if line.start_with?('c') || line.start_with?('p')
      break if line.start_with?('%')
      nums = line.split(" ")
      k = Array.new
      cnt = 0
      for i in (0..2)
        k.push(Literal.new(nums.at(i).to_i))
        cnt += 1
      end
      data.push(Klauzule.new(k))
      #data.push(Batoh.new(w, p, nums.at(2).to_i, Array.new(cnt, 0)))  
    end
  end
  pp data.to_s
  return data
end


class Generace
  
  attr_accessor :res, :tmpg
  
  #vytvorim prvni nahodnou generaci
  def initialize(batoh)
    @res = Paaqh.new
    for i in 1..$velikost_generace
      b = Marshal.load(Marshal.dump(batoh))
      b.randomfill
      @res.push(b, b.fitness)
    end
  end
  
  def vytvor
    #puts "prvku v @res: "+@res.size.to_s
    @tmpg = Paaqh.new
    #nejlepsi necham
    for i in 1..$zachovat_nejlepsich
      x = Marshal.load(Marshal.dump(@res.pop))
      @tmpg.push(x, x.fitness)
    end
    #dalsi krizim s mutovanym jednim rodicem (protoze jsem je vybral za sebou, tak by jinak byli podobni)
    for j in i..($velikost_generace/2)
      break if (@res.empty?)  #pokud bych mel moc malou generaci
      a = Marshal.load(Marshal.dump(@res.pop))
      b = Marshal.load(Marshal.dump(@res.pop.mutate($mutace_rodice)))
      #deti
      d1 = a.kriz(b)
      d2 = b.kriz(a)
      #pridani rodice, trochu mutovaneho rodice a deti
      @tmpg.push(d1, d1.fitness)
      @tmpg.push(d2, d2.fitness)
      @tmpg.push(b, b.fitness)
      @tmpg.push(a, a.fitness)
    end
    #zbytek nahodna mutace
    while (@tmpg.size < $velikost_generace)
      tmp = Marshal.load(Marshal.dump(@res.pop.mutate($mutace_ostatni)))
      @tmpg.push(tmp, tmp.fitness)
    end
    #puts "prvku v @tmpg "+@tmpg.size.to_s
  end
  
  def krok
    @res = @tmpg
  end
  
  def nejlepsi
    x = @res.pop
    @res.push(x, x.fitness)
    return x
  end
  
end

$velikost_generace = 200
$pocet_generaci = 100
$zachovat_nejlepsich = 2
$mutace_rodice = 1
$mutace_ostatni = 1

#---------------pro vsechny druhy formuli------------------------------------------------
formule = ['uf20-91'] #, 10, 15, 20, 25, 27, 30, 40
formule.each { |fi|  

  puts "priklad: "+fi.to_s
  
  data = load("../test/sat/"+fi.to_s)

  next
  
  #data.each { |d| 
  
  g = Generace.new(data[0])
  
  tstart = Process.times.utime
  
  for i in 1..$pocet_generaci
    g.vytvor  #novou generaci
    g.krok  #nastav novou generaci za aktualni
    #puts g.nejlepsi.price
  end
  
  ut = Process.times.utime - tstart
  
  nejlepsi = g.nejlepsi
  puts "nejlepsi: "+nejlepsi.price.to_s+" (vaha "+nejlepsi.weight.to_s+"/"+nejlepsi.cap.to_s+")"
  
  puts ut.to_s
  
  #}
  #puts r.price.to_s+";"+r.weight.to_s+";"+ut.round(4).to_s
  #puts r.weight.to_s

} #konec iteratoru pro mereni vice inst.

puts "konec"






