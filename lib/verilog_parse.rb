#!/bin/ruby
$:.unshift(File.dirname(__FILE__))

class VerilogParse
  def initialize(src)
    @src = src
  end
  def lex
    case @src
    when /^[\r\n\t ]*([0-9.a-zA-Z_]+)(.*$)/      # number
    when /^[\r\n\t ]*(\w+)(.*$)/         # alphabet
    when /^[\r\n\t ]*([\{\}\[\]\"\(\)\,\;\:])(.*$)/  # delimiter({,},[,])
    when /^[\r\n\t ]*(\=+|\|\||\!\=|\&\&|\||\&)(.*$)/         # delimiter({,},[,])
    when /^[\r\n\t ]+(.*)(.*$)/          # ==
      return nil
    end
    @src = $2
    $1
  end

  def tokens
    ts = Array.new
    while (token = lex) != nil
      ts.push(token)
    end
    ts
  end
end

