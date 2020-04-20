## Takes sarathi html file as input
require 'nokogiri'

def get_file
  begin
    file_name = ARGV[0]
    file = File.open(file_name)
  rescue => e
    puts "Opening File Failes: #{e.inspect}"
    return
  end
  return file
end



def parse_html(file)
  begin
    page = Nokogiri::HTML(file.read)
    license_number = page.css('thead')[0].css('span.text').text
    status = page.css('table')[2].css('td')[1].text

    date_of_issue = page.css('table')[3].css('td')[1].text
    date_of_last_transaction = page.css('table')[3].css('td')[3].text
    last_transacted_at = page.css('table')[4].css('td')[1].text

    ## DL validity
    nt_dl_vailidity_starts_at = page.css('table')[5].css('td')[3].text
    nt_dl_vailidity_ends_at = page.css('table')[5].css('td')[5].text
    t_dl_vailidity_starts_at = page.css('table')[5].css('td')[8].text
    t_dl_vailidity_ends_at = page.css('table')[5].css('td')[10].text
    hazardous_valid_till = page.css('table')[5].css('td')[12].text
    hill_valid_till = page.css('table')[5].css('td')[14].text

    ## COV Details
    cov_details = []
    page.css('table')[7].css('table')[0].css('tr')[1..-1].each do |detail|
      cov_details <<  { category: detail.css('td')[0].text,
                        class: detail.css('td')[1].text.gsub(' ', ''),
                        issue_date: detail.css('td')[2].text
                      }
    end

    ## Badge Details
    badge_details = []
    page.css('table')[9].css('table')[0].css('tr')[1..-1].each do |detail|
      badge_details <<  { category: detail.css('td')[0].text,
                        class: detail.css('td')[1].text.gsub(' ', ''),
                        issue_date: detail.css('td')[2].text
                      }
    end
  rescue => e
    puts "Parsing failed: #{e.inspect}"
    exit(1)
  end

  data = Hash.new
  data[:license_number] = license_number
  data[:status] = status
  data[:date_of_issue] = date_of_issue
  data[:date_of_last_transaction] = date_of_last_transaction
  data[:last_transacted_at] = last_transacted_at
  data[:nt_dl_vailidity_starts_at] = nt_dl_vailidity_starts_at
  data[:nt_dl_vailidity_ends_at] = nt_dl_vailidity_ends_at
  data[:t_dl_vailidity_starts_at] = t_dl_vailidity_starts_at
  data[:t_dl_vailidity_ends_at] = t_dl_vailidity_ends_at
  data[:hazardous_valid_till] = hazardous_valid_till
  data[:hill_valid_till] = hill_valid_till
  data[:cov_details] = cov_details
  data[:badge_details] = badge_details

  return data
end

def get_data
  file = get_file
  parse_html(file)
end

puts get_data
