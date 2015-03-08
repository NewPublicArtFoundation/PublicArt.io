module ApplicationHelper

  def thanks_block name, url, reason
    content = '<li><a href="' + url + '"><div><h5>' + name + '</h5><em>' + reason + '</em></div></a></li>'
    return content.html_safe
  end

end
