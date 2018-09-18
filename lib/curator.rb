require './lib/artist'
require './lib/photograph'
require 'csv'

class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def load_photographs(file)
    photographs = []
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.each do |row|
      photograph_hash = {
        id: row[:id],
        name: row[:name],
        artist_id: row[:artist_id],
        year: row[:year],
      }
      photographs << photograph_hash
    end
    add_photographs_from_csv(photographs)
  end

  def add_photographs_from_csv(collection)
    collection.each do |photo_attributes|
      add_photograph(photo_attributes)
    end
  end

  def add_photograph(photo_attributes)
    @photographs << Photograph.new(photo_attributes)
  end

  def load_artists(file)
    artists = []
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.each do |row|
      artist_hash = {
        id: row[:id],
        name: row[:name],
        born: row[:born],
        died: row[:died],
        country: row[:country]
      }
      artists << artist_hash
    end
    add_artist_from_csv(artists)
  end

  def add_artist_from_csv(collection)
    collection.each do |artist|
      add_artist(collection)
    end
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

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      artist_photos = find_photographs_by_artist(artist)
      artist_photos.count > 1
    end
  end

  def photographs_taken_by_artists_from(country)
    artist_ids = find_artist_ids_from_country(country)
    @photographs.find_all do |photograph|
      artist_ids.include?(photograph.artist_id)
    end
  end

  def find_artists_from_country(country)
    @artists.find_all do |artist|
      artist.country == country
    end
  end

  def find_artist_ids_from_country(country)
    artists = find_artists_from_country(country)
    artists.map do |artist|
      artist.id
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photograph|
      range.include?(photograph.year.to_i)
    end
  end

  def artists_photographs_by_age(artist)
    photos = find_photographs_by_artist(artist)
    hash = Hash.new
    photos.each do |photo|
      hash[2018 - photo.year.to_i] = photo.name
    end
    hash
  end
end
