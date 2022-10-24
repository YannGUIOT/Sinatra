
class Gossip
    attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open('./db/gossip.csv','ab') do |csv|
      csv << [@author,@content]
    end
  end

  def self.all
    all_gossips = []
    CSV.open('./db/gossip.csv').each do |tab|
      gossip_temp = Gossip.new(tab[0], tab[1])
      all_gossips << gossip_temp
    end
    return all_gossips
  end


  def self.delete(gossip_to_delete)

    # COPIE les lignes du fichier 'gossip.csv' dans un tableau 'lines'
    lines = File.readlines('db/gossip.csv')
    # lines = [ "author,content" , "author, content" , ... ]

    # on supprime du tableau la ligne correspondant à l'index désiré 
  	lines.delete_at(gossip_to_delete-1)
    
    # on supprime toutes les lignes du fichier 'gossip.csv' 
  	File.open('db/gossip.csv', 'w') {|file| file.truncate(0)}
    
    # on réécrit les lignes dans le fichier 'gossip.csv' depuis le tableau 'lines' ne contenant plus l'élément supprimé
    lines.each do |line|
      File.open('db/gossip.csv', 'a') { |f| f.write line }
    end

  end

end