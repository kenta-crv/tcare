class MailersController < ApplicationController
before_action :authenticate_member!

  def index
    @mailers = Mailer.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @mailer = Mailer.find(params[:id])
  end

  def new
    @list = List.find(list_id: list.id)
    @mailer = Mailer.new
  end

  def create
    @mailer = Mailer.new(mailer_params)
    if @mailer.save
      redirect_to list_path(@list)
    else
      render 'new'
    end
  end

  def edit
    @mailer = Mailer.find_by(member_id: current_member.id)
  end

 def update
    @mailer = Mailer.find(params[:id])
    if @mailer.update(mailer_params)
       redirect_to list_path(@list)
   else
       render 'edit'
   end
 end

  def confirm
    @mailer = Mailer.new(mailer_params)
    render :new if @mailer.invalid?
  end

  def thanks
    @mailer = Mailer.new(mailer_params)
    #MailerMailer.received_email(@Mailer).deliver
    #MailerMailer.send_email(@Mailer).deliver
  end

 def destroy
    @mailer = Mailer.find(params[:id])
    @mailer.destroy
    redirect_to list_path(@list)
 end

  private
  def mailer_params
    params.require(:mailer).permit(
      :number,
      :title,
      :select,
      :commit,
      :body)
  end
end
