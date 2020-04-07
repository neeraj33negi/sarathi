## Takes sarathi html file as input
require 'nokogiri'

file_name = 'sarathi.html'
file = File.open(file_name)
page = Nokogiri::HTML(file.read)

license_number = page.css('thead')[0].css('span.text').text
status = page.css('tbody')[1].css('td')[1].text

date_of_issue = page.css('table')[2].css('td')[1].text
date_of_last_transaction = page.css('table')[2].css('td')[3].text
last_transacted_at = page.css('table')[3].css('td')[1].text

## DL validity
nt_dl_vailidity_starts_at = page.css('table')[4].css('td')[3].text
nt_dl_vailidity_ends_at = page.css('table')[4].css('td')[5].text
t_dl_vailidity_starts_at = page.css('table')[4].css('td')[8].text
t_dl_vailidity_ends_at = page.css('table')[4].css('td')[10].text
hazardous_valid_till = page.css('table')[4].css('td')[12].text
hill_valid_till = page.css('table')[4].css('td')[14].text

##COV Details
cov_details = Hash.new([])
page.css('table')[6].css('tr')[1].css('tr')[1..-1].each do |detail|
  cov_details << [detail.css('td')[0], detail.css('td')[1], detail.css('td')[2]]
end
puts cov_details

