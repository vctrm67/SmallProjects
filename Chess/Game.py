"""Note: the way the board interprets coordinates is row, column"""

from Gameboard5 import Gameboard 
from ChessPiece import ChessPiece 

"""This is the Game class. This is where the actual game is played."""
class Game(object):

	Player1 = {}
	Player2 = {}
	GameOver = False
	Chessboard = Gameboard()

	listOfColumns = ["A", "B", "C", "D", "E", "F", "G", "H"]
	listOfCoordinates = [1, 2, 3, 4, 5, 6, 7, 8]

	def __init__(self):
		print "Victor and Harry cordially welcome you to Chess, a CS10 production. This a two player game. First enter the coordinates of your piece of choice, then enter the coordinates of the place to move. Be sure to use capitals when typing in the column. All rules apply, but there is no castling or notification for check; the game will end once a King has been taken." + "\n"

	def information(self, name, color, dicty):
		dicty["Name"] = name
		dicty["Color"] = color

	def position_to_xCoor(self, position):
		for i in range(0, 8):
			if self.listOfColumns[i] == position[0]:
				row = i + 1
		return row

	def position_to_yCoor(self, position):
		column = 8 - int(position[1])
		return column

	"""This checks to see if the move chosen was a valid move. Each piece has a different valid move."""
	def validMove(self, color, row1, column1, row2, column2):
		slopes = {
			"Bishop" : [1.0, -1.0], # can diagonally
			"Knight" : [2.0, -2.0, 0.5, -0.5],
			"King"   : [0.0, 1.0, -1.0, 10], #10 signifies the vertical movement
			"Pawn"   : [10.0, 1.0, -1.0],
			"Queen"  : [1.0, -1.0, 0.0, 10.0], # can move across the board
			"Rook"   : [0.0, 10.0], # can move across the board
		}

		if (column1 - column2) != 0.0: 
			row1 += 0.0
			row2 += 0.0
			column1 += 0.0	
			column2 += 0.0
			slope = (row2 - row1)/(column2 - column1)
			piece1 = self.Chessboard.Matrix[int(row1)][int(column1)].Piece
			piece2 = self.Chessboard.Matrix[int(row2)][int(column2)].Piece
			Type = self.Chessboard.Matrix[int(row1)][int(column1)].Piece.Type
			Occupied = True
			if slope in (slopes[Type]): #Is the slope correct for the given piece?
				if Type == "Pawn":
					if color == "Black":
						if (slope in [1.0, -1.0]) and (row2 == row1 + 1.0) and piece2.Color == "White":
							Occupied = False
					if color == "White":
						if (slope in [1.0, -1.0]) and (row2 == row1 - 1.0) and piece2.Color == "Black":
							Occupied = False
				if Type == "Bishop":
					row1 = int(row1)
					row2 = int(row2)
					column1 = int(column1)
					column2 = int(column2)
					if slope == 1.0:
						Occupied = self.blockedMove(color, 1, 1, column1, column2, row1, row2)
					else:
						Occupied = self.blockedMove(color, -1, 1, column1, column2, row1, row2)	
				if Type == "Knight":
					if (row2 - row1) in [2.0, -2.0, 1.0, -1.0]:
						if slope in (slopes["Knight"]) and piece2.Color != color:
							Occupied = False
				if Type == "King":
					if (row2 - row1) in ([1.0, -1.0, 0.0]) and (column2 - column1) in [1.0, -1.0, 0.0]:
						if slope in ([-1.0, 1.0, 0.0]) and piece2.Color != color:
							Occupied = False
				if Type == "Queen":
					row1 = int(row1)
					row2 = int(row2)
					column1 = int(column1)
					column2 = int(column2)
					if slope == 1.0:
						Occupied = self.blockedMove(color, 1, 1, column1, column2, row1, row2)
					if slope == -1.0:
						Occupied = self.blockedMove(color, -1, 1, column1, column2, row1, row2)
					if slope == 0.0:
						Occupied = self.blockedMove(color, 0, 1, column1, column2, row1, row2)
				if Type == "Rook":
					row1 = int(row1)
					row2 = int(row2)
					column1 = int(column1)
					column2 = int(column2)
					Occupied = self.blockedMove(color, 0, 1, column1, column2, row1, row2)
			if Occupied == False: #If all the spaces in the path are empty, return True
				return True
			else: 
				return False
		elif (column1 - column2) == 0.0:
			slope = 10.0
			piece1 = self.Chessboard.Matrix[int(row1)][int(column1)].Piece
			piece2 = self.Chessboard.Matrix[int(row2)][int(column2)].Piece
			Type = self.Chessboard.Matrix[int(row1)][int(column1)].Piece.Type
			Occupied = True
			if slope in (slopes[Type]): #Is the slope correct?
				if Type == "King":
					if (row2 - row1 in ([1.0, -1.0])) and piece2.Color != color:
						Occupied = False
				if Type == "Pawn":
					if color == "White":
						if row1 == 6:
							if ((row2 - row1) in ([-1.0, -2.0])) and piece2.Color != color:
								Occupied = False

						else: 
							if (row2 - row1 == -1.0) and piece2.Color != color:
								Occupied = False							
					if color == "Black":
						if row1 == 1:
							if (row2 - row1 in ([1.0, 2.0])) and piece2.Color != color:
								Occupied = False
						else:
							if (row2 - row1 == 1.0) and piece2.Color != color:							
								Occupied = False
				if Type == "Queen":
					row1 = int(row1)
					row2 = int(row2)
					column1 = int(column1)
					column2 = int(column2)				
					Occupied = self.blockedMove(color, 1, 0, column1, column2, row1, row2)	
				if Type == "Rook":
					row1 = int(row1)
					row2 = int(row2)
					column1 = int(column1)
					column2 = int(column2)
					Occupied = self.blockedMove(color, 1, 0, column1, column2, row1, row2)
			if Occupied == False: #If all the spaces in the path are empty, return True
				return True
			else: 
				return False

	"""If the path is true, the method will return false. Otherwise, it will return false."""
 	def blockedMove(self, color, rise, run, column1, column2, row1, row2):
		rise1 = rise
		run1 = run
		Occupied = False
		piece1 = self.Chessboard.Matrix[row1][column1].Piece
		piece2 = self.Chessboard.Matrix[row2][column2].Piece
		if column2 > column1:
			column1 += run1
			row1 += rise1
			while row1 != row2 and column1 != column2 and Occupied == False:
				if self.Chessboard.Matrix[row1][column1].Occupied == True:
					Occupied = True
				column1 += run1
				row1 += rise1
		elif column2 < column1:
			column1 -= run1
			row1 -= rise1
			while row1 != row2 and column1 != column2 and Occupied == False:
				if self.Chessboard.Matrix[row1][column1].Occupied == True:
					Occupied = True
				column1 -= run1
				row1 -= rise1
		elif column2 - column1 == 0:
			if row2 > row1:
				row1 += rise1
				while row1 != row2 and Occupied == False:
					if self.Chessboard.Matrix[row1][column1].Occupied == True:
						Occupied = True
					row1 += rise1
			else:
				row1 -= rise1
				while row1 != row2 and Occupied == False:
					if self.Chessboard.Matrix[row1][column1].Occupied == True:
						Occupied = True
					row1 -= rise1
		return Occupied
					

 	def check(color, piece, rise, run, column, row):

		if piece.Type in ["Knight", "King", "Pawn"]:
			column1 = column + run
			row1 = row + rise
			if self.Chessboard.Matrix[row1][column1].Occupied == True:
				Piece = self.Chessboard.Matrix[row1][column1].Piece
				if Piece == "King":
					print "Check."

			column2 = column - run
			row2 = row - rise
			if self.Chessboard.Matrix[row2][column2].Occupied == True:
				return True
			else: 
				return False
		if piece.Type in ["Queen", "Rook", "Bishop"]:
			Occupied = False
			while Occupied == False:
				column1 -= run

	"""If the king is taken, execute Game Over."""
	def kingDead(self, color):
		GameOver = True
		for row in range (0, 8):
			for column in range(1, 8):
				if self.Chessboard.Matrix[row][column].Piece.Color == color:
					if self.Chessboard.Matrix[row][column].Piece.Type == "King":
						GameOver = False
		return GameOver

	"""If the Pawn reaches the end of the board, promote the pawn."""
	def promotePawn(self, piece, row1, column1, row2):
		if piece.Type == "Pawn" and row2 == 0:
			newPiece = raw_input("Pawn has reached the back row: promotion. Choose your new piece from: 1. Queen 2. Rook 3. Knight 4. Bishop. Enter the number of choice.")
			if newPiece == 1:
				self.addPiece("White", "Queen", row2, column1)
			if newPiece == 2:
				self.addPiece("White", "Rook", row2, column1)
			if newPiece == 3:
				self.addPiece("White", "Knight", row2, column1)
			if newPiece == 4:
				self.addPiece("White", "Bishop", row2, column1)
		if piece.Type == "Pawn" and row2 == 7:
			newPiece = raw_input("Pawn has reached the back row: promotion. Choose your new piece from: 1. Queen 2. Rook 3. Knight 4. Bishop. Enter the number of choice.")
			if newPiece == 1:
				self.addPiece("Black", "Queen", row2, column1)
			if newPiece == 2:
				self.addPiece("Black", "Rook", row2, column1)
			if newPiece == 3:
				self.addPiece("Black", "Knight", row2, column1)
			if newPiece == 4:
				self.addPiece("Black", "Bishop", row2, column1)		

	"""Here is the main run method. It's where the execution of the game takes place."""
	def run(self):
		name1 = raw_input("Please enter the name of Player 1." + "\n")
		name2 = raw_input("Please enter the name of Player 2." + "\n")
		color1 = raw_input("Thank you " + name1 + ", would you like to be Black or White? Press 1 for black and 2 for white." + "\n")
		color2 = ""
		if int(color1) == 2:
			color1 = "White"
			color2 = "Black"
			print "Thank you. Player 2, you are black."
		elif int(color1) == 1:
			color1 = "Black"
			color2 = "White"
			print "Thank you. Player 2, you are white." 
		self.information(name1, color1, self.Player1)
		self.information(name2, color2, self.Player2)

		print "\n" + "Let's play!"
		print self.Chessboard

		listOfColumns = ["A", "B", "C", "D", "E", "F", "G", "H"]
		validChoice = False
		if color1 == "White":
			column = ""
			row = ""
			piece = raw_input(self.Player1["Name"] + ", pick a piece to move. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			while validChoice == False:
				column = self.position_to_xCoor(piece)
				row = self.position_to_yCoor(piece)
				piece1 = self.Chessboard.Matrix[row][column].Piece
				if str(piece[0]) not in self.listOfColumns or int(piece[1]) > 8 or piece1.Color != color1:
					piece = raw_input("That is not a valid choice. Pick again." + "\n")
				else:
					validChoice = True

			validChoice = False
			place = raw_input("Now pick a place to move to. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			while validChoice == False:
				column2 = self.position_to_xCoor(place) 
				row2 = self.position_to_yCoor(place)
				piece2 = self.Chessboard.Matrix[row2][column2].Piece
				validMove = self.validMove("White", row, column, row2, column2)
				if ((place[0] <= "H" or place[1] <= 8) and validMove == True and piece2.Color != self.Player1["Color"]):
					validChoice = True
					self.Chessboard.addPiece("", "", row, column)
					self.Chessboard.Matrix[row2][column2].setPiece(piece1)
					self.promotePawn(piece1, row, column, row2)
				else:
					place = raw_input("That's not a valid move. Please pick again. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			
		validChoice = False
		while self.GameOver == False:
			print self.Chessboard

			piece = raw_input(self.Player2["Name"] + ", pick a piece to move. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			while validChoice == False:
				column = self.position_to_xCoor(piece)
				row = self.position_to_yCoor(piece)
				piece1 = self.Chessboard.Matrix[row][column].Piece
				if str(piece[0]) not in self.listOfColumns or int(piece[1]) > 8 or piece1.Color != color2:
					piece = raw_input("That is not a valid choice. Pick again." + "\n")
				else:
					validChoice = True
			
			validChoice = False
			place = raw_input("Now pick a place to move to. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			while validChoice == False:
				column2 = self.position_to_xCoor(place) 
				row2 = self.position_to_yCoor(place)
				piece2 = self.Chessboard.Matrix[row2][column2].Piece
				validMove = self.validMove(self.Player2["Color"], row, column, row2, column2)
				if (place[0] <= "H" or place[1] <= 8) and validMove == True and piece2.Color != self.Player2["Color"]:
					validChoice = True
					self.Chessboard.addPiece("", "", row, column)
					self.Chessboard.Matrix[row2][column2].setPiece(piece1)
					self.promotePawn(piece1, row, column, row2)
				else:
					place = raw_input("That's not a valid move. Please pick again. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			
			if self.kingDead(self.Player1["Color"]) == True:
				return
			
			print self.Chessboard

			validChoice = False
			piece = raw_input(self.Player1["Name"] + ", pick a piece to move. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			while validChoice == False:
				column = self.position_to_xCoor(piece)
				row = self.position_to_yCoor(piece)
				piece1 = self.Chessboard.Matrix[row][column].Piece
				if str(piece[0]) not in self.listOfColumns or int(piece[1]) > 8 or piece1.Color != color1:
					piece = raw_input("That is not a valid choice. Pick again." + "\n")
				else:
					validChoice = True
			
			validChoice = False
			place = raw_input("Now pick a place to move to. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			while validChoice == False:
				column2 = self.position_to_xCoor(place) 
				row2 = self.position_to_yCoor(place)
				piece2 = self.Chessboard.Matrix[row2][column2].Piece
				validMove = self.validMove(self.Player1["Color"], row, column, row2, column2)
				if ((place[0] <= "H" or place[1] <= 8) and validMove == True and piece2.Color != self.Player1["Color"]):
					validChoice = True
					self.Chessboard.addPiece("", "", row, column)
					self.Chessboard.Matrix[row2][column2].setPiece(piece1)
					self.promotePawn(piece1, row, column, row2)
				else:
					place = raw_input("That's not a valid move. Please pick again. Enter the coordinates (ex. A3, D4, etc.). Use Capitals, and no space between." + "\n")
			validChoice = False

			if self.kingDead(self.Player2["Color"]) == True:
				return

newgame = Game()
newgame.run()
print self.Chessboard
print "GAME OVER!"




