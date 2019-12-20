# rubocop:disable Rails/OutputSafety
module PostsHelper
  def auto_link_regex
    # Taken from https://github.com/kylewm/cassis-autolink-py/blob/master/cassis.py#L19

    # rubocop:disable Metrics/LineLength
    Regexp.new('(?:\\@[_a-zA-Z0-9]{1,17})(?:\\.[a-zA-Z0-9][-a-zA-Z0-9]*)*|(?:(?:(?:(?:http|https|irc)?:\\/\\/(?:(?:[!$&-.0-9;=?A-Z_a-z]|(?:\\%[a-fA-F0-9]{2}))+(?:\\:(?:[!$&-.0-9;=?A-Z_a-z]|(?:\\%[a-fA-F0-9]{2}))+)?\\@)?)?(?:(?:(?:[a-zA-Z0-9][-a-zA-Z0-9]*\\.)+(?:(?:aero|arpa|asia|a[cdefgilmnoqrstuwxz])|(?:biz|blog|b[abdefghijmnorstvwyz])|(?:cat|com|coop|c[acdfghiklmnoruvxyz])|d[ejkmoz]|(?:edu|e[cegrstu])|f[ijkmor]|(?:gov|g[abdefghilmnpqrstuwy])|h[kmnrtu]|(?:info|int|i[delmnoqrst])|j[emop]|k[eghimnrwyz]|l[abcikrstuvy]|(?:mil|museum|m[acdeghklmnopqrstuvwxyz])|(?:name|net|n[acefgilopruz])|(?:org|om)|(?:pro|p[aefghklmnrstwy])|qa|(?:rocks|r[eouw])|(?:space|s[abcdeghijklmnortuvyz])|(?:tel|travel|t[cdfghjklmnoprtvwz])|u[agkmsyz]|v[aceginu]|(?:wtf|w[fs])|xyz|y[etu]|z[amw]))|(?:(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[1-9])\\.(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[0-9])\\.(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[0-9])\\.(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[0-9])))(?:\\:\\d{1,5})?)(?:\\/(?:(?:[!#&-;=?-Z_a-z~])|(?:\\%[a-fA-F0-9]{2}))*)?)(?=\\b|\\s|$)', 'gi')
    # rubocop:enable Metrics/LineLength
  end

  def file_extension(url)
    match = url.match(/\.\w*$/)
    return match[0] if match
  end

  def addresses(content)
    res = content.scan(auto_link_regex)
    res.map do |address|
      uri = web_address_to_uri(address)
      display_text = address
      extension = file_extension(uri)
      [address, uri, display_text, extension]
    end
  end

  def replace_address(content, parsed_address)
    address, uri, display_text, extension = parsed_address
    if ['.gif', '.jpg', '.jpeg', '.png', '.svg'].include?(extension)
      display_text = ('<img src="' << address << '" />').html_safe
    elsif address[0] == '@'
      classes = 'h-x-username'
    else
      display_text = strip_protocol(display_text)
    end
    content.gsub!(address, autolink_tag(uri, display_text, classes))
  end

  def replace_hashtags(content)
    content.scan(/(?:^|\s)(#\w+)/).each do |match|
      hashtag = match[0]
      uri = "https://twitter.com/hashtag/#{hashtag[1..-1]}"
      content.gsub!(hashtag, autolink_tag(uri, hashtag))
    end
  end

  def auto_link(content)
    addresses(content).each { |a| replace_address(content, a) }
    replace_hashtags(content)
    content.html_safe
  end

  def strip_protocol(url)
    url.gsub(%r{http(s)?://}, '')
  end

  def autolink_tag(url, text, classes = nil)
    html_class = 'auto-link'
    html_class << " #{classes}" if classes
    content_tag :a, text, class: html_class, href: url
  end

  def web_address_to_uri(addr)
    return addr if addr.start_with?('http://') || addr.start_with?('https://')

    return "https://twitter.com/#{addr[1..-1]}" if addr[0] == '@'

    'http://' + addr
  end
end
# rubocop:enable Rails/OutputSafety
