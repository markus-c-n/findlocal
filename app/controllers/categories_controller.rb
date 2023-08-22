class CategoriesController < ApplicationController

  def sub_categories
    main_category = MainCategory.find(params[:id])
    sub_categories = main_category.sub_categories

    options = sub_categories.map { |sub_category| [sub_category.name, sub_category.id] }
    render json: { options: options }
  end

end
