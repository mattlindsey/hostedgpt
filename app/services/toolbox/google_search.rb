class Toolbox::GoogleSearch < Toolbox

  describe :google_search, <<~S
    Search Google for the indicated query.
    Use this to answer questions about current events, look up information, or find answers to questions.
    Try to use this sparingly; prefer to use the user's memories and the tools you have available to answer questions.
    When you do use this, try to use exact queries for which you expect to get a definitive answer.
    When you respond to the user, try to include an answer to the question rather than just a link.
  S
  def google_search(query_s:)
    encoded_query = URI.encode_www_form_component(query_s)
    response = get("https://www.google.com/search?q=#{encoded_query}").get_body
    doc = Nokogiri::HTML(response)
    results = doc.css('div.BNeawe').map(&:text).join("\n")

    {
      message_to_user: "Web search results for #{query_s} are #{results}",
      results: results
    }
  end
end