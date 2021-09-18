class PostItemGenre < ApplicationRecord
  belongs_to :genre
  belongs_to :post_item
end
