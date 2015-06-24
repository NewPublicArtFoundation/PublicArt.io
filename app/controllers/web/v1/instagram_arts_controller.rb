module Web
  module V1
    class InstagramArtsController < ApplicationController
      def most_recent
        graffitis = InstagramArt.page(params[:id]).per(30)
        blocks = []
        graffitis.each do |graffiti|
          html = '<li class="text-center"><img src="' + graffiti.image_url + '"></li>'
          blocks << html
        end
        @fragment = blocks.join('')
        respond_to do |format|
            format.html {
              render plain: @fragment.html_safe
            }
          end
      end
    end
  end
end
