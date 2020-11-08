class SeosController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @list.seos.create(seo_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list = List.find(params[:list_id])
    @seo = @list.seos.find(params[:id])
    @image.destroy
    redirect_to list_path(@list)
  end

  private
  def seo_params
    params.require(:seo).permit(:rank)
  end
end
