require './lib/artist'
require './lib/photograph'

class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo_attributes)
    @photographs << Photograph.new(photo_attributes)
  end

  def add_artist(artist_attributes)
    @artists << Artist.new(artist_attributes)
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photograph|
      photograph.id == id
    end
  end
end
