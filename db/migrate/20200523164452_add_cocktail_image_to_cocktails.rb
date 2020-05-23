class AddCocktailImageToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :cocktail_image, :string
  end
end
