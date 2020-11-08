class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
        t.string :company #会社名
        t.string :company_kana #カイシャメイ
        t.string :name #代表者名
          t.string :first_name
          t.string :last_name
          t.string :first_kana
          t.string :last_kana
        t.string :tel #電話番号
          t.string :tel_front
          t.string :tel_middle
          t.string :tel_back
        t.string :fax #電話番号
          t.string :fax_front
          t.string :fax_middle
          t.string :fax_back
        t.string :postnumber #郵便番号
        t.string :address #住所
          t.string :prefecture
          t.string :city
          t.string :town
          t.string :town_number
          t.string :building
        t.string :mail #URL
        t.string :url #URL
        t.string :url_2 #URL2 → n
        t.string :title #タイトル
        t.string :industry #職種
        t.string :other
        t.string :other2
        t.string :caption #資本金
        t.string :people #従業員数
        t.string :rogo #ロゴ
        t.string :image

        t.string :seo_rank #SEOランク　→ n
        t.string :google_rank #googleランク → n
        t.string :foundation #設立日
        t.string :contact_url #問い合わせ　
        t.string :number_of_business #事業所数 →　n
        t.string :number_of_store #店舗数
        t.string :listing #上場日
        t.string :settlement #決算月

        t.string :published_site #掲載サイト
        t.string :published_now #今掲載している状況
        t.string :recruit_now #求人の状況
        t.string :ip_address #IPアドレス
        t.string :explanation #解説

        t.string :access #アクセス
        t.string :holiday #休日
        t.string :business_hour #営業時間
        t.string :payment #支払方法
        t.string :price #価格

        t.string :extraction_count #リスト
        t.string :send_count #送信
        t.string :worker_search #ワーカー用検索

        t.string :headline
        t.string :description

        t.references :admin
        t.references :worker
      t.timestamps
    end
  end
end
