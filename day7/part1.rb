#!/usr/bin/ruby

p File.read('data.txt').scan(%r{([a-z]+)}).flatten.group_by{ |d| d}.keep_if{ |_,e| e.size==1 }.keys.first
