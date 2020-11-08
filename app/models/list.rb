class List < ApplicationRecord
  mount_uploader :image, ImagesUploader
  mount_uploader :rogo, ImagesUploader
  belongs_to :worker, optional: true
  #belongs_to :user
  #belongs_to :admin
  has_many :comments
  has_many :seos
  has_many :recruits
  has_many :mailers
  validates :company, {presence: true}
  validates :prefecture, {presence: true}
  validates :city, {presence: true}
  validates :town, {presence: true}
  validates :town_number, {presence: true}
  validates :industry, {presence: true}
  validates :extraction_count_or_send_count, {presence: true}
  validates :tel_front, :exclusion => ["080", "090", "0120", "0088", "070"]

  def self.import(file)
      save_cont = 0
      CSV.foreach(file.path, headers:true) do |row|
       list = find_by(id: row["id"]) || new
       list.attributes = row.to_hash.slice(*updatable_attributes)
       next if customer.industry == nil
       next if self.where(tel: list.tel).count > 0
       next if self.where(tel: list.company).where(worker_search: list.worker_search).count > 0
       list.save!
       save_cont += 1
      end
      save_cont
  end

  def self.updatable_attributes
    ["company","company_kana","name","first_name","last_name","tel","tel_front","tel_middle","tel_back","fax","fax_front","fax_middle","fax_back",
      "postnumber","address","prefecture","city", "town","town_number","building","mail","url","url_2","title","industry","other","other2","caption","people","foundation","number_of_business","number_of_store","listing","settlement",
      "access","holiday","business_hour","payment","price","rogo","image","seo_rank","google_rank", "contact_url","ip_address", "published_site","published_now","recruit_now", "explanation", "extraction_count","send_count","worker_search","headline","description"]
  end



  def self.csv_attributes
    ["company","company_kana","name","first_name","last_name","tel","tel_front","tel_middle","tel_back","fax","fax_front","fax_middle","fax_back",
      "postnumber","address","prefecture","city", "town","town_number","building","mail","url","url_2","title","industry","other","other2","caption","people","foundation","number_of_business","number_of_store","listing","settlement",
      "access","holiday","business_hour","payment","price","rogo","image","seo_rank","google_rank", "contact_url","ip_address", "published_site","published_now","recruit_now", "explanation", "extraction_count","send_count","worker_search","headline","description"]
  end


  def self.generate_csv
    CSV.generate(headers:true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr)}
      end
    end
  end

  def perfect_tel
    tel_front + tel_middle + tel_back
  end

  @@extraction_status = [
    ["抽出不可","抽出不可"],
    ["電話番号抽出済","電話番号抽出済"]
  ]
  def self.ExtractionStatus
    @@extraction_status
  end

  @@send_status = [
    ["メール送信不可","メール送信不可"],
    ["メール送信済","メール送信済"]
  ]
  def self.SendStatus
    @@send_status
  end
end
