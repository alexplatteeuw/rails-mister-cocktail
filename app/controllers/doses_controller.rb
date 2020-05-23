class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.all.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.all.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    # @dose.cocktail = @cocktail
    @dose.save
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id, :cocktail_id)
  end
end
