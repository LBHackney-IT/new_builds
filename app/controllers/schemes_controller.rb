class SchemesController < ApplicationController
  def index
    @schemes = Scheme.all
  end
end
