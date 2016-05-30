module LinksHelper
  #function for link tag_list
  def tag_list_with_links(tag_list)
    tag_list
      .map { |tag| link_to(tag, "/tags/#{tag}") }
      .join(', ')
      .html_safe
  end
end
