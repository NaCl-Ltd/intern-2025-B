class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  # バリデーション（データが正しく保存されるためのルール）
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  # 一人のユーザーは同じ投稿に一度しか「いいね」できないようにする
  validates :user_id, uniqueness: { scope: :micropost_id }
end