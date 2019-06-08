
from ChessPiece import ChessPiece

"""The Square class. It makes up all the tiles of the chessboard, and holds information about what piece is on it."""
class Square(object): 
	Row = 0
	Column = 0
	Occupied = False
	Piece = "  "
	listOfColumns = ["A", "B", "C", "D", "E", "F", "G", "H"]
	listOfCoordinates = [1, 2, 3, 4, 5, 6, 7, 8]

	def __init__(self, row, column):
		self.Row = row
		self.Column = column

	"""Returns true if there is a piece"""
	def occupied(self):
		return self.Occupied

	"""Sets the piece for a square and sets the occupied variable"""
	def setPiece(self, piece):
		if piece.Type == "":
			self.Occupied = False
		else:
			self.Occupied = True
		self.Piece = piece

	"""Returns the piece attached to this square instance"""
	def getPiece(self):
		return self.Piece


class Gameboard(object):

	Matrix = [[0 for x in range(9)] for j in range(9)] 
	Board = [[0 for x in range(9)] for j in range(9)] 

	listOfColumns = ["A", "B", "C", "D", "E", "F", "G", "H"]

	def __init__(self):
		for row in range(0, 9):
			for column in range(0, 9):
				self.Matrix[row][column] = Square(row, column)
				self.Matrix[row][column].Occupied = True 

		for column in range(1, 9):
			self.addPiece("Black", "Pawn", 1, column)
			self.addPiece("White", "Pawn", 6, column)
		row = 0
		self.addPiece("Black", "Rook", row, 1)
		self.addPiece("Black", "Knight", row, 2)
		self.addPiece("Black", "Bishop", row, 3)
		self.addPiece("Black", "Bishop", row, 6)
		self.addPiece("Black", "Knight", row, 7)
		self.addPiece("Black", "Rook", row, 8)

		row = 7
		self.addPiece("White", "Rook", row, 1)
		self.addPiece("White", "Knight", row, 2)
		self.addPiece("White", "Bishop", row, 3)
		self.addPiece("White", "Bishop", row, 6)
		self.addPiece("White", "Knight", row, 7)
		self.addPiece("White", "Rook", row, 8)

		self.addPiece("White", "Queen", 7, 4)
		self.addPiece("White", "King", 7, 5)
		self.addPiece("Black", "Queen", 0, 4)
		self.addPiece("Black", "King", 0, 5)

		for row in range (2, 6):
			for column in range (1, 9):
				self.addPiece("", "", row, column)
	def __str__(self):
		row1 = 0
		for number in range(8, -1, -1):
			self.Board[row1][0] = number
			row1 += 1

		for row in range (0, 9):
			for column in range(1, 9):
				self.Board[row][column] = self.Matrix[row][column].Piece

		displayBoard = ""
		for row in range (0, 8):
			displayBoard += "   " + "---" * 13 + "\n"
			for column in range(0, 9):
				displayBoard += str(self.Board[row][column]) + " | "
			displayBoard += "\n"
		displayBoard += "   " + "---" * 13 + "\n"
		displayBoard += "   "
		for column in range(0, 8):
			displayBoard += "  " + self.listOfColumns[column] + "  "

		return displayBoard

	def addPiece(self, color, piece_type, row, column):
		Information = {
			"Type" : piece_type,
			"Color" : color,
			}
		self.Matrix[row][column].setPiece(ChessPiece(Information))

	@staticmethod
	def coor_to_position(a, b):
		row = self.listofrows[a]
		return row + str(b)

