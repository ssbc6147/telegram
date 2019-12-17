# Fakerの設定を日本語に変更
Faker::Config.locale = :ja

unless Rails.env.production?
  # 10件のデータを用意する
  USER_MAX = 10
  AVATAR_COUNT = 4
  user_attrs = Proc.new do
    Array.new(USER_MAX) do |idx|
      { id: idx + 1,
        # Fakerを使ってデータを用意
        email: Faker::Internet.email,
        name: Faker::Name.name,
        username: Faker::Name.name,
        description: Faker::Lorem.paragraph,
        password: 'password',
        password_confirmation: 'password',
      }
    end
  end

  # 配列を一度に登録する(一度だけ)
  User.seed_once(:id, *user_attrs.call)

  # 追加したレコードに画像を追加
  User.all.each do |u|
    unless u.avatar.attached?
      u.avatar.attach(io: File.open("db/fixtures/images/user/#{Random.rand(1..AVATAR_COUNT)}.jpg"), filename: "#{Random.rand(1..AVATAR_COUNT)}.jpg")
    end
  end

end