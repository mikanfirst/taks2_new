class SearchsController < ApplicationController
  before_action :authenticate_user!
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'partial'
        User.where('name LIKE ?', "%#{content}%")
      elsif method == 'forward'
        User.where('name LIKE ?', "#{content}%")
      elsif method == 'backward'
        User.where('name LIKE ?', "%#{content}")
      else
        User.all
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'partial'
        Book.where('title LIKE ?', "%#{content}%")
      elsif method == 'forward'
        Book.where('title LIKE ?', "#{content}%")
      elsif method == 'backward'
        Book.where('title LIKE ?', "%#{content}")
      else
        Book.all
      end
    end
  end
#   回答↓
#   def search
# 		@model = params[:model]
# 		@content = params[:content]
# 		@method = params[:method]
# 		if @model == 'user'
# 			@records = User.search_for(@content, @method)
# 		else
# 			@records = Book.search_for(@content, @method)
# 		end
# 	end
end
