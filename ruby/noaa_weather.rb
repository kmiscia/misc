require 'net/http'
require 'rexml/document'

class NoaaWeather

  include REXML

  attr_accessor :zip
  attr_accessor :days
  attr_accessor :time_layouts

  def initialize(zip, days)
    @zip = zip
    @days = days
    @time_layouts = []
  end

  def execute
    noaa_xml.root.elements.to_a("//time-layout").each do |time_layout|
      @time_layouts << TimeLayout.new(time_layout)
    end
  end

  private 

  def noaa_xml
    url = 'http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?'
    params = {:zipCodeList] => @zip, :numDays => @days, :format => "12+hourly"}
    url = URI.parse(URL << params.parameterize)
    response = Net::HTTP.get_response(url)
    Document.new(response.body)
  end

end

class TimeLayout

  attr_accessor :time_coordinate
  attr_accessor :summarization 
  attr_accessor :key
  attr_accessor :time_period

  def initialize(xml)
    @time_period = []
    @time_coordinate = xml.attribute('time-coordinate')
    @summarization = xml.attribute('summarization')
    parse(xml.elements.to_a)
  end

  private 

  def parse(elements)

    @key = elements.shift.text
    
    until elements.empty? do
      @time_period << {:start_time => elements.shift.text, :end_time => elements.shift.text}
    end
  end

end

class Hash
  def parameterize
    URI.escape(collect{|key, value| "#{key}=#{value}"}.join('&'))
  end
end