require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # Opens a file and reads it into a variable
    # URL: fixtures/student-site/index.html
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)

    students_array = []
    # Iterate through the student
    index_page.css(".student-card").each do |card|
      hash = {}
      hash[:name] = card.css(".student-name").text
      hash[:location] = card.css(".student-location").text
      hash[:profile_url] = card.css("a")[0]["href"]
      students_array << hash
      #students << {name: student_name, location: student_location, profile_url: student_profile_url}
      #binding.pry
    end
    # Returns the student_array
    students_array
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    # Opens a file and reads it into a variable
    # URL: fixtures/student-site/index.html/profile_url
    html = File.read(profile_url)
    student_profile_page = Nokogiri::HTML(html)

    # student_profile hash
    student_profile = {}

    # Iterate through the student social links
    student_profile_page.css(".social-icon-container a").each do |link|
      case true
      when link["href"].include?("twitter")
        student_profile[:twitter] = link["href"]
      when link["href"].include?("linkedin")
        student_profile[:linkedin] = link["href"]
      when link["href"].include?("github")
        student_profile[:github] = link["href"]
      when link["href"].include?("http")
        student_profile[:blog] = link["href"]
      end
      #binding.pry
    end

    student_profile[:profile_quote] = student_profile_page.css(".profile-quote").text
    student_profile[:bio] = student_profile_page.css(".description-holder p").text
    # Returns the student_profile hash
    student_profile
    #binding.pry
  end

end
