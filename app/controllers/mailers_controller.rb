class MailersController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @list.mailers.create(mailer_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list = List.find(params[:list_id])
    @mailer = @list.mailers.find(params[:id])
    @image.destroy
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
