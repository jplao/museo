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
end
