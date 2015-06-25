module Api
  module V2
    class ApiController < ApplicationController
      def check_all_urls
        ValidationWorker.process_images_for_404()
      end
    end
  end
end
