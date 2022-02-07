class Gossip 
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end


  # fonction pour sauvegarder dans le csv
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author, content]
    end
  end

  #fonction pour retourner un array avec les auteurs et les gossips du fichier csv
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  #fonction qui prend l'id en parametre et qui retourne le gossip qui a cet id
  def self.find(id)
    all_gossips = Gossip.all
    return all_gossips[id.to_i]
  end

  #fonction update pour edit un potin qui prend en entrée un id et les valeurs author et content du formulaire edit
  def self.update(id, new_author, new_content)
    gossips = self.all
    gossips[id].author = new_author
    gossips[id].content = new_content
    # Je vide le fichier et je le rempli avec les nouvelles valeurs
    CSV.open('./db/gossip.csv', 'w') { gossips.each { |gossip| gossip.save }}
  end

end