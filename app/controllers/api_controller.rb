class ApiController < ApplicationController

  def check_all_urls
    ValidationWorker.process_images_for_404()
  end

end
