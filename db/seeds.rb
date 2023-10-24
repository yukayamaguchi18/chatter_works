# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

guestpass = SecureRandom.urlsafe_base64

users = [
  {
    id: 1,
    email: "guest@example.com",
    name: "guestuser",
    introduction: "guestuser",
    is_public: true,
    is_active: true,
    password: guestpass
  },
  {
    id: 2,
    email: "landscape@example.com",
    name: "ランド・スケープ",
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/icon2.png")),filename: 'profile_image.jpg'),
    introduction: %Q{背景素材の使用時はリンク先の規約をご確認ください\nhttps://example.com},
    is_public: true,
    is_active: true,
    password: "landscape"
  },
  {
    id: 3,
    email: "bistroart@example.com",
    name: "ビストロあーと",
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/icon3.png")),filename: 'profile_image.jpg'),
    introduction: "三度のお絵描きよりごはんが好き",
    is_public: true,
    is_active: true,
    password: "bistroart"
  },
  {
    id: 4,
    email: "robotya@example.com",
    name: "ロボ屋",
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/icon4.png")),filename: 'profile_image.jpg'),
    introduction: "こいつ、描くぞ！",
    is_public: true,
    is_active: true,
    password: "robotya"
  },
  {
    id: 5,
    email: "dotworld@example.com",
    name: "点描世界観",
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/icon5.png")),filename: 'profile_image.jpg'),
    introduction: "しがないドット打ち",
    is_public: true,
    is_active: true,
    password: "dotworld"
  },
  {
    id: 6,
    email: "youthboard@example.com",
    name: "青少年委員会",
    profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/icon6.png")),filename: 'profile_image.jpg'),
    introduction: "青春は人生にたった一度しか来ない",
    is_public: false,
    is_active: true,
    password: "youthboard"
  }
]

users.each do |record|
  User.create!(record) unless User.find_by(email: record[:email])
end

for i in 7..11 do
  user = {
      id: i,
      email: "test#{i}@test.com",
      name: "テスト",
      introduction: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      is_public: true,
      is_active: true,
      password: "000000"
  }
  User.create!(user) unless User.find_by(email: user[:email])
end

admin = {
  id: 1,
  email: 'admin@example.com',
  password: 'admintest'
}
Admin.create!(admin) unless Admin.find_by(email: admin[:email])

relationships = [
  {
    id: 1,
    follower_id: 1,
    followed_id: 4
  },
  {
    id: 2,
    follower_id: 1,
    followed_id: 5
  },
  {
    id: 3,
    follower_id: 4,
    followed_id: 5
  },
  {
    id: 4,
    follower_id: 5,
    followed_id: 4
  },
  {
    id: 5,
    follower_id: 2,
    followed_id: 3
  },
  {
    id: 6,
    follower_id: 3,
    followed_id: 2
  }
]

relationships.each do |relationship|
  Relationship.find_or_create_by!(relationship)
end

for i in 2..6 do
  10.times do |n|
    work = {
      id: (n + 1) + 10 * (i - 2),
      user_id: i,
      work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/no_work_image.jpg")),filename: 'no_image.jpg'),
      title: "test#{(n + 1) + 10 * (i - 2)}",
      caption: "test#{(n + 1) + 10 * (i - 2)}"
    }
    Work.create!(work) unless Work.find_by(id: work[:id])
  end
end

works = [
  {
    id: 51,
    user_id: 2,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/51.png")),filename: 'work_image.jpg'),
    title: "サイバー",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nサイバー系の街並み。ギラギラの夜景。}
  },
  {
    id: 52,
    user_id: 2,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/52.png")),filename: 'work_image.jpg'),
    title: "海底王国",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n海の下の王国とおさかなさんたち。}
  },
  {
    id: 53,
    user_id: 2,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/53.png")),filename: 'work_image.jpg'),
    title: "大樹",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n大樹。ご神木とかかも。}
  },
  {
    id: 54,
    user_id: 2,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/54.png")),filename: 'work_image.jpg'),
    title: "カフェキッチン",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nカフェのキッチン。よく行くお店から着想。}
  },
  {
    id: 55,
    user_id: 2,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/55.png")),filename: 'work_image.jpg'),
    title: "青い花畑",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n街のはずれの花畑。}
  },
  {
    id: 56,
    user_id: 3,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/56.png")),filename: 'work_image.jpg'),
    title: "フルーツタルト",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n期間限定の食べに行きたい～}
  },
  {
    id: 57,
    user_id: 3,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/57.png")),filename: 'work_image.jpg'),
    title: "サンドイッチ",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nふらっと入ったお店のがおいしかったので模写}
  },
  {
    id: 58,
    user_id: 3,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/58.png")),filename: 'work_image.jpg'),
    title: "なんかのトマト煮",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n実家の食卓に出てくる名前のない料理（おいしい）}
  },
  {
    id: 59,
    user_id: 3,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/59.png")),filename: 'work_image.jpg'),
    title: "グラタン",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nグラタンのおいしい季節になってきましたね}
  },
  {
    id: 60,
    user_id: 3,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/60.png")),filename: 'work_image.jpg'),
    title: "パスタ",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nおうちで生パスタ初挑戦記念}
  },
  {
    id: 61,
    user_id: 4,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/61.png")),filename: 'work_image.jpg'),
    title: "両雄並び立つ",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n兄弟機ってサイコー！！}
  },
  {
    id: 62,
    user_id: 4,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/62.png")),filename: 'work_image.jpg'),
    title: "三倍速い",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n赤いといえば。お約束。}
  },
  {
    id: 63,
    user_id: 4,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/63.png")),filename: 'work_image.jpg'),
    title: "必殺！",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n今週ラスト激熱でしたね。}
  },
  {
    id: 64,
    user_id: 4,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/64.png")),filename: 'work_image.jpg'),
    title: "蒼穹の",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n青空をバック。いいよね。}
  },
  {
    id: 65,
    user_id: 4,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/65.png")),filename: 'work_image.jpg'),
    title: "発進！",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n復活記念}
  },
  {
    id: 66,
    user_id: 5,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/66.png")),filename: 'work_image.jpg'),
    title: "街並み",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nお屋敷っぽいのもある}
  },
  {
    id: 67,
    user_id: 5,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/67.png")),filename: 'work_image.jpg'),
    title: "緑の遺跡",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n谷間にある遺跡}
  },
  {
    id: 68,
    user_id: 5,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/68.png")),filename: 'work_image.jpg'),
    title: "湖上の街",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nこういう景色ワクワクする}
  },
  {
    id: 69,
    user_id: 5,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/69.png")),filename: 'work_image.jpg'),
    title: "城からの眺め",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n前回上げたのの別視点ver}
  },
  {
    id: 70,
    user_id: 5,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/70.png")),filename: 'work_image.jpg'),
    title: "天空の島",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n開拓ゲーム的な。キミだけの最強の島を作ろう！}
  },
  {
    id: 71,
    user_id: 6,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/71.png")),filename: 'work_image.jpg'),
    title: "メイドさん",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nフリル練習したい}
  },
  {
    id: 72,
    user_id: 6,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/72.png")),filename: 'work_image.jpg'),
    title: "釣り女子",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n女の子がガジェットいっぱい装備してるの好き}
  },
  {
    id: 73,
    user_id: 6,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/73.png")),filename: 'work_image.jpg'),
    title: "ハッピーハロウィーン！",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nトリックオアトリート！}
  },
  {
    id: 74,
    user_id: 6,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/74.png")),filename: 'work_image.jpg'),
    title: "部活中",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\n頑張る姿がまぶしい}
  },
  {
    id: 75,
    user_id: 6,
    work_image: ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join("app/assets/images/75.png")),filename: 'work_image.jpg'),
    title: "店員さん",
    caption: %Q{※画像と文章はダミーです。画像の背景素材等への利用は固く禁じます。\nよく行く本屋の店員さんがいつも親切でたすかる}
  }
]

