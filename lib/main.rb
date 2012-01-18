# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'algorithms'
require 'priority_queue'
require 'thread'
require 'pp'

require File.expand_path(File.join(File.dirname(__FILE__), 'formule.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'klauzule.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'literal.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'reseni.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'g_a.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), '2/paaqh.rb'))

puts "PAA 6.uloha 3SAT GA"

#funkce pro nacteni dat (neni u klazule protoze nacita vic klauzuli)
def load(dir)
  #nacteni souboru v adresari
  formule = Array.new
  Dir.new(dir).entries.each do |filename|
    next if filename == '.' || filename == '..' || filename == '.svn'
    #cteni dat ze souboru
    f = File.new(dir+'/'+filename, "r")
    data = Array.new
    while (line = f.gets())
      next if line.start_with?('c') || line.start_with?('p')    #zatim neresim jina data/pocty promennych
      break if line.start_with?('%')
      nums = line.split(" ")
      k = Array.new
      for i in (0..2)
        k.push(Literal.new(nums.at(i).to_i))
      end
      data.push(Klauzule.new(k))
    end
    formule.push(Formule.new(data))
  end
  return formule
end

#---------------pro vsechny druhy formuli------------------------------------------------
formule = ['uf20-91'] #, 10, 15, 20, 25, 27, 30, 40
formule.each do |fi|  

  puts "priklad: "+fi.to_s
  
  data = load("../test/sat/"+fi.to_s)

  #pp data[0]  
  #for i in 1..1000 do
  #  break
  #  res = Reseni.new
  #  #pp res
  #  v = data[0].ohodnoceni(res)
  #  print i.to_s
  #  print "  "+v[0].to_s+"/"+v[1].to_s
  #  print "  "+v[2].to_s
  #  puts "  "+res.promenne.to_s
  #end
  
  #  sum = 0

  #-------nastaveni parametru GA--------
  $velikost_generace = 170
  $pocet_generaci = 50
  $zachovat_nejlepsich = 2
  $mutace_rodice = 2
  $mutace_ostatni = 2
  
  #pro vice instanci
  data.each do |d| 
   
    for $velikost_generace in [210] do
    
      puts $velikost_generace.to_s
      
      tstart = Process.times.utime
  
      #prvni generace se vygeneruje pri inic. genetickeho algoritmu
      g = GA.new(data[0])
    
      #test resnei v prvni generaci
      #  sum += g.stats1g
      #  next
  
      for i in 1..$pocet_generaci
        g.vytvor  #vytvori novou generaci
        g.krok  #nastavi novou generaci za aktualni
        g.stats_maxcena #vypise info o akt.generaci
      end
  
      ut = Process.times.utime - tstart
  
      #nejlepsi = g.nejlepsi
      #puts "-- nejlepsi: "+g.data.ohodnoceni(nejlepsi)[2].to_s
      puts ut.to_s
      puts "  "
  
    end

  end #konec iteratoru pro mereni vice inst.

  puts (sum/226).to_s
  
end
  
puts "konec"






