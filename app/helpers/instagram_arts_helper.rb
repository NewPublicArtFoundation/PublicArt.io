module InstagramArtsHelper
  def graffiti_block_list_item id
    graffiti = InstagramArt.find(id)
    html = '<li data-id="<%= graffiti.uid %>" class="text-center">' + image_tag(graffiti.image_url) + '</li>'
    return html.html_safe
  end
end
