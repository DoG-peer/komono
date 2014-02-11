#coding : SJIS
class Kakko
	attr_reader :string
	def initialize (input,type="none")
		case input
		when Integer
			n = input
			@size = n
			@string = ""
			case type
			when "start"
				n.times do
					@string = '(' + @string + ',)'
				end
			when "goal"
				n.times do
					@string = '(,' + @string + ')'
				end
			when "rand"
				@size = input
				if input.is_a?(Integer) && input > 0
					l = rand(input)
					r = input - l -1
					@string = "(" + Kakko.new(l,"rand").string + "," + Kakko.new(r,"rand").string + ")"
				elsif input == 0
					@strinh = ""
				else
					raise
				end
			end
		when String
			@string = input
			@size = input.length / 3
		when Array
			@size = input.length 
			@string = "," * (@size*3)
			@size.times do |i|
				@string[input[i][0]] = "("
				@string[input[i][2]] = ")"
			end
		end
	end
	def to_a
		#対応する括弧のペアの文字列での位置を知らせる配列．
		if @size == 0
			return []
		end
		searcher = 0
		div = -1
		@string.split(//).each.with_index do |s,i|
			case s
			when "("
				searcher += 1
			when ")"
				searcher -= 1
			when ","
				if searcher == 1
					div = i
					break
				end
			end
		end
		left = Kakko.new(@string[1...div])
		right = Kakko.new(@string[(div+1)...-1])
		return [[0,div,@size * 3 -1]] + left.to_a.map{|val|val.map{|x|x+1}} + right.to_a.map{|val|val.map{|x|x+div+1}}
	end
end
#以下サンプル，適当にコメントアウトをはずして実行してください．
=begin
ar = []
for i in 1..20
	x = Kakko.new(i,"start")
	ar << x
	ar << x.to_a
	ar <<  Kakko.new(x.to_a)
end
p ar
=end

=begin
x =  Kakko.new("((,),(,))")
p x
p Kakko.new(x.to_a)
=end

=begin
20.times do
	puts Kakko.new(20,"rand").string
end
=end
