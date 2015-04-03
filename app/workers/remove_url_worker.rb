class RemoveUrlWorker
  include Sidekiq::Worker
  def perform(id)
    InstagramArt.check_id_url(id)
  end
end
