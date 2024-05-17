class HiraganasController < ApplicationController
  def index
    @hiraganas = Hiragana.all
  end
end
