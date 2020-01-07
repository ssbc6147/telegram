# Fakerの設定を日本語に変更
Faker::Config.locale = :ja

unless Rails.env.production?
  # 200件のデータを用意する
  POST_MAX = 200

  # Proc.newでその後の配列をオブジェクトとしてpost_attrsに代入
  post_attrs = Proc.new do
    # Array.newでその後の内容を配列としてオブジェクト化する準備
    Array.new(POST_MAX) do |idx|
      { id: idx + 1,
        # Fakerを使って文言を用意
        caption: Faker::Lorem.paragraph,
        user_id: User.pluck(:id).sample
      }
    end
  end

  # Proc.newでオブジェクト化したデータ(*post_attrs)を.callで呼び出して保存
  # seed_onceメソッドは上書きを行わない
  Post.seed_once(:id, *post_attrs.call)

  # 追加したレコードに画像を追加
  Post.all.each do |p|
    # 対応する画像があるか確認
    unless p.image.attached?
      # 画像をattachメソッドで登録(登録するデータはpathを指定, filenameでファイルを選択)
      p.image.attach(io: File.open("db/fixtures/images/post/#{Random.rand(1..6)}.jpg"), filename: "#{Random.rand(1..6)}.jpg")
    end
  end
end