class HomeController < ApplicationController
  before_action :get_pictures, :get_veggies, :get_community_demos
  def index
  end
  private
  def get_pictures
    images_list = %w(asparagus.jpg carrots.jpeg citrouille.jpg oranges.jpg poivrons.jpg
                   tomato1.jpg tomato2.jpg tomato3.jpg tomato4.jpg tomatoes.jpg)
    @img1 = images_list.sample
    images_list.delete(@img1)
    @img2 = images_list.sample
  end
  def get_veggies
    @veggies = Variety.all
  end
  def get_community_demos
    @communities = Community.joins(:produce).all.first(4)
  end
end
