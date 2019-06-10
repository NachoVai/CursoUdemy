class ArticlesController < ApplicationController

	before_action :set_article, only: [:show, :edit, :update, :destroy]
	#before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
	before_action :authenticate_editor!, only: [:edit, :update, :new, :create]
	before_action :authenticate_admin!, only: [:destroy]


	def index
		@articulos = Article.ultimos
		if user_signed_in? && current_user.is_editor? && !params.has_key?(:normal)
			render :"admin_article"
		end
	end

	def show
		
	end 

	def new
		@article = Article.new
		@categories = Category.all
	end

	def create
		if params[:categories].nil?
			redirect_to new_article_path, alert: "Necesitas agregar minimo una categoría."
		else
		@article = current_user.articles.new(article_params)
			@article.categories = params[:categories]
			respond_to do |format|
				if @article.save
					format.html {redirect_to @article, notice: "Articulo #{@article.title} creado."}
					format.json {render :show, status: :created, location: @article}
				else
					format.html {render :new}
					format.html {render json: @article.errors, status: :unprocessable_entity}
				end
			end
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @article.update(article_params)
				format.html {redirect_to @article, notice: "Articulo #{@article.title} modificado."}
				format.html {render :show, status: :ok, location: @article}       
			else
				format.html {render :edit }
				format.json {render json: @article.errors, status: :unprocessable_entity }        
			end
		end
	end

	def destroy
		@article.destroy
		respond_to do |format|
			format.html {redirect_to articles_url, notice: "Articulo eliminado."}
			format.json { head :no_content }
		end
	end

	private

	def article_params
		params.require(:article).permit(:title, :body, :categories)
	end

	def set_article
		@article = Article.find(params[:id])
	end
end