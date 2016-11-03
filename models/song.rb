class SongUploader < CarrierWave::Uploader::Base
  storage :fog
end


class Song < ActiveRecord::Base
  # has_and_belongs_to_many :playlists
  belongs_to :User
  mount_uploader :song_file, SongUploader

  def get_song_url
    song_url = self.song_file.url
    if self.song_file.url == nil
      song_url = self.location_url
    end
    return song_url
  end

end
