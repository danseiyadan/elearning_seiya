class User < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, foreign_key: "follower_id", # 能動的関係にあるuserのid = follower_id
                                  class_name: "Relationship", # このモデルの中に擬似的にactive_relationshipsというモデルを作ってるようなイメージ。
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  # "active_relationships"テーブルの↑のforeign_keyを探して、そこからfollowed_usersを探す。source:はこの文の出力結果を戻すメソッドのようなもの。

  has_many :passive_relationships, foreign_key: "followed_id", # 受動的関係にあるuserのid = followed_id
                                   class_name: "Relationship", # このモデルの中に擬似的にpassive_relationshipsというモデルを作ってるようなイメージ。
                                   dependent: :destroy

  has_many :followers, through: :passive_relationships, source: :follower

  default_scope -> { order("is_admin DESC")}

  validates :name, presence: true, length: { maximum: 50 }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 50 }, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id) # 引数で渡されたユーザーをfollowしているか判断する
  end

  def follow(other_user)
    active_relationships.build(followed_id: other_user.id) # 引数で渡されたユーザーをfollowedにする（すなわちフォローする）
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy # 引数で渡されたユーザーを探してfollowedから削除する（すなわちアンフォローする）
  end
end
