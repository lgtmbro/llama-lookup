require 'date'
require 'whois'

domains = %w[example test xneelo]
response = []
processed_threads = []
res = {}
is_fin = false
variants = %w[.co.za .co .com .link .page .space .xyz .net .cc .org .in]

print 'Searching'

def get_domain_result(domain)
  print '.'
  is_aval = true
  res = Whois.whois(domain).to_s
  is_aval = false if res.include? "Expiry Date"
  { "#{domain}": is_aval ? '🦙' : '🚫' }
rescue
  { "#{domain}": '🤚' }
end

def look_up_multiple(domain, variants)
  response = []
  variants.each do |tld|
    domain_in_question = "#{domain}#{tld}"
    # puts "new thread for #{domain_in_question}"
    response << Thread.new { Thread.current[:output] = get_domain_result domain_in_question }
  end
  response
end

domains.each do |domain|
  # puts "create lookups for #{domain}"
  response += look_up_multiple(domain, variants)
end

# p response.length
# p response

until is_fin
  # puts "processed : #{processed_threads.length}"
  # puts "total : #{response.length}"
  # puts "total 2: #{domains.length * variants.length}"
  response.each do |thr|
    next if processed_threads.include? thr
    next unless thr.alive? == false

    op = thr[:output]
    # p op
    res.update(op)
    processed_threads << thr
  end
  is_fin = true if processed_threads.length == domains.length * variants.length
end

# p res

puts "\nResults: "

domains.each do |domain|
  variants.each do |tld|
    domain_in_question = "#{domain}#{tld}".to_sym
    puts "#{res[domain_in_question]} | #{domain_in_question}"
  end
end

puts "#{res.length} domains looked up."
