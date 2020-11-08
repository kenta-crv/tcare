class ListsController < ApplicationController
  #before_action :authenticate_worker!, only: [:new, :edit]
  def index
    @q = List.ransack(params[:q])
    @lists = @q.result
    @lists = @lists.page(params[:page]).per(30).order(created_at: :desc)
    respond_to do |format|
     format.html
     format.csv{ send_data @lists.generate_csv, filename: "lists-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def show
    @list = List.find(params[:id])
    @q = List.ransack(params[:q])
    @lists = @q.result
    @prev_list = @lists.where("lists.id > ?", @list.id).first
    @next_list = @lists.where("lists.id < ?", @list.id).last
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
        redirect_to lists_path
    else
        render 'new'
    end
  end

  def edit
    @list = List.find(params[:id])
  end

 def update
    @list = List.find(params[:id])
     if @list.update(list_params)
        redirect_to list_path(@list)
    else
        render 'edit'
    end
 end

 def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
 end

 def import
   List.import(params[:file])
   redirect_to root_url, notice:"リストを追加しました"
 end

private
 def extraction_count_or_send_count
   extraction_count.presence or send_count.presence
 end
 def list_params
  params.require(:list).permit(
    :company, #会社名
    :company_kana, #会社名
    :name, #代表者名
      :first_name,
      :last_name,
      :first_kana,
      :last_kana,
    :tel, #電話番号
      :tel_front,
      :tel_middle,
      :tel_back,
    :fax, #電話番号
      :fax_front,
      :fax_middle,
      :fax_back,
    :postnumber, #郵便番号
    :address, #住所
      :prefecture,
      :city,
      :town,
      :town_number,
      :building,
    :mail, #URL
    :url, #URL
    :url_2, #URL2
    :title, #タイトル
    :industry, #職種
    :other,
    :other2,
    :caption, #資本金
    :people, #従業員数
    :foundation, #設立日
    :number_of_business, #事業所数
    :number_of_store, #店舗数
    :listing, #上場
    :settlement, #決算月

    :access, #アクセス
    :holiday, #休日
    :business_hour, #営業時間
    :payment, #支払方法
    :price, #価格

    :rogo, #ロゴ
    :image,

    :seo_rank, #SEOランク
    :google_rank, #googleランク
    :contact_url, #問い合わせ　
    :ip_address, #IPアドレス

    :published_site, #掲載サイト
    :published_now, #今掲載している状況
    :recruit_now, #求人の状況
    :explanation, #解説

    :extraction_count,
    :send_count,
    :worker_search,
    :headline,
    :description
  )&.merge(worker: current_worker)
  end
end
