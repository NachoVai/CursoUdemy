class WelcomeController < ApplicationController
	def index
		@articulos = Article.all
	end
	def contacto
		@email = "nacho@gmail.com"
	end
end