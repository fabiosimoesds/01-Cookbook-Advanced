require "nokogiri"
require "open-uri"

class Scrapping
  def initialize(keyword)
    @keyword = keyword
    @url = "https://www.allrecipes.com/search/results/?search=#{keyword}"
    @doc = Nokogiri::HTML(URI.open(@url), nil, "utf-8")
  end

  def scrape_description
    description_array = []
    @doc.search(".card__summary.elementFont__details--paragraphWithin.margin-8-tb").first(5).each do |element|
      description_array << element.text.strip
    end
    return description_array
  end

  def scrape_rating
    rating_array = []
    @doc.search(".review-star-text.visually-hidden").first(5).each do |element|
      rating_array << element.text.strip.split[1]
    end
    return rating_array
  end

  def scrape_prep_time
    prep_time_array = []
    @doc.search(".card__titleLink.manual-link-behavior.elementFont__titleLink.margin-8-bottom").first(5).each do |elem|
      url = elem.attribute("href").value
      doc = Nokogiri::HTML(URI.open(url), nil, "utf-8")
      doc.search(".recipe-meta-item").first(4).each do |item|
        prep_time_array << item.text.strip[7..] if item.text.strip.include?("total:")
      end
    end
    return prep_time_array
  end

  def scrape_recipes
    full_array = []
    @doc.search(".card__title.elementFont__resetHeading").first(5).each_with_index do |element, index|
      full_array << [element.text.strip, scrape_description[index], scrape_rating[index], scrape_prep_time[index]]
    end
    return full_array
  end
end
