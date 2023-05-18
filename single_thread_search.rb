require 'date'
require 'whois'

def take_3_sec(domain)
  res = Whois.whois(domain).to_s
  is_avalible = res.include? 'No information was found matching that query.'
  "#{is_avalible ? '🦙' : '🚫'} #{domain}"
end

domains = ['hookprop123.co.za', 'xneelo.com', 'propkeep.co.za', 'keepa.co.za', 'koop.co.za',
           'proptop.co.za', 'topprop.co.za', 'proprop.co.za', 'prophub.co.za', 'xprop.co.za', 'phub.co.za', 'propchat.co.za', 'propx.co.za', 'propix.co.za', 'ioprop.co.za', 'myprop.co.za', 'xprop.co.za', 'propcheck.co.za', 'proptrack.co.za', 'propnect.co.za', 'proplead.co.za', 'proptick.co.za', 'callum.co.za', 'prop+.co.za', 'propplus.co.za', 'intelliprop.co.za', '301.co.za', '307.co.za', '308.co.za', '410.co.za', '418.co.za', '200.co.za', '202.co.za', '206.co.za', '302.co.za', '555.co.za', '418.xyz', '418.org', '418.net', '308.net', '200.net', '200.co.za', 'i200.co.za', 'i418.co.za', 'rev.co.za', '200.link', '200.page', '418.page', '308.page', '418.cc', '418.co', '200.co', '200.site', '418.site', "200.quest", "202.club", "201.club",
           "418.club"]


domains.each do |domain|
  puts take_3_sec domain
end