works.each do |work|
  Work.create!(work) unless Work.find_by(id: work[:id])
end

for i in 2..6 do
  10.times do |n|
    chatter = {
      id: (n + 1) + 10 * (i - 2),
      user_id: i,
      body: "test#{(n + 1) + 10 * (i - 2)}"
    }
    Chatter.find_or_create_by!(chatter)
  end
end

chatters = [
  {
    id: 51,
    user_id: 4,
    body: "ヨドバシ混みすぎ"
  },
  {
    id: 52,
    user_id: 4,
    body: "買えた！"
  },
  {
    id: 53,
    user_id: 4,
    body: "帰りにラーメン行く"
  },
  {
    id: 54,
    user_id: 5,
    body: "よかった"
  },
  {
    id: 55,
    user_id: 5,
    body: "新作待ってた！https://example.com"
  },
  {
    id: 56,
    user_id: 5,
    body: "リマスターいいね～"
  },
  {
    id: 57,
    user_id: 5,
    body: "やっぱ2Dじゃないとな"
  },
  {
    id: 58,
    user_id: 4,
    body: "ありがとう！"
  },
  {
    id: 59,
    user_id: 2,
    body: "来週雨なん？"
  },
  {
    id: 60,
    user_id: 2,
    body: "写真撮りに行きたい"
  },
  {
    id: 61,
    user_id: 3,
    body: "どこ行くの？"
  },
  {
    id: 62,
    user_id: 2,
    body: "某自然公園"
  },
  {
    id: 63,
    user_id: 3,
    body: "入口のパン屋おいしいよ"
  },
  {
    id: 64,
    user_id: 2,
    body: "マ？いいこと聞いた"
  },
  {
    id: 65,
    user_id: 3,
    body: "このレシピよかったhttps://example.com"
  },
  {
    id: 66,
    user_id: 6,
    body: "1限だるすぎ"
  },
  {
    id: 67,
    user_id: 6,
    body: "飲み会いってきます"
  },
  {
    id: 68,
    user_id: 6,
    body: "待ち合わせまで暇になっちゃった"
  },
  {
    id: 69,
    user_id: 6,
    body: "イラストでも漁るか…"
  },
  {
    id: 70,
    user_id: 2,
    body: %Q{投稿しました。\n「青い花畑 / by ランド・スケープ」\nhttps://example.com}
  },
  {
    id: 71,
    user_id: 3,
    body: %Q{投稿しました。\n「パスタ / by ビストロあーと」\nhttps://example.com}
  },
  {
    id: 72,
    user_id: 4,
    body: %Q{投稿しました。\n「発進！ / by ロボ屋」\nhttps://example.com}
  },
  {
    id: 73,
    user_id: 5,
    body: %Q{投稿しました。\n「天空の島 / by 点描世界観」\nhttps://example.com}
  },
  {
    id: 74,
    user_id: 6,
    body: %Q{投稿しました。\n「店員さん / by 青少年委員会」\nhttps://example.com}
  },
  {
    id: 75,
    user_id: 2,
    body: %Q{コメントしました。\n「test」\ntest / by テスト\nhttps://example.com}
  },
  {
    id: 76,
    user_id: 3,
    body: %Q{コメントしました。\n「test」\ntest / by テスト\nhttps://example.com}
  },
  {
    id: 77,
    user_id: 4,
    body: %Q{コメントしました。\n「test」\ntest / by テスト\nhttps://example.com}
  },
  {
    id: 78,
    user_id: 5,
    body: %Q{コメントしました。\n「test」\ntest / by テスト\nhttps://example.com}
  },
  {
    id: 79,
    user_id: 6,
    body: %Q{コメントしました。\n「test」\ntest / by テスト\nhttps://example.com}
  }
]

chatters.each do |chatter|
  Chatter.find_or_create_by!(chatter)
end

tags = [
  {
    id: 1,
    name: "背景"
  },
  {
    id: 2,
    name: "食べ物"
  },
  {
    id: 3,
    name: "ロボット"
  },
  {
    id: 4,
    name: "ドット"
  },
  {
    id: 5,
    name: "人物"
  }
]

tags.each do |tag|
  Tag.find_or_create_by!(tag)
end

for i in 1..5 do
  WorkTag.find_or_create_by!(
    id: i,
    tag_id: 1,
    work_id: i + 50
  )
end

for i in 6..10 do
  WorkTag.find_or_create_by!(
    id: i,
    tag_id: 2,
    work_id: i + 50
  )
end

for i in 11..15 do
  WorkTag.find_or_create_by!(
    id: i,
    tag_id: 3,
    work_id: i + 50
  )
end

for i in 16..20 do
  WorkTag.find_or_create_by!(
    id: i,
    tag_id: 4,
    work_id: i + 50
  )
end

for i in 21..25 do
  WorkTag.find_or_create_by!(
    id: i,
    tag_id: 5,
    work_id: i + 50
  )
end

followtags = [
  {
    id: 1,
    tag_id: 1,
    user_id: 1
  },
  {
    id: 2,
    tag_id: 2,
    user_id: 1
  },
  {
    id: 3,
    tag_id: 5,
    user_id: 1
  }
]

followtags.each do |followtag|
  FollowTag.find_or_create_by!(followtag)
end

replies = [
  {
    id: 1,
    reply_id: 54,
    reply_to_id: 52
  },
  {
    id: 2,
    reply_id: 58,
    reply_to_id: 54
  },
  {
    id: 3,
    reply_id: 61,
    reply_to_id: 60
  },
  {
    id: 4,
    reply_id: 62,
    reply_to_id: 61
  },
  {
    id: 5,
    reply_id: 63,
    reply_to_id: 62
  },
  {
    id: 6,
    reply_id: 64,
    reply_to_id: 63
  }
]

replies.each do |reply|
  Reply.find_or_create_by!(reply)
end