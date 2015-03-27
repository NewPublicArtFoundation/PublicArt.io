module InstagramArtsHelper
  def graffiti_block_list_item id
    graffiti = InstagramArt.find(id)
    html = '<li data-id="' + graffiti.uid + '" class="text-center">' + link_to image_tag(graffiti.image_url), graffiti + '</li>'
    return html.html_safe
  end
end
