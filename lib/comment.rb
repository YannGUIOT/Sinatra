
#Cette classe représente un commentaire, elle est définie par son id, son auteur et son contenu.
class Comment

    attr_accessor :id, :author, :content
  
    #initialise un commentaire
    def initialize(id, author, content)
      @id = id
      @author = author
      @content = content
    end
  
    #cette methode renvoie un array qui contient tous les commentaires du fichier csv
    def self.all
      comment_array = []
      CSV.read("./db/comment.csv").each do |csv_line|
        comment_array << Comment.new(csv_line[0], csv_line[1], csv_line[2])
      end
      return comment_array
    end
    
    #sauvegarde les commentaires crées dans le fichier csv
    def save
      CSV.open("./db/comment.csv", "ab") do |csv|
        csv << [@id, @author, @content]
      end
    end
  
    def self.select_by_id(id)
      self.all.select {|index| index.id.to_i == id}
    end
  
  end