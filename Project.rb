class Player 
	BLACKJACK = 21
	def initialize(player_card_1,player_card_2)
		@player_card_1=player_card_1
		@player_card_2=player_card_2
		@player_current_score=@player_card_1+@player_card_2
	end

	def player_hit
		if @player_current_score >= BLACKJACK
			return stand
		end
		display_current_score
		prompt
		move
	end

	def display
		puts "Player has won."
		return
	end

	def move
		response = gets.chomp
		while response == "y"
			next_card=generate_card
			puts "The next card is: #{next_card}"
			@player_current_score+=next_card
			display_current_score
			if check_if_won == :has_lost
				return stand
			elsif check_if_won == :has_won
				return stand
			else
				prompt
				response = response == "y"? response=gets.chomp : response = "no"
			end
		end
		stand
	end

	def display_current_score
		puts "Player's total score is #{@player_current_score}"
	end

	def stand
		return @player_current_score
	end

	def generate_card
		Deck.new.get_card
	end

	def prompt
		puts "Do you want to play further."
	end

	def check_if_won
		if @player_current_score == BLACKJACK
			return :has_won
		elsif @player_current_score > BLACKJACK
			return :has_lost
		else
			return :can_play
		end
	end
end



class Dealer
	def initialize(dealer_card_1)
		@dealer_card_1=dealer_card_1
	end

	def dealer_hit(player_standing_score)
		move(player_standing_score)
	end

	def move(player_standing_score)
		@dealer_current_score = @dealer_card_1
		while @dealer_current_score <17 && @dealer_current_score < player_standing_score
			next_card = generate
			puts "The next card is: #{next_card}"
			@dealer_current_score+=next_card
			puts "Dealer's total score is #{@dealer_current_score}"
		end
		return @dealer_current_score
	end

	def display
		puts "Dealer has won."
	end

	def generate
		Deck.new.get_card
	end

end


class Card 
	def initialize(number,suit)
		@number=number
		@suit=suit
	end
end


class Deck
	@@equivalent_number={
		"A" => 11,
		"2" => 2,
		"3" => 3,
		"4" => 4,
		"5" => 5,
		"6" => 6,
		"7" => 7,
		"8" => 8,
		"9" => 9,
		"1" => 10,
		"J" => 10,
		"Q" => 10,
		"K" => 10
	}

	@@deck=[]
	def initialize
		suits = ["Hearts", "Spade", "Clubs", "Diamonds"].freeze
		numbers = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"].freeze
		for x in numbers do
			for y in suits do
				@@deck.push("#{x} of #{y}")
			end
		end
	end

	def shuffle
		@@deck.shuffle!
	end
	@@generated_card
	def get_card
		shuffle
		@@generated_card=@@deck.pop
		@@generated_card.split(' ')
		return @@equivalent_number[@@generated_card[0]]
	end
	def display
		puts @@generated_card
	end
end

class Play
	BLACKJACK = 21
	def initialize
		deck = Deck.new
		@player_initial_card_1=deck.get_card
		puts "First card is:"
		deck.display
		@player_initial_card_2=deck.get_card
		puts "Second card is:"
		deck.display
		puts "Dealer's turn."
		@dealer_initial_card_1=deck.get_card
		puts "The card is: "
		deck.display
	end

	def player_turn
		@player = Player.new(@player_initial_card_1,@player_initial_card_2)
		@player_stand_score=@player.player_hit
		if @player_stand_score == BLACKJACK
			@player.display
		end
	end

	def dealers_turn
		if @player_stand_score > BLACKJACK
			puts "Dealer wins"
		elsif @player_stand_score < BLACKJACK
			puts "Dealer's turn."
			dealer = Dealer.new(@dealer_initial_card_1)
			dealer_stand_score = dealer.dealer_hit(@player_stand_score)
			if @player_stand_score == BLACKJACK 
				@player.display
			elsif dealer_stand_score >BLACKJACK
				@player.display
			elsif @player_stand_score > BLACKJACK
				dealer.display
			elsif dealer_stand_score == BLACKJACK
				dealer.display
			elsif @player_stand_score > BLACKJACK
				dealer.display
			elsif dealer_stand_score >= @player_stand_score
				dealer.display
			else
				@player.display
			end
		end
	end
end

play=Play.new
play.player_turn
play.dealers_turn







