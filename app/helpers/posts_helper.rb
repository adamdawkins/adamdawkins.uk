module PostsHelper
  def auto_link_regex
    # Taken from https://github.com/kylewm/cassis-autolink-py/blob/master/cassis.py#L19

    Regexp.new('(?:\\@[_a-zA-Z0-9]{1,17})|(?:(?:(?:(?:http|https|irc)?:\\/\\/(?:(?:[!$&-.0-9;=?A-Z_a-z]|(?:\\%[a-fA-F0-9]{2}))+(?:\\:(?:[!$&-.0-9;=?A-Z_a-z]|(?:\\%[a-fA-F0-9]{2}))+)?\\@)?)?(?:(?:(?:[a-zA-Z0-9][-a-zA-Z0-9]*\\.)+(?:(?:aero|arpa|asia|a[cdefgilmnoqrstuwxz])|(?:biz|b[abdefghijmnorstvwyz])|(?:cat|com|coop|c[acdfghiklmnoruvxyz])|d[ejkmoz]|(?:edu|e[cegrstu])|f[ijkmor]|(?:gov|g[abdefghilmnpqrstuwy])|h[kmnrtu]|(?:info|int|i[delmnoqrst])|j[emop]|k[eghimnrwyz]|l[abcikrstuvy]|(?:mil|museum|m[acdeghklmnopqrstuvwxyz])|(?:name|net|n[acefgilopruz])|(?:org|om)|(?:pro|p[aefghklmnrstwy])|qa|r[eouw]|s[abcdeghijklmnortuvyz]|(?:tel|travel|t[cdfghjklmnoprtvwz])|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw]))|(?:(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[1-9])\\.(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[0-9])\\.(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[0-9])\\.(?:25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[0-9])))(?:\\:\\d{1,5})?)(?:\\/(?:(?:[!#&-;=?-Z_a-z~])|(?:\\%[a-fA-F0-9]{2}))*)?)(?=\\b|\\s|$)', 'gi')
  end

  def auto_link(content)
    addresses = content.scan(auto_link_regex)
    addresses.each do |address|
      uri = web_address_to_uri(address)
      display_text = address

      if address[0] == "@"
        content.gsub!(address, autolink_tag(uri, display_text, "h-x-username"))
      else
        display_text = strip_protocol(display_text)
        content.gsub!(address, autolink_tag(uri, display_text))
      end
    end
    content.html_safe
  end

  def strip_protocol(url)
    url.gsub(/http(s)?:\/\//, '')
  end

  def autolink_tag(url, text, classes = nil)
    html_class = "auto-link"
    html_class << " #{classes}" if classes
    content_tag :a, text, class: html_class, href: url
  end

  def web_address_to_uri(wa)
    return wa if (wa.start_with?('http://') || wa.start_with?('https://'))

    return "https://twitter.com/#{wa[1..-1]}" if wa[0] == '@'

    "http://" + wa
  end
end
