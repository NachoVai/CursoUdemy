class ApplicationController < ActionController::Base
    before_action :cargar_registros
    def cargar_registros
        @categorias = Category.all
    end
end
