module InstagramArtsHelper

  def graffiti_block_list_item url
    html = '<li class="text-center">' + image_tag(url) + '</li>'
    return html.html_safe
  end
end
