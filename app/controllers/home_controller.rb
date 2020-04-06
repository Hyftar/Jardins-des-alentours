class HomeController < ApplicationController
  before_action :get_pictures, :get_veggies, :get_community_demos

  def index
  end

  private

  def get_pictures
    # lists images to use and then chooses two for display on the home page
    images_list = %w(asparagus.jpg carrots.jpeg citrouille.jpg oranges.jpg poivrons.jpg
                   tomato1.jpg tomato2.jpg tomato3.jpg tomato4.jpg tomatoes.jpg)
    @img1 = images_list.delete(images_list.sample)
    @img2 = images_list.sample
  end

  def get_veggies
    @veggies = Variety.all
  end

  def get_community_demos
    @communities = Community.includes(:variety).order(score: :desc).first(4)
  end
end
