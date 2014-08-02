class StaticPagesController < ApplicationController
  
  def home

  end

  def help
    @test1 = "about"
  end

	def about

    @test2 = "about"

	end

end
