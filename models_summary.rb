class User < ActiveRecord::Base
  has_secure_password
  has_many :songs
  has_many :playlists
end



** SONG PLAYLIST  associations **
class Song < ApplicationRecord
  has_and_belongs_to_many :playlists
  belongs_to :User
end

class Playlist < ApplicationRecord
  has_and_belongs_to_many :songs
  belongs_to :User
end





** Account history associations **
class User < ApplicationRecord
  has_one :account
  has_one :account_history, through: :account
end

class Account < ApplicationRecord
  belongs_to :User
  has_one :account_history
end

class AccountHistory < ApplicationRecord
  belongs_to :account
end



** TAG ASSOCIATIONS **
class Song < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through :taggings
end

class Tagging < ActiveRecord::Base
  belongs_to :song
  belongs_to :tag
end

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :songs, through :taggings
end




** FOLLOWER ASSOCIATIONS **
** default is to follow self. Then all detail is built around who you follow.

class User < ActiveRecord::Base
  has_many :connections
  has_many :followers, through :connections
end

class connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
end

class Follower < ActiveRecord::Base
  has_many :connections
  has_many :users, through :connections
end
