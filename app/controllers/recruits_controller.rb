class RecruitsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @list.recruits.create(recruit_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list = List.find(params[:list_id])
    @recruit = @list.recruits.find(params[:id])
    @image.destroy
    redirect_to list_path(@list)
  end

  private
  def recruit_params
    params.require(:recruit).permit(
      :current, #現状
      :media, #掲載媒体
      :occupation #職種)
  end
end
