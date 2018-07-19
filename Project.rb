class Player 

	def initialize(player_card_1,player_card_2)
		@player_card_1=player_card_1
		@player_card_2=player_card_2
	end

	def player_hit
		player_current_score=@player_card_1+@player_card_2
		if player_current_score == 21
			return 21
		end
		puts "Player's total score is #{player_current_score}"
		puts "Do you want to play further?"
		response=gets.chomp
		while response=="y"
			next_card=Deck.new.get_card
			player_current_score+=next_card
			puts "Player's total score is #{player_current_score}"
			if player_current_score >= 21
				return player_current_score
			else
				puts "Do you want to play further."
				if response == "y"
					response=gets.chomp
				else
					response = "no"
				end
			end
		end
		return player_current_score
	end

	def display
		puts "Player has won."
		return
	end
end



class Dealer
	def initialize(dealer_card_1)
		@dealer_card_1=dealer_card_1
	end

	def dealer_hit(player_standing_score)
		dealer_current_score = @dealer_card_1
		while dealer_current_score <17 && dealer_current_score < player_standing_score
			next_card = Deck.new.get_card
			dealer_current_score+=next_card
			puts "Dealer's total score is #{dealer_current_score}"
		end
		return dealer_current_score
	end

	def display
		puts "Dealer has won."
	end
end



class Card 

	def suit
		suits = ["Hearts", "Spade", "Clubs", "Diamonds"]
		pos1 = rand(3)+1
		return suits[pos1]
	end

	def number
		numbers = ["A",2,3,4,5,6,7,8,9,10,"J","Q","K"]
		pos2=rand(12)+1
		return numbers[pos2]
	end
end

class Deck
	def get_card
		picked_suit=Card.new.suit
		picked_number=Card.new.number
		puts "Your card is: #{picked_number} of #{picked_suit}."
		if picked_number == "J" 
			return 10
		elsif picked_number == "A"
			return 11
		elsif picked_number == "Q"
			return 10
		elsif picked_number. == "K"
			return 10
		else
			return picked_number
		end	
	end
end

class Play
	deck = Deck.new
	player_initial_card_1=deck.get_card
	player_initial_card_2=deck.get_card

	puts "Dealer's turn."
	dealer_initial_card_1=deck.get_card


	player = Player.new(player_initial_card_1,player_initial_card_2)
	current_score =player_initial_card_1+player_initial_card_2 
	player_stand_score=player.player_hit


	dealer = Dealer.new(dealer_initial_card_1)

	if player_stand_score >21
		dealer.display
		return
	end

	puts "Dealer's turn."
	dealer_stand_score = dealer.dealer_hit(player_stand_score)
	if player_stand_score == 21
		player.display
	elsif player_stand_score > 21
		dealer.display
	elsif dealer_stand_score == 21
		dealer.display
	elsif dealer_stand_score > player_stand_score
		dealer.display
	else
		player.display
	end
end

play = Play.new






