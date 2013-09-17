# -*- coding:utf-8 -*-
require 'spreadsheet'
require 'pp'

book = Spreadsheet.open("template.xls")
sheet = book.worksheet(0)

pp sheet.row(3)
pp sheet.row(3).format(4)
