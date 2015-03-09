module InstagramArtsHelper

  def graffiti_block_list_item url
    html = '<li class="text-center">' + image_tag graffiti.image_url + '</li>'
    return html
  end
end
