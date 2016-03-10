class SlidesController < ApplicationController


  # GET /slides
  # GET /slides.json
  def index


    @slides = Slide.publication.min_publication.max_publication
  end
end
