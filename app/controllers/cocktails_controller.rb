class CocktailsController < ApplicationController
  def index
    if params[:query]
      @query = params[:query]
      @cocktails = Cocktail.where("name ILIKE '%#{params[:query]}%'")
    else
      @cocktails = Cocktail.order(:name)
    end
  end

  def show
    @cocktail = Cocktail.all.find(params[:id])
    @doses = @cocktail.doses
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.all.find(params[:id])
  end

  def update
    @cocktail = Cocktail.all.find(params[:id])
    @cocktail.update(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.all.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :cocktail_image)
  end
end
